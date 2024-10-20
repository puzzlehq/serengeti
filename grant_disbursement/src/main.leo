import credits.aleo;
import time_oracle.aleo;

// The 'grant_disbursement' program.
program grant_disbursement_puzzle_v10.aleo {
  const GRANTEE_REWARDS_ADDRESS: address = aleo12mg4yjxtaejwm3aaxk8gugr5p4nddhdn8g5xr2hlfcasxf532qqq7yaga0;
  const GRANTEE_PRINCIPAL_ADDRESS: address = aleo12mg4yjxtaejwm3aaxk8gugr5p4nddhdn8g5xr2hlfcasxf532qqq7yaga0;
  const PUZZLE_VALIDATOR_ADDRESS: address = aleo1zdzzxfrhgzlhh89vqpf4384ewqs0g32wqzvdeltzlynq25hkju8s38953f;
  const MIN_BONDED_CREDITS: u64 = 10_000_000_000u64;
  const CREDITS_AMOUNT: u64 = 10_000_000_000u64;
  const START_TIMESTAMP: u64 = 1725479626u64;
  const CLIFF_TIMESTAMP: u64 = 1757015626u64;
  const FULLY_VESTED_TIMESTAMP: u64 = 1757015686u64;

  struct Grant {
    credits_amount: u64, // The amount of Aleo credits to be distributed
    recipient_rewards_address: address, // The address that can withdraw the rewards
    recipient_principal_address: address, // The address that can withdraw the principal
    start_timestamp: u64, // The timestamp at which the grant was created
    cliff_timestamp: u64, // The timestamp at which the recipient can start withdrawing principal
    fully_vested_timestamp: u64,// The height at which the recipient can withdraw the full principal
    is_processed: bool // Whether the grant has been processed
  }

  mapping grants: u8 => Grant;

  async transition initialize() -> Future {
    return finalize_initialize();
  }

  async function finalize_initialize() {
    // Ensure the protocol is not already initialized
    let already_initialized: bool = grants.contains(0u8);
    assert(!already_initialized);

    // Create the initial grant
    let initial_grant: Grant = Grant {
      credits_amount: CREDITS_AMOUNT,
      recipient_rewards_address: GRANTEE_REWARDS_ADDRESS,
      recipient_principal_address: GRANTEE_PRINCIPAL_ADDRESS,
      start_timestamp: START_TIMESTAMP,
      cliff_timestamp: CLIFF_TIMESTAMP,
      fully_vested_timestamp: FULLY_VESTED_TIMESTAMP,
      is_processed: false
    };

    // Add the grant to the mapping
    grants.set(0u8, initial_grant);
  }

  async transition process_grant(
    grant_id: u8,
    credits_amount: u64,
  ) -> Future {
    // transfer credits to the protocol
    let f0: Future = credits.aleo/transfer_public_as_signer(self.address, credits_amount);
    // bond the credits to the puzzle validator
    let f1: Future = credits.aleo/bond_public(PUZZLE_VALIDATOR_ADDRESS, self.address, credits_amount);

    return finalize_process_grant(f0, f1, grant_id, credits_amount);
  }

  async function finalize_process_grant(
    f0: Future,
    f1: Future,
    grant_id: u8,
    credits_amount: u64,
  ) {
    f0.await();
    f1.await();

    // Get the grant
    let grant: Grant = grants.get(grant_id);

    // Assert the credits amount is the same
    assert_eq(credits_amount, grant.credits_amount);
    // Assert that the grant has not been processed
    assert(!grant.is_processed);

    // Update the grant
    let updated_grant: Grant = Grant {
      credits_amount: grant.credits_amount,
      recipient_rewards_address: grant.recipient_rewards_address,
      recipient_principal_address: grant.recipient_principal_address,
      start_timestamp: grant.start_timestamp,
      cliff_timestamp: grant.cliff_timestamp,
      fully_vested_timestamp: grant.fully_vested_timestamp,
      is_processed: true
    };
    grants.set(grant_id, updated_grant);
  }

  async transition withdraw_rewards(
    id: u8,
    reward_amount: u64,
  ) -> Future {
    assert_eq(self.caller, GRANTEE_REWARDS_ADDRESS);

    // unbond an arbitrary number of credits from the program
    let f0: Future = credits.aleo/unbond_public(self.address, reward_amount);

    return finalize_withdraw_rewards(f0, id, reward_amount);
  }

  async function finalize_withdraw_rewards(
    f0: Future,
    id: u8,
    reward_amount: u64
  ) {
    f0.await();

    let grant: Grant = grants.get(id);

    // Assert that the current timestamp is before the cliff
    let current_timestamp: u64 = time_oracle.aleo/timestamp.get(0u8);
    assert(current_timestamp < grant.cliff_timestamp);

    // Ensure the number of credits in the staked amount remains above the principal
    let bonded_credits_struct: bond_state = credits.aleo/bonded.get(self.address);
    let bonded_credits: u64 = bonded_credits_struct.microcredits;
    assert(bonded_credits - reward_amount > grant.credits_amount);
  }

  async transition withdraw_principal(
    id: u8,
    credits_amount: u64
  ) -> Future {
    assert_eq(self.caller, GRANTEE_PRINCIPAL_ADDRESS);

    let f0: Future = credits.aleo/unbond_public(self.address, credits_amount);

    return finalize_withdraw_principal(f0, id, credits_amount);
  }

  async function finalize_withdraw_principal(
    f0: Future,
    id: u8,
    amount: u64
  ) {
    f0.await();

    let grant: Grant = grants.get(id);

    // Assert that the current timestamp is after the cliff
    let current_timestamp: u64 = time_oracle.aleo/timestamp.get(0u8);
    assert(current_timestamp >= grant.cliff_timestamp);

    // Calculate the vested credits
    let timestamps_since_start: u64 = current_timestamp - grant.start_timestamp;
    let total_vesting_timestamps: u64 = grant.fully_vested_timestamp - grant.start_timestamp;
    let vested_credits: u128 = grant.credits_amount as u128 * timestamps_since_start as u128 / total_vesting_timestamps as u128;

    // Assert the withdrawal claim does not exceed the vested amount
    assert(amount as u128 <= vested_credits);
  }

  async transition claim_withdrawal_public (
    credits_amount: u64,
  ) -> Future {
    let f0: Future = credits.aleo/claim_unbond_public(self.address);
    let f1: Future = credits.aleo/transfer_public(GRANTEE_PRINCIPAL_ADDRESS, credits_amount);
    return finalize_claim_withdrawal_public(f0, f1);
  }

  async function finalize_claim_withdrawal_public
  (
    f0: Future,
    f1: Future,
  )
  {
    f0.await();
    f1.await();
  }

  // copied from credits.aleo, as structs are not importable
  struct bond_state {
    validator: address,
    microcredits: u64
  }

  // copied from credits.aleo, as structs are not importable
  struct unbond_state {
    microcredits: u64,
    height: u32
  }
}
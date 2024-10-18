import credits.aleo;
import time_oracle.aleo;

// The 'grant_disbursement' program.
program grant_disbursement_puzzle_v9.aleo {
  // todo: do we even need grantee_rewards_address ?
  const GRANTEE_REWARDS_ADDRESS: address = aleo1qfvzv4y0eh39cwszelmu8r8ysvp70ljvj2t3vxjv26uc337ppufqjahahj;
  const GRANTEE_PRINCIPAL_ADDRESS: address = aleo1f7zquf7ax3u0gprx6vek9ww9hhz36kgwjkuujq3stxfqc8n9nq8qq4y8ng;
  const PUZZLE_VALIDATOR_ADDRESS: address = aleo1zdzzxfrhgzlhh89vqpf4384ewqs0g32wqzvdeltzlynq25hkju8s38953f;
  const MIN_BONDED_CREDITS: u64 = 10_000_000_000u64;
  const CREDITS_AMOUNT: u64 = 10_000_000_000u64;
  const START_TIMESTAMP: u64 = 1725479626u64;
  const CLIFF_TIMESTAMP: u64 = 1757015626u64;
  //  3000000000u64;
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
    // unbond an arbitrary number of credits from the program
    let f0: Future = credits.aleo/unbond_public(self.address, reward_amount);

    return finalize_withdraw_rewards(f0, id, reward_amount, self.caller);
  }

  async function finalize_withdraw_rewards(
    f0: Future,
    id: u8,
    reward_amount: u64,
    caller: address
  ) {
    f0.await();

    // Get the grant
    let grant: Grant = grants.get(id);

    // Ensure the caller is the recipient_rewards_address
    assert_eq(caller, grant.recipient_rewards_address);

    // Get the current timestamp
    let current_timestamp: u64 = time_oracle.aleo/timestamp.get(0u8);

    // Assert that the current timestamp is before the cliff
    assert(current_timestamp < grant.cliff_timestamp);

    // Ensure the number of credits in the principal remains above the initial deposit
    // fetch the bonded state struct
    let bonded_credits_struct: bond_state = credits.aleo/bonded.get(self.address);
    let bonded_credits: u64 = bonded_credits_struct.microcredits;

    // assert that the credits bonded are still > 10_000 credits after rewards withdrawal
    assert(bonded_credits - reward_amount > MIN_BONDED_CREDITS);

    // Update the grant
    // todo: don't think we need to update here
    let updated_grant: Grant = Grant {
      credits_amount: grant.credits_amount,
      recipient_rewards_address: grant.recipient_rewards_address,
      recipient_principal_address: grant.recipient_principal_address,
      start_timestamp: grant.start_timestamp,
      cliff_timestamp: grant.cliff_timestamp,
      fully_vested_timestamp: grant.fully_vested_timestamp,
      is_processed: grant.is_processed
    };
    grants.set(id, updated_grant);
  }

  async transition withdraw_principal(
    id: u8,
    credits_amount: u64
  ) -> Future {
    let f0: Future = credits.aleo/unbond_public(self.address, credits_amount);

    return finalize_withdraw_principal(f0, id, credits_amount, self.caller);
  }

  async function finalize_withdraw_principal(
    f0: Future,
    id: u8,
    amount: u64,
    caller: address
  ) {
    f0.await();

    // Get the grant
    let grant: Grant = grants.get(id);

    // Ensure the caller is the recipient_principal_address
    assert_eq(caller, grant.recipient_principal_address);

    // Get the current timestamp
    let current_timestamp: u64 = time_oracle.aleo/timestamp.get(0u8);

    // Assert that the current timestamp is after the cliff
    assert(current_timestamp >= grant.cliff_timestamp);

    // todo: add mechanism to get grantee credits balance

    // Calculate the vested credits
    let timestamps_since_start: u64 = current_timestamp - grant.start_timestamp;
    let total_vesting_timestamps: u64 = grant.fully_vested_timestamp - grant.start_timestamp;
    let vested_credits: u128 = grant.credits_amount as u128 * timestamps_since_start as u128 / total_vesting_timestamps as u128;
    let bounded_vested_credits: u128 = vested_credits < grant.credits_amount as u128 ? vested_credits : grant.credits_amount as u128;
    let minimum_credits_balance: u128 = grant.credits_amount as u128 - bounded_vested_credits;

    // Assert we're not claiming more than we're allowed to
    assert(amount as u128 <= vested_credits);

    // Update the grant
    let updated_grant: Grant = Grant {
      credits_amount: grant.credits_amount,
      // todo: do we need to add something here to track the credits unbonded?
      recipient_rewards_address: grant.recipient_rewards_address,
      recipient_principal_address: grant.recipient_principal_address,
      start_timestamp: grant.start_timestamp,
      cliff_timestamp: grant.cliff_timestamp,
      fully_vested_timestamp: grant.fully_vested_timestamp,
      is_processed: grant.is_processed
    };
    grants.set(id, updated_grant);
  }


  async transition claim_withdrawal_public (
    credits_amount: u64,
  ) -> Future {
    // todo: add admin assertions
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
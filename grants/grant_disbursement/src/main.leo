import credits.aleo;
import time_oracle.aleo;

// The 'grant_disbursement_puzzle' program.
program grant_disbursement_puzzle.aleo {
  const WITHDRAWAL_ADDRESS: address = aleo1pld4a6wdl9psu882ce4cz97uf3n9kk8dl2sm74dmu62sakw6qcrqfwc3h9;
  const PUZZLE_VALIDATOR_ADDRESS: address = aleo1q3gtqtd03fs7chhjdr8c4hf8vkwt96pf3vw28uytsdrnwt4hrs9sg7c62j;

  const CREDITS_AMOUNT: u64 = 500_000_000_000u64;

  const START_TIMESTAMP: u64 = 1725479626u64;
  const CLIFF_TIMESTAMP: u64 = 1757015626u64;
  const FULLY_VESTED_TIMESTAMP: u64 = 1757015686u64;

  struct Grant {
    credits_amount: u64, // The amount of Aleo credits to be distributed
    withdrawal_address: address, // The address that will receive rewards and principal
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
      withdrawal_address: WITHDRAWAL_ADDRESS,
      start_timestamp: START_TIMESTAMP,
      cliff_timestamp: CLIFF_TIMESTAMP,
      fully_vested_timestamp: FULLY_VESTED_TIMESTAMP,
      is_processed: false
    };

    // Add the grant to the mapping
    grants.set(0u8, initial_grant);
  }

  async transition process_grant(
    grant_id: u8
  ) -> Future {
    // transfer credits to the protocol
    let f0: Future = credits.aleo/transfer_public_as_signer(self.address, CREDITS_AMOUNT);
    // bond the credits to the puzzle validator
    let f1: Future = credits.aleo/bond_public(PUZZLE_VALIDATOR_ADDRESS, self.address, CREDITS_AMOUNT);

    return finalize_process_grant(f0, f1, grant_id);
  }

  async function finalize_process_grant(
    f0: Future,
    f1: Future,
    grant_id: u8,
  ) {
    f0.await();
    f1.await();

    // Get the grant
    let grant: Grant = grants.get(grant_id);

    // Assert that the grant has not been processed
    assert(!grant.is_processed);

    // Update the grant to be "processed"
    let processed_grant: Grant = Grant {
      credits_amount: grant.credits_amount,
      withdrawal_address: grant.withdrawal_address,
      start_timestamp: grant.start_timestamp,
      cliff_timestamp: grant.cliff_timestamp,
      fully_vested_timestamp: grant.fully_vested_timestamp,
      is_processed: true
    };
    grants.set(grant_id, processed_grant);
  }

  async transition withdraw_rewards(
    id: u8,
    reward_amount: u64
  ) -> Future {
    assert_eq(self.caller, WITHDRAWAL_ADDRESS);

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
    let bonded_state: bond_state = credits.aleo/bonded.get(self.address);
    let bonded_credits: u64 = bonded_state.microcredits;
    assert(bonded_credits - reward_amount >= grant.credits_amount);
  }

  async transition withdraw_principal(
    id: u8,
    credits_amount: u64
  ) -> Future {
    assert_eq(self.caller, WITHDRAWAL_ADDRESS);

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
    let vested_credits: u64 = grant.credits_amount * timestamps_since_start / total_vesting_timestamps;

    // Assert the withdrawal claim does not exceed the vested amount
    assert(amount <= vested_credits);
  }

  async transition claim_unbond_public () -> Future {
    let f0: Future = credits.aleo/claim_unbond_public(self.address);
    return finalize_claim_unbond_public(f0);
  }
  async function finalize_claim_unbond_public(f0: Future) {
    f0.await();
  }

  async transition withdraw (
    id: u8,
    amount: u64,
  ) -> Future {
    let f0: Future = credits.aleo/transfer_public(WITHDRAWAL_ADDRESS, amount);
    return finalize_withdraw(f0, id, amount);
  }
  async function finalize_withdraw(f0: Future, id: u8, amount: u64) {
    f0.await();

    let grant: Grant = grants.get(id);

    // If for some reason the program was forcefully unbonded from the validator,
    //   we need to ensure we're withdrawing appropriate amounts
    let current_timestamp: u64 = time_oracle.aleo/timestamp.get(0u8);
    if (current_timestamp < grant.cliff_timestamp) {
      // Assert the withdrawal claim does not dip into the principal
      let program_balance: u64 = credits.aleo/account.get(self.address);
      assert(program_balance - amount >= grant.credits_amount);
    } else if (current_timestamp < grant.fully_vested_timestamp) {
      // Assert the withdrawal claim does not exceed the vested amount
      let timestamps_since_start: u64 = current_timestamp - grant.start_timestamp;
      let total_vesting_timestamps: u64 = grant.fully_vested_timestamp - grant.start_timestamp;
      let vested_credits: u64 = grant.credits_amount * timestamps_since_start / total_vesting_timestamps;
      assert(amount <= vested_credits);
    }
  }

  // copied from credits.aleo, as structs are not importable
  struct bond_state {
    validator: address,
    microcredits: u64
  }
}
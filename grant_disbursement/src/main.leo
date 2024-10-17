import credits.aleo;
import time_oracle.aleo;

// The 'grant_disbursement' program.
program grant_disbursement_puzzle.aleo {
  // todo: update grantee rewards key
  const GRANTEE_REWARDS_KEY: address = aleo12shtwnmf49t5atmad2jnk3e58ahtp749d9trctt9z3wryxyzt5pspp0nd0;
  // todo: update this maybe
  const GRANTEE_PRINCIPAL_KEY: address = aleo1z9y9afh0h6dnyj3f0hvjc4mhayjy06fj42ppcq0rvpmmyky6fuzs449sjr;
  const PUZZLE_VALIDATOR_ADDRESS: address = aleo1q3gtqtd03fs7chhjdr8c4hf8vkwt96pf3vw28uytsdrnwt4hrs9sg7c62j;
  const MIN_BONDED_CREDITS: u64 = 10_000_000u64;
  const CREDITS_AMOUNT: u64 = 1_000_000_000u64;
  const START_TIMESTAMP: u64 = 0u64;
  const CLIFF_TIMESTAMP: u64 = 1_000_000_000u64;
  const FULLY_VESTED_TIMESTAMP: u64 = 2_000_000_000u64;

  struct Grant {
    credits_amount: u64, // The amount of Aleo credits to be distributed
    recipient_rewards_key: address, // The address that can withdraw the rewards
    recipient_principal_key: address, // The address that can withdraw the principal
    start_timestamp: u64, // The timestamp at which the grant was created
    cliff_timestamp: u64, // The timestamp at which the recipient can start withdrawing principal
    fully_vested_timestamp: u64, // The timestamp at which the recipient can withdraw the full principal
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
      recipient_rewards_key: GRANTEE_REWARDS_KEY,
      recipient_principal_key: GRANTEE_PRINCIPAL_KEY,
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
    amount: u128,
  ) -> Future {
    // transfer credits to the protocol
    let f1: Future = credits.aleo/transfer_public_as_signer(self.address, microcredits);
    // bond the credits to the puzzle validator
    let f2: Future = credits.aleo/bond_public(PUZZLE_VALIDATOR_ADDRESS, self.address, microcredits);

    return finalize_process_grant(f0, grant_id, credits_amount, paleo_amount);
  }

  async function finalize_process_grant(
    f0: Future,
    grant_id: u8,
    credits_amount: u64,
    paleo_amount: u128
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
      recipient_rewards_key: grant.recipient_rewards_key,
      recipient_principal_key: grant.recipient_principal_key,
      start_timestamp: grant.start_timestamp,
      cliff_timestamp: grant.cliff_timestamp,
      fully_vested_timestamp: grant.fully_vested_timestamp,
      is_processed: true
    };
    grants.set(grant_id, updated_grant);
  }

  async transition withdraw_rewards(
    id: u8,
    reward_amount: u128,
  ) -> Future {
    let f0: Future = credits.aleo/unbond_public(self.address, reward_amount);

    return finalize_withdraw_rewards(f0, id, reward_amount);
  }

  async function finalize_withdraw_rewards(
    f0: Future,
    id: u8,
    reward_amount: u128,
    signer: address
  ) {
    f0.await();

    // Get the grant
    let grant: Grant = grants.get(id);

    // Ensure the caller is the recipient_rewards_key
    assert_eq(caller, grant.recipient_rewards_key);

    // Get the current timestamp
    let current_timestamp: u64 = time_oracle.aleo/timestamp.get(0u8);

    // Assert that the current timestamp is before the cliff
    assert(current_timestamp < grant.cliff_timestamp);

    // Ensure the number of credits in the principal remains above the initial deposit
    // fetch the bonded state
    let bonded_credits: u64 = credits.aleo/bonded.get(self.address);
    // assert that the credits bonded are still > 10_000 credits after rewards withdrawal
    assert(bonded_credits - reward_amount > MIN_BONDED_CREDITS);

    // Update the grant
    // todo: don't think we need to update here
    let updated_grant: Grant = Grant {
      credits_amount: grant.credits_amount,
      recipient_rewards_key: grant.recipient_rewards_key,
      recipient_principal_key: grant.recipient_principal_key,
      start_timestamp: grant.start_timestamp,
      cliff_timestamp: grant.cliff_timestamp,
      fully_vested_timestamp: grant.fully_vested_timestamp,
      is_processed: grant.is_processed
    };
    grants.set(id, updated_grant);
  }

  async transition withdraw_principal(
    id: u8,
    amount: u128
  ) -> Future {
    let f0: Future = credits.aleo/unbond_public(self.address, amount);

    return finalize_withdraw_principal(f0, id, amount);
  }

  async function finalize_withdraw_principal(
    f0: Future,
    id: u8,
    amount: u128,
    caller: address
  ) {
    f0.await();

    // Get the grant
    let grant: Grant = grants.get(id);

    // Ensure the caller is the recipient_principal_key
    assert_eq(caller, grant.recipient_principal_key);

    // Get the current timestamp
    let current_timestamp: u64 = time_oracle.aleo/timestamp.get(0u8);

    // Assert that the current timestamp is after the cliff
    assert(current_timestamp >= grant.cliff_timestamp);

    // Calculate the vested credits
    let timestamps_since_start: u64 = current_timestamp - grant.start_timestamp;
    let total_vesting_timestamps: u64 = grant.fully_vested_timestamp - grant.start_timestamp;
    let vested_credits: u128 = grant.credits_amount as u128 * timestamps_since_start as u128 / total_vesting_timestamps as u128;
    let bounded_vested_credits: u128 = vested_credits < grant.credits_amount as u128 ? vested_credits : grant.credits_amount as u128;
    let minimum_credits_balance: u128 = grant.credits_amount as u128 - bounded_vested_credits;
    assert(grantee_credits_balance >= minimum_credits_balance as u128);

    // Update the grant
    // todo: don't think we need to update here
    let updated_grant: Grant = Grant {
      credits_amount: grant.credits_amount,
      recipient_rewards_key: grant.recipient_rewards_key,
      recipient_principal_key: grant.recipient_principal_key,
      start_timestamp: grant.start_timestamp,
      cliff_timestamp: grant.cliff_timestamp,
      fully_vested_timestamp: grant.fully_vested_timestamp,
      is_processed: grant.is_processed
    };
    grants.set(id, updated_grant);
  }


  async transition claim_withdrawal_public (
    amount: u64
  ) {
    // todo: add admin assertions
    let f0: Future = credits.aleo/claim_unbond_public(self.address);
    let f1: Future = credits.aleo/transfer_public(GRANTEE_PRINCIPAL_KEY, amount);
    return finalize_withdraw_principal(f0);
  }

  async function finalize_claim_withdrawal_public () {
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
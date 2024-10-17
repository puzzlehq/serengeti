import credits.aleo;

// The 'grant_disbursement' program.
program grant_disbursement_puzzle.aleo {
  // todo: update grantee rewards key
  const GRANTEE_REWARDS_KEY: address = aleo12shtwnmf49t5atmad2jnk3e58ahtp749d9trctt9z3wryxyzt5pspp0nd0;
  // todo: update this maybe
  const GRANTEE_PRINCIPAL_KEY: address = aleo1z9y9afh0h6dnyj3f0hvjc4mhayjy06fj42ppcq0rvpmmyky6fuzs449sjr;
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
    paleo_amount: u128,
  ) -> Future {
    // Transfer the credits to signer temporarily to deposit into the pondo core protocol
    let f0: Future = credits.aleo/transfer_public(self.signer, credits_amount);

    // todo: add bond_public

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
    f2.await();

    /* START Verify deposit as sufficient */

    /* END Verify deposit as sufficient */

    // Get the grant
    let grant: Grant = grants.get(grant_id);

    // Assert the credits amount is the same
    assert_eq(credits_amount, grant.credits_amount);
    // Assert that the grant has not been processed
    assert(!grant.is_processed);

    // Update the grant, with the new paleo amount
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
    amount: u128
  ) -> Future {
    // Transfer the pAleo to the recipient_rewards_key
    let f0: Future = credits.aleo/transfer_public(self.signer, amount);

    return finalize_withdraw_rewards(f0, id, paleo_amount, self.caller);
  }

  async function finalize_withdraw_rewards(
    f0: Future,
    id: u8,
    paleo_amount: u128,
    caller: address
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
    // Note: the paleo pool and the credits pool are always an underestimate (assuming no slashing) as it does not include rewards & owed commissions
    // We use this underestimate because it as significantly reduces gas costs and should be close to the actual amount
    // As it is an underestimate, the downside is it will slightly reduce the amount of paleo that can be withdrawn

    // Update the grant
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
    // Transfer the pAleo to the recipient_rewards_key
    let f0: Future = credits.aleo/transfer_public(self.signer, amount);

    return finalize_withdraw_principal(f0, id, amount, self.caller);
  }

  async function finalize_withdraw_principal(
    f0: Future,
    id: u8,
    paleo_amount: u128,
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

    // Ensure the number of credits in the principal remains above the initial deposit
    // Note: the paleo pool and the credits pool are always an underestimate (assuming no slashing) as it does not include rewards & owed commissions
    // We use this underestimate because it as significantly reduces gas costs and should be close to the actual amount
    // As it is an underestimate, the downside is it will slightly reduce the amount of paleo that can be withdrawn

    // Calculate the vested credits
    let timestamps_since_start: u64 = current_timestamp - grant.start_timestamp;
    let total_vesting_timestamps: u64 = grant.fully_vested_timestamp - grant.start_timestamp;
    let vested_credits: u128 = grant.credits_amount as u128 * timestamps_since_start as u128 / total_vesting_timestamps as u128;
    let bounded_vested_credits: u128 = vested_credits < grant.credits_amount as u128 ? vested_credits : grant.credits_amount as u128;
    let minimum_credits_balance: u128 = grant.credits_amount as u128 - bounded_vested_credits;
    assert(grantee_credits_balance >= minimum_credits_balance as u128);

    // Update the grant
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

  // shadowed from token_registry.aleo
  struct TokenMetadata {
    token_id: field,
    name: u128,
    symbol: u128,
    decimals: u8,
    supply: u128,
    max_supply: u128,
    admin: address,
    external_authorization_required: bool,
    external_authorization_party: address
  }

  // shadowed from token_registry.aleo
  struct TokenOwner {
    account: address,
    token_id: field
  }

  // shadowed from token_registry.aleo
  struct Balance {
    token_id: field,
    account: address,
    balance: u128,
    authorized_until: u32
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
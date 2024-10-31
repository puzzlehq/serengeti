import credits.aleo;

program puzzle_staking_v001.aleo {
  // Owner of the program
  const ADMIN: address = aleo1as9067txqeya80e720ge68pt9faj6ymy20drfr5a7stfntyk95rqmv9afs;
  // todo - update this to be our validator
  const PUZZLE_VALIDATOR_ADDRESS: address = aleo1zdzzxfrhgzlhh89vqpf4384ewqs0g32wqzvdeltzlynq25hkju8s38953f;
  const SHARES_TO_MICROCREDITS: u64 = 1_000u64;
  const PRECISION_UNSIGNED: u128 = 1_000u128;
  const MAX_COMMISSION_RATE: u128 = 500u128;
  const UNBONDING_PERIOD: u32 = 360u32;
  const MINIMUM_BOND_AMOUNT: u64 = 10_000_000_000u64;

  // copied from credits.aleo, as structs are not importable
  struct bond_state {
    // The address of the validator.
    validator: address,
    // The amount of microcredits that are currently bonded to the specified validator.
    microcredits: u64
  }

  // copied from credits.aleo, as structs are not importable
  // The `unbond_state` struct tracks the microcredits that are currently unbonding, along with the unlock height.
  struct unbond_state {
    // The amount of microcredits that are currently unbonding.
    microcredits: u64,
    // The block height at which the unbonding will be complete, and can be claimed.
    height: u32
  }

  // 0u8 -> Whether the program has been initialized
  mapping is_initialized: u8 => bool;

  /** Commission rate: 0u8 -> u128
    * percentage of rewards taken as commission
    * relative to precision of 1000
    * e.g. 100u128 = 10%
  */
  mapping commission_percent: u8 => u128;

  // 0u8 -> address of validator
  // 1u8 -> the address of the next validator, automatically updated after calling "bond_all"
  mapping validator: u8 => address;

  // 0u8 -> total balance of microcredits pooled
  mapping total_balance: u8 => u64;

  // 0u8 -> balance of deposits that have not been bonded, updated when calling "bond_all"
  mapping pending_deposits: u8 => u64;

  // 0u8 -> total pool of delegator shares
  mapping total_shares: u8 => u64;

  // address -> number of shares held by the delegator with this address
  mapping delegator_shares: address => u64;

  // 0u8 -> balance pending withdrawal currently unbonding
  // 1u8 -> balance pending withdrawal owned by the program
  mapping pending_withdrawal: u8 => u64;

  /** Unbonding allowed: 0u8 ->
    * The height at which the current withdrawal batch will be done unbonding
    * if not present or == 0u32, a new batch can begin unbonding
  */
  mapping current_batch_height: u8 => u32;

  struct withdrawal_state {
    microcredits: u64,
    claim_block: u32
  }

  // address -> pending withdrawal for the delegator with this address
  mapping withdrawals: address => withdrawal_state;


  //
  // ###### Initialization Functions
  //

  async transition initialize(public commission_rate: u128, public validator_address: address) -> Future {
    assert_eq(self.caller, ADMIN);
    assert(commission_rate < PRECISION_UNSIGNED);
    assert(commission_rate <= MAX_COMMISSION_RATE);
    assert_neq(validator_address, self.address);

    return finalize_initialize(commission_rate, validator_address);
  }

  async function finalize_initialize(commission_rate: u128, validator_address: address) {
    let initialized: bool = is_initialized.get_or_use(0u8, false);
    assert_eq(initialized, false);

    is_initialized.set(0u8, true);
    commission_percent.set(0u8, commission_rate);
    validator.set(0u8, validator_address);
    total_shares.set(0u8, 0u64);
    total_balance.set(0u8, 0u64);
    // pending_deposits.set(0u8, 0u64);
    pending_withdrawal.set(0u8, 0u64);
    pending_withdrawal.set(1u8, 0u64);
    current_batch_height.set(0u8, 0u32);
  }

  async transition initial_deposit(
    public microcredits: u64,
  ) -> (Future) {
    assert_eq(self.caller, ADMIN);
    // transfer initial > 10k credits into the protocol
    let f1: Future = credits.aleo/transfer_public_as_signer(self.address, microcredits);
    // program bonds the 10k credits to the puzzle validator
    let f2: Future = credits.aleo/bond_public(PUZZLE_VALIDATOR_ADDRESS, self.address, microcredits);

    return finalize_initial_deposit(f1, f2, microcredits);
  }

  async function finalize_initial_deposit(
    f1: Future,
    f2: Future,
    microcredits: u64,
  ) {
    f1.await();
    f2.await();

    // assert that the contract is initialized
    assert(is_initialized.get(0u8));
    // validate that the initial balance is set to 0
    let balance: u64 = total_balance.get_or_use(0u8, 0u64);
    // validate that the initial shares are set to 0
    let shares: u64 = total_shares.get_or_use(0u8, 0u64);
    // assert that the balance is 0
    assert_eq(balance, 0u64);
    // assert that the shares are eq to
    assert_eq(shares, 0u64);
    // set the total balance to the microcredits passed in
    total_balance.set(0u8, microcredits);
    // set the shares to the microcredits * the number of shares
    shares = microcredits * SHARES_TO_MICROCREDITS;
    total_shares.set(0u8, shares);
    // set the number of shares held by the admin in the delegator shares mapping
    delegator_shares.set(ADMIN, shares);
  }

  //
  // ###### Deposit Functions
  //

  async transition deposit_public(
    public microcredits: u64
  ) -> Future {
    // Transfer credits from the user to the contract
    let f1: Future = credits.aleo/transfer_public_as_signer(self.address, microcredits);
    // Bond the credits immediately to the validator
    let f2: Future = credits.aleo/bond_public(PUZZLE_VALIDATOR_ADDRESS, self.address, microcredits);

    return finalize_deposit_public(f1, f2, self.caller, microcredits);
  }

  async function finalize_deposit_public(
    f1: Future,
    f2: Future,
    caller: address,
    microcredits: u64
  ) {
    f1.await();
    f2.await();

    let base: bond_state = bond_state {
        validator: self.address,
        microcredits: 0u64
    };

    let bonded: u64 = credits.aleo/bonded.get_or_use(self.address, base).microcredits;

    // Retrieve current balance and shares before the deposit
    let current_balance: u64 = total_balance.get_or_use(0u8, 0u64);
    let current_shares: u64 = total_shares.get_or_use(0u8, 0u64);
    let admin_shares: u64 = delegator_shares.get_or_use(ADMIN, 0u64);

    // Calculate rewards as bonded - (current_balance + microcredits) -> total in pool - current "set bal" + newly deposited
    let rewards: i64 = bonded as i64 - (current_balance as i64 + microcredits as i64);
    let rewards_to_distribute: u64 = rewards > 0i64 ? rewards as u64 : 0u64;

    // Calculate commission and new commission shares
    let commission_rate: u128 = commission_percent.get(0u8);
    let new_commission: u64 = rewards_to_distribute > 0u64
        ? get_commission(rewards_to_distribute as u128, commission_rate)
        : 0u64;

    let net_rewards: u64 = rewards_to_distribute - new_commission;

    let pre_commission_balance: u128 = (current_balance as u128) + (net_rewards as u128);

    let new_commission_shares: u64 = rewards_to_distribute > 0u64
        ? calculate_new_shares_new(
            pre_commission_balance,
            new_commission as u128,
            current_shares as u128
        )
        : 0u64;

    let updated_admin_shares: u64 = admin_shares + new_commission_shares;
    delegator_shares.set(ADMIN, updated_admin_shares);

    let updated_shares: u64 = current_shares + new_commission_shares;

    let updated_balance: u64 = (pre_commission_balance as u64) + new_commission;

    let new_shares: u64 = calculate_new_shares_new(
        updated_balance as u128,
        microcredits as u128,
        updated_shares as u128
    );

    // Ensure at least one share is minted
    assert(new_shares >= 1u64);

    let user_shares: u64 = delegator_shares.get_or_use(caller, 0u64);
    let updated_user_shares: u64 = user_shares + new_shares;
    delegator_shares.set(caller, updated_user_shares);

    let final_total_shares: u64 = updated_shares + new_shares;
    total_shares.set(0u8, final_total_shares);

    let final_total_balance: u64 = updated_balance + microcredits;
    total_balance.set(0u8, final_total_balance);
  }

  // async transition bond_all(public validator_address: address, public amount: u64) -> Future {
  //   // Call will fail if there is any balance still bonded to another validator
  //   let f1: Future = credits.aleo/bond_public(validator_address, self.address, amount);

  //   return finalize_bond_all(f1, validator_address);
  // }

  // async function finalize_bond_all(f1: Future, validator_address: address) {
  //   f1.await();

  //   let account_balance: u64 = credits.aleo/account.get_or_use(self.address, 0u64);
  //   let pending_withdrawals: u64 = pending_withdrawal.get(1u8);
  //   assert(account_balance >= pending_withdrawals);

  //   let base: bond_state = bond_state {
  //     validator: self.address,
  //     microcredits: 0u64
  //   };
  //   let bonded: u64 = credits.aleo/bonded.get_or_use(self.address, base).microcredits;
  //   let current_balance: u64 = total_balance.get(0u8);
  //   let pending_deposit_balance: u64 = pending_deposits.get(0u8);

  //   pending_deposit_balance = account_balance - pending_withdrawals;
  //   pending_deposits.set(0u8, pending_deposit_balance);
  //   total_balance.set(0u8, bonded);

  //   // Set validator
  //   // remove next validator setting
  //   // let next_validator: address = validator.get(1u8);
  //   // assert_eq(validator_address, next_validator);

  //   // validator.set(0u8, next_validator);
  //   // validator.remove(1u8);
  // }

  // async transition bond_deposits(public validator_address: address, public amount: u64) -> Future {
  //   // Call will fail if there is any balance still bonded to another validator
  //   let f1: Future = credits.aleo/bond_public(validator_address, self.address, amount);

  //   return finalize_bond_deposits(f1, amount, validator_address);
  // }

  // async function finalize_bond_deposits(f1: Future, amount: u64, validator_address: address) {
  //   f1.await();

  //   let account_balance: u64 = credits.aleo/account.get_or_use(self.address, 0u64);
  //   let pending_withdrawals: u64 = pending_withdrawal.get(1u8);
  //   assert(account_balance >= pending_withdrawals);

  //   let current_balance: u64 = total_balance.get(0u8);
  //   let pending_deposit_balance: u64 = account_balance - pending_withdrawals;
  //   pending_deposits.set(0u8, pending_deposit_balance);
  //   total_balance.set(0u8, current_balance + amount);

  //   // let has_next_validator: bool = validator.contains(1u8);
  //   // assert_eq(has_next_validator, false);
  //   // assert_eq(validator.get(0u8), validator_address);
  // }

  //
  // ###### Withdraw Functions
  //

  async transition withdraw_public(public withdrawal_shares: u64, public total_withdrawal: u64) -> Future {
    let f1: Future = credits.aleo/unbond_public(self.address, total_withdrawal);

    return finalize_withdraw_public(f1, withdrawal_shares, total_withdrawal, self.caller);
  }

  async function finalize_withdraw_public(f1: Future, withdrawal_shares: u64, total_withdrawal: u64, owner: address) {
    f1.await();

    // Retrieve current balance and shares
    let current_balance: u64 = total_balance.get_or_use(0u8, 0u64);
    let current_shares: u64 = total_shares.get_or_use(0u8, 0u64);
    let admin_shares: u64 = delegator_shares.get_or_use(ADMIN, 0u64);

    // Initialize updated values
    let updated_balance: u64 = current_balance;
    let updated_shares: u64 = current_shares;
    let updated_admin_shares: u64 = admin_shares;

    // Begin reward updating logic
    // Get the bonded amount
    let base: bond_state = bond_state {
        validator: self.address,
        microcredits: 0u64
    };
    let bonded: u64 = credits.aleo/bonded.get_or_use(self.address, base).microcredits;

    // Calculate rewards as bonded - current_balance
    let rewards: i64 = bonded as i64 - current_balance as i64;
    let rewards_to_distribute: u64 = rewards > 0i64 ? rewards as u64 : 0u64;

    // Calculate commission and new commission shares
    let commission_rate: u128 = commission_percent.get(0u8);
    let new_commission: u64 = rewards_to_distribute > 0u64
        ? get_commission(rewards_to_distribute as u128, commission_rate)
        : 0u64;

    let net_rewards: u64 = rewards_to_distribute - new_commission;

    let pre_commission_balance: u128 = (updated_balance as u128) + (net_rewards as u128);

    let new_commission_shares: u64 = rewards_to_distribute > 0u64
        ? calculate_new_shares_new(
            pre_commission_balance,
            new_commission as u128,
            updated_shares as u128
        )
        : 0u64;

    // Update admin's shares
    updated_admin_shares = updated_admin_shares + new_commission_shares;
    delegator_shares.set(ADMIN, updated_admin_shares);

    // Update total shares
    updated_shares = updated_shares + new_commission_shares;

    // Update total balance with net rewards and commission
    updated_balance = (pre_commission_balance as u64) + new_commission;

    // Assert that they have enough shares to withdraw
    let user_shares: u64 = delegator_shares.get_or_use(owner, 0u64);
    assert(user_shares >= withdrawal_shares);

    // Calculate withdrawal amount
    let withdrawal_amount: u64 = (withdrawal_shares as u128 * updated_balance as u128 / updated_shares as u128) as u64;

    // Update user's shares
    let updated_user_shares: u64 = user_shares - withdrawal_shares;
    delegator_shares.set(owner, updated_user_shares);

    // Update total shares and balance
    updated_shares = updated_shares - withdrawal_shares;
    updated_balance = updated_balance - withdrawal_amount;

    total_shares.set(0u8, updated_shares);
    total_balance.set(0u8, updated_balance);

    // Record withdrawal
    let withdrawal: withdrawal_state = withdrawal_state {
        microcredits: withdrawal_amount,
        claim_block: block.height + UNBONDING_PERIOD
    };
    withdrawals.set(owner, withdrawal);
  }


  // async transition unbond_all(public pool_balance: u64) -> (Future) {
  //   let f1: Future = credits.aleo/unbond_public(self.address, pool_balance);

  //   return finalize_unbond_all(f1);
  // }

  // async function finalize_unbond_all(f1: Future) {
  //   f1.await();

  //   // let next_validator: bool = validator.contains(1u8);
  //   // assert(next_validator);

  //   let base: bond_state = bond_state {
  //     validator: self.address,
  //     microcredits: 0u64
  //   };
  //   let bonded: u64 = credits.aleo/bonded.get_or_use(self.address, base).microcredits;
  //   // Assert that the pool was fully unbonded
  //   assert_eq(bonded, 0u64);

  //   // Make sure all commission is claimed before unbonding
  //   let base_unbonding: unbond_state = unbond_state {
  //     microcredits: 0u64,
  //     height: 0u32
  //   };
  //   let unbonding: u64 = credits.aleo/unbonding.get_or_use(self.address, base_unbonding).microcredits;
  //   let unbonding_withdrawals: u64 = pending_withdrawal.get(0u8);
  //   let previously_bonded: u64 = unbonding - unbonding_withdrawals;
  //   let current_balance: u64 = total_balance.get(0u8);
  //   let current_shares: u64 = total_shares.get(0u8);
  //   let rewards: i64 = previously_bonded > current_balance ? previously_bonded as i64 - current_balance as i64 : 0i64;
  //   let commission_rate: u128 = commission_percent.get(0u8);
  //   let new_commission: u64 = get_commission(rewards as u128, commission_rate);
  //   current_balance += rewards as u64 - new_commission;

  //   let pending_deposit_pool: u64 = pending_deposits.get(0u8);
  //   let new_commission_shares: u64 = calculate_new_shares(current_balance as u128, pending_deposit_pool as u128, new_commission as u128, current_shares as u128);
  //   let current_commission: u64 = delegator_shares.get_or_use(ADMIN, 0u64);
  //   delegator_shares.set(ADMIN, current_commission + new_commission_shares);

  //   total_shares.set(0u8, current_shares + new_commission_shares);
  //   total_balance.set(0u8, current_balance + new_commission);
  // }

  // async transition claim_unbond() -> Future {
  //   let f1: Future = credits.aleo/claim_unbond_public(self.address);

  //   return finalize_claim_unbond(f1);
  // }

  // async function finalize_claim_unbond(f1: Future) {
  //   f1.await();

  //   current_batch_height.remove(0u8);
  //   let unbonding_withdrawals: u64 = pending_withdrawal.get(0u8);
  //   let already_claimed: u64 = pending_withdrawal.get(1u8);
  //   already_claimed += unbonding_withdrawals;

  //   pending_withdrawal.set(0u8, 0u64);
  //   pending_withdrawal.set(1u8, already_claimed);
  // }


  async transition claim_withdrawal_public(public amount: u64) -> Future {
    let owner: address = self.caller;

    // Attempt to claim unbonded funds
    let f1: Future = credits.aleo/claim_unbond_public(self.address);

    // Transfer funds to the user
    let f2: Future = credits.aleo/transfer_public(owner, amount);

    return finalize_claim_withdrawal_public(f1, f2, owner, amount);
  }

  async function finalize_claim_withdrawal_public(f1: Future, f2: Future, owner: address, amount: u64) {
    f1.await();
    f2.await();

    let withdrawal: withdrawal_state = withdrawals.get(owner);

    assert(block.height >= withdrawal.claim_block);

    assert_eq(withdrawal.microcredits, amount);

    withdrawals.remove(owner);

    let currently_pending: u64 = pending_withdrawal.get_or_use(1u8, 0u64);
    let updated_pending: u64 = currently_pending - amount;
    pending_withdrawal.set(1u8, updated_pending);
  }



  //
  // ###### Utility Functions
  //

  inline get_commission(
    rewards: u128,
    commission_rate: u128,
  ) -> u64 {
    // calculated as % of the rewards
    // the total rewards accumulated * commission / precision
    let commission: u128 = rewards * commission_rate / PRECISION_UNSIGNED;
    let commission_64: u64 = commission as u64;
    return commission_64;
  }

  // utility function to get the commission
  transition get_commission_test(rewards: u128, commission_rate: u128) -> u64 {
    return get_commission(rewards, commission_rate);
  }

  inline calculate_new_shares(bonded_balance: u128, pending_deposit_pool: u128, deposit: u128, shares: u128) -> u64 {
    let full_balance: u128 = bonded_balance + pending_deposit_pool;
    let new_total_shares: u128 = (shares * (full_balance + deposit)) / full_balance;
    let diff: u128 = new_total_shares - shares;
    let shares_to_mint: u64 = diff as u64;
    return shares_to_mint;
  }

  inline calculate_new_shares_new(total_bal: u128, deposits: u128, shares: u128) -> u64 {
    // If total_shares is zero (first deposit), mint shares equal to deposit amount
    if shares == 0u128 {
        return deposits as u64;
    }
    let new_shares: u128 = (deposits * shares) / total_bal;
    return new_shares as u64;
  }


  // utiility function to calculate the new shares based on the pending deposit pool
  transition calculate_new_shares_test(bonded_balance: u128, pending_deposit_pool: u128, deposit: u128, shares: u128) -> u64 {
    return calculate_new_shares(bonded_balance, pending_deposit_pool, deposit, shares);
  }

  async transition set_commission_percent(public new_commission_rate: u128) -> Future {
    assert_eq(self.caller, ADMIN);
    assert(new_commission_rate < PRECISION_UNSIGNED);
    assert(new_commission_rate <= MAX_COMMISSION_RATE);

    return finalize_set_commission_percent(new_commission_rate);
  }

  async function finalize_set_commission_percent(new_commission_rate: u128) {
      // Retrieve current balances and shares
      let current_balance: u64 = total_balance.get_or_use(0u8, 0u64);
      let current_shares: u64 = total_shares.get_or_use(0u8, 0u64);
      let admin_shares: u64 = delegator_shares.get_or_use(ADMIN, 0u64);

      let base: bond_state = bond_state {
          validator: self.address,
          microcredits: 0u64
      };
      let bonded: u64 = credits.aleo/bonded.get_or_use(self.address, base).microcredits;

      let rewards: i64 = bonded as i64 - current_balance as i64;
      let rewards_to_distribute: u64 = rewards > 0i64 ? rewards as u64 : 0u64;

      let commission_rate: u128 = commission_percent.get(0u8);
      let new_commission: u64 = get_commission(rewards_to_distribute as u128, commission_rate);

      let net_rewards: u64 = rewards_to_distribute - new_commission;

      let pre_commission_balance: u128 = (current_balance as u128) + (net_rewards as u128);

      let new_commission_shares: u64 = calculate_new_shares_new(
          pre_commission_balance,
          new_commission as u128,
          current_shares as u128
      );

      let updated_admin_shares: u64 = admin_shares + new_commission_shares;
      delegator_shares.set(ADMIN, updated_admin_shares);

      let updated_total_shares: u64 = current_shares + new_commission_shares;
      total_shares.set(0u8, updated_total_shares);

      let updated_total_balance: u64 = (pre_commission_balance as u64) + new_commission;
      total_balance.set(0u8, updated_total_balance);

      commission_percent.set(0u8, new_commission_rate);
  }


  // Update the validator address, to be applied automatically on the next bond_all call
  async transition set_next_validator(public validator_address: address) -> Future {
    assert_eq(self.caller, ADMIN);
    assert_neq(validator_address, self.address);

    return finalize_set_next_validator(validator_address);
  }

  async function finalize_set_next_validator(validator_address: address) {
    validator.set(1u8, validator_address);
  }

  async transition claim_commission() -> Future {
    assert_eq(self.caller, ADMIN);
    return finalize_claim_commission();
  }

  async function finalize_claim_commission() {
    // Retrieve current balances and shares
    let current_balance: u64 = total_balance.get_or_use(0u8, 0u64);
    let current_shares: u64 = total_shares.get_or_use(0u8, 0u64);
    let admin_shares: u64 = delegator_shares.get_or_use(ADMIN, 0u64);

    // Get the bonded amount
    let base: bond_state = bond_state {
        validator: self.address,
        microcredits: 0u64
    };
    let bonded: u64 = credits.aleo/bonded.get_or_use(self.address, base).microcredits;

    let rewards: i64 = bonded as i64 - current_balance as i64;
    let rewards_to_distribute: u64 = rewards > 0i64 ? rewards as u64 : 0u64;

    let commission_rate: u128 = commission_percent.get(0u8);
    let new_commission: u64 = get_commission(rewards_to_distribute as u128, commission_rate);

    let net_rewards: u64 = rewards_to_distribute - new_commission;

    let pre_commission_balance: u128 = (current_balance as u128) + (net_rewards as u128);

    let new_commission_shares: u64 = calculate_new_shares_new(
        pre_commission_balance,
        new_commission as u128,
        current_shares as u128
    );

    let updated_admin_shares: u64 = admin_shares + new_commission_shares;
    delegator_shares.set(ADMIN, updated_admin_shares);

    let updated_total_shares: u64 = current_shares + new_commission_shares;
    total_shares.set(0u8, updated_total_shares);

    let updated_total_balance: u64 = (pre_commission_balance as u64) + new_commission;
    total_balance.set(0u8, updated_total_balance);
}


  inline get_new_batch_height(height: u32) -> u32 {
    return height + 1_000u32;
  }

  transition get_new_batch_height_test(height: u32) -> u32 {
    return get_new_batch_height(height);
  }

  async transition create_withdraw_claim(public withdrawal_shares: u64) -> Future {
    return finalize_create_withdraw_claim(withdrawal_shares, self.caller);
  }

  async function finalize_create_withdraw_claim(withdrawal_shares: u64, owner: address) {
      let currently_withdrawing: bool = withdrawals.contains(owner);
      assert_eq(currently_withdrawing, false);

      let current_balance: u64 = total_balance.get_or_use(0u8, 0u64);
      let current_shares: u64 = total_shares.get_or_use(0u8, 0u64);
      let user_shares: u64 = delegator_shares.get_or_use(owner, 0u64);

      assert(user_shares >= withdrawal_shares);

      let base: bond_state = bond_state {
          validator: self.address,
          microcredits: 0u64
      };
      let bonded: u64 = credits.aleo/bonded.get_or_use(self.address, base).microcredits;

      let rewards: i64 = bonded as i64 - current_balance as i64;
      let rewards_to_distribute: u64 = rewards > 0i64 ? rewards as u64 : 0u64;

      let commission_rate: u128 = commission_percent.get(0u8);
      let new_commission: u64 = get_commission(rewards_to_distribute as u128, commission_rate);

      let net_rewards: u64 = rewards_to_distribute - new_commission;

      let pre_commission_balance: u128 = (current_balance as u128) + (net_rewards as u128);

      let new_commission_shares: u64 = rewards_to_distribute > 0u64
          ? calculate_new_shares_new(
              pre_commission_balance,
              new_commission as u128,
              current_shares as u128
          )
          : 0u64;

      let admin_shares: u64 = delegator_shares.get_or_use(ADMIN, 0u64);
      let updated_admin_shares: u64 = admin_shares + new_commission_shares;
      delegator_shares.set(ADMIN, updated_admin_shares);

      let updated_total_shares: u64 = current_shares + new_commission_shares;

      let updated_total_balance: u64 = (pre_commission_balance as u64) + new_commission;

      let withdrawal_amount: u64 = (withdrawal_shares as u128 * updated_total_balance as u128 / updated_total_shares as u128) as u64;

      let updated_user_shares: u64 = user_shares - withdrawal_shares;
      delegator_shares.set(owner, updated_user_shares);

      updated_total_shares = updated_total_shares - withdrawal_shares;
      total_shares.set(0u8, updated_total_shares);

      updated_total_balance = updated_total_balance - withdrawal_amount;
      total_balance.set(0u8, updated_total_balance);

      let withdrawal: withdrawal_state = withdrawal_state {
          microcredits: withdrawal_amount,
          claim_block: block.height + UNBONDING_PERIOD
      };
      withdrawals.set(owner, withdrawal);

      let currently_pending: u64 = pending_withdrawal.get_or_use(1u8, 0u64);
      let updated_pending: u64 = currently_pending + withdrawal_amount;
      pending_withdrawal.set(1u8, updated_pending);
  }
}
import credits.aleo;

program puzzle_staking_g2.aleo {
  // Owner of the program
  const ADMIN: address = aleo1f7zquf7ax3u0gprx6vek9ww9hhz36kgwjkuujq3stxfqc8n9nq8qq4y8ng;
  // todo - update this to be our validator
  const PUZZLE_VALIDATOR_ADDRESS: address = aleo1zdzzxfrhgzlhh89vqpf4384ewqs0g32wqzvdeltzlynq25hkju8s38953f;
  const SHARES_TO_MICROCREDITS: u64 = 1_000u64;
  const PRECISION_FACTOR: u128 = 1_000_000u128;
  const MAX_COMMISSION_RATE: u128 = 500u128;
  const UNBONDING_PERIOD: u32 = 360u32;
  const MINIMUM_BOND_AMOUNT: u64 = 10_000_000_000u64;
  const BLOCKS_PER_EPOCH: u32 = 5u32;


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

  mapping batch_totals: u32 => u64;


  //
  // ###### Initialization Functions
  //

  async transition initialize(public commission_rate: u128, public validator_address: address) -> Future {
    assert_eq(self.caller, ADMIN);
    assert(commission_rate < PRECISION_FACTOR);
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
    pending_deposits.set(0u8, 0u64);
    pending_withdrawal.set(0u8, 0u64);
    pending_withdrawal.set(1u8, 0u64);
    current_batch_height.set(0u8, 0u32);
  }

  async transition initial_deposit(
    public microcredits: u64,
  ) -> Future {
    assert_eq(self.caller, ADMIN);
    assert(microcredits >= MINIMUM_BOND_AMOUNT);
    let f1: Future = credits.aleo/transfer_public_as_signer(self.address, microcredits);
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

    assert(is_initialized.get(0u8));
    let balance: u64 = total_balance.get_or_use(0u8, 0u64);
    let shares: u64 = total_shares.get_or_use(0u8, 0u64);
    assert_eq(balance, 0u64);
    assert_eq(shares, 0u64);
    total_balance.set(0u8, microcredits);
    shares = microcredits * SHARES_TO_MICROCREDITS;
    total_shares.set(0u8, shares);
    delegator_shares.set(ADMIN, shares);
  }

  //
  // ###### Deposit Functions
  //

  async transition deposit_public(
    public microcredits: u64
  ) -> Future {
    let f1: Future = credits.aleo/transfer_public_as_signer(self.address, microcredits);
    return finalize_deposit_public(f1, self.caller, microcredits);
  }

  async function finalize_deposit_public(
    f1: Future,
    caller: address,
    microcredits: u64
  ) {
    f1.await();

    let base: bond_state = bond_state {
      validator: self.address,
      microcredits: 0u64
    };

    let bonded: u64 = credits.aleo/bonded.get_or_use(self.address, base).microcredits;
    let current_balance: u64 = total_balance.get_or_use(0u8, 0u64);
    let current_shares: u64 = total_shares.get_or_use(0u8, 0u64);
    let pending_deposit_pool: u64 = pending_deposits.get_or_use(0u8, 0u64);

    let full_pool: u128 = current_balance as u128 + pending_deposit_pool as u128;
    let new_shares: u64 = calculate_new_shares_new(full_pool, microcredits as u128, current_shares as u128);

    assert(new_shares > 0u64 || microcredits == 0u64);
    new_shares = new_shares == 0u64 && microcredits > 0u64 ? 1u64 : new_shares;

    let user_shares: u64 = delegator_shares.get_or_use(caller, 0u64);
    delegator_shares.set(caller, user_shares + new_shares);

    total_shares.set(0u8, current_shares + new_shares);

    pending_deposits.set(0u8, pending_deposit_pool + microcredits);
  }


  //
  // ###### Bonding Functions
  //

  async transition bond_deposits(public amount: u64) -> Future {
    let f1: Future = credits.aleo/bond_public(PUZZLE_VALIDATOR_ADDRESS, self.address, amount);
    return finalize_bond_deposits(f1, amount);
  }

  async function finalize_bond_deposits(f1: Future, amount: u64) {
    f1.await();

    assert(amount > 0u64);

    let account_balance: u64 = credits.aleo/account.get_or_use(self.address, 0u64);
    let pending_withdrawals: u64 = pending_withdrawal.get(0u8);
    let total_pending_deposits: u64 = pending_deposits.get(0u8);

    assert(account_balance >= pending_withdrawals);
    assert(total_pending_deposits > 0u64);
    assert(amount <= total_pending_deposits);

    let current_balance: u64 = total_balance.get(0u8);

    total_balance.set(0u8, current_balance + amount);
    pending_deposits.set(0u8, total_pending_deposits - amount);
  }

  async transition bond_all(public amount: u64) -> Future {
    let f1: Future = credits.aleo/bond_public(PUZZLE_VALIDATOR_ADDRESS, self.address, amount);
    return finalize_bond_all(f1, amount);
  }

  async function finalize_bond_all(f1: Future, amount: u64) {
    f1.await();

    assert(amount > 0u64);
    let total_pending_deposits: u64 = pending_deposits.get(0u8);
    assert(total_pending_deposits > 0u64);
    assert(amount <= total_pending_deposits);

    let current_balance: u64 = total_balance.get(0u8);

    total_balance.set(0u8, current_balance + total_pending_deposits);
    pending_deposits.set(0u8, total_pending_deposits - amount);
  }


  //
  // ###### Initiate Withdraw Functions
  //

  // force unbond case (for testing)
  async transition emergency_withdraw(amt: u64) -> Future {
    let f1: Future = credits.aleo/transfer_public(ADMIN, amt);
    return finalize_emergency_withdraw(f1);
  }

  async function finalize_emergency_withdraw(f1: Future){
    f1.await();
  }

  async transition withdraw_public(
    public withdrawal_shares: u64,
    public total_withdrawal: u64
  ) -> Future {
    assert(withdrawal_shares > 0u64);
    assert(total_withdrawal > 0u64);

    let f1: Future = credits.aleo/unbond_public(self.address, total_withdrawal);
    return finalize_withdraw_public(f1, withdrawal_shares, total_withdrawal, self.caller);
  }

  async function finalize_withdraw_public(
    f1: Future,
    withdrawal_shares: u64,
    total_withdrawal: u64,
    owner: address
) {
    f1.await();

    let currently_withdrawing: bool = withdrawals.contains(owner);
    assert_eq(currently_withdrawing, false);

    let current_batch: u32 = current_batch_height.get_or_use(0u8, 0u32);
    let min_claim_height: u32 = block.height + UNBONDING_PERIOD;
    let new_batch: bool = current_batch == 0u32;
    let unbonding_allowed: bool = new_batch || current_batch >= min_claim_height;
    assert(unbonding_allowed);

    let current_balance: u64 = total_balance.get_or_use(0u8, 0u64);
    let pending_deposit_pool: u64 = pending_deposits.get_or_use(0u8, 0u64);
    let current_shares: u64 = total_shares.get_or_use(0u8, 0u64);
    let user_shares: u64 = delegator_shares.get_or_use(owner, 0u64);
    assert(user_shares >= withdrawal_shares);
    assert(current_shares >= withdrawal_shares);

    let base_unbonding: unbond_state = unbond_state {
        microcredits: 0u64,
        height: 0u32
    };
    let unbonding: u64 = credits.aleo/unbonding.get_or_use(self.address, base_unbonding).microcredits;
    let unbonding_withdrawals: u64 = pending_withdrawal.get(0u8);
    let newly_unbonded: u64 = unbonding - unbonding_withdrawals;
    let sufficient_deposits: bool = newly_unbonded - total_withdrawal + pending_deposit_pool >= MINIMUM_BOND_AMOUNT;

    let base: bond_state = bond_state {
        validator: self.address,
        microcredits: 0u64
    };
    let bonded: u64 = credits.aleo/bonded.get_or_use(self.address, base).microcredits;
    assert(bonded >= MINIMUM_BOND_AMOUNT || !sufficient_deposits);

    bonded += newly_unbonded;
    let full_pool: u128 = current_balance as u128 + pending_deposit_pool as u128;

    let rewards: i64 = bonded as i64 - full_pool as i64;
    let rewards_to_distribute: i64 = rewards > 0i64 ? rewards : 0i64;

    let commission_rate: u128 = commission_percent.get(0u8);
    let new_commission: u64 = rewards_to_distribute as u64 > 0u64
        ? get_commission(rewards_to_distribute as u128, commission_rate)
        : 0u64;
    let net_rewards: u64 = rewards_to_distribute as u64 - new_commission;

    let updated_balance: u64 = (full_pool as u64) + net_rewards + new_commission;

    let withdrawal_calculation: u128 = (withdrawal_shares as u128 * updated_balance as u128 * PRECISION_FACTOR) / current_shares as u128;
    withdrawal_calculation = withdrawal_calculation / PRECISION_FACTOR;

    let min_withdrawal: u128 = (withdrawal_shares as u128 * updated_balance as u128) / (current_shares as u128 * SHARES_TO_MICROCREDITS as u128);
    min_withdrawal = min_withdrawal > 0u128 ? min_withdrawal : 1u128;

    assert(withdrawal_calculation >= total_withdrawal as u128);
    assert(total_withdrawal as u128 >= min_withdrawal);

    let claim_batch: u32 = current_batch + 1u32;
    let claim_height: u32 = claim_batch * BLOCKS_PER_EPOCH;

    delegator_shares.set(owner, user_shares - withdrawal_shares);
    total_shares.set(0u8, current_shares - withdrawal_shares);
    total_balance.set(0u8, current_balance - total_withdrawal);

    let withdrawal: withdrawal_state = withdrawal_state {
        microcredits: total_withdrawal,
        claim_block: claim_height
    };
    withdrawals.set(owner, withdrawal);
    let batch_total: u64 = batch_totals.get_or_use(claim_batch, 0u64);
    batch_totals.set(claim_batch, batch_total + total_withdrawal);
    let current_pending: u64 = pending_withdrawal.get_or_use(0u8, 0u64);
    pending_withdrawal.set(0u8, current_pending + total_withdrawal);
  }

  //
  // ###### Claim Unbond Function
  //

  async transition claim_unbond() -> Future {
    let f1: Future = credits.aleo/claim_unbond_public(self.address);
    return finalize_claim_unbond(f1);
  }

  async function finalize_claim_unbond(f1: Future) {
    f1.await();

    let unbonding_amount: u64 = pending_withdrawal.get(0u8);
    let claimable_amount: u64 = pending_withdrawal.get(1u8);

    pending_withdrawal.set(0u8, 0u64);
    pending_withdrawal.set(1u8, claimable_amount + unbonding_amount);
  }

  //
  // ###### Claim Withdrawal Function
  //

  async transition claim_withdrawal(public amount: u64) -> Future {
    assert(amount > 0u64);
    let f1: Future = credits.aleo/transfer_public(self.caller, amount);
    return finalize_claim_withdrawal(f1, self.caller, amount);
}

  async function finalize_claim_withdrawal(
    f1: Future,
    owner: address,
    amount: u64
  ) {
    f1.await();

    assert(withdrawals.contains(owner));
    let withdrawal: withdrawal_state = withdrawals.get(owner);

    let current_batch: u32 = block.height / BLOCKS_PER_EPOCH;
    assert(block.height >= withdrawal.claim_block);
    assert_eq(withdrawal.microcredits, amount);
    let claimable_amount: u64 = pending_withdrawal.get(1u8);
    assert(claimable_amount >= amount);

    pending_withdrawal.set(1u8, claimable_amount - amount);
    withdrawals.remove(owner);
  }

  //
  // ###### Utility Functions
  //

  inline get_batch_number(height: u32) -> u32 {
    return height / BLOCKS_PER_EPOCH;
  }

  inline get_commission(
    rewards: u128,
    commission_rate: u128,
  ) -> u64 {
    // calculated as % of the rewards
    // the total rewards accumulated * commission / precision
    let commission: u128 = rewards * commission_rate / PRECISION_FACTOR;
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
    // todo: do i need to handle overflow case here?
    let new_shares: u128 = shares == 0u128 ?
        (deposits * SHARES_TO_MICROCREDITS as u128) :
        (deposits * shares) / total_bal;

    return new_shares == 0u128 && deposits > 0u128 ? 1u64 : new_shares as u64;
  }
  // utiility function to calculate the new shares based on the pending deposit pool
  transition calculate_new_shares_test(bonded_balance: u128, pending_deposit_pool: u128, deposit: u128, shares: u128) -> u64 {
    return calculate_new_shares(bonded_balance, pending_deposit_pool, deposit, shares);
  }

  async transition set_commission_percent(public new_commission_rate: u128) -> Future {
    assert_eq(self.caller, ADMIN);
    assert(new_commission_rate < PRECISION_FACTOR);
    assert(new_commission_rate <= MAX_COMMISSION_RATE);

    return finalize_set_commission_percent(new_commission_rate);
  }

  async function finalize_set_commission_percent(new_commission_rate: u128) {
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
    let updated_balance: u64 = current_balance + net_rewards;

    let commission_shares: u128 = (new_commission as u128 * current_shares as u128 * PRECISION_FACTOR) / updated_balance as u128;
    let new_commission_shares: u64 = (commission_shares / PRECISION_FACTOR) as u64;

    new_commission_shares = new_commission_shares == 0u64 && new_commission > 0u64 ? 1u64 : new_commission_shares;

    let updated_admin_shares: u64 = admin_shares + new_commission_shares;
    delegator_shares.set(ADMIN, updated_admin_shares);

    let updated_total_shares: u64 = current_shares + new_commission_shares;
    total_shares.set(0u8, updated_total_shares);

    let updated_total_balance: u64 = updated_balance + new_commission;
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
    let updated_balance: u64 = current_balance + net_rewards;

    let commission_shares: u128 = (new_commission as u128 * current_shares as u128 * PRECISION_FACTOR) / updated_balance as u128;
    let new_commission_shares: u64 = (commission_shares / PRECISION_FACTOR) as u64;

    new_commission_shares = new_commission_shares == 0u64 && new_commission > 0u64 ? 1u64 : new_commission_shares;

    let updated_admin_shares: u64 = admin_shares + new_commission_shares;
    delegator_shares.set(ADMIN, updated_admin_shares);

    let updated_total_shares: u64 = current_shares + new_commission_shares;
    total_shares.set(0u8, updated_total_shares);

    let updated_total_balance: u64 = updated_balance + new_commission;
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
      let updated_balance: u64 = current_balance + net_rewards + new_commission;

      let withdrawal_calc: u128 = (withdrawal_shares as u128 * updated_balance as u128 * PRECISION_FACTOR) / current_shares as u128;
      let withdrawal_amount: u64 = (withdrawal_calc / PRECISION_FACTOR) as u64;

      delegator_shares.set(owner, user_shares - withdrawal_shares);
      total_shares.set(0u8, current_shares - withdrawal_shares);
      total_balance.set(0u8, updated_balance - withdrawal_amount);

      let withdrawal: withdrawal_state = withdrawal_state {
          microcredits: withdrawal_amount,
          claim_block: block.height + UNBONDING_PERIOD
      };
      withdrawals.set(owner, withdrawal);

      let currently_pending: u64 = pending_withdrawal.get_or_use(1u8, 0u64);
      pending_withdrawal.set(1u8, currently_pending + withdrawal_amount);
  }
}
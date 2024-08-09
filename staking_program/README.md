## Specification
### Required Constants:
```
const ADMIN: address = aleo1kf3dgrz9lqyklz8kqfy0hpxxyt78qfuzshuhccl02a5x43x6nqpsaapqru;
```
Validators will need to set an admin address from which they will be able to control certain aspects of the program, such as the commission rate and address of the validator node
```
const CORE_PROTOCOL: address = aleo17hwvp7fl5da40hd29heasjjm537uqce489hhuc3lwhxfm0njucpq0rvfny;
```
This is the precompiled address of the program itself. This is used for reading the mapping values for the program in `credits.aleo` (account, bonded, etc).
```
const SHARES_TO_MICROCREDITS: u64 = 1_000u64;
```
Shares in the protocol are equivalent to nanocredits (at time of initial deposit) in order to more precisely calculate the commission due to the validator. This constant helps us move between shares and microcredits for the initial deposit.


```
const PRECISION_UNSIGNED: u128 = 1000u128;
```
A constant used for added precision when performing integer calculations


```
const MAX_COMMISSION_RATE: u128 = 500u128;
```
This is the maximum allowed commission rate for the program. It is relative to the `PRECISION_UNSIGNED` above. e.g. 100u128 = 10%


```
const UNBONDING_PERIOD: u32 = 360u32;
```
The unbonding period in blocks, as defined in `credits.aleo` Used for batching withdrawal requests


```
const MINIMUM_BOND_POOL: u64 = 10_000_000_000u64;
```
This minimum stake as defined in `credits.aleo`. Used to ensure an attempt to unbond the full balance will successfully remove the value in the `bonded` mapping.


### Required Mappings:
```
mapping is_initialized: u8 => bool;
```
Key `0u8` stores a boolean showing whether the program has been initialized by the admin.


```
mapping commission_percent: u8 => u128;
```
Key `0u8` stores the percentage of rewards taken as commission. Relative to `PRECISION_UNSIGNED` e.g. 100u128 = 10%


```
mapping validator: u8 => address;
```
Key `0u8` stores the current address used for bonding to the validator.
Key `1u8` stores the next address to use for bonding, in the case the validator address needs to be updated. Automatically reset when the pool funds are bonded.
```
mapping total_balance: u8 => u64;
```
Key `0u8` stores the total balance of microcredits that have been deposited to the program, excluding commissions.


```
mapping total_shares: u8 => u64;
```
Key `0u8` stores the total number of shares owned by delegators. Shares represent the portion of the `total_balance` that a delegator owns. For example, upon withdrawal, we calculate the amount of microcredits to disburse to the delegator based on the portion of the shares pool they own. (`delegator_shares / total_shares`)


```
mapping delegator_shares: address => u64;
```
Maps from a delegator to the number of shares they own.


```
mapping pending_withdrawal: u8 => u64;
```
Key `0u8` stores the total amount of microcredits that delegators are waiting to withdraw.


```
mapping current_batch_height: u8 => u32;
```
Key `0u8` stores the height at which the current batch of withdrawals will be available for claim. Used to prevent indefinite unbonding due to withdrawals. If the value is not present or equal to `0u32`, there is no batch currently unbonding, and a new batch may be started.


```
mapping withdrawals: address => withdrawal_state;
```
Maps from a delegator to their `withdrawal_state`, which contains the amount of microcredits they have pending withdrawal and the height at which they will be available to claim.


### Required Structs:
```
struct withdrawal_state:
	microcredits as u64;
	claim_block as u32;

```
In normal operation of the protocol, most if not all of the credits owned by the protocol will be bonded to a validator, which means withdrawals must unbond, claim, and then transfer credits to the withdrawer.
To keep track of the amount of microcredits a withdrawer can claim, as well as to keep track of when the withdrawer can claim, this struct holds both properties. For use of this struct, see the `withdrawals` mapping, `create_withdraw_claim` finalize block, and the `withdraw_public` finalize block.

### Required Records:
None

### Required Functions:

#### Initialize
The `initialize` function takes two arguments: `commission_rate`, the initial commission rate as a `u128` and `validator_address`, the `address` of the validator the program will bond to.
The transition is straightforward - we assert that it is the admin calling this function and that the commission rate is within bounds.
The finalize confirms that the program has not already been initialized and then sets `is_initialized` to true and sets the initial values for each of the program’s mappings.

#### Initial Deposit
`initial_deposit` takes three arguments: `input_record` (`credits.aleo/credits` record) and `microcredits` (`u64`) which are used to transfer credits into the program, and `validator_address` (`address`) used to call `bond_public` with the credits transferred in. Note: once `transfer_public_signer` is added to `credits.aleo`, we won’t need to accept private records and can instead only take microcredits as the singular argument for this function. Currently, `transfer_public` uses the caller and not the signer to transfer credits, which means the protocol address would be transferring credits from and to itself in this function.
The transition simply asserts that the admin is calling this function and handles the calls to `credits.aleo` for transferring and bonding.
The finalize block first confirms that the program has been initialized, and there are no funds present in the program. It then initializes the balance of microcredits and shares (in nanocredits) and assigns the new shares to the admin in `delegator_shares`.

#### Get Commission
`get_commission` is an inline function (i.e. a helper function that, when compiled to aleo instructions, is inserted directly everywhere it is called) that takes two arguments: `rewards` the total amount of rewards earned from bonding in microcredits, and `commission_rate` the current commission rate of the program both as `u128`s
`get_commission` is used to calculate the portion of rewards that is owed to the validator as commission. We use `u128`s for safety against overflow when multiplying and normalize back to `u64` by dividing by `PRECISION_UNSIGNED`.

#### Calculate New Shares
`calculate_new_shares` is an inline function that takes three arguments: `balance` the total balance of microcredits in the program (deposits + rewards), `deposit` the amount of microcredits being deposited, and `shares` the total amount of shares outstanding.
`calculate_new_shares` is used to determine the amount of shares to mint for the depositor. This is determined by first calculating the ratio of the current amount of shares and the current balance in microcredits. The goal is to keep this ratio constant, so we determine the number of shares to mint based on the relative change in microcredits.
This code represents the following formula:
`new_shares = ( total_shares / total_balance) * (total_balance + deposit) - total_shares`

#### Set Commission Percent
`set_commission_percent` takes one argument: `new_commission_rate` as a `u128` which will be set as the new value for `commission_percent[0u8]`
The transition simply confirms that the program admin is calling this function and that the new commission rate is within bounds.
The concerns of the finalize block are to:
- First claim any remaining commission at the current commission percent, by distributing shares to the program admin
- Set the new commission rate

#### Set Next Validator
`set_next_validator` takes one argument: `validator_address`, the new `address` that the program will bond to after any currently bonded funds are unbonded.
The transition simply confirms that only the admin may call this function, and the finalize block handles setting the value into `validator[1u8]`

#### Unbond All
`unbond_all` takes one argument: `pool_balance` which is the total amount of microcredits to unbond, as a `u64`
The transition simply calls `unbond_public` with the supplied value, and is permissionless.
The finalize block handles the following:
- Confirming that the admin has set a value for the next validator, as `unbond_all` should only occur as part of a validator address change
- Distributing any outstanding commission to the validator
- Asserting that the amount unbonded will result in a complete unbonding (by checking that any difference between `pool_balance` and the actual amount bonded is less than the minimum stake amount)

#### Claim Unbond
`claim_unbond` takes no arguments. The transition simply calls `claim_unbond_public`, to claim any unbonded credits - whether from a withdrawal or as a result of `unbond_all`.
The finalize block removes the value of `current_batch_height` to allow a new withdrawal batch to begin.

#### Bond All
`bond_all` takes two arguments: `validator_address` as an address, and `amount` as a u64.
The transition part is straightforward – the credits.aleo program is called to bond credits held by the protocol to the validator, either the next validator if one is set or to the current validator.
In a nutshell, the concerns of the finalize portion of bond_all are to:
- Ensure there’s not credits unbonding, which means we would be unable to bond to a validator
- Bond all available microcredits to the validator (next or current). Available microcredits depends on pending withdrawals.
- If a next validator is set, bond to the next validator. Set the next validator as the current validator, and remove the next validator.

#### Claim Commission
`claim_commission` takes no arguments. `claim_commission` is intended for the admin of the protocol to harvest rewards from staking at any point.
In a nutshell, the concerns of the finalize portion of `claim_commission` are to:
- Distribute commission shares for the protocol admin
- Update the protocol state

#### Deposit Public
`deposit_public` takes two arguments: `input_record` as a `credits.aleo/credits` record, and `microcredits` as a u64. Note: once `transfer_public_signer` is added to `credits.aleo`, we won’t need to accept private records and can instead only take microcredits as the singular argument for this function. Currently, `transfer_public` uses the caller and not the signer to transfer credits, which means the protocol address would be transferring credits from and to itself in this function.
The transition part is straightforward – the `credits.aleo` program is called to transfer credits from the depositor to the protocol address.
In a nutshell, the concerns of the finalize portion of `deposit_public` are to:
- Distribute commission shares for the protocol admin
- Distribute shares for the depositor, in direct proportion to the amount of the protocol credits pool they just contributed to
- Update the protocol state
Deposit public does not automatically bond the credits. This is for several reasons. By not directly bonding credits, we do not enforce a minimum deposit. We also save the depositor on fees, since the constraints of the bond call are not a part of the overall transition. `bond_all` must be called in order to bond the microcredits held by the protocol to the validator.

#### Withdraw Public
`withdraw_public` takes two arguments: `withdrawal_shares` and `total_withdrawal`, both as u64s. Withdrawal shares are the amount of shares to burn in exchange for `total_withdrawal` microcredits.
`withdraw_public` is meant to be used in the normal operation of the protocol – most credits (excepting deposits and pending withdrawals) should be bonded to the validator.
The transition part is straightforward – the `credits.aleo` program is called to unbond the `total_withdrawal` microcredits from the protocol address.
In a nutshell, the concerns of the finalize portion of `withdraw_public` are to:
- Determine whether this withdrawal will fit into the current withdraw batch, if one is taking place
- Distribute commission shares for the protocol admin
- Ensure that the `total_withdrawal` microcredits are less than or equal to the proportion of microcredits held by the withdrawal_shares
- Update the protocol state
- Set a withdraw claim for the withdrawer so that they may withdraw their shares at a given `claim_height`

#### Get New Batch Height
`get_new_batch_height` is an inline function (i.e. a helper function that, when compiled to aleo instructions, is inserted directly everywhere it is called) takes one argument: `height` as a u32, representing the current block height.
`get_new_batch_height` rounds up the current `block.height` to the nearest 1000th block height. Given an input of 0, we expect an output of 1000. Given input of 999, we expect an output of 1000.

#### Create Withdraw Claim
`create_withdraw_claim` takes one argument: `withdrawal_shares`, as a u64. Withdrawal shares are the amount of shares to burn in exchange for their proportional amount of the protocol’s microcredits.
`create_withdraw_claim` is intended to be used in special circumstances for the protocol. The credits of the protocol should all be unbonded, which means that credits are not earning rewards, and withdrawers do not need to call `unbond_public` from the `credits.aleo` program.
In a nutshell, the concerns of the finalize portion of `create_withdraw_claim` are to:
- Assert that the protocol is fully unbonded from any validator
- Ensure that the withdrawer can withdraw – i.e. they are not currently withdrawing and they have at least as many shares as they are attempting to burn
- Create a `withdrawal_state` so that the withdrawer may claim their credits
- Update the protocol state

#### Claim Withdrawal Public
`claim_withdrawal_public` takes two arguments: `recipient` as an address, and `amount` as a u64. Given that a withdrawer has a withdrawal claim, they can pass in a `recipient` to receive `amount`. Note, to keep the protocol simple, the `amount` must be the full amount of their withdrawal claim.
`claim_withdrawal_public` is intended to be used at any point that the withdrawer has a withdraw claim with a `claim_height` that is greater than or equal to the current block height.
In a nutshell, the concerns of the finalize portion of `claim_withdrawal_public` are to:
- Ensure that the withdrawer can withdraw and that the withdrawer is withdrawing everything in the claim
- Remove the `withdrawal_state` so that the withdrawer may claim more credits in a separate withdrawal process
- Update the protocol state

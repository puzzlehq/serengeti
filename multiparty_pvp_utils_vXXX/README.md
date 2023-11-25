# multiparty_pvp_utils_v011.aleo

## Functions

## We also have a `test.sh` script [here](test.sh) that runs through all the flows.

### stake_transfer_in

`mint_answer` mints answer record on propose_game, verifies a signature by the challenger

Function:
```rust
mint_answer(
  piece_token: Piece,
  sender: address,
  challenger: address,
  opponent: address,
  game_multisig: address,
  amount: u64,
  message_1: field,
  message_2: field,
  message_3: field,
  message_4: field,
  message_5: field,
  sig: signature,
)
```

### mint_multisig_key

`mint_multisig_key` to mint the multisig key record with a seed

Function:
```rust
mint_multisig_key(
  seed: field,
  amount: u64,
  challenger: address,
  opponent: address,
  game_multisig: address,
)
```

## reveal_answer

`reveal_answer` called by challenger to reveal the original answer to verify there was no cheating involved

Function:
```rust
reveal_answer (
  answer: Answer,
  sig: signature,
)
```
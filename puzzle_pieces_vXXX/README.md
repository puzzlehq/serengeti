# puzzle_pieces_v008.aleo

## We also have a `test.sh` script [here](test.sh) that runs through all the flows.

## Functions

### stake_transfer_in

`stake_transfer_in` to stake piece token into a game multisig/shared account.

Function:
```rust
stake_transfer_in(
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

### stake_transfer_out

`stake_transfer_out` to stake piece token out of a game multisig/shared account.

Function:
```rust
stake_transfer_out(
  piece_stake: PieceStake,
  piece_claim: PieceClaim,
  sig: signature,
)
```

## transfer_stakes_to_joint

`transfer_stakes_to_joint` to jointly stake piece token into the game multisig/shared account.

Function:
```rust
transfer_stakes_to_joint (
  piece_stake_challenger: PieceStake,
  piece_claim_challenger: PieceClaim,
  piece_stake_opponent: PieceStake,
  piece_claim_opponent: PieceClaim,
  block_ht: u32,
)
```

### joint_stake_state_update

`joint_stake_state_update` called by challenger to reveal answer in where's alex game

Function:
```rust
joint_stake_state_update(
  reveal_answer_notification_record: RevealAnswerNotification,
  answer_record: multiparty_pvp_utils_v001.leo/Answer.record,
  joint_piece_state: puzzle_pieces_v007.leo/JointPieceState.record,
  claim_signature: puzzle_pieces_v007.leo/ClaimSignature.record,
  sig: signature,
)
```


### joint_stake_transfer_to_winner

`joint_stake_transfer_to_winner` called by anyone with multisig key to end the game and transfer the pieces to the winner

Function:
```rust
joint_stake_transfer_to_winner (
  joint_piece_winner: JointPieceWinner,
  piece_joint_stake: PieceJointStake,
  joint_piece_time_claim: JointPieceTimeClaim,
)
```

### joint_timeout_to_opponent

`joint_timeout_to_opponent` called by opponent using multisig key and valid signature to end the game and transfer the pieces to the winner after a blockheight passes indicating challenger timeout

Function:
```rust
joint_timeout_to_opponent (
  joint_piece_state: JointPieceState,
  joint_piece_time_claim: JointPieceTimeClaim,
  sig: signature,
)
```
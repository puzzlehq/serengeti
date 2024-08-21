import puzzle_arcade_coin_v001.aleo;
program puzzle_multiparty_coin_v001.aleo;


struct Message:
    field_1 as field;
    field_2 as field;
    field_3 as field;
    field_4 as field;
    field_5 as field;

record Stake:
    owner as address.private;
    amount as u64.private;
    challenger as address.private;
    opponent as address.private;
    staker as address.private;

record StakeClaim:
    owner as address.private;
    amount as u64.private;
    claimer as address.private;
    message_1 as field.private;
    message_2 as field.private;
    message_3 as field.private;
    message_4 as field.private;
    message_5 as field.private;
    challenger as address.private;
    opponent as address.private;

record ClaimSignature:
    owner as address.private;
    sig as signature.private;
    amount as u64.private;
    game_multisig as address.private;
    challenger as address.private;
    opponent as address.private;

record JointTimeoutClaim:
    owner as address.private;
    amount as u64.private;
    time_claimer_address as address.private;
    state_updater_address as address.private;
    message_1 as field.private;
    message_2 as field.private;
    message_3 as field.private;
    message_4 as field.private;
    message_5 as field.private;
    game_multisig as address.private;
    challenger as address.private;
    opponent as address.private;
    block_ht as u32.private;

record JointStake:
    owner as address.private;
    amount as u64.private;
    time_claimer_address as address.private;
    state_updater_address as address.private;
    block_ht as u32.private;

record JointState:
    owner as address.private;
    amount as u64.private;
    time_claimer_address as address.private;
    state_updater_address as address.private;
    message_1 as field.private;
    message_2 as field.private;
    message_3 as field.private;
    message_4 as field.private;
    message_5 as field.private;
    challenger as address.private;
    opponent as address.private;
    game_multisig as address.private;

record JointWinner:
    owner as address.private;
    amount as u64.private;
    time_claimer_address as address.private;
    state_updater_address as address.private;
    challenger as address.private;
    opponent as address.private;
    game_multisig as address.private;
    winner as address.private;


function stake_transfer_in:
    input r0 as puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin.record;
    input r1 as u64.private;
    input r2 as address.private;
    input r3 as address.private;
    input r4 as address.private;
    input r5 as field.private;
    input r6 as field.private;
    input r7 as field.private;
    input r8 as field.private;
    input r9 as field.private;
    input r10 as signature.private;
    cast r4 r1 self.signer r5 r6 r7 r8 r9 r2 r3 into r11 as StakeClaim.record;
    cast r4 r1 r2 r3 self.signer into r12 as Stake.record;
    cast self.signer r10 r1 r4 r2 r3 into r13 as ClaimSignature.record;
    call puzzle_arcade_coin_v001.aleo/spend r0 r1 into r14;
    output r11 as StakeClaim.record;
    output r12 as Stake.record;
    output r13 as ClaimSignature.record;
    output r14 as puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin.record;


function stake_transfer_out:
    input r0 as Stake.record;
    input r1 as StakeClaim.record;
    input r2 as signature.private;
    cast r1.message_1 r1.message_2 r1.message_3 r1.message_4 r1.message_5 into r3 as Message;
    sign.verify r2 r1.claimer r3 into r4;
    assert.eq r4 true;
    call puzzle_arcade_coin_v001.aleo/mint r1.claimer r1.amount into r5;
    output r5 as puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin.record;


function join_stakes:
    input r0 as Stake.record;
    input r1 as StakeClaim.record;
    input r2 as Stake.record;
    input r3 as StakeClaim.record;
    input r4 as u32.private;
    add r0.amount r0.amount into r5;
    cast r0.owner r5 r0.opponent r0.challenger r4 into r6 as JointStake.record;
    add r0.amount r0.amount into r7;
    cast r0.challenger r7 r0.opponent r0.challenger r1.message_1 r1.message_2 r1.message_3 r1.message_4 r1.message_5 r0.challenger r0.opponent r0.owner into r8 as JointState.record;
    add r0.amount r0.amount into r9;
    cast r0.owner r9 r0.opponent r0.challenger r3.message_1 r3.message_2 r3.message_3 r3.message_4 r3.message_5 r0.owner r0.challenger r0.opponent r4 into r10 as JointTimeoutClaim.record;
    output r6 as JointStake.record;
    output r10 as JointTimeoutClaim.record;
    output r8 as JointState.record;


function joint_stake_state_update:
    input r0 as JointState.record;
    input r1 as ClaimSignature.record;
    input r2 as address.private;
    cast r0.message_1 r0.message_2 r0.message_3 r0.message_4 r0.message_5 into r3 as Message;
    sign.verify r1.sig r0.state_updater_address r3 into r4;
    assert.eq r4 true;
    cast r0.game_multisig r0.amount r0.time_claimer_address r0.state_updater_address r0.challenger r0.opponent r0.game_multisig r2 into r5 as JointWinner.record;
    output r5 as JointWinner.record;


function joint_stake_transfer_to_winner:
    input r0 as JointWinner.record;
    input r1 as JointStake.record;
    input r2 as JointTimeoutClaim.record;
    is.eq r0.winner r1.time_claimer_address into r3;
    not r3 into r4;
    is.eq r0.winner r1.time_claimer_address into r5;
    or r4 r5 into r6;
    assert.eq r6 true;
    not r3 into r7;
    not r7 into r8;
    is.eq r0.winner r1.state_updater_address into r9;
    or r8 r9 into r10;
    assert.eq r10 true;
    call puzzle_arcade_coin_v001.aleo/mint r0.winner r0.amount into r11;
    output r11 as puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin.record;


function joint_timeout_to_opponent:
    input r0 as JointStake.record;
    input r1 as JointTimeoutClaim.record;
    input r2 as signature.private;
    assert.eq r0.owner r1.owner;
    assert.eq r0.amount r1.amount;
    assert.eq r0.state_updater_address r1.challenger;
    assert.eq r0.time_claimer_address r1.opponent;
    cast r1.message_1 r1.message_2 r1.message_3 r1.message_4 r1.message_5 into r3 as Message;
    sign.verify r2 r1.time_claimer_address r3 into r4;
    assert.eq r4 true;
    call puzzle_arcade_coin_v001.aleo/mint r1.opponent r1.amount into r5;
    output r5 as puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin.record;

program puzzle_pieces_v016.aleo;

struct Message:
    field_1 as field;
    field_2 as field;
    field_3 as field;
    field_4 as field;
    field_5 as field;

record Piece:
    owner as address.private;
    amount as u8.private;

record PieceStake:
    owner as address.private;
    amount as u8.private;
    challenger as address.private;
    opponent as address.private;
    staker as address.private;

record PieceClaim:
    owner as address.private;
    amount as u8.private;
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
    amount as u8.private;
    game_multisig as address.private;
    challenger as address.private;
    opponent as address.private;

record JointPieceTimeClaim:
    owner as address.private;
    amount as u8.private;
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

record PieceJointStake:
    owner as address.private;
    amount as u8.private;
    time_claimer_address as address.private;
    state_updater_address as address.private;
    block_ht as u32.private;

record JointPieceState:
    owner as address.private;
    amount as u8.private;
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

record JointPieceWinner:
    owner as address.private;
    amount as u8.private;
    time_claimer_address as address.private;
    state_updater_address as address.private;
    challenger as address.private;
    opponent as address.private;
    game_multisig as address.private;
    winner as address.private;


function mint_private:
    input r0 as u8.private;
    input r1 as address.private;
    cast r1 r0 into r2 as Piece.record;
    output r2 as Piece.record;


function transfer_private:
    input r0 as Piece.record;
    input r1 as address.private;
    input r2 as u8.private;
    sub r0.amount r2 into r3;
    cast r0.owner r3 into r4 as Piece.record;
    cast r1 r2 into r5 as Piece.record;
    output r4 as Piece.record;
    output r5 as Piece.record;


function stake_transfer_in:
    input r0 as Piece.record;
    input r1 as address.private;
    input r2 as address.private;
    input r3 as address.private;
    input r4 as address.private;
    input r5 as u8.private;
    input r6 as field.private;
    input r7 as field.private;
    input r8 as field.private;
    input r9 as field.private;
    input r10 as field.private;
    input r11 as signature.private;
    is.eq r1 r2 into r12;
    not r12 into r13;
    is.eq r1 r2 into r14;
    or r13 r14 into r15;
    assert.eq r15 true;
    not r12 into r16;
    not r16 into r17;
    is.eq r1 r3 into r18;
    or r17 r18 into r19;
    assert.eq r19 true;
    cast r4 r5 r1 r6 r7 r8 r9 r10 r2 r3 into r20 as PieceClaim.record;
    cast r1 r11 r5 r4 r2 r3 into r21 as ClaimSignature.record;
    cast r4 r5 r2 r3 r1 into r22 as PieceStake.record;
    sub r0.amount r5 into r23;
    cast r1 r23 into r24 as Piece.record;
    output r20 as PieceClaim.record;
    output r22 as PieceStake.record;
    output r21 as ClaimSignature.record;
    output r24 as Piece.record;


function stake_transfer_out:
    input r0 as PieceStake.record;
    input r1 as PieceClaim.record;
    input r2 as signature.private;
    cast r1.message_1 r1.message_2 r1.message_3 r1.message_4 r1.message_5 into r3 as Message;
    sign.verify r2 r1.claimer r3 into r4;
    cast r1.claimer r1.amount into r5 as Piece.record;
    output r5 as Piece.record;


function transfer_stakes_to_joint:
    input r0 as PieceStake.record;
    input r1 as PieceClaim.record;
    input r2 as PieceStake.record;
    input r3 as PieceClaim.record;
    input r4 as u32.private;
    add r0.amount r0.amount into r5;
    cast r0.owner r5 r0.opponent r0.challenger r4 into r6 as PieceJointStake.record;
    add r0.amount r0.amount into r7;
    cast r0.challenger r7 r0.opponent r0.challenger r1.message_1 r1.message_2 r1.message_3 r1.message_4 r1.message_5 r0.challenger r0.opponent r0.owner into r8 as JointPieceState.record;
    add r0.amount r0.amount into r9;
    cast r0.owner r9 r0.opponent r0.challenger r3.message_1 r3.message_2 r3.message_3 r3.message_4 r3.message_5 r0.owner r0.challenger r0.opponent r4 into r10 as JointPieceTimeClaim.record;
    output r6 as PieceJointStake.record;
    output r10 as JointPieceTimeClaim.record;
    output r8 as JointPieceState.record;


function joint_stake_state_update:
    input r0 as JointPieceState.record;
    input r1 as ClaimSignature.record;
    input r2 as address.private;
    cast r0.message_1 r0.message_2 r0.message_3 r0.message_4 r0.message_5 into r3 as Message;
    sign.verify r1.sig r0.state_updater_address r3 into r4;
    assert.eq true r4;
    cast r0.game_multisig r0.amount r0.time_claimer_address r0.state_updater_address r0.challenger r0.opponent r0.game_multisig r2 into r5 as JointPieceWinner.record;
    output r5 as JointPieceWinner.record;


function joint_stake_transfer_to_winner:
    input r0 as JointPieceWinner.record;
    input r1 as PieceJointStake.record;
    input r2 as JointPieceTimeClaim.record;
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
    cast r0.winner r0.amount into r11 as Piece.record;
    output r11 as Piece.record;


function joint_timeout_to_opponent:
    input r0 as PieceJointStake.record;
    input r1 as JointPieceTimeClaim.record;
    input r2 as signature.private;
    assert.eq r0.owner r1.owner;
    assert.eq r0.amount r1.amount;
    assert.eq r0.state_updater_address r1.challenger;
    assert.eq r0.time_claimer_address r1.opponent;
    cast r1.message_1 r1.message_2 r1.message_3 r1.message_4 r1.message_5 into r3 as Message;
    sign.verify r2 r1.time_claimer_address r3 into r4;
    assert.eq true r4;
    cast r1.opponent r1.amount into r5 as Piece.record;
    output r5 as Piece.record;

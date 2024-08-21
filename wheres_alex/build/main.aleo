import puzzle_arcade_coin_v001.aleo;
import puzzle_multiparty_coin_v001.aleo;
program wheres_alex_v019.aleo;









record Answer:
    owner as address.private;
    challenger_address as address.private;
    opponent_address as address.private;
    game_multisig as address.private;
    amount as u64.private;
    nonce as field.private;
    answer as u8.private;

record Key:
    owner as address.private;
    seed as field.private;
    game_multisig as address.private;

record Game:
    owner as address.private;
    challenger_commit as field.private;
    opponent_answer as u8.private;
    total_pot as u64.private;
    challenger_address as address.private;
    opponent_address as address.private;
    game_multisig as address.private;
    game_state as u8.private;

record Proposal:
    owner as address.private;
    game_multisig as address.private;
    game_state as u8.private;
    total_pot as u64.private;
    challenger_address as address.private;

record RevealAnswerNotification:
    owner as address.private;
    game_multisig as address.private;
    game_state as u8.private;
    your_turn as boolean.private;
    total_pot as u64.private;
    opponent_answer as u8.private;

record GameFinishReqNotification:
    owner as address.private;
    game_multisig as address.private;
    game_state as u8.private;
    your_turn as boolean.private;
    total_pot as u64.private;
    challenger_answer as u8.private;
    opponent_answer as u8.private;

record GameFinishedNotification:
    owner as address.private;
    game_multisig as address.private;
    game_state as u8.private;
    total_pot as u64.private;


function propose_game:
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
    input r11 as field.private;
    input r12 as u8.private;
    input r13 as field.private;
    assert.eq self.caller self.signer;
    assert.neq r4 r3;
    is.eq r12 0u8 into r14;
    is.eq r12 1u8 into r15;
    or r14 r15 into r16;
    assert.eq r16 true;
    cast r11 into r17 as scalar;
    commit.bhp256 r12 r17 into r18 as field;
    gt r1 0u64 into r19;
    gte r0.amount r1 into r20;
    and r19 r20 into r21;
    assert.eq r21 true;
    call puzzle_multiparty_coin_v001.aleo/stake_transfer_in r0 r1 r2 r3 r4 r5 r6 r7 r8 r9 r10 into r22 r23 r24 r25;
    cast r3 r13 r4 into r26 as Key.record;
    add r1 r1 into r27;
    cast r3 r4 1u8 r27 r2 into r28 as Proposal.record;
    add r1 r1 into r29;
    cast r4 r18 0u8 r29 r2 r3 r4 1u8 into r30 as Game.record;
    cast r2 r2 r3 r4 r1 r11 r12 into r31 as Answer.record;
    output r22 as puzzle_multiparty_coin_v001.aleo/StakeClaim.record;
    output r23 as puzzle_multiparty_coin_v001.aleo/Stake.record;
    output r24 as puzzle_multiparty_coin_v001.aleo/ClaimSignature.record;
    output r25 as puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin.record;
    output r31 as Answer.record;
    output r26 as Key.record;
    output r30 as Game.record;
    output r28 as Proposal.record;


function submit_wager:
    input r0 as puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin.record;
    input r1 as Key.record;
    input r2 as Proposal.record;
    input r3 as field.private;
    input r4 as field.private;
    input r5 as field.private;
    input r6 as field.private;
    input r7 as field.private;
    input r8 as signature.private;
    div r2.total_pot 2u64 into r9;
    gte r0.amount r9 into r10;
    assert.eq r10 true;
    div r2.total_pot 2u64 into r11;
    call puzzle_multiparty_coin_v001.aleo/stake_transfer_in r0 r11 r2.challenger_address self.signer r2.game_multisig r3 r4 r5 r6 r7 r8 into r12 r13 r14 r15;
    output r12 as puzzle_multiparty_coin_v001.aleo/StakeClaim.record;
    output r13 as puzzle_multiparty_coin_v001.aleo/Stake.record;
    output r14 as puzzle_multiparty_coin_v001.aleo/ClaimSignature.record;
    output r15 as puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin.record;


function accept_game:
    input r0 as Game.record;
    input r1 as u8.private;
    input r2 as puzzle_multiparty_coin_v001.aleo/Stake.record;
    input r3 as puzzle_multiparty_coin_v001.aleo/StakeClaim.record;
    input r4 as puzzle_multiparty_coin_v001.aleo/Stake.record;
    input r5 as puzzle_multiparty_coin_v001.aleo/StakeClaim.record;
    input r6 as u32.private;
    is.eq r1 0u8 into r7;
    is.eq r1 1u8 into r8;
    or r7 r8 into r9;
    assert.eq r9 true;
    call puzzle_multiparty_coin_v001.aleo/join_stakes r2 r3 r4 r5 r6 into r10 r11 r12;
    cast r0.challenger_address r0.owner 3u8 true r0.total_pot r1 into r13 as RevealAnswerNotification.record;
    cast r0.owner r0.challenger_commit r1 r0.total_pot r0.challenger_address r0.opponent_address r0.game_multisig 3u8 into r14 as Game.record;
    output r10 as puzzle_multiparty_coin_v001.aleo/JointStake.record;
    output r11 as puzzle_multiparty_coin_v001.aleo/JointTimeoutClaim.record;
    output r12 as puzzle_multiparty_coin_v001.aleo/JointState.record;
    output r13 as RevealAnswerNotification.record;
    output r14 as Game.record;


function reveal_answer_game:
    input r0 as RevealAnswerNotification.record;
    input r1 as Answer.record;
    input r2 as puzzle_multiparty_coin_v001.aleo/JointState.record;
    input r3 as puzzle_multiparty_coin_v001.aleo/ClaimSignature.record;
    assert.eq r2.state_updater_address self.signer;
    assert.eq self.caller self.signer;
    is.eq r0.opponent_answer r1.answer into r4;
    ternary r4 r1.opponent_address r1.challenger_address into r5;
    is.eq r5 r1.challenger_address into r6;
    ternary r6 r1.opponent_address r1.challenger_address into r7;
    cast r1.game_multisig r1.challenger_address r1.opponent_address r1.game_multisig r1.amount r1.nonce r1.answer into r8 as Answer.record;
    call puzzle_multiparty_coin_v001.aleo/joint_stake_state_update r2 r3 r5 into r9;
    cast r1.opponent_address r1.game_multisig 4u8 true r2.amount r1.answer r0.opponent_answer into r10 as GameFinishReqNotification.record;
    cast r1.challenger_address r1.game_multisig 4u8 true r2.amount r1.answer r0.opponent_answer into r11 as GameFinishReqNotification.record;
    output r8 as Answer.record;
    output r9 as puzzle_multiparty_coin_v001.aleo/JointWinner.record;
    output r10 as GameFinishReqNotification.record;
    output r11 as GameFinishReqNotification.record;


function finish_game:
    input r0 as Game.record;
    input r1 as puzzle_multiparty_coin_v001.aleo/JointWinner.record;
    input r2 as puzzle_multiparty_coin_v001.aleo/JointStake.record;
    input r3 as puzzle_multiparty_coin_v001.aleo/JointTimeoutClaim.record;
    assert.eq r0.owner self.signer;
    assert.eq self.caller self.signer;
    is.eq r1.winner r0.challenger_address into r4;
    ternary r4 r0.opponent_address r0.challenger_address into r5;
    call puzzle_multiparty_coin_v001.aleo/joint_stake_transfer_to_winner r1 r2 r3 into r6;
    cast r0.owner r0.challenger_commit r0.opponent_answer r0.total_pot r0.challenger_address r0.opponent_address r0.game_multisig 5u8 into r7 as Game.record;
    cast r0.challenger_address r0.game_multisig 5u8 r0.total_pot into r8 as GameFinishedNotification.record;
    cast r0.opponent_address r0.game_multisig 5u8 r0.total_pot into r9 as GameFinishedNotification.record;
    output r6 as puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin.record;
    output r7 as Game.record;
    output r8 as GameFinishedNotification.record;
    output r9 as GameFinishedNotification.record;

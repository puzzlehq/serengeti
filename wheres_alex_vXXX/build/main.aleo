import puzzle_pieces_v007.aleo;
import multiparty_pvp_utils_v001.aleo;
program wheres_alex_v001.aleo;






















record Game:
    owner as address.private;
    challenger_commit as field.private;
    opponent_answer as field.private;
    total_pot as u64.private;
    challenger_address as address.private;
    opponent_address as address.private;
    game_multisig as address.private;
    game_state as field.private;

record GameReqNotification:
    owner as address.private;
    game_multisig as address.private;
    game_state as field.private;
    your_turn as boolean.private;
    total_pot as u64.private;
    challenger_address as address.private;
    opponent_address as address.private;

record WaitingAcceptanceNotification:
    owner as address.private;
    game_multisig as address.private;
    game_state as field.private;
    your_turn as boolean.private;
    total_pot as u64.private;
    challenger_address as address.private;
    opponent_address as address.private;

record ChallengerWagerNotification:
    owner as address.private;
    game_multisig as address.private;
    game_state as field.private;
    your_turn as boolean.private;
    total_pot as u64.private;
    challenger_address as address.private;
    opponent_address as address.private;

record OpponentWagerNotification:
    owner as address.private;
    game_multisig as address.private;
    game_state as field.private;
    your_turn as boolean.private;
    total_pot as u64.private;
    challenger_address as address.private;
    opponent_address as address.private;

record WaitingRevealNotification:
    owner as address.private;
    game_multisig as address.private;
    game_state as field.private;
    your_turn as boolean.private;
    total_pot as u64.private;
    challenger_address as address.private;
    opponent_address as address.private;

record RevealAnswerNotification:
    owner as address.private;
    game_multisig as address.private;
    game_state as field.private;
    your_turn as boolean.private;
    total_pot as u64.private;
    challenger_address as address.private;
    opponent_address as address.private;


function propose_game:
    input r0 as puzzle_pieces_v007.aleo/Piece.record;
    input r1 as u64.private;
    input r2 as address.private;
    input r3 as address.private;
    input r4 as address.private;
    input r5 as address.private;
    input r6 as field.private;
    input r7 as field.private;
    input r8 as field.private;
    input r9 as field.private;
    input r10 as field.private;
    input r11 as signature.private;
    input r12 as field.private;
    input r13 as field.private;
    input r14 as field.private;
    assert.neq r5 r4;
    is.eq r13 0field into r15;
    is.eq r13 1field into r16;
    or r15 r16 into r17;
    assert.eq r17 true;
    cast r12 into r18 as scalar;
    commit.bhp256 r13 r18 into r19 as field;
    gt r1 0u64 into r20;
    assert.eq r20 true;
    gte r0.amount r1 into r21;
    assert.eq r21 true;
    call puzzle_pieces_v007.aleo/stake_transfer_in r0 r2 r3 r4 r5 r1 r6 r7 r8 r9 r10 r11 into r22 r23 r24 r25 r26;
    call multiparty_pvp_utils_v001.aleo/mint_multisig_key r14 r1 r3 r4 r5 into r27 r28;
    add r1 r1 into r29;
    cast r4 r5 1field true r29 r3 r4 into r30 as GameReqNotification.record;
    add r1 r1 into r31;
    cast r3 r5 1field false r31 r3 r4 into r32 as WaitingAcceptanceNotification.record;
    add r1 r1 into r33;
    cast r5 r19 r13 r33 r3 r4 r5 1field into r34 as Game.record;
    call multiparty_pvp_utils_v001.aleo/mint_answer r3 r4 r5 r1 r12 r13 r6 r7 r8 r9 r10 r11 into r35 r36;
    output r22 as puzzle_pieces_v007.aleo/PieceClaim.record;
    output r23 as puzzle_pieces_v007.aleo/PieceStake.record;
    output r24 as puzzle_pieces_v007.aleo/ClaimSignature.record;
    output r25 as puzzle_pieces_v007.aleo/Piece.record;
    output r26 as puzzle_pieces_v007.aleo/AuditStakeIn.record;
    output r35 as multiparty_pvp_utils_v001.aleo/Answer.record;
    output r36 as multiparty_pvp_utils_v001.aleo/AuditMintAnswer.record;
    output r27 as multiparty_pvp_utils_v001.aleo/Key.record;
    output r28 as multiparty_pvp_utils_v001.aleo/AuditKey.record;
    output r34 as Game.record;
    output r30 as GameReqNotification.record;
    output r32 as WaitingAcceptanceNotification.record;


function submit_wager:
    input r0 as puzzle_pieces_v007.aleo/Piece.record;
    input r1 as address.private;
    input r2 as address.private;
    input r3 as address.private;
    input r4 as address.private;
    input r5 as u64.private;
    input r6 as field.private;
    input r7 as field.private;
    input r8 as field.private;
    input r9 as field.private;
    input r10 as field.private;
    input r11 as signature.private;
    assert.eq self.caller self.signer;
    gt r5 0u64 into r12;
    assert.eq r12 true;
    gte r0.amount r5 into r13;
    assert.eq r13 true;
    call puzzle_pieces_v007.aleo/stake_transfer_in r0 r1 r2 r3 r4 r5 r6 r7 r8 r9 r10 r11 into r14 r15 r16 r17 r18;
    add r5 r5 into r19;
    cast r2 r4 1field false r19 r2 r3 into r20 as ChallengerWagerNotification.record;
    add r5 r5 into r21;
    cast r3 r4 1field true r21 r2 r3 into r22 as OpponentWagerNotification.record;
    output r14 as puzzle_pieces_v007.aleo/PieceClaim.record;
    output r15 as puzzle_pieces_v007.aleo/PieceStake.record;
    output r16 as puzzle_pieces_v007.aleo/ClaimSignature.record;
    output r17 as puzzle_pieces_v007.aleo/Piece.record;
    output r18 as puzzle_pieces_v007.aleo/AuditStakeIn.record;
    output r20 as ChallengerWagerNotification.record;
    output r22 as OpponentWagerNotification.record;


function accept_game:
    input r0 as Game.record;
    input r1 as field.private;
    input r2 as puzzle_pieces_v007.aleo/PieceStake.record;
    input r3 as puzzle_pieces_v007.aleo/PieceClaim.record;
    input r4 as puzzle_pieces_v007.aleo/PieceStake.record;
    input r5 as puzzle_pieces_v007.aleo/PieceClaim.record;
    input r6 as u32.private;
    call puzzle_pieces_v007.aleo/transfer_stakes_to_joint r2 r3 r4 r5 r6 into r7 r8 r9 r10;
    cast r0.opponent_address r0.owner 2field false r0.total_pot r0.challenger_address r0.opponent_address into r11 as WaitingRevealNotification.record;
    cast r0.challenger_address r0.owner 2field true r0.total_pot r0.challenger_address r0.opponent_address into r12 as RevealAnswerNotification.record;
    async accept_game r6 into r13;
    output r7 as puzzle_pieces_v007.aleo/PieceJointStake.record;
    output r8 as puzzle_pieces_v007.aleo/JointPieceTimeClaim.record;
    output r9 as puzzle_pieces_v007.aleo/JointPieceState.record;
    output r10 as puzzle_pieces_v007.aleo/AuditJointStake.record;
    output r11 as WaitingRevealNotification.record;
    output r12 as RevealAnswerNotification.record;
    output r13 as wheres_alex_v001.aleo/accept_game.future;

finalize accept_game:
    input r0 as u32.public;
    sub block.height 100u32 into r1;
    gte r0 r1 into r2;
    assert.eq r2 true;
    add block.height 100u32 into r3;
    lte r0 r3 into r4;
    assert.eq r4 true;


function reveal_answer:

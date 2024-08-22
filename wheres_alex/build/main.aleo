import puzzle_arcade_coin_v002.aleo;
import puzzle_multiparty_coin_v001.aleo;
program wheres_alex_v019.aleo;








record Answer:
    owner as address.private;
    game_multisig as address.private;
    opponent as address.private;
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
    challenger as address.private;
    opponent as address.private;
    game_state as u8.private;

record Proposal:
    owner as address.private;
    game_multisig as address.private;
    game_state as u8.private;
    total_pot as u64.private;
    challenger as address.private;

record OpponentGuess:
    owner as address.private;
    guess as u8.private;


function propose_game:
    input r0 as puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin.record;
    input r1 as u64.private;
    input r2 as address.private;
    input r3 as address.private;
    input r4 as address.private;
    input r5 as field.private;
    input r6 as u8.private;
    input r7 as field.private;
    assert.eq self.caller self.signer;
    assert.neq r4 r3;
    is.eq r6 0u8 into r8;
    is.eq r6 1u8 into r9;
    or r8 r9 into r10;
    assert.eq r10 true;
    cast r5 into r11 as scalar;
    commit.bhp256 r6 r11 into r12 as field;
    gt r1 0u64 into r13;
    gte r0.amount r1 into r14;
    and r13 r14 into r15;
    assert.eq r15 true;
    call puzzle_multiparty_coin_v001.aleo/stake_transfer_in r0 r1 r2 r3 r4 into r16 r17 r18;
    cast r3 r7 r4 into r19 as Key.record;
    add r1 r1 into r20;
    cast r3 r4 1u8 r20 r2 into r21 as Proposal.record;
    add r1 r1 into r22;
    cast r4 r12 0u8 r22 r2 r3 1u8 into r23 as Game.record;
    cast r2 r4 r3 r1 r5 r6 into r24 as Answer.record;
    output r16 as puzzle_multiparty_coin_v001.aleo/StakeClaim.record;
    output r17 as puzzle_multiparty_coin_v001.aleo/Stake.record;
    output r18 as puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin.record;
    output r24 as Answer.record;
    output r19 as Key.record;
    output r23 as Game.record;
    output r21 as Proposal.record;


function submit_wager:
    input r0 as puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin.record;
    input r1 as Key.record;
    input r2 as Proposal.record;
    div r2.total_pot 2u64 into r3;
    gte r0.amount r3 into r4;
    assert.eq r4 true;
    div r2.total_pot 2u64 into r5;
    call puzzle_multiparty_coin_v001.aleo/stake_transfer_in r0 r5 r2.challenger self.signer r2.game_multisig into r6 r7 r8;
    output r6 as puzzle_multiparty_coin_v001.aleo/StakeClaim.record;
    output r7 as puzzle_multiparty_coin_v001.aleo/Stake.record;
    output r8 as puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin.record;



function renege_stake:
    input r0 as puzzle_multiparty_coin_v001.aleo/Stake.record;
    input r1 as puzzle_multiparty_coin_v001.aleo/StakeClaim.record;
    call puzzle_multiparty_coin_v001.aleo/stake_transfer_out r0 r1 into r2 r3;
    async renege_stake r3 into r4;
    output r2 as puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin.record;
    output r4 as wheres_alex_v019.aleo/renege_stake.future;

finalize renege_stake:
    input r0 as puzzle_multiparty_coin_v001.aleo/stake_transfer_out.future;
    await r0;




function renege_stake_all:
    input r0 as puzzle_multiparty_coin_v001.aleo/Stake.record;
    input r1 as puzzle_multiparty_coin_v001.aleo/StakeClaim.record;
    input r2 as puzzle_multiparty_coin_v001.aleo/Stake.record;
    input r3 as puzzle_multiparty_coin_v001.aleo/StakeClaim.record;
    call puzzle_multiparty_coin_v001.aleo/stake_transfer_out r0 r1 into r4 r5;
    call puzzle_multiparty_coin_v001.aleo/stake_transfer_out r2 r3 into r6 r7;
    async renege_stake_all r5 r7 into r8;
    output r4 as puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin.record;
    output r6 as puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin.record;
    output r8 as wheres_alex_v019.aleo/renege_stake_all.future;

finalize renege_stake_all:
    input r0 as puzzle_multiparty_coin_v001.aleo/stake_transfer_out.future;
    input r1 as puzzle_multiparty_coin_v001.aleo/stake_transfer_out.future;
    await r0;
    await r1;



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
    cast r0.challenger r1 into r13 as OpponentGuess.record;
    cast r0.owner r0.challenger_commit r1 r0.total_pot r0.challenger r0.opponent 3u8 into r14 as Game.record;
    output r10 as puzzle_multiparty_coin_v001.aleo/JointStake.record;
    output r11 as puzzle_multiparty_coin_v001.aleo/JointTimeoutClaim.record;
    output r12 as puzzle_multiparty_coin_v001.aleo/JointState.record;
    output r13 as OpponentGuess.record;
    output r14 as Game.record;


function reveal_answer_game:
    input r0 as OpponentGuess.record;
    input r1 as Answer.record;
    input r2 as puzzle_multiparty_coin_v001.aleo/JointState.record;
    is.eq r0.guess r1.answer into r3;
    ternary r3 r1.opponent self.signer into r4;
    cast r1.game_multisig r1.game_multisig r1.opponent r1.amount r1.nonce r1.answer into r5 as Answer.record;
    call puzzle_multiparty_coin_v001.aleo/set_winner r2 r4 self.signer into r6;
    output r5 as Answer.record;
    output r6 as puzzle_multiparty_coin_v001.aleo/JointWinner.record;



function finish_game:
    input r0 as Game.record;
    input r1 as puzzle_multiparty_coin_v001.aleo/JointWinner.record;
    input r2 as puzzle_multiparty_coin_v001.aleo/JointStake.record;
    input r3 as puzzle_multiparty_coin_v001.aleo/JointTimeoutClaim.record;
    call puzzle_multiparty_coin_v001.aleo/transfer_stake_to_winner r1 r2 r3 into r4 r5;
    cast r0.owner r0.challenger_commit r0.opponent_answer r0.total_pot r0.challenger r0.opponent 5u8 into r6 as Game.record;
    async finish_game r5 into r7;
    output r4 as puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin.record;
    output r6 as Game.record;
    output r7 as wheres_alex_v019.aleo/finish_game.future;

finalize finish_game:
    input r0 as puzzle_multiparty_coin_v001.aleo/transfer_stake_to_winner.future;
    await r0;




function finish_game_by_timeout:
    input r0 as Game.record;
    input r1 as puzzle_multiparty_coin_v001.aleo/JointStake.record;
    input r2 as puzzle_multiparty_coin_v001.aleo/JointTimeoutClaim.record;
    cast r0.owner r0.challenger_commit r0.opponent_answer r0.total_pot r0.challenger r0.opponent 6u8 into r3 as Game.record;
    call puzzle_multiparty_coin_v001.aleo/transfer_via_timeout r1 r2 into r4 r5;
    async finish_game_by_timeout r2.block_height r5 into r6;
    output r4 as puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin.record;
    output r3 as Game.record;
    output r6 as wheres_alex_v019.aleo/finish_game_by_timeout.future;

finalize finish_game_by_timeout:
    input r0 as u32.public;
    input r1 as puzzle_multiparty_coin_v001.aleo/transfer_via_timeout.future;
    gt r0 block.height into r2;
    assert.eq r2 true;
    await r1;


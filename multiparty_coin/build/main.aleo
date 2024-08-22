import puzzle_arcade_coin_v002.aleo;
program puzzle_multiparty_coin_v001.aleo;


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

record JointTimeoutClaim:
    owner as address.private;
    amount as u64.private;
    challenger as address.private;
    opponent as address.private;
    block_height as u32.private;

record JointStake:
    owner as address.private;
    amount as u64.private;
    block_height as u32.private;

record JointState:
    owner as address.private;
    amount as u64.private;
    opponent as address.private;
    game_multisig as address.private;

record JointWinner:
    owner as address.private;
    amount as u64.private;
    challenger as address.private;
    opponent as address.private;
    winner as address.private;


function stake_transfer_in:
    input r0 as puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin.record;
    input r1 as u64.private;
    input r2 as address.private;
    input r3 as address.private;
    input r4 as address.private;
    cast r4 r1 self.signer into r5 as StakeClaim.record;
    cast r4 r1 r2 r3 self.signer into r6 as Stake.record;
    call puzzle_arcade_coin_v002.aleo/spend r0 r1 into r7;
    output r5 as StakeClaim.record;
    output r6 as Stake.record;
    output r7 as puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin.record;



function stake_transfer_out:
    input r0 as Stake.record;
    input r1 as StakeClaim.record;
    call puzzle_arcade_coin_v002.aleo/mint_program r1.claimer r1.amount into r2 r3;
    async stake_transfer_out r3 into r4;
    output r2 as puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin.record;
    output r4 as puzzle_multiparty_coin_v001.aleo/stake_transfer_out.future;

finalize stake_transfer_out:
    input r0 as puzzle_arcade_coin_v002.aleo/mint_program.future;
    await r0;



function join_stakes:
    input r0 as Stake.record;
    input r1 as StakeClaim.record;
    input r2 as Stake.record;
    input r3 as StakeClaim.record;
    input r4 as u32.private;
    add r0.amount r0.amount into r5;
    cast self.signer r5 r4 into r6 as JointStake.record;
    add r0.amount r0.amount into r7;
    cast self.signer r7 r0.challenger r0.opponent r4 into r8 as JointTimeoutClaim.record;
    add r0.amount r0.amount into r9;
    cast r0.challenger r9 r0.opponent self.signer into r10 as JointState.record;
    output r6 as JointStake.record;
    output r8 as JointTimeoutClaim.record;
    output r10 as JointState.record;


function set_winner:
    input r0 as JointState.record;
    input r1 as address.private;
    input r2 as address.private;
    cast r0.game_multisig r0.amount r2 r0.opponent r1 into r3 as JointWinner.record;
    output r3 as JointWinner.record;



function transfer_stake_to_winner:
    input r0 as JointWinner.record;
    input r1 as JointStake.record;
    input r2 as JointTimeoutClaim.record;
    call puzzle_arcade_coin_v002.aleo/mint_program r0.winner r1.amount into r3 r4;
    async transfer_stake_to_winner r4 into r5;
    output r3 as puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin.record;
    output r5 as puzzle_multiparty_coin_v001.aleo/transfer_stake_to_winner.future;

finalize transfer_stake_to_winner:
    input r0 as puzzle_arcade_coin_v002.aleo/mint_program.future;
    await r0;




function transfer_via_timeout:
    input r0 as JointStake.record;
    input r1 as JointTimeoutClaim.record;
    assert.eq r0.owner r1.owner;
    assert.eq r0.amount r1.amount;
    call puzzle_arcade_coin_v002.aleo/mint_program r1.opponent r1.amount into r2 r3;
    async transfer_via_timeout r3 into r4;
    output r2 as puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin.record;
    output r4 as puzzle_multiparty_coin_v001.aleo/transfer_via_timeout.future;

finalize transfer_via_timeout:
    input r0 as puzzle_arcade_coin_v002.aleo/mint_program.future;
    await r0;


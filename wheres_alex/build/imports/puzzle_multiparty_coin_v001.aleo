import puzzle_arcade_coin_v002.aleo;
import puzzle_arcade_ticket_v001.aleo;
program puzzle_multiparty_coin_v001.aleo;



record Stake:
    owner as address.private;
    staker as address.private;
    amount as u64.private;

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

record JointWinner:
    owner as address.private;
    amount as u64.private;
    winner as address.private;


function stake_transfer_in:
    input r0 as puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin.record;
    input r1 as u64.private;
    input r2 as address.private;
    input r3 as address.private;
    input r4 as address.private;
    cast r4 r1 self.signer into r5 as StakeClaim.record;
    cast r4 self.signer r1 into r6 as Stake.record;
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
    cast self.signer r5 r0.staker r2.staker r4 into r6 as JointTimeoutClaim.record;
    output r6 as JointTimeoutClaim.record;


function set_winner:
    input r0 as address.private;
    input r1 as u64.private;
    input r2 as address.private;
    cast r0 r1 r2 into r3 as JointWinner.record;
    output r3 as JointWinner.record;



function transfer_stake_to_winner:
    input r0 as JointWinner.record;
    input r1 as JointTimeoutClaim.record;
    mul r0.amount 5u64 into r2;
    call puzzle_arcade_ticket_v001.aleo/mint r0.winner r2 into r3 r4;
    async transfer_stake_to_winner r4 into r5;
    output r3 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r5 as puzzle_multiparty_coin_v001.aleo/transfer_stake_to_winner.future;

finalize transfer_stake_to_winner:
    input r0 as puzzle_arcade_ticket_v001.aleo/mint.future;
    await r0;




function transfer_via_timeout:
    input r0 as JointTimeoutClaim.record;
    mul r0.amount 5u64 into r1;
    call puzzle_arcade_ticket_v001.aleo/mint r0.opponent r1 into r2 r3;
    async transfer_via_timeout r3 into r4;
    output r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r4 as puzzle_multiparty_coin_v001.aleo/transfer_via_timeout.future;

finalize transfer_via_timeout:
    input r0 as puzzle_arcade_ticket_v001.aleo/mint.future;
    await r0;


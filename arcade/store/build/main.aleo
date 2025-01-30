import puzzle_arcade_ticket_v001.aleo;
import par_store_inventory_v4.aleo;
program par_store_v6.aleo;

struct Code:
    pt1 as u128;
    pt2 as u128;
    pt3 as u128;
    pt4 as u128;
    pt5 as u128;

function purchase:
    input r0 as u128.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r2 as u64.private;
    sub r1.amount r2 into r3;
    call puzzle_arcade_ticket_v001.aleo/spend r1 r3 into r4;
    call par_store_inventory_v4.aleo/validate_purchase r0 r2 into r5;
    async purchase r5 into r6;
    output r4 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r6 as par_store_v6.aleo/purchase.future;

finalize purchase:
    input r0 as par_store_inventory_v4.aleo/validate_purchase.future;
    await r0;

function purchase2:
    input r0 as u128.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r3 as u64.private;
    add r1.amount r2.amount into r4;
    sub r4 r3 into r5;
    call puzzle_arcade_ticket_v001.aleo/spend r1 r1.amount into r6;
    sub r2.amount r5 into r7;
    call puzzle_arcade_ticket_v001.aleo/spend r2 r7 into r8;
    call par_store_inventory_v4.aleo/validate_purchase r0 r3 into r9;
    async purchase2 r9 into r10;
    output r8 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r10 as par_store_v6.aleo/purchase2.future;

finalize purchase2:
    input r0 as par_store_inventory_v4.aleo/validate_purchase.future;
    await r0;

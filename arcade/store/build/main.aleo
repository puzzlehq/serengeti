import puzzle_arcade_ticket_v001.aleo;
import par_store_inventory_v3.aleo;
program par_store_v4.aleo;

struct Code:
    pt1 as u128;
    pt2 as u128;
    pt3 as u128;
    pt4 as u128;
    pt5 as u128;

function purchase:
    input r0 as u128.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r2 as par_store_inventory_v3.aleo/Product.record;
    call puzzle_arcade_ticket_v001.aleo/spend r1 r2.price into r3;
    output r3 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;

function two_part_purchase:
    input r0 as u128.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r2 as u64.private;
    input r3 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r4 as u64.private;
    input r5 as par_store_inventory_v3.aleo/Product.record;
    add r2 r4 into r6;
    gte r6 r5.price into r7;
    assert.eq r7 true;
    call puzzle_arcade_ticket_v001.aleo/spend r1 r2 into r8;
    call puzzle_arcade_ticket_v001.aleo/spend r3 r4 into r9;
    output r9 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;

function three_part_purchase:
    input r0 as u128.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r2 as u64.private;
    input r3 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r4 as u64.private;
    input r5 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r6 as u64.private;
    input r7 as par_store_inventory_v3.aleo/Product.record;
    add r2 r4 into r8;
    add r8 r6 into r9;
    gte r9 r7.price into r10;
    assert.eq r10 true;
    call puzzle_arcade_ticket_v001.aleo/spend r1 r2 into r11;
    call puzzle_arcade_ticket_v001.aleo/spend r3 r4 into r12;
    call puzzle_arcade_ticket_v001.aleo/spend r5 r6 into r13;
    output r13 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;

function four_part_purchase:
    input r0 as u128.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r2 as u64.private;
    input r3 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r4 as u64.private;
    input r5 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r6 as u64.private;
    input r7 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r8 as u64.private;
    input r9 as par_store_inventory_v3.aleo/Product.record;
    add r2 r4 into r10;
    add r10 r6 into r11;
    add r11 r8 into r12;
    gte r12 r9.price into r13;
    assert.eq r13 true;
    call puzzle_arcade_ticket_v001.aleo/spend r1 r2 into r14;
    call puzzle_arcade_ticket_v001.aleo/spend r3 r4 into r15;
    call puzzle_arcade_ticket_v001.aleo/spend r5 r6 into r16;
    call puzzle_arcade_ticket_v001.aleo/spend r7 r8 into r17;
    output r17 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;

function five_part_purchase:
    input r0 as u128.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r2 as u64.private;
    input r3 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r4 as u64.private;
    input r5 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r6 as u64.private;
    input r7 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r8 as u64.private;
    input r9 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r10 as u64.private;
    input r11 as par_store_inventory_v3.aleo/Product.record;
    add r2 r4 into r12;
    add r12 r6 into r13;
    add r13 r8 into r14;
    add r14 r10 into r15;
    gte r15 r11.price into r16;
    assert.eq r16 true;
    call puzzle_arcade_ticket_v001.aleo/spend r1 r2 into r17;
    call puzzle_arcade_ticket_v001.aleo/spend r3 r4 into r18;
    call puzzle_arcade_ticket_v001.aleo/spend r5 r6 into r19;
    call puzzle_arcade_ticket_v001.aleo/spend r7 r8 into r20;
    call puzzle_arcade_ticket_v001.aleo/spend r9 r10 into r21;
    output r21 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;

function six_part_purchase:
    input r0 as u128.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r2 as u64.private;
    input r3 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r4 as u64.private;
    input r5 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r6 as u64.private;
    input r7 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r8 as u64.private;
    input r9 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r10 as u64.private;
    input r11 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r12 as u64.private;
    input r13 as par_store_inventory_v3.aleo/Product.record;
    add r2 r4 into r14;
    add r14 r6 into r15;
    add r15 r8 into r16;
    add r16 r10 into r17;
    add r17 r12 into r18;
    gte r18 r13.price into r19;
    assert.eq r19 true;
    call puzzle_arcade_ticket_v001.aleo/spend r1 r2 into r20;
    call puzzle_arcade_ticket_v001.aleo/spend r3 r4 into r21;
    call puzzle_arcade_ticket_v001.aleo/spend r5 r6 into r22;
    call puzzle_arcade_ticket_v001.aleo/spend r7 r8 into r23;
    call puzzle_arcade_ticket_v001.aleo/spend r9 r10 into r24;
    call puzzle_arcade_ticket_v001.aleo/spend r11 r12 into r25;
    output r25 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;

function seven_part_purchase:
    input r0 as u128.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r2 as u64.private;
    input r3 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r4 as u64.private;
    input r5 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r6 as u64.private;
    input r7 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r8 as u64.private;
    input r9 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r10 as u64.private;
    input r11 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r12 as u64.private;
    input r13 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r14 as u64.private;
    input r15 as par_store_inventory_v3.aleo/Product.record;
    add r2 r4 into r16;
    add r16 r6 into r17;
    add r17 r8 into r18;
    add r18 r10 into r19;
    add r19 r12 into r20;
    add r20 r14 into r21;
    gte r21 r15.price into r22;
    assert.eq r22 true;
    call puzzle_arcade_ticket_v001.aleo/spend r1 r2 into r23;
    call puzzle_arcade_ticket_v001.aleo/spend r3 r4 into r24;
    call puzzle_arcade_ticket_v001.aleo/spend r5 r6 into r25;
    call puzzle_arcade_ticket_v001.aleo/spend r7 r8 into r26;
    call puzzle_arcade_ticket_v001.aleo/spend r9 r10 into r27;
    call puzzle_arcade_ticket_v001.aleo/spend r11 r12 into r28;
    call puzzle_arcade_ticket_v001.aleo/spend r13 r14 into r29;
    output r29 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;

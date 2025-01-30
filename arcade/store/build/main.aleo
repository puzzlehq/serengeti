import puzzle_arcade_ticket_v001.aleo;
import par_store_inventory_v3.aleo;
program par_store_v5.aleo;

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

function purchase2:
    input r0 as u128.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r3 as par_store_inventory_v3.aleo/Product.record;
    add r1.amount r2.amount into r4;
    sub r4 r3.price into r5;
    call puzzle_arcade_ticket_v001.aleo/spend r1 r1.amount into r6;
    sub r2.amount r5 into r7;
    call puzzle_arcade_ticket_v001.aleo/spend r2 r7 into r8;
    output r8 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;

function purchase3:
    input r0 as u128.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r3 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r4 as par_store_inventory_v3.aleo/Product.record;
    add r1.amount r2.amount into r5;
    add r5 r3.amount into r6;
    sub r6 r4.price into r7;
    call puzzle_arcade_ticket_v001.aleo/spend r1 r1.amount into r8;
    call puzzle_arcade_ticket_v001.aleo/spend r2 r2.amount into r9;
    call puzzle_arcade_ticket_v001.aleo/spend r3 r7 into r10;
    output r10 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;

function purchase4:
    input r0 as u128.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r3 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r4 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r5 as par_store_inventory_v3.aleo/Product.record;
    add r1.amount r2.amount into r6;
    add r6 r3.amount into r7;
    add r7 r4.amount into r8;
    sub r8 r5.price into r9;
    call puzzle_arcade_ticket_v001.aleo/spend r1 r1.amount into r10;
    call puzzle_arcade_ticket_v001.aleo/spend r2 r2.amount into r11;
    call puzzle_arcade_ticket_v001.aleo/spend r3 r3.amount into r12;
    call puzzle_arcade_ticket_v001.aleo/spend r4 r9 into r13;
    output r13 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;

function purchase5:
    input r0 as u128.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r3 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r4 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r5 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r6 as par_store_inventory_v3.aleo/Product.record;
    add r1.amount r2.amount into r7;
    add r7 r3.amount into r8;
    add r8 r4.amount into r9;
    add r9 r5.amount into r10;
    sub r10 r6.price into r11;
    call puzzle_arcade_ticket_v001.aleo/spend r1 r1.amount into r12;
    call puzzle_arcade_ticket_v001.aleo/spend r2 r2.amount into r13;
    call puzzle_arcade_ticket_v001.aleo/spend r3 r3.amount into r14;
    call puzzle_arcade_ticket_v001.aleo/spend r4 r4.amount into r15;
    call puzzle_arcade_ticket_v001.aleo/spend r5 r11 into r16;
    output r16 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;

function purchase6:
    input r0 as u128.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r3 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r4 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r5 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r6 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r7 as par_store_inventory_v3.aleo/Product.record;
    add r1.amount r2.amount into r8;
    add r8 r3.amount into r9;
    add r9 r4.amount into r10;
    add r10 r5.amount into r11;
    add r11 r6.amount into r12;
    sub r12 r7.price into r13;
    call puzzle_arcade_ticket_v001.aleo/spend r1 r1.amount into r14;
    call puzzle_arcade_ticket_v001.aleo/spend r2 r2.amount into r15;
    call puzzle_arcade_ticket_v001.aleo/spend r3 r3.amount into r16;
    call puzzle_arcade_ticket_v001.aleo/spend r4 r4.amount into r17;
    call puzzle_arcade_ticket_v001.aleo/spend r5 r5.amount into r18;
    call puzzle_arcade_ticket_v001.aleo/spend r6 r13 into r19;
    output r19 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;

function purchase7:
    input r0 as u128.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r3 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r4 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r5 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r6 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r7 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r8 as par_store_inventory_v3.aleo/Product.record;
    add r1.amount r2.amount into r9;
    add r9 r3.amount into r10;
    add r10 r4.amount into r11;
    add r11 r5.amount into r12;
    add r12 r6.amount into r13;
    add r13 r7.amount into r14;
    sub r14 r8.price into r15;
    call puzzle_arcade_ticket_v001.aleo/spend r1 r1.amount into r16;
    call puzzle_arcade_ticket_v001.aleo/spend r2 r2.amount into r17;
    call puzzle_arcade_ticket_v001.aleo/spend r3 r3.amount into r18;
    call puzzle_arcade_ticket_v001.aleo/spend r4 r4.amount into r19;
    call puzzle_arcade_ticket_v001.aleo/spend r5 r5.amount into r20;
    call puzzle_arcade_ticket_v001.aleo/spend r6 r6.amount into r21;
    call puzzle_arcade_ticket_v001.aleo/spend r7 r15 into r22;
    output r22 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;

function purchase8:
    input r0 as u128.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r3 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r4 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r5 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r6 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r7 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r8 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r9 as par_store_inventory_v3.aleo/Product.record;
    add r1.amount r2.amount into r10;
    add r10 r3.amount into r11;
    add r11 r4.amount into r12;
    add r12 r5.amount into r13;
    add r13 r6.amount into r14;
    add r14 r7.amount into r15;
    add r15 r8.amount into r16;
    sub r16 r9.price into r17;
    call puzzle_arcade_ticket_v001.aleo/spend r1 r1.amount into r18;
    call puzzle_arcade_ticket_v001.aleo/spend r2 r2.amount into r19;
    call puzzle_arcade_ticket_v001.aleo/spend r3 r3.amount into r20;
    call puzzle_arcade_ticket_v001.aleo/spend r4 r4.amount into r21;
    call puzzle_arcade_ticket_v001.aleo/spend r5 r5.amount into r22;
    call puzzle_arcade_ticket_v001.aleo/spend r6 r6.amount into r23;
    call puzzle_arcade_ticket_v001.aleo/spend r7 r7.amount into r24;
    call puzzle_arcade_ticket_v001.aleo/spend r8 r17 into r25;
    output r25 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;

function purchase9:
    input r0 as u128.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r3 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r4 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r5 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r6 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r7 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r8 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r9 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r10 as par_store_inventory_v3.aleo/Product.record;
    add r1.amount r2.amount into r11;
    add r11 r3.amount into r12;
    add r12 r4.amount into r13;
    add r13 r5.amount into r14;
    add r14 r6.amount into r15;
    add r15 r7.amount into r16;
    add r16 r8.amount into r17;
    add r17 r9.amount into r18;
    sub r18 r10.price into r19;
    call puzzle_arcade_ticket_v001.aleo/spend r1 r1.amount into r20;
    call puzzle_arcade_ticket_v001.aleo/spend r2 r2.amount into r21;
    call puzzle_arcade_ticket_v001.aleo/spend r3 r3.amount into r22;
    call puzzle_arcade_ticket_v001.aleo/spend r4 r4.amount into r23;
    call puzzle_arcade_ticket_v001.aleo/spend r5 r5.amount into r24;
    call puzzle_arcade_ticket_v001.aleo/spend r6 r6.amount into r25;
    call puzzle_arcade_ticket_v001.aleo/spend r7 r7.amount into r26;
    call puzzle_arcade_ticket_v001.aleo/spend r8 r8.amount into r27;
    call puzzle_arcade_ticket_v001.aleo/spend r9 r19 into r28;
    output r28 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;

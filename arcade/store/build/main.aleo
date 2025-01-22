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
    input r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r3 as par_store_inventory_v3.aleo/Product.record;
    call puzzle_arcade_ticket_v001.aleo/spend r1 r3.price into r4;
    call puzzle_arcade_ticket_v001.aleo/spend r2 r3.price into r5;
    output r5 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;

function three_part_purchase:
    input r0 as u128.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r3 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r4 as par_store_inventory_v3.aleo/Product.record;
    call puzzle_arcade_ticket_v001.aleo/spend r1 r4.price into r5;
    call puzzle_arcade_ticket_v001.aleo/spend r2 r4.price into r6;
    call puzzle_arcade_ticket_v001.aleo/spend r3 r4.price into r7;
    output r7 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;

function four_part_purchase:
    input r0 as u128.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r3 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r4 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r5 as par_store_inventory_v3.aleo/Product.record;
    call puzzle_arcade_ticket_v001.aleo/spend r1 r5.price into r6;
    call puzzle_arcade_ticket_v001.aleo/spend r2 r5.price into r7;
    call puzzle_arcade_ticket_v001.aleo/spend r3 r5.price into r8;
    call puzzle_arcade_ticket_v001.aleo/spend r4 r5.price into r9;
    output r9 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;

function five_part_purchase:
    input r0 as u128.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r3 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r4 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r5 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r6 as par_store_inventory_v3.aleo/Product.record;
    call puzzle_arcade_ticket_v001.aleo/spend r1 r6.price into r7;
    call puzzle_arcade_ticket_v001.aleo/spend r2 r6.price into r8;
    call puzzle_arcade_ticket_v001.aleo/spend r3 r6.price into r9;
    call puzzle_arcade_ticket_v001.aleo/spend r4 r6.price into r10;
    call puzzle_arcade_ticket_v001.aleo/spend r5 r6.price into r11;
    output r11 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;

function six_part_purchase:
    input r0 as u128.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r3 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r4 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r5 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r6 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r7 as par_store_inventory_v3.aleo/Product.record;
    call puzzle_arcade_ticket_v001.aleo/spend r1 r7.price into r8;
    call puzzle_arcade_ticket_v001.aleo/spend r2 r7.price into r9;
    call puzzle_arcade_ticket_v001.aleo/spend r3 r7.price into r10;
    call puzzle_arcade_ticket_v001.aleo/spend r4 r7.price into r11;
    call puzzle_arcade_ticket_v001.aleo/spend r5 r7.price into r12;
    call puzzle_arcade_ticket_v001.aleo/spend r6 r7.price into r13;
    output r13 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;

function seven_part_purchase:
    input r0 as u128.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r3 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r4 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r5 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r6 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r7 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r8 as par_store_inventory_v3.aleo/Product.record;
    call puzzle_arcade_ticket_v001.aleo/spend r1 r8.price into r9;
    call puzzle_arcade_ticket_v001.aleo/spend r2 r8.price into r10;
    call puzzle_arcade_ticket_v001.aleo/spend r3 r8.price into r11;
    call puzzle_arcade_ticket_v001.aleo/spend r4 r8.price into r12;
    call puzzle_arcade_ticket_v001.aleo/spend r5 r8.price into r13;
    call puzzle_arcade_ticket_v001.aleo/spend r6 r8.price into r14;
    call puzzle_arcade_ticket_v001.aleo/spend r7 r8.price into r15;
    output r15 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;

function eight_part_purchase:
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
    call puzzle_arcade_ticket_v001.aleo/spend r1 r9.price into r10;
    call puzzle_arcade_ticket_v001.aleo/spend r2 r9.price into r11;
    call puzzle_arcade_ticket_v001.aleo/spend r3 r9.price into r12;
    call puzzle_arcade_ticket_v001.aleo/spend r4 r9.price into r13;
    call puzzle_arcade_ticket_v001.aleo/spend r5 r9.price into r14;
    call puzzle_arcade_ticket_v001.aleo/spend r6 r9.price into r15;
    call puzzle_arcade_ticket_v001.aleo/spend r7 r9.price into r16;
    call puzzle_arcade_ticket_v001.aleo/spend r8 r9.price into r17;
    output r17 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;

function nine_part_purchase:
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
    call puzzle_arcade_ticket_v001.aleo/spend r1 r10.price into r11;
    call puzzle_arcade_ticket_v001.aleo/spend r2 r10.price into r12;
    call puzzle_arcade_ticket_v001.aleo/spend r3 r10.price into r13;
    call puzzle_arcade_ticket_v001.aleo/spend r4 r10.price into r14;
    call puzzle_arcade_ticket_v001.aleo/spend r5 r10.price into r15;
    call puzzle_arcade_ticket_v001.aleo/spend r6 r10.price into r16;
    call puzzle_arcade_ticket_v001.aleo/spend r7 r10.price into r17;
    call puzzle_arcade_ticket_v001.aleo/spend r8 r10.price into r18;
    call puzzle_arcade_ticket_v001.aleo/spend r9 r10.price into r19;
    output r19 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;

function ten_part_purchase:
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
    input r10 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r11 as par_store_inventory_v3.aleo/Product.record;
    call puzzle_arcade_ticket_v001.aleo/spend r1 r11.price into r12;
    call puzzle_arcade_ticket_v001.aleo/spend r2 r11.price into r13;
    call puzzle_arcade_ticket_v001.aleo/spend r3 r11.price into r14;
    call puzzle_arcade_ticket_v001.aleo/spend r4 r11.price into r15;
    call puzzle_arcade_ticket_v001.aleo/spend r5 r11.price into r16;
    call puzzle_arcade_ticket_v001.aleo/spend r6 r11.price into r17;
    call puzzle_arcade_ticket_v001.aleo/spend r7 r11.price into r18;
    call puzzle_arcade_ticket_v001.aleo/spend r8 r11.price into r19;
    call puzzle_arcade_ticket_v001.aleo/spend r9 r11.price into r20;
    call puzzle_arcade_ticket_v001.aleo/spend r10 r11.price into r21;
    output r21 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;

function eleven_part_purchase:
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
    input r10 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r11 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r12 as par_store_inventory_v3.aleo/Product.record;
    call puzzle_arcade_ticket_v001.aleo/spend r1 r12.price into r13;
    call puzzle_arcade_ticket_v001.aleo/spend r2 r12.price into r14;
    call puzzle_arcade_ticket_v001.aleo/spend r3 r12.price into r15;
    call puzzle_arcade_ticket_v001.aleo/spend r4 r12.price into r16;
    call puzzle_arcade_ticket_v001.aleo/spend r5 r12.price into r17;
    call puzzle_arcade_ticket_v001.aleo/spend r6 r12.price into r18;
    call puzzle_arcade_ticket_v001.aleo/spend r7 r12.price into r19;
    call puzzle_arcade_ticket_v001.aleo/spend r8 r12.price into r20;
    call puzzle_arcade_ticket_v001.aleo/spend r9 r12.price into r21;
    call puzzle_arcade_ticket_v001.aleo/spend r10 r12.price into r22;
    call puzzle_arcade_ticket_v001.aleo/spend r11 r12.price into r23;
    output r23 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;

function twelve_part_purchase:
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
    input r10 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r11 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r12 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r13 as par_store_inventory_v3.aleo/Product.record;
    call puzzle_arcade_ticket_v001.aleo/spend r1 r13.price into r14;
    call puzzle_arcade_ticket_v001.aleo/spend r2 r13.price into r15;
    call puzzle_arcade_ticket_v001.aleo/spend r3 r13.price into r16;
    call puzzle_arcade_ticket_v001.aleo/spend r4 r13.price into r17;
    call puzzle_arcade_ticket_v001.aleo/spend r5 r13.price into r18;
    call puzzle_arcade_ticket_v001.aleo/spend r6 r13.price into r19;
    call puzzle_arcade_ticket_v001.aleo/spend r7 r13.price into r20;
    call puzzle_arcade_ticket_v001.aleo/spend r8 r13.price into r21;
    call puzzle_arcade_ticket_v001.aleo/spend r9 r13.price into r22;
    call puzzle_arcade_ticket_v001.aleo/spend r10 r13.price into r23;
    call puzzle_arcade_ticket_v001.aleo/spend r11 r13.price into r24;
    call puzzle_arcade_ticket_v001.aleo/spend r12 r13.price into r25;
    output r25 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;

function thirteen_part_purchase:
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
    input r10 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r11 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r12 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r13 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r14 as par_store_inventory_v3.aleo/Product.record;
    call puzzle_arcade_ticket_v001.aleo/spend r1 r14.price into r15;
    call puzzle_arcade_ticket_v001.aleo/spend r2 r14.price into r16;
    call puzzle_arcade_ticket_v001.aleo/spend r3 r14.price into r17;
    call puzzle_arcade_ticket_v001.aleo/spend r4 r14.price into r18;
    call puzzle_arcade_ticket_v001.aleo/spend r5 r14.price into r19;
    call puzzle_arcade_ticket_v001.aleo/spend r6 r14.price into r20;
    call puzzle_arcade_ticket_v001.aleo/spend r7 r14.price into r21;
    call puzzle_arcade_ticket_v001.aleo/spend r8 r14.price into r22;
    call puzzle_arcade_ticket_v001.aleo/spend r9 r14.price into r23;
    call puzzle_arcade_ticket_v001.aleo/spend r10 r14.price into r24;
    call puzzle_arcade_ticket_v001.aleo/spend r11 r14.price into r25;
    call puzzle_arcade_ticket_v001.aleo/spend r12 r14.price into r26;
    call puzzle_arcade_ticket_v001.aleo/spend r13 r14.price into r27;
    output r27 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;

function fourteen_part_purchase:
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
    input r10 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r11 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r12 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r13 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r14 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r15 as par_store_inventory_v3.aleo/Product.record;
    call puzzle_arcade_ticket_v001.aleo/spend r1 r15.price into r16;
    call puzzle_arcade_ticket_v001.aleo/spend r2 r15.price into r17;
    call puzzle_arcade_ticket_v001.aleo/spend r3 r15.price into r18;
    call puzzle_arcade_ticket_v001.aleo/spend r4 r15.price into r19;
    call puzzle_arcade_ticket_v001.aleo/spend r5 r15.price into r20;
    call puzzle_arcade_ticket_v001.aleo/spend r6 r15.price into r21;
    call puzzle_arcade_ticket_v001.aleo/spend r7 r15.price into r22;
    call puzzle_arcade_ticket_v001.aleo/spend r8 r15.price into r23;
    call puzzle_arcade_ticket_v001.aleo/spend r9 r15.price into r24;
    call puzzle_arcade_ticket_v001.aleo/spend r10 r15.price into r25;
    call puzzle_arcade_ticket_v001.aleo/spend r11 r15.price into r26;
    call puzzle_arcade_ticket_v001.aleo/spend r12 r15.price into r27;
    call puzzle_arcade_ticket_v001.aleo/spend r13 r15.price into r28;
    call puzzle_arcade_ticket_v001.aleo/spend r14 r15.price into r29;
    output r29 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;

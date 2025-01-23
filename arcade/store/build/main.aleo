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

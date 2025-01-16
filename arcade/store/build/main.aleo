import puzzle_arcade_ticket_v001.aleo;
import par_store_inventory_v1.aleo;
program par_store_v1.aleo;

struct Code:
    pt1 as u128;
    pt2 as u128;
    pt3 as u128;
    pt4 as u128;
    pt5 as u128;

function purchase:
    input r0 as u64.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r2 as par_store_inventory_v1.aleo/Product.record;
    call puzzle_arcade_ticket_v001.aleo/spend r1 r2.price into r3;
    output r3 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;

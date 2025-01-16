import puzzle_arcade_ticket_v002.aleo;
import puzzle_arcade_store_inventory.aleo;
program puzzle_arcade_store.aleo;

struct Code:
    pt1 as u128;
    pt2 as u128;
    pt3 as u128;
    pt4 as u128;
    pt5 as u128;

function fulfill:
    input r0 as address.private;
    input r1 as puzzle_arcade_store_inventory.aleo/Product.record;
    assert.eq r1.owner aleo14y7ahmrzka0wphss6p5wtvs0s08u4e00azr8ua6wxr3h60vlgyyqw7mxtd;
    call puzzle_arcade_store_inventory.aleo/fulfill r0 r1 into r2;
    output r2 as puzzle_arcade_store_inventory.aleo/Product.record;

function purchase:
    input r0 as u64.private;
    input r1 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r2 as puzzle_arcade_store_inventory.aleo/Product.record;
    call puzzle_arcade_ticket_v002.aleo/spend r1 r2.price into r3;
    output r3 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;

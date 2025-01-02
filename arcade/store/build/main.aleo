import puzzle_arcade_ticket_v002.aleo;
program puzzle_arcade_store.aleo;

struct Code:
    pt1 as u128;
    pt2 as u128;
    pt3 as u128;
    pt4 as u128;
    pt5 as u128;

record Product:
    owner as address.private;
    id as u64.private;
    code as Code.private;

function mint:
    input r0 as u64.private;
    input r1 as Code.private;
    cast aleo14y7ahmrzka0wphss6p5wtvs0s08u4e00azr8ua6wxr3h60vlgyyqw7mxtd r0 r1 into r2 as Product.record;
    output r2 as Product.record;

function purchase:
    input r0 as u64.private;
    input r1 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r2 as u64.private;
    call puzzle_arcade_ticket_v002.aleo/spend r1 r2 into r3;
    output r3 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;

function fulfill:
    input r0 as address.private;
    input r1 as Product.record;
    assert.eq r1.owner aleo14y7ahmrzka0wphss6p5wtvs0s08u4e00azr8ua6wxr3h60vlgyyqw7mxtd;
    cast r0 r1.id r1.code into r2 as Product.record;
    output r2 as Product.record;

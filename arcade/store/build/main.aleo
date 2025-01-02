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
    input r2 as address.private;
    input r3 as Product.record;
    input r4 as u64.private;
    call puzzle_arcade_ticket_v002.aleo/spend r1 r4 into r5;
    cast r2 r3.id r3.code into r6 as Product.record;
    output r5 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    output r6 as Product.record;

function fulfill:
    input r0 as address.private;
    input r1 as Product.record;
    cast r0 r1.id r1.code into r2 as Product.record;
    output r2 as Product.record;

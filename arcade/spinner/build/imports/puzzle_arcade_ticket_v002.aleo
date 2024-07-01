program puzzle_arcade_ticket_v002.aleo;

record PuzzleArcadeTicket:
    owner as address.private;
    amount as u64.private;


mapping registry:
	key as address.public;
	value as boolean.public;


function add_program_to_registry:
    input r0 as address.private;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw;
    async add_program_to_registry r0 into r1;
    output r1 as puzzle_arcade_ticket_v002.aleo/add_program_to_registry.future;

finalize add_program_to_registry:
    input r0 as address.public;
    set true into registry[r0];




function mint:
    input r0 as address.private;
    input r1 as u64.private;
    cast r0 r1 into r2 as PuzzleArcadeTicket.record;
    async mint self.caller into r3;
    output r2 as PuzzleArcadeTicket.record;
    output r3 as puzzle_arcade_ticket_v002.aleo/mint.future;

finalize mint:
    input r0 as address.public;
    get.or_use registry[r0] false into r1;
    assert.eq r1 true;



function spend:
    input r0 as PuzzleArcadeTicket.record;
    input r1 as u64.private;
    gte r0.amount r1 into r2;
    assert.eq r2 true;
    sub r0.amount r1 into r3;
    cast r0.owner r3 into r4 as PuzzleArcadeTicket.record;
    output r4 as PuzzleArcadeTicket.record;


function join:
    input r0 as PuzzleArcadeTicket.record;
    input r1 as PuzzleArcadeTicket.record;
    assert.eq self.caller self.signer;
    is.eq r0.owner self.signer into r2;
    assert.eq r2 true;
    is.eq r1.owner self.signer into r3;
    assert.eq r3 true;
    gt r0.amount 0u64 into r4;
    assert.eq r4 true;
    gt r1.amount 0u64 into r5;
    assert.eq r5 true;
    add r0.amount r1.amount into r6;
    cast self.signer r6 into r7 as PuzzleArcadeTicket.record;
    output r7 as PuzzleArcadeTicket.record;

program puzzle_arcade_ticket_v001.aleo;

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
    output r1 as puzzle_arcade_ticket_v001.aleo/add_program_to_registry.future;

finalize add_program_to_registry:
    input r0 as address.public;
    set true into registry[r0];




function mint:
    input r0 as address.public;
    input r1 as u64.public;
    cast r0 r1 into r2 as PuzzleArcadeTicket.record;
    async mint self.caller into r3;
    output r2 as PuzzleArcadeTicket.record;
    output r3 as puzzle_arcade_ticket_v001.aleo/mint.future;

finalize mint:
    input r0 as address.public;
    get.or_use registry[r0] false into r1;
    assert.eq r1 true;



function spend:
    input r0 as PuzzleArcadeTicket.record;
    input r1 as u64.public;
    gte r0.amount r1 into r2;
    assert.eq r2 true;
    sub r0.amount r1 into r3;
    cast r0.owner r3 into r4 as PuzzleArcadeTicket.record;
    output r4 as PuzzleArcadeTicket.record;


function join:
    input r0 as PuzzleArcadeTicket.record;
    input r1 as PuzzleArcadeTicket.record;
    gt r0.amount 0u64 into r2;
    assert.eq r2 true;
    gt r1.amount 0u64 into r3;
    assert.eq r3 true;
    add r0.amount r1.amount into r4;
    cast self.signer r4 into r5 as PuzzleArcadeTicket.record;
    output r5 as PuzzleArcadeTicket.record;


function join3:
    input r0 as PuzzleArcadeTicket.record;
    input r1 as PuzzleArcadeTicket.record;
    input r2 as PuzzleArcadeTicket.record;
    gt r0.amount 0u64 into r3;
    assert.eq r3 true;
    gt r1.amount 0u64 into r4;
    assert.eq r4 true;
    gt r2.amount 0u64 into r5;
    assert.eq r5 true;
    add r0.amount r1.amount into r6;
    add r6 r2.amount into r7;
    cast self.signer r7 into r8 as PuzzleArcadeTicket.record;
    output r8 as PuzzleArcadeTicket.record;


function join4:
    input r0 as PuzzleArcadeTicket.record;
    input r1 as PuzzleArcadeTicket.record;
    input r2 as PuzzleArcadeTicket.record;
    input r3 as PuzzleArcadeTicket.record;
    gt r0.amount 0u64 into r4;
    assert.eq r4 true;
    gt r1.amount 0u64 into r5;
    assert.eq r5 true;
    gt r2.amount 0u64 into r6;
    assert.eq r6 true;
    gt r3.amount 0u64 into r7;
    assert.eq r7 true;
    add r0.amount r1.amount into r8;
    add r8 r2.amount into r9;
    add r9 r3.amount into r10;
    cast self.signer r10 into r11 as PuzzleArcadeTicket.record;
    output r11 as PuzzleArcadeTicket.record;


function join5:
    input r0 as PuzzleArcadeTicket.record;
    input r1 as PuzzleArcadeTicket.record;
    input r2 as PuzzleArcadeTicket.record;
    input r3 as PuzzleArcadeTicket.record;
    input r4 as PuzzleArcadeTicket.record;
    gt r0.amount 0u64 into r5;
    assert.eq r5 true;
    gt r1.amount 0u64 into r6;
    assert.eq r6 true;
    gt r2.amount 0u64 into r7;
    assert.eq r7 true;
    gt r3.amount 0u64 into r8;
    assert.eq r8 true;
    gt r4.amount 0u64 into r9;
    assert.eq r9 true;
    add r0.amount r1.amount into r10;
    add r10 r2.amount into r11;
    add r11 r3.amount into r12;
    add r12 r4.amount into r13;
    cast self.signer r13 into r14 as PuzzleArcadeTicket.record;
    output r14 as PuzzleArcadeTicket.record;

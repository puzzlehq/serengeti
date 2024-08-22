program puzzle_arcade_coin_v002.aleo;

record PuzzleArcadeCoin:
    owner as address.private;
    amount as u64.private;


mapping registry:
	key as address.public;
	value as boolean.public;

function mint:
    input r0 as address.public;
    input r1 as u64.public;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw;
    cast r0 r1 into r2 as PuzzleArcadeCoin.record;
    output r2 as PuzzleArcadeCoin.record;


function spend:
    input r0 as PuzzleArcadeCoin.record;
    input r1 as u64.public;
    gte r0.amount r1 into r2;
    assert.eq r2 true;
    sub r0.amount r1 into r3;
    cast r0.owner r3 into r4 as PuzzleArcadeCoin.record;
    output r4 as PuzzleArcadeCoin.record;



function add_program_to_registry:
    input r0 as address.private;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw;
    async add_program_to_registry r0 into r1;
    output r1 as puzzle_arcade_coin_v002.aleo/add_program_to_registry.future;

finalize add_program_to_registry:
    input r0 as address.public;
    set true into registry[r0];




function mint_program:
    input r0 as address.public;
    input r1 as u64.public;
    cast r0 r1 into r2 as PuzzleArcadeCoin.record;
    async mint_program self.caller into r3;
    output r2 as PuzzleArcadeCoin.record;
    output r3 as puzzle_arcade_coin_v002.aleo/mint_program.future;

finalize mint_program:
    input r0 as address.public;
    get.or_use registry[r0] false into r1;
    assert.eq r1 true;


program puzzle_arcade_coin_v002.aleo;

record PuzzleArcadeCoin:
    owner as address.private;
    amount as u64.private;


function mint:
    input r0 as address.private;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw;
    cast r0 1000000u64 into r1 as PuzzleArcadeCoin.record;
    output r1 as PuzzleArcadeCoin.record;


function spend:
    input r0 as PuzzleArcadeCoin.record;
    input r1 as u64.private;
    gte r0.amount r1 into r2;
    assert.eq r2 true;
    sub r0.amount r1 into r3;
    cast r0.owner r3 into r4 as PuzzleArcadeCoin.record;
    output r4 as PuzzleArcadeCoin.record;

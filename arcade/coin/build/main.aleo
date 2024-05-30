program puzzle_arcade_coin_v001.aleo;

record PuzzleArcadeCoin:
    owner as address.private;
    amount as u64.private;


function mint_coin:
    input r0 as address.private;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw;
    cast r0 1000000u64 into r1 as PuzzleArcadeCoin.record;
    output r1 as PuzzleArcadeCoin.record;

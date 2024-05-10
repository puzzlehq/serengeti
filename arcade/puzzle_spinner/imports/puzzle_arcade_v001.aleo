program puzzle_arcade_v001.aleo;

record PuzzleArcadeCoin:
    owner as address.private;
    amount as u64.private;

record PuzzleArcadeTicket:
    owner as address.private;
    amount as u64.private;


function mint_coins:
    input r0 as u64.private;
    input r1 as address.private;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw;
    cast r1 r0 into r2 as PuzzleArcadeCoin.record;
    output r2 as PuzzleArcadeCoin.record;


function mint_tickets:
    input r0 as u64.private;
    input r1 as address.private;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw;
    cast r1 r0 into r2 as PuzzleArcadeTicket.record;
    output r2 as PuzzleArcadeTicket.record;

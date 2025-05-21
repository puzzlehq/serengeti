program puzzle_arcade_coin_v002.aleo;

record PuzzleArcadeCoin:
    owner as address.private;
    amount as u64.private;

function mint:
    input r0 as address.public;
    input r1 as u64.public;
    assert.eq self.caller self.signer ;
    assert.eq self.caller aleo196a39wq9q8ea779cmlmff0c9pj2gl4f5e8fhjpvmufe5utuq7y8snz4h2l ;
    cast r0 r1 into r2 as PuzzleArcadeCoin.record;
    output r2 as PuzzleArcadeCoin.record;

function spend:
    input r0 as PuzzleArcadeCoin.record;
    input r1 as u64.public;
    gte r0.amount r1 into r2;
    assert.eq r2 true ;
    sub r0.amount r1 into r3;
    cast r0.owner r3 into r4 as PuzzleArcadeCoin.record;
    output r4 as PuzzleArcadeCoin.record;

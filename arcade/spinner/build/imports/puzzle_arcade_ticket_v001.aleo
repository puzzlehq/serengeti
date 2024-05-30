program puzzle_arcade_ticket_v001.aleo;

record PuzzleArcadeTicket:
    owner as address.private;
    amount as u64.private;


function mint:
    input r0 as address.private;
    input r1 as u64.private;
    assert.eq self.caller puzzle_arcade_v001.aleo;
    cast r0 r1 into r2 as PuzzleArcadeTicket.record;
    output r2 as PuzzleArcadeTicket.record;


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

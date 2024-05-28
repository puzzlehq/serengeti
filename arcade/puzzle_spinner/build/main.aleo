import puzzle_arcade_v001.aleo;
program puzzle_spinner_v001.aleo;




function spin:
    input r0 as u64.public;
    input r1 as puzzle_arcade_v001.aleo/PuzzleArcadeCoin.record;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw;
    call puzzle_arcade_v001.aleo/mint_tickets r0 r1.owner into r2;
    output r2 as puzzle_arcade_v001.aleo/PuzzleArcadeTicket.record;

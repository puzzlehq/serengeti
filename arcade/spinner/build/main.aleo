import puzzle_arcade_coin_v001.aleo;
import puzzle_arcade_ticket_v001.aleo;
program puzzle_spinner_v001.aleo;





function spin:
    input r0 as u64.public;
    input r1 as puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin.record;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw;
    call puzzle_arcade_ticket_v001.aleo/mint r1.owner r0 into r2 r3;
    async spin r3 into r4;
    output r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r4 as puzzle_spinner_v001.aleo/spin.future;

finalize spin:
    input r0 as puzzle_arcade_ticket_v001.aleo/mint.future;
    await r0;


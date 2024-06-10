import puzzle_arcade_coin_v002.aleo;
import puzzle_arcade_ticket_v001.aleo;
program puzzle_spinner_v002.aleo;





function spin:
    input r0 as u64.public;
    input r1 as puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin.record;
    input r2 as field.private;
    input r3 as signature.private;
    sign.verify r3 aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw r2 into r4;
    assert.eq r4 true;
    call puzzle_arcade_coin_v002.aleo/spend r1 into r5;
    call puzzle_arcade_ticket_v001.aleo/mint r1.owner r0 into r6 r7;
    async spin r7 into r8;
    output r5 as puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin.record;
    output r6 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r8 as puzzle_spinner_v002.aleo/spin.future;

finalize spin:
    input r0 as puzzle_arcade_ticket_v001.aleo/mint.future;
    await r0;


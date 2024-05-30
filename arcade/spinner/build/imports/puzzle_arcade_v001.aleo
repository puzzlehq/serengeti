import puzzle_arcade_coin_v001.aleo;
import puzzle_arcade_ticket_v001.aleo;
program puzzle_arcade_v001.aleo;




function mint:
    input r0 as puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin.record;
    input r1 as u64.private;
    assert.eq self.caller puzzle_spinner_v001.aleo;
    call puzzle_arcade_ticket_v001.aleo/mint r0.owner r1 into r2;
    output r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;

import puzzle_arcade_coin_v002.aleo;
import puzzle_arcade_ticket_v002.aleo;
program puzzle_spinner_v002.aleo;



struct Result:
    nonce as field;
    tickets as u64;


mapping used_nonces:
	key as field.public;
	value as boolean.public;


function spin:
    input r0 as puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin.record;
    input r1 as Result.public;
    input r2 as signature.private;
    sign.verify r2 aleo196a39wq9q8ea779cmlmff0c9pj2gl4f5e8fhjpvmufe5utuq7y8snz4h2l r1 into r3;
    assert.eq r3 true;
    is.eq r1.tickets 1000000u64 into r4;
    is.eq r1.tickets 2000000u64 into r5;
    or r4 r5 into r6;
    is.eq r1.tickets 5000000u64 into r7;
    or r6 r7 into r8;
    is.eq r1.tickets 10000000u64 into r9;
    or r8 r9 into r10;
    assert.eq r10 true;
    call puzzle_arcade_coin_v002.aleo/spend r0 1000000u64 into r11;
    call puzzle_arcade_ticket_v002.aleo/mint r0.owner r1.tickets into r12 r13;
    async spin r13 r1.nonce into r14;
    output r11 as puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin.record;
    output r12 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    output r14 as puzzle_spinner_v002.aleo/spin.future;

finalize spin:
    input r0 as puzzle_arcade_ticket_v002.aleo/mint.future;
    input r1 as field.public;
    get.or_use used_nonces[r1] false into r2;
    assert.eq r2 false;
    set true into used_nonces[r1];
    await r0;


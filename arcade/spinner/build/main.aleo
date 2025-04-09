import puzzle_arcade_coin_v001.aleo;
import puzzle_arcade_ticket_v001.aleo;
program par_spinner_v3.aleo;

struct Result:
    nonce as field;
    tickets as u64;

mapping used_nonces:
    key as field.public;
    value as boolean.public;

function spin:
    input r0 as puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin.record;
    input r1 as Result.public;
    input r2 as signature.private;
    sign.verify r2 aleo196a39wq9q8ea779cmlmff0c9pj2gl4f5e8fhjpvmufe5utuq7y8snz4h2l r1 into r3;
    assert.eq r3 true;
    is.eq r1.tickets 0u64 into r4;
    is.eq r1.tickets 1000000u64 into r5;
    or r4 r5 into r6;
    is.eq r1.tickets 2000000u64 into r7;
    or r6 r7 into r8;
    is.eq r1.tickets 3000000u64 into r9;
    or r8 r9 into r10;
    is.eq r1.tickets 5000000u64 into r11;
    or r10 r11 into r12;
    is.eq r1.tickets 10000000u64 into r13;
    or r12 r13 into r14;
    assert.eq r14 true;
    call puzzle_arcade_coin_v001.aleo/spend r0 1000000u64 into r15;
    call puzzle_arcade_ticket_v001.aleo/mint r0.owner r1.tickets into r16 r17;
    async spin r17 r1.nonce into r18;
    output r15 as puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin.record;
    output r16 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r18 as par_spinner_v3.aleo/spin.future;

finalize spin:
    input r0 as puzzle_arcade_ticket_v001.aleo/mint.future;
    input r1 as field.public;
    get.or_use used_nonces[r1] false into r2;
    assert.eq r2 false;
    set true into used_nonces[r1];
    await r0;

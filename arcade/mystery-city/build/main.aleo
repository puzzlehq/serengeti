import puzzle_arcade_coin_v001.aleo;
import puzzle_arcade_ticket_v001.aleo;
program mystery_city_test_v002.aleo;

struct Result:
    nonce as field;
    tickets as u64;

mapping used_nonces:
    key as field.public;
    value as boolean.public;

function submit_game:
    input r0 as puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin.record;
    input r1 as Result.public;
    input r2 as signature.private;
    sign.verify r2 aleo196a39wq9q8ea779cmlmff0c9pj2gl4f5e8fhjpvmufe5utuq7y8snz4h2l r1 into r3;
    assert.eq r3 true;
    is.eq r1.tickets 1000000u64 into r4;
    is.eq r1.tickets 2000000u64 into r5;
    or r4 r5 into r6;
    is.eq r1.tickets 3000000u64 into r7;
    or r6 r7 into r8;
    is.eq r1.tickets 4000000u64 into r9;
    or r8 r9 into r10;
    is.eq r1.tickets 5000000u64 into r11;
    or r10 r11 into r12;
    is.eq r1.tickets 6000000u64 into r13;
    or r12 r13 into r14;
    is.eq r1.tickets 7000000u64 into r15;
    or r14 r15 into r16;
    is.eq r1.tickets 8000000u64 into r17;
    or r16 r17 into r18;
    is.eq r1.tickets 9000000u64 into r19;
    or r18 r19 into r20;
    is.eq r1.tickets 10000000u64 into r21;
    or r20 r21 into r22;
    is.eq r1.tickets 11000000u64 into r23;
    or r22 r23 into r24;
    is.eq r1.tickets 12000000u64 into r25;
    or r24 r25 into r26;
    is.eq r1.tickets 13000000u64 into r27;
    or r26 r27 into r28;
    is.eq r1.tickets 14000000u64 into r29;
    or r28 r29 into r30;
    is.eq r1.tickets 15000000u64 into r31;
    or r30 r31 into r32;
    assert.eq r32 true;
    call puzzle_arcade_coin_v001.aleo/spend r0 1000000u64 into r33;
    call puzzle_arcade_ticket_v001.aleo/mint r0.owner r1.tickets into r34 r35;
    async submit_game r35 r1.nonce into r36;
    output r33 as puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin.record;
    output r34 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r36 as mystery_city_test_v002.aleo/submit_game.future;

finalize submit_game:
    input r0 as puzzle_arcade_ticket_v001.aleo/mint.future;
    input r1 as field.public;
    get.or_use used_nonces[r1] false into r2;
    assert.eq r2 false;
    set true into used_nonces[r1];
    await r0;

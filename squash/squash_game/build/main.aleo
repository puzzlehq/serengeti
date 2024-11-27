import timestamp_testing.aleo;
import puzzle_arcade_ticket_v001.aleo;
program squash_testing_5.aleo;

record Squash:
    owner as address.private;
    kg as u64.private;
    last_water as u64.private;
    level as u8.private;

function mint:
    input r0 as address.private;
    input r1 as timestamp_testing.aleo/Timestamp.record;
    cast r0 1000000u64 r1.time 0u8 into r2 as Squash.record;
    output r2 as Squash.record;

function water:
    input r0 as Squash.record;
    input r1 as timestamp_testing.aleo/Timestamp.record;
    input r2 as u64.public;
    input r3 as u64.public;
    gte r2 r1.time into r4;
    assert.eq r4 true;
    gte r2 r0.last_water into r5;
    assert.eq r5 true;
    gte r1.time r0.last_water into r6;
    assert.eq r6 true;
    sub r1.time r3 into r7;
    lt r0.last_water r7 into r8;
    sub r1.time r0.last_water into r9;
    div r9 r3 into r10;
    cast r10 into r11 as u64;
    mul r11 1000000u64 into r12;
    div r12 2u64 into r13;
    cast r13 into r14 as u64;
    cast r0.kg into r15 as i64;
    cast r14 into r16 as i64;
    sub r15 r16 into r17;
    lte r15 r16 into r18;
    ternary r18 0i64 r17 into r19;
    cast r19 into r20 as u64;
    add r20 1000000u64 into r21;
    cast r0.owner r21 r2 r0.level into r22 as Squash.record;
    not r8 into r23;
    lt r0.last_water r1.time into r24;
    add r0.kg 1000000u64 into r25;
    cast r0.owner r25 r2 r0.level into r26 as Squash.record;
    and r23 r24 into r27;
    not r24 into r28;
    and r23 r28 into r29;
    not r29 into r30;
    or r8 r27 into r31;
    or false r30 into r32;
    or r32 r31 into r33;
    assert.eq r33 true;
    ternary r27 r26.owner r0.owner into r34;
    ternary r27 r26.kg r0.kg into r35;
    ternary r27 r26.last_water r0.last_water into r36;
    ternary r27 r26.level r0.level into r37;
    cast r34 r35 r36 r37 into r38 as Squash.record;
    ternary r8 r22.owner r38.owner into r39;
    ternary r8 r22.kg r38.kg into r40;
    ternary r8 r22.last_water r38.last_water into r41;
    ternary r8 r22.level r38.level into r42;
    cast r39 r40 r41 r42 into r43 as Squash.record;
    output r43 as Squash.record;

function water_and_level_up:
    input r0 as Squash.record;
    input r1 as timestamp_testing.aleo/Timestamp.record;
    input r2 as u64.public;
    input r3 as u64.public;
    gte r2 r1.time into r4;
    assert.eq r4 true;
    gte r2 r0.last_water into r5;
    assert.eq r5 true;
    gte r1.time r0.last_water into r6;
    assert.eq r6 true;
    sub r1.time r3 into r7;
    lt r0.last_water r7 into r8;
    not r8 into r9;
    or false r9 into r10;
    assert.eq r10 true;
    not r8 into r11;
    lt r0.last_water r1.time into r12;
    not r12 into r13;
    and r11 r13 into r14;
    not r14 into r15;
    or false r15 into r16;
    assert.eq r16 true;
    add r0.kg 1000000u64 into r17;
    div r17 10000000u64 into r18;
    cast r18 into r19 as u8;
    gt r19 r0.level into r20;
    assert.eq r20 true;
    cast r19 into r21 as u64;
    mul r21 10000000u64 into r22;
    call puzzle_arcade_ticket_v001.aleo/mint r0.owner r22 into r23 r24;
    cast r0.owner r17 r2 r19 into r25 as Squash.record;
    async water_and_level_up r24 into r26;
    output r25 as Squash.record;
    output r23 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r26 as squash_testing_5.aleo/water_and_level_up.future;

finalize water_and_level_up:
    input r0 as puzzle_arcade_ticket_v001.aleo/mint.future;
    await r0;

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
    lte r0.kg r14 into r15;
    sub r0.kg r14 into r16;
    ternary r15 0u64 r16 into r17;
    add r17 1000000u64 into r18;
    cast r0.owner r18 r2 r0.level into r19 as Squash.record;
    not r8 into r20;
    lt r0.last_water r1.time into r21;
    add r0.kg 1000000u64 into r22;
    cast r0.owner r22 r2 r0.level into r23 as Squash.record;
    and r20 r21 into r24;
    not r21 into r25;
    and r20 r25 into r26;
    not r26 into r27;
    or r8 r24 into r28;
    or false r27 into r29;
    or r29 r28 into r30;
    assert.eq r30 true;
    ternary r24 r23.owner r0.owner into r31;
    ternary r24 r23.kg r0.kg into r32;
    ternary r24 r23.last_water r0.last_water into r33;
    ternary r24 r23.level r0.level into r34;
    cast r31 r32 r33 r34 into r35 as Squash.record;
    ternary r8 r19.owner r35.owner into r36;
    ternary r8 r19.kg r35.kg into r37;
    ternary r8 r19.last_water r35.last_water into r38;
    ternary r8 r19.level r35.level into r39;
    cast r36 r37 r38 r39 into r40 as Squash.record;
    output r40 as Squash.record;

function water_and_level_up:
    input r0 as Squash.record;
    input r1 as timestamp_testing.aleo/Timestamp.record;
    input r2 as u64.public;
    input r3 as u64.public;
    gte r2 r1.time into r4;
    assert.eq r4 true;
    sub r1.time r3 into r5;
    lt r0.last_water r5 into r6;
    not r6 into r7;
    or false r7 into r8;
    assert.eq r8 true;
    not r6 into r9;
    lt r0.last_water r1.time into r10;
    not r10 into r11;
    and r9 r11 into r12;
    not r12 into r13;
    or false r13 into r14;
    assert.eq r14 true;
    add r0.kg 1000000u64 into r15;
    div r15 10u64 into r16;
    cast r16 into r17 as u8;
    gt r17 r0.level into r18;
    assert.eq r18 true;
    cast r17 into r19 as u64;
    mul r19 10000000u64 into r20;
    call puzzle_arcade_ticket_v001.aleo/mint r0.owner r20 into r21 r22;
    cast r0.owner r15 r2 r17 into r23 as Squash.record;
    async water_and_level_up r22 into r24;
    output r23 as Squash.record;
    output r21 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r24 as squash_testing_5.aleo/water_and_level_up.future;

finalize water_and_level_up:
    input r0 as puzzle_arcade_ticket_v001.aleo/mint.future;
    await r0;

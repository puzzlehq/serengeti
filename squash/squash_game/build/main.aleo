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
    sub r1.time r3 into r5;
    lt r0.last_water r5 into r6;
    sub r1.time r0.last_water into r7;
    div r7 r3 into r8;
    mul r8 1000000u64 into r9;
    div r9 2u64 into r10;
    lte r0.kg r10 into r11;
    sub r0.kg r10 into r12;
    ternary r11 0u64 r12 into r13;
    add r13 1000000u64 into r14;
    cast r0.owner r14 r2 r0.level into r15 as Squash.record;
    not r6 into r16;
    lt r0.last_water r1.time into r17;
    add r0.kg 1000000u64 into r18;
    cast r0.owner r18 r2 r0.level into r19 as Squash.record;
    and r16 r17 into r20;
    not r17 into r21;
    and r16 r21 into r22;
    not r22 into r23;
    or r6 r20 into r24;
    or false r23 into r25;
    or r25 r24 into r26;
    assert.eq r26 true;
    ternary r20 r19.owner r0.owner into r27;
    ternary r20 r19.kg r0.kg into r28;
    ternary r20 r19.last_water r0.last_water into r29;
    ternary r20 r19.level r0.level into r30;
    cast r27 r28 r29 r30 into r31 as Squash.record;
    ternary r6 r15.owner r31.owner into r32;
    ternary r6 r15.kg r31.kg into r33;
    ternary r6 r15.last_water r31.last_water into r34;
    ternary r6 r15.level r31.level into r35;
    cast r32 r33 r34 r35 into r36 as Squash.record;
    output r36 as Squash.record;

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

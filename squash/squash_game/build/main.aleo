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
    sub r1.time r3 into r4;
    lt r0.last_water r4 into r5;
    sub r1.time r0.last_water into r6;
    div r6 r3 into r7;
    mul r7 1000000u64 into r8;
    div r8 2u64 into r9;
    lt r0.kg r9 into r10;
    sub r0.kg r9 into r11;
    ternary r10 0u64 r11 into r12;
    cast r0.owner r9 r2 r0.level into r13 as Squash.record;
    not r5 into r14;
    lt r0.last_water r1.time into r15;
    add r0.kg 1000000u64 into r16;
    cast r0.owner r16 r2 r0.level into r17 as Squash.record;
    and r14 r15 into r18;
    not r15 into r19;
    and r14 r19 into r20;
    not r20 into r21;
    or r5 r18 into r22;
    or false r21 into r23;
    or r23 r22 into r24;
    assert.eq r24 true;
    ternary r18 r17.owner r0.owner into r25;
    ternary r18 r17.kg r0.kg into r26;
    ternary r18 r17.last_water r0.last_water into r27;
    ternary r18 r17.level r0.level into r28;
    cast r25 r26 r27 r28 into r29 as Squash.record;
    ternary r5 r13.owner r29.owner into r30;
    ternary r5 r13.kg r29.kg into r31;
    ternary r5 r13.last_water r29.last_water into r32;
    ternary r5 r13.level r29.level into r33;
    cast r30 r31 r32 r33 into r34 as Squash.record;
    output r34 as Squash.record;

function water_and_level_up:
    input r0 as Squash.record;
    input r1 as timestamp_testing.aleo/Timestamp.record;
    input r2 as u64.public;
    input r3 as u64.public;
    sub r1.time r3 into r4;
    lt r0.last_water r4 into r5;
    not r5 into r6;
    or false r6 into r7;
    assert.eq r7 true;
    not r5 into r8;
    lt r0.last_water r1.time into r9;
    not r9 into r10;
    and r8 r10 into r11;
    not r11 into r12;
    or false r12 into r13;
    assert.eq r13 true;
    add r0.kg 1000000u64 into r14;
    div r14 10u64 into r15;
    cast r15 into r16 as u8;
    gt r16 r0.level into r17;
    assert.eq r17 true;
    cast r16 into r18 as u64;
    mul r18 10000000u64 into r19;
    call puzzle_arcade_ticket_v001.aleo/mint r0.owner r19 into r20 r21;
    cast r0.owner r14 r2 r16 into r22 as Squash.record;
    async water_and_level_up r21 into r23;
    output r22 as Squash.record;
    output r20 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r23 as squash_testing_5.aleo/water_and_level_up.future;

finalize water_and_level_up:
    input r0 as puzzle_arcade_ticket_v001.aleo/mint.future;
    await r0;

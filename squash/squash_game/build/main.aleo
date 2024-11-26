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
    div r7 2u64 into r8;
    lt r0.kg r8 into r9;
    sub r0.kg r8 into r10;
    ternary r9 0u64 r10 into r11;
    cast r0.owner r8 r2 r0.level into r12 as Squash.record;
    not r5 into r13;
    lt r0.last_water r1.time into r14;
    add r0.kg 1000000u64 into r15;
    cast r0.owner r15 r2 r0.level into r16 as Squash.record;
    and r13 r14 into r17;
    not r14 into r18;
    and r13 r18 into r19;
    not r19 into r20;
    or r5 r17 into r21;
    or false r20 into r22;
    or r22 r21 into r23;
    assert.eq r23 true;
    ternary r17 r16.owner r0.owner into r24;
    ternary r17 r16.kg r0.kg into r25;
    ternary r17 r16.last_water r0.last_water into r26;
    ternary r17 r16.level r0.level into r27;
    cast r24 r25 r26 r27 into r28 as Squash.record;
    ternary r5 r12.owner r28.owner into r29;
    ternary r5 r12.kg r28.kg into r30;
    ternary r5 r12.last_water r28.last_water into r31;
    ternary r5 r12.level r28.level into r32;
    cast r29 r30 r31 r32 into r33 as Squash.record;
    output r33 as Squash.record;

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
    add r0.kg 1u64 into r14;
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

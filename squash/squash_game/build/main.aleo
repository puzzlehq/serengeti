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
    cast r0 0u64 r1.time 0u8 into r2 as Squash.record;
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
    div r7 2000000u64 into r8;
    lt r0.kg r8 into r9;
    sub r0.kg r8 into r10;
    ternary r9 0u64 r10 into r11;
    cast r0.owner r11 r2 r0.level into r12 as Squash.record;
    lt r0.last_water r1.time into r13;
    add r0.kg 1u64 into r14;
    cast r0.owner r14 r2 r0.level into r15 as Squash.record;
    not r5 into r16;
    not r13 into r17;
    and r16 r17 into r18;
    not r18 into r19;
    or r19 false into r20;
    assert.eq r20 true;
    not r5 into r21;
    and r21 r13 into r22;
    ternary r22 r15.owner r0.owner into r23;
    not r5 into r24;
    and r24 r13 into r25;
    ternary r25 r15.kg r0.kg into r26;
    not r5 into r27;
    and r27 r13 into r28;
    ternary r28 r15.last_water r0.last_water into r29;
    not r5 into r30;
    and r30 r13 into r31;
    ternary r31 r15.level r0.level into r32;
    cast r23 r26 r29 r32 into r33 as Squash.record;
    ternary r5 r12.owner r33.owner into r34;
    ternary r5 r12.kg r33.kg into r35;
    ternary r5 r12.last_water r33.last_water into r36;
    ternary r5 r12.level r33.level into r37;
    cast r34 r35 r36 r37 into r38 as Squash.record;
    output r38 as Squash.record;



function water_and_level_up:
    input r0 as Squash.record;
    input r1 as timestamp_testing.aleo/Timestamp.record;
    input r2 as u64.public;
    input r3 as u64.public;
    sub r1.time r3 into r4;
    lt r0.last_water r4 into r5;
    not r5 into r6;
    or r6 false into r7;
    assert.eq r7 true;
    lt r0.last_water r1.time into r8;
    not r5 into r9;
    not r8 into r10;
    and r9 r10 into r11;
    not r11 into r12;
    or r12 false into r13;
    assert.eq r13 true;
    add r0.kg 1u64 into r14;
    div r14 10u64 into r15;
    cast r15 into r16 as u8;
    gt r16 r0.level into r17;
    assert.eq r17 true;
    mul r16 10u8 into r18;
    cast r18 into r19 as u64;
    call puzzle_arcade_ticket_v001.aleo/mint r0.owner r19 into r20 r21;
    cast r0.owner r14 r2 r16 into r22 as Squash.record;
    async water_and_level_up r21 into r23;
    output r22 as Squash.record;
    output r20 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r23 as squash_testing_5.aleo/water_and_level_up.future;

finalize water_and_level_up:
    input r0 as puzzle_arcade_ticket_v001.aleo/mint.future;
    await r0;


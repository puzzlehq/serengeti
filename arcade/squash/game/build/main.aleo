import squash_timestamp.aleo;
import puzzle_arcade_ticket_v002.aleo;
import squash_v001.aleo;
program squash_v002.aleo;

record Squash:
    owner as address.private;
    kg as u64.private;
    last_water as u64.private;
    level as u8.private;
    squash_name as u128.private;
    squash_id as u32.private;

function mint:
    input r0 as address.private;
    input r1 as u128.private;
    input r2 as u32.private;
    input r3 as squash_timestamp.aleo/Timestamp.record;
    cast r0 1000000u64 r3.time 0u8 r1 r2 into r4 as Squash.record;
    output r4 as Squash.record;

function water:
    input r0 as Squash.record;
    input r1 as squash_timestamp.aleo/Timestamp.record;
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
    cast r0.owner r21 r2 r0.level r0.squash_name r0.squash_id into r22 as Squash.record;
    not r8 into r23;
    lt r0.last_water r1.time into r24;
    add r0.kg 1000000u64 into r25;
    cast r0.owner r25 r2 r0.level r0.squash_name r0.squash_id into r26 as Squash.record;
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
    ternary r27 r26.squash_name r0.squash_name into r38;
    ternary r27 r26.squash_id r0.squash_id into r39;
    cast r34 r35 r36 r37 r38 r39 into r40 as Squash.record;
    ternary r8 r22.owner r40.owner into r41;
    ternary r8 r22.kg r40.kg into r42;
    ternary r8 r22.last_water r40.last_water into r43;
    ternary r8 r22.level r40.level into r44;
    ternary r8 r22.squash_name r40.squash_name into r45;
    ternary r8 r22.squash_id r40.squash_id into r46;
    cast r41 r42 r43 r44 r45 r46 into r47 as Squash.record;
    output r47 as Squash.record;

function water_and_level_up:
    input r0 as Squash.record;
    input r1 as squash_timestamp.aleo/Timestamp.record;
    input r2 as u64.public;
    input r3 as u64.public;
    gte r2 r1.time into r4;
    assert.eq r4 true;
    gte r2 r0.last_water into r5;
    assert.eq r5 true;
    gte r1.time r0.last_water into r6;
    assert.eq r6 true;
    sub r1.time r3 into r7;
    sub r7 r3 into r8;
    lt r0.last_water r8 into r9;
    not r9 into r10;
    or false r10 into r11;
    assert.eq r11 true;
    not r9 into r12;
    lt r0.last_water r1.time into r13;
    not r13 into r14;
    and r12 r14 into r15;
    not r15 into r16;
    or false r16 into r17;
    assert.eq r17 true;
    add r0.kg 1000000u64 into r18;
    div r18 10000000u64 into r19;
    cast r19 into r20 as u8;
    gt r20 r0.level into r21;
    assert.eq r21 true;
    cast r20 into r22 as u64;
    mul r22 10000000u64 into r23;
    call puzzle_arcade_ticket_v002.aleo/mint r0.owner r23 into r24 r25;
    cast r0.owner r18 r2 r20 r0.squash_name r0.squash_id into r26 as Squash.record;
    async water_and_level_up r25 into r27;
    output r26 as Squash.record;
    output r24 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    output r27 as squash_v002.aleo/water_and_level_up.future;

finalize water_and_level_up:
    input r0 as puzzle_arcade_ticket_v002.aleo/mint.future;
    await r0;

function migrate_from_v1:
    input r0 as squash_v001.aleo/Squash.record;
    input r1 as u32.private;
    input r2 as squash_timestamp.aleo/Timestamp.record;
    assert.eq self.caller aleo12e0yyyqw0lfff8nufdss94k5hml9d9jl45rlfwu5l3e73wpu9s8sdznsev;
    div r0.kg 10000000u64 into r3;
    cast r3 into r4 as u8;
    cast r0.owner r0.kg r2.time r4 r0.squash_name r1 into r5 as Squash.record;
    output r5 as Squash.record;

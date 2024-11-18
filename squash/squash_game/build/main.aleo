import squash_time_oracle.aleo;
program squash_game.aleo;


record Squash:
    owner as address.private;
    kg as u64.private;
    last_water as u64.private;


function mint:
    input r0 as address.private;
    input r1 as squash_time_oracle.aleo/Timestamp.record;
    cast r0 0u64 r1.time into r2 as Squash.record;
    output r2 as Squash.record;


function water:
    input r0 as Squash.record;
    input r1 as squash_time_oracle.aleo/Timestamp.record;
    input r2 as u64.public;
    input r3 as u64.public;
    sub r1.time r3 into r4;
    lt r0.last_water r4 into r5;
    sub r1.time r0.last_water into r6;
    rem r6 r3 into r7;
    div r7 2000000u64 into r8;
    lt r0.kg r8 into r9;
    sub r0.kg r8 into r10;
    ternary r9 0u64 r10 into r11;
    cast r0.owner r11 r2 into r12 as Squash.record;
    lt r0.last_water r1.time into r13;
    add r0.kg 1u64 into r14;
    cast r0.owner r14 r2 into r15 as Squash.record;
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
    cast r23 r26 r29 into r30 as Squash.record;
    ternary r5 r12.owner r30.owner into r31;
    ternary r5 r12.kg r30.kg into r32;
    ternary r5 r12.last_water r30.last_water into r33;
    cast r31 r32 r33 into r34 as Squash.record;
    output r34 as Squash.record;

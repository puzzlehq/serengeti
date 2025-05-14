import timestamp_testing.aleo;

program squash_testing.aleo;

record Squash:
    owner as address.private;
    kg as u64.private;
    last_water as u64.private;

function mint:
    input r0 as address.private;
    input r1 as timestamp_testing.aleo/Timestamp.record;
    cast r0 0u64 r1.time into r2 as Squash.record;
    output r2 as Squash.record;

function water:
    input r0 as Squash.record;
    input r1 as timestamp_testing.aleo/Timestamp.record;
    input r2 as u64.public;
    sub r1.time 300u64 into r3;
    lt r0.last_water r3 into r4;
    sub r1.time r0.last_water into r5;
    rem r5 300u64 into r6;
    div r6 2000000u64 into r7;
    sub r0.kg r7 into r8;
    cast r0.owner r8 r2 into r9 as Squash.record;
    lt r0.last_water r1.time into r10;
    add r0.kg 1u64 into r11;
    cast r0.owner r11 r2 into r12 as Squash.record;
    not r4 into r13;
    and r13 r10 into r14;
    ternary r14 r12.owner r0.owner into r15;
    not r4 into r16;
    and r16 r10 into r17;
    ternary r17 r12.kg r0.kg into r18;
    not r4 into r19;
    and r19 r10 into r20;
    ternary r20 r12.last_water r0.last_water into r21;
    cast r15 r18 r21 into r22 as Squash.record;
    ternary r4 r9.owner r22.owner into r23;
    ternary r4 r9.kg r22.kg into r24;
    ternary r4 r9.last_water r22.last_water into r25;
    cast r23 r24 r25 into r26 as Squash.record;
    output r26 as Squash.record;

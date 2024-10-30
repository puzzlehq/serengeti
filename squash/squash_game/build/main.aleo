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
    sub r1.time 86_400u64 into r2;
    lt r0.last_water r2 into r3;
    sub r1.time r0.last_water into r4;
    rem r4 86_400u64 into r5;
    div r5 2000000u64 into r6;
    sub r0.kg r6 into r7;
    cast r0.owner r7 r1.time into r8 as Squash.record;
    lt r0.last_water r1.time into r9;
    add r0.kg 1u64 into r10;
    cast r0.owner r10 r1.time into r11 as Squash.record;
    not r3 into r12;
    and r12 r9 into r13;
    ternary r13 r11.owner r0.owner into r14;
    not r3 into r15;
    and r15 r9 into r16;
    ternary r16 r11.kg r0.kg into r17;
    not r3 into r18;
    and r18 r9 into r19;
    ternary r19 r11.last_water r0.last_water into r20;
    cast r14 r17 r20 into r21 as Squash.record;
    ternary r3 r8.owner r21.owner into r22;
    ternary r3 r8.kg r21.kg into r23;
    ternary r3 r8.last_water r21.last_water into r24;
    cast r22 r23 r24 into r25 as Squash.record;
    output r25 as Squash.record;

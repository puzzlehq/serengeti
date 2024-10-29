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
    add r0.kg 1u64 into r4;
    cast r0.owner r4 r1.time into r5 as Squash.record;
    sub r1.time r0.last_water into r6;
    rem r6 86_400u64 into r7;
    sub r0.kg r7 into r8;
    cast r0.owner r8 r1.time into r9 as Squash.record;
    ternary r3 r5.owner r9.owner into r10;
    ternary r3 r5.kg r9.kg into r11;
    ternary r3 r5.last_water r9.last_water into r12;
    cast r10 r11 r12 into r13 as Squash.record;
    output r13 as Squash.record;

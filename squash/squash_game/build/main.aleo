import squash_time_oracle.aleo;
import puzzle_arcade_ticket_v001.aleo;
program squash_testing_4.aleo;



record Squash:
    owner as address.private;
    kg as u64.private;
    last_water as u64.private;
    level as u8.private;


function mint:
    input r0 as address.private;
    input r1 as squash_time_oracle.aleo/Timestamp.record;
    cast r0 0u64 r1.time 0u8 into r2 as Squash.record;
    output r2 as Squash.record;


function water:
    input r0 as Squash.record;
    input r1 as squash_time_oracle.aleo/Timestamp.record;
    input r2 as u64.public;
    input r3 as u64.public;
    sub r1.time r3 into r4;
    lt r0.last_water r4 into r5;
    sub r1.time r0.last_water into r6;
    div r6 r3 into r7;
    add r7 1u64 into r8;
    div r8 2000000u64 into r9;
    lt r0.kg r9 into r10;
    sub r0.kg r9 into r11;
    ternary r10 0u64 r11 into r12;
    cast r0.owner r12 r2 r0.level into r13 as Squash.record;
    lt r0.last_water r1.time into r14;
    add r0.kg 1u64 into r15;
    cast r0.owner r15 r2 r0.level into r16 as Squash.record;
    not r5 into r17;
    not r14 into r18;
    and r17 r18 into r19;
    not r19 into r20;
    or r20 false into r21;
    assert.eq r21 true;
    not r5 into r22;
    and r22 r14 into r23;
    ternary r23 r16.owner r0.owner into r24;
    not r5 into r25;
    and r25 r14 into r26;
    ternary r26 r16.kg r0.kg into r27;
    not r5 into r28;
    and r28 r14 into r29;
    ternary r29 r16.last_water r0.last_water into r30;
    not r5 into r31;
    and r31 r14 into r32;
    ternary r32 r16.level r0.level into r33;
    cast r24 r27 r30 r33 into r34 as Squash.record;
    ternary r5 r13.owner r34.owner into r35;
    ternary r5 r13.kg r34.kg into r36;
    ternary r5 r13.last_water r34.last_water into r37;
    ternary r5 r13.level r34.level into r38;
    cast r35 r36 r37 r38 into r39 as Squash.record;
    output r39 as Squash.record;



function level_up:
    input r0 as Squash.record;
    div r0.kg 10u64 into r1;
    cast r1 into r2 as u8;
    gt r2 r0.level into r3;
    assert.eq r3 true;
    mul r2 10u8 into r4;
    cast r4 into r5 as u64;
    call puzzle_arcade_ticket_v001.aleo/mint r0.owner r5 into r6 r7;
    async level_up r7 into r8;
    output r0 as Squash.record;
    output r6 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r8 as squash_testing_4.aleo/level_up.future;

finalize level_up:
    input r0 as puzzle_arcade_ticket_v001.aleo/mint.future;
    await r0;


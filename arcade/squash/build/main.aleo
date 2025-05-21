import puzzle_arcade_ticket_v002.aleo;
import puzzle_arcade_coin_v002.aleo;
import timestamp_testing.aleo;
import puzzle_arcade_ticket_v001.aleo;
import puzzle_arcade_coin_v001.aleo;
import squash_testing.aleo;
import squash_v3.aleo;
program squash_v4.aleo;

record Squash:
    owner as address.private;
    kg as u64.private;
    last_water as u64.private;
    level as u8.private;
    squash_name as u128.private;
    squash_id as u32.private;

mapping day_start:
    key as u8.public;
    value as u64.public;

function mint:
    input r0 as puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin.record;
    input r1 as address.private;
    input r2 as u128.private;
    input r3 as u32.private;
    input r4 as u64.private;
    call puzzle_arcade_coin_v002.aleo/spend r0 r0.amount into r5;
    cast r1 1000000u64 r4 0u8 r2 r3 into r6 as Squash.record;
    async mint r4 into r7;
    output r6 as Squash.record;
    output r7 as squash_v4.aleo/mint.future;

finalize mint:
    input r0 as u64.public;
    get.or_use day_start[0u8] 0u64 into r1;
    assert.eq r0 r1;

function water:
    input r0 as Squash.record;
    input r1 as u64.private;
    input r2 as u64.public;
    input r3 as u64.public;
    gte r2 r1 into r4;
    assert.eq r4 true;
    gte r2 r0.last_water into r5;
    assert.eq r5 true;
    gte r1 r0.last_water into r6;
    assert.eq r6 true;
    lt r0.level 5u8 into r7;
    assert.eq r7 true;
    sub r1 r3 into r8;
    lt r0.last_water r8 into r9;
    sub r1 r0.last_water into r10;
    div r10 r3 into r11;
    cast r11 into r12 as u64;
    mul r12 1000000u64 into r13;
    div r13 2u64 into r14;
    cast r14 into r15 as u64;
    cast r0.kg into r16 as i64;
    cast r15 into r17 as i64;
    sub r16 r17 into r18;
    lte r16 r17 into r19;
    ternary r19 0i64 r18 into r20;
    cast r20 into r21 as u64;
    not r9 into r22;
    lt r0.last_water r1 into r23;
    add r0.kg 1000000u64 into r24;
    not r23 into r25;
    and r22 r25 into r26;
    not r26 into r27;
    or false r27 into r28;
    assert.eq r28 true;
    ternary r23 r24 r0.kg into r29;
    ternary r9 r21 r29 into r30;
    cast r0.owner r30 r2 r0.level r0.squash_name r0.squash_id into r31 as Squash.record;
    async water r1 into r32;
    output r31 as Squash.record;
    output r32 as squash_v4.aleo/water.future;

finalize water:
    input r0 as u64.public;
    get.or_use day_start[0u8] 0u64 into r1;
    assert.eq r0 r1;

function water_and_level_up:
    input r0 as Squash.record;
    input r1 as u64.private;
    input r2 as u64.public;
    input r3 as u64.public;
    gte r2 r1 into r4;
    assert.eq r4 true;
    gte r2 r0.last_water into r5;
    assert.eq r5 true;
    gte r1 r0.last_water into r6;
    assert.eq r6 true;
    sub r1 r3 into r7;
    sub r7 r3 into r8;
    lt r0.last_water r8 into r9;
    not r9 into r10;
    or false r10 into r11;
    assert.eq r11 true;
    not r9 into r12;
    lt r0.last_water r1 into r13;
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
    lte r20 5u8 into r22;
    assert.eq r22 true;
    cast r20 into r23 as u64;
    mul r23 10000000u64 into r24;
    call puzzle_arcade_ticket_v002.aleo/mint r0.owner r24 into r25 r26;
    cast r0.owner r18 r2 r20 r0.squash_name r0.squash_id into r27 as Squash.record;
    async water_and_level_up r1 r26 into r28;
    output r27 as Squash.record;
    output r25 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    output r28 as squash_v4.aleo/water_and_level_up.future;

finalize water_and_level_up:
    input r0 as u64.public;
    input r1 as puzzle_arcade_ticket_v002.aleo/mint.future;
    get.or_use day_start[0u8] 0u64 into r2;
    assert.eq r0 r2;
    await r1;

function set_day_start:
    input r0 as u64.private;
    assert.eq self.caller aleo18xacl585anaqc06320r3yw8yjx9u3278l7vlrjj7nkpznz667gxq3kr2ev;
    async set_day_start r0 into r1;
    output r1 as squash_v4.aleo/set_day_start.future;

finalize set_day_start:
    input r0 as u64.public;
    set r0 into day_start[0u8];

function migrate_from_v3:
    input r0 as squash_v3.aleo/Squash.record;
    assert.eq self.caller aleo18xacl585anaqc06320r3yw8yjx9u3278l7vlrjj7nkpznz667gxq3kr2ev;
    cast r0.owner r0.kg r0.last_water r0.level r0.squash_name r0.squash_id into r1 as Squash.record;
    output r1 as Squash.record;

function mint_arbitrary_squash:
    input r0 as address.private;
    input r1 as u128.private;
    input r2 as u32.private;
    input r3 as u64.private;
    input r4 as u64.private;
    input r5 as u8.private;
    assert.eq self.caller aleo18xacl585anaqc06320r3yw8yjx9u3278l7vlrjj7nkpznz667gxq3kr2ev;
    lte r5 5u8 into r6;
    assert.eq r6 true;
    cast r0 r4 r3 r5 r1 r2 into r7 as Squash.record;
    async mint_arbitrary_squash r3 into r8;
    output r7 as Squash.record;
    output r8 as squash_v4.aleo/mint_arbitrary_squash.future;

finalize mint_arbitrary_squash:
    input r0 as u64.public;
    get.or_use day_start[0u8] 0u64 into r1;
    sub r1 86400u64 into r2;
    assert.eq r0 r2;

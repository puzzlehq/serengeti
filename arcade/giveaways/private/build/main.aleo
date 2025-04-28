import puzzle_arcade_ticket_v001.aleo;
import par_store_inventory_v1.aleo;
program par_giveaways_v1.aleo;

struct Code:
    pt1 as u128;
    pt2 as u128;
    pt3 as u128;
    pt4 as u128;
    pt5 as u128;

struct Index:
    giveaway_id as field;
    index as u64;

struct Entrant:
    giveaway_id as field;
    user as address;

mapping is_open:
    key as field.public;
    value as boolean.public;

mapping max_entries:
    key as field.public;
    value as u64.public;

mapping entries:
    key as field.public;
    value as address.public;

mapping user_entries:
    key as field.public;
    value as u16.public;

mapping total_entries:
    key as field.public;
    value as u64.public;

mapping winners:
    key as field.public;
    value as address.public;

mapping has_won:
    key as field.public;
    value as boolean.public;

mapping total_winners:
    key as field.public;
    value as u64.public;

function open:
    input r0 as field.private;
    input r1 as u64.private;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo196a39wq9q8ea779cmlmff0c9pj2gl4f5e8fhjpvmufe5utuq7y8snz4h2l;
    async open r0 r1 into r2;
    output r2 as par_giveaways_v1.aleo/open.future;

finalize open:
    input r0 as field.public;
    input r1 as u64.public;
    set true into is_open[r0];
    set r1 into max_entries[r0];

function close:
    input r0 as field.private;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo196a39wq9q8ea779cmlmff0c9pj2gl4f5e8fhjpvmufe5utuq7y8snz4h2l;
    async close r0 into r1;
    output r1 as par_giveaways_v1.aleo/close.future;

finalize close:
    input r0 as field.public;
    set false into is_open[r0];

function draw_winner:
    input r0 as field.private;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo196a39wq9q8ea779cmlmff0c9pj2gl4f5e8fhjpvmufe5utuq7y8snz4h2l;
    async draw_winner r0 into r1;
    output r1 as par_giveaways_v1.aleo/draw_winner.future;

finalize draw_winner:
    input r0 as field.public;
    get.or_use is_open[r0] false into r1;
    assert.eq r1 false;
    get total_entries[r0] into r2;
    rand.chacha into r3 as u64;
    rem r3 r2 into r4;
    cast r0 r4 into r5 as Index;
    hash.bhp256 r5 into r6 as field;
    get entries[r6] into r7;
    cast r0 r7 into r8 as Entrant;
    hash.bhp256 r8 into r9 as field;
    get.or_use has_won[r9] false into r10;
    assert.eq r10 false;
    get.or_use total_winners[r0] 0u64 into r11;
    hash.bhp256 r8 into r12 as field;
    set true into has_won[r12];
    add r11 1u64 into r13;
    set r13 into total_winners[r0];
    cast r0 r11 into r14 as Index;
    hash.bhp256 r14 into r15 as field;
    set r7 into winners[r15];

function buy_one_entry:
    input r0 as field.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v001.aleo/spend r1 1000000u64 into r2;
    async buy_one_entry r1.owner r0 into r3;
    output r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r3 as par_giveaways_v1.aleo/buy_one_entry.future;

finalize buy_one_entry:
    input r0 as address.public;
    input r1 as field.public;
    get.or_use is_open[r1] false into r2;
    assert.eq r2 true;
    get.or_use total_entries[r1] 0u64 into r3;
    add r3 1u64 into r4;
    get.or_use max_entries[r1] 0u64 into r5;
    lt r4 r5 into r6;
    assert.eq r6 true;
    cast r1 r3 into r7 as Index;
    hash.bhp256 r7 into r8 as field;
    set r0 into entries[r8];
    add r3 1u64 into r9;
    set r9 into total_entries[r1];
    cast r1 r0 into r10 as Entrant;
    hash.bhp256 r10 into r11 as field;
    get.or_use user_entries[r11] 0u16 into r12;
    add r12 1u16 into r13;
    set r13 into user_entries[r11];

function buy_two_entries:
    input r0 as field.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v001.aleo/spend r1 2000000u64 into r2;
    async buy_two_entries r1.owner r0 into r3;
    output r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r3 as par_giveaways_v1.aleo/buy_two_entries.future;

finalize buy_two_entries:
    input r0 as address.public;
    input r1 as field.public;
    get.or_use is_open[r1] false into r2;
    assert.eq r2 true;
    get.or_use total_entries[r1] 0u64 into r3;
    add r3 2u64 into r4;
    get.or_use max_entries[r1] 0u64 into r5;
    lt r4 r5 into r6;
    assert.eq r6 true;
    add r3 0u64 into r7;
    cast r1 r7 into r8 as Index;
    hash.bhp256 r8 into r9 as field;
    set r0 into entries[r9];
    add r3 1u64 into r10;
    cast r1 r10 into r11 as Index;
    hash.bhp256 r11 into r12 as field;
    set r0 into entries[r12];
    add r3 2u64 into r13;
    set r13 into total_entries[r1];
    cast r1 r0 into r14 as Entrant;
    hash.bhp256 r14 into r15 as field;
    get.or_use user_entries[r15] 0u16 into r16;
    add r16 2u16 into r17;
    set r17 into user_entries[r15];

function buy_three_entries:
    input r0 as field.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v001.aleo/spend r1 3000000u64 into r2;
    async buy_three_entries r1.owner r0 into r3;
    output r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r3 as par_giveaways_v1.aleo/buy_three_entries.future;

finalize buy_three_entries:
    input r0 as address.public;
    input r1 as field.public;
    get.or_use is_open[r1] false into r2;
    assert.eq r2 true;
    get.or_use total_entries[r1] 0u64 into r3;
    add r3 3u64 into r4;
    get.or_use max_entries[r1] 0u64 into r5;
    lt r4 r5 into r6;
    assert.eq r6 true;
    add r3 0u64 into r7;
    cast r1 r7 into r8 as Index;
    hash.bhp256 r8 into r9 as field;
    set r0 into entries[r9];
    add r3 1u64 into r10;
    cast r1 r10 into r11 as Index;
    hash.bhp256 r11 into r12 as field;
    set r0 into entries[r12];
    add r3 2u64 into r13;
    cast r1 r13 into r14 as Index;
    hash.bhp256 r14 into r15 as field;
    set r0 into entries[r15];
    add r3 3u64 into r16;
    set r16 into total_entries[r1];
    cast r1 r0 into r17 as Entrant;
    hash.bhp256 r17 into r18 as field;
    get.or_use user_entries[r18] 0u16 into r19;
    add r19 3u16 into r20;
    set r20 into user_entries[r18];

function buy_four_entries:
    input r0 as field.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v001.aleo/spend r1 4000000u64 into r2;
    async buy_four_entries r1.owner r0 into r3;
    output r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r3 as par_giveaways_v1.aleo/buy_four_entries.future;

finalize buy_four_entries:
    input r0 as address.public;
    input r1 as field.public;
    get.or_use is_open[r1] false into r2;
    assert.eq r2 true;
    get.or_use total_entries[r1] 0u64 into r3;
    add r3 4u64 into r4;
    get.or_use max_entries[r1] 0u64 into r5;
    lt r4 r5 into r6;
    assert.eq r6 true;
    add r3 0u64 into r7;
    cast r1 r7 into r8 as Index;
    hash.bhp256 r8 into r9 as field;
    set r0 into entries[r9];
    add r3 1u64 into r10;
    cast r1 r10 into r11 as Index;
    hash.bhp256 r11 into r12 as field;
    set r0 into entries[r12];
    add r3 2u64 into r13;
    cast r1 r13 into r14 as Index;
    hash.bhp256 r14 into r15 as field;
    set r0 into entries[r15];
    add r3 3u64 into r16;
    cast r1 r16 into r17 as Index;
    hash.bhp256 r17 into r18 as field;
    set r0 into entries[r18];
    add r3 4u64 into r19;
    set r19 into total_entries[r1];
    cast r1 r0 into r20 as Entrant;
    hash.bhp256 r20 into r21 as field;
    get.or_use user_entries[r21] 0u16 into r22;
    add r22 4u16 into r23;
    set r23 into user_entries[r21];

function buy_five_entries:
    input r0 as field.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v001.aleo/spend r1 5000000u64 into r2;
    async buy_five_entries r1.owner r0 into r3;
    output r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r3 as par_giveaways_v1.aleo/buy_five_entries.future;

finalize buy_five_entries:
    input r0 as address.public;
    input r1 as field.public;
    get.or_use is_open[r1] false into r2;
    assert.eq r2 true;
    get.or_use total_entries[r1] 0u64 into r3;
    add r3 5u64 into r4;
    get.or_use max_entries[r1] 0u64 into r5;
    lt r4 r5 into r6;
    assert.eq r6 true;
    add r3 0u64 into r7;
    cast r1 r7 into r8 as Index;
    hash.bhp256 r8 into r9 as field;
    set r0 into entries[r9];
    add r3 1u64 into r10;
    cast r1 r10 into r11 as Index;
    hash.bhp256 r11 into r12 as field;
    set r0 into entries[r12];
    add r3 2u64 into r13;
    cast r1 r13 into r14 as Index;
    hash.bhp256 r14 into r15 as field;
    set r0 into entries[r15];
    add r3 3u64 into r16;
    cast r1 r16 into r17 as Index;
    hash.bhp256 r17 into r18 as field;
    set r0 into entries[r18];
    add r3 4u64 into r19;
    cast r1 r19 into r20 as Index;
    hash.bhp256 r20 into r21 as field;
    set r0 into entries[r21];
    add r3 5u64 into r22;
    set r22 into total_entries[r1];
    cast r1 r0 into r23 as Entrant;
    hash.bhp256 r23 into r24 as field;
    get.or_use user_entries[r24] 0u16 into r25;
    add r25 5u16 into r26;
    set r26 into user_entries[r24];

function buy_six_entries:
    input r0 as field.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v001.aleo/spend r1 6000000u64 into r2;
    async buy_six_entries r1.owner r0 into r3;
    output r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r3 as par_giveaways_v1.aleo/buy_six_entries.future;

finalize buy_six_entries:
    input r0 as address.public;
    input r1 as field.public;
    get.or_use is_open[r1] false into r2;
    assert.eq r2 true;
    get.or_use total_entries[r1] 0u64 into r3;
    add r3 6u64 into r4;
    get.or_use max_entries[r1] 0u64 into r5;
    lt r4 r5 into r6;
    assert.eq r6 true;
    add r3 0u64 into r7;
    cast r1 r7 into r8 as Index;
    hash.bhp256 r8 into r9 as field;
    set r0 into entries[r9];
    add r3 1u64 into r10;
    cast r1 r10 into r11 as Index;
    hash.bhp256 r11 into r12 as field;
    set r0 into entries[r12];
    add r3 2u64 into r13;
    cast r1 r13 into r14 as Index;
    hash.bhp256 r14 into r15 as field;
    set r0 into entries[r15];
    add r3 3u64 into r16;
    cast r1 r16 into r17 as Index;
    hash.bhp256 r17 into r18 as field;
    set r0 into entries[r18];
    add r3 4u64 into r19;
    cast r1 r19 into r20 as Index;
    hash.bhp256 r20 into r21 as field;
    set r0 into entries[r21];
    add r3 5u64 into r22;
    cast r1 r22 into r23 as Index;
    hash.bhp256 r23 into r24 as field;
    set r0 into entries[r24];
    add r3 6u64 into r25;
    set r25 into total_entries[r1];
    cast r1 r0 into r26 as Entrant;
    hash.bhp256 r26 into r27 as field;
    get.or_use user_entries[r27] 0u16 into r28;
    add r28 6u16 into r29;
    set r29 into user_entries[r27];

function buy_seven_entries:
    input r0 as field.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v001.aleo/spend r1 7000000u64 into r2;
    async buy_seven_entries r1.owner r0 into r3;
    output r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r3 as par_giveaways_v1.aleo/buy_seven_entries.future;

finalize buy_seven_entries:
    input r0 as address.public;
    input r1 as field.public;
    get.or_use is_open[r1] false into r2;
    assert.eq r2 true;
    get.or_use total_entries[r1] 0u64 into r3;
    add r3 7u64 into r4;
    get.or_use max_entries[r1] 0u64 into r5;
    lt r4 r5 into r6;
    assert.eq r6 true;
    add r3 0u64 into r7;
    cast r1 r7 into r8 as Index;
    hash.bhp256 r8 into r9 as field;
    set r0 into entries[r9];
    add r3 1u64 into r10;
    cast r1 r10 into r11 as Index;
    hash.bhp256 r11 into r12 as field;
    set r0 into entries[r12];
    add r3 2u64 into r13;
    cast r1 r13 into r14 as Index;
    hash.bhp256 r14 into r15 as field;
    set r0 into entries[r15];
    add r3 3u64 into r16;
    cast r1 r16 into r17 as Index;
    hash.bhp256 r17 into r18 as field;
    set r0 into entries[r18];
    add r3 4u64 into r19;
    cast r1 r19 into r20 as Index;
    hash.bhp256 r20 into r21 as field;
    set r0 into entries[r21];
    add r3 5u64 into r22;
    cast r1 r22 into r23 as Index;
    hash.bhp256 r23 into r24 as field;
    set r0 into entries[r24];
    add r3 6u64 into r25;
    cast r1 r25 into r26 as Index;
    hash.bhp256 r26 into r27 as field;
    set r0 into entries[r27];
    add r3 7u64 into r28;
    set r28 into total_entries[r1];
    cast r1 r0 into r29 as Entrant;
    hash.bhp256 r29 into r30 as field;
    get.or_use user_entries[r30] 0u16 into r31;
    add r31 7u16 into r32;
    set r32 into user_entries[r30];

function buy_eight_entries:
    input r0 as field.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v001.aleo/spend r1 8000000u64 into r2;
    async buy_eight_entries r1.owner r0 into r3;
    output r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r3 as par_giveaways_v1.aleo/buy_eight_entries.future;

finalize buy_eight_entries:
    input r0 as address.public;
    input r1 as field.public;
    get.or_use is_open[r1] false into r2;
    assert.eq r2 true;
    get.or_use total_entries[r1] 0u64 into r3;
    add r3 8u64 into r4;
    get.or_use max_entries[r1] 0u64 into r5;
    lt r4 r5 into r6;
    assert.eq r6 true;
    add r3 0u64 into r7;
    cast r1 r7 into r8 as Index;
    hash.bhp256 r8 into r9 as field;
    set r0 into entries[r9];
    add r3 1u64 into r10;
    cast r1 r10 into r11 as Index;
    hash.bhp256 r11 into r12 as field;
    set r0 into entries[r12];
    add r3 2u64 into r13;
    cast r1 r13 into r14 as Index;
    hash.bhp256 r14 into r15 as field;
    set r0 into entries[r15];
    add r3 3u64 into r16;
    cast r1 r16 into r17 as Index;
    hash.bhp256 r17 into r18 as field;
    set r0 into entries[r18];
    add r3 4u64 into r19;
    cast r1 r19 into r20 as Index;
    hash.bhp256 r20 into r21 as field;
    set r0 into entries[r21];
    add r3 5u64 into r22;
    cast r1 r22 into r23 as Index;
    hash.bhp256 r23 into r24 as field;
    set r0 into entries[r24];
    add r3 6u64 into r25;
    cast r1 r25 into r26 as Index;
    hash.bhp256 r26 into r27 as field;
    set r0 into entries[r27];
    add r3 7u64 into r28;
    cast r1 r28 into r29 as Index;
    hash.bhp256 r29 into r30 as field;
    set r0 into entries[r30];
    add r3 8u64 into r31;
    set r31 into total_entries[r1];
    cast r1 r0 into r32 as Entrant;
    hash.bhp256 r32 into r33 as field;
    get.or_use user_entries[r33] 0u16 into r34;
    add r34 8u16 into r35;
    set r35 into user_entries[r33];

function buy_nine_entries:
    input r0 as field.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v001.aleo/spend r1 9000000u64 into r2;
    async buy_nine_entries r1.owner r0 into r3;
    output r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r3 as par_giveaways_v1.aleo/buy_nine_entries.future;

finalize buy_nine_entries:
    input r0 as address.public;
    input r1 as field.public;
    get.or_use is_open[r1] false into r2;
    assert.eq r2 true;
    get.or_use total_entries[r1] 0u64 into r3;
    add r3 9u64 into r4;
    get.or_use max_entries[r1] 0u64 into r5;
    lt r4 r5 into r6;
    assert.eq r6 true;
    add r3 0u64 into r7;
    cast r1 r7 into r8 as Index;
    hash.bhp256 r8 into r9 as field;
    set r0 into entries[r9];
    add r3 1u64 into r10;
    cast r1 r10 into r11 as Index;
    hash.bhp256 r11 into r12 as field;
    set r0 into entries[r12];
    add r3 2u64 into r13;
    cast r1 r13 into r14 as Index;
    hash.bhp256 r14 into r15 as field;
    set r0 into entries[r15];
    add r3 3u64 into r16;
    cast r1 r16 into r17 as Index;
    hash.bhp256 r17 into r18 as field;
    set r0 into entries[r18];
    add r3 4u64 into r19;
    cast r1 r19 into r20 as Index;
    hash.bhp256 r20 into r21 as field;
    set r0 into entries[r21];
    add r3 5u64 into r22;
    cast r1 r22 into r23 as Index;
    hash.bhp256 r23 into r24 as field;
    set r0 into entries[r24];
    add r3 6u64 into r25;
    cast r1 r25 into r26 as Index;
    hash.bhp256 r26 into r27 as field;
    set r0 into entries[r27];
    add r3 7u64 into r28;
    cast r1 r28 into r29 as Index;
    hash.bhp256 r29 into r30 as field;
    set r0 into entries[r30];
    add r3 8u64 into r31;
    cast r1 r31 into r32 as Index;
    hash.bhp256 r32 into r33 as field;
    set r0 into entries[r33];
    add r3 9u64 into r34;
    set r34 into total_entries[r1];
    cast r1 r0 into r35 as Entrant;
    hash.bhp256 r35 into r36 as field;
    get.or_use user_entries[r36] 0u16 into r37;
    add r37 9u16 into r38;
    set r38 into user_entries[r36];

function buy_ten_entries:
    input r0 as field.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v001.aleo/spend r1 10000000u64 into r2;
    async buy_ten_entries r1.owner r0 into r3;
    output r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r3 as par_giveaways_v1.aleo/buy_ten_entries.future;

finalize buy_ten_entries:
    input r0 as address.public;
    input r1 as field.public;
    get.or_use is_open[r1] false into r2;
    assert.eq r2 true;
    get.or_use total_entries[r1] 0u64 into r3;
    add r3 10u64 into r4;
    get.or_use max_entries[r1] 0u64 into r5;
    lt r4 r5 into r6;
    assert.eq r6 true;
    add r3 0u64 into r7;
    cast r1 r7 into r8 as Index;
    hash.bhp256 r8 into r9 as field;
    set r0 into entries[r9];
    add r3 1u64 into r10;
    cast r1 r10 into r11 as Index;
    hash.bhp256 r11 into r12 as field;
    set r0 into entries[r12];
    add r3 2u64 into r13;
    cast r1 r13 into r14 as Index;
    hash.bhp256 r14 into r15 as field;
    set r0 into entries[r15];
    add r3 3u64 into r16;
    cast r1 r16 into r17 as Index;
    hash.bhp256 r17 into r18 as field;
    set r0 into entries[r18];
    add r3 4u64 into r19;
    cast r1 r19 into r20 as Index;
    hash.bhp256 r20 into r21 as field;
    set r0 into entries[r21];
    add r3 5u64 into r22;
    cast r1 r22 into r23 as Index;
    hash.bhp256 r23 into r24 as field;
    set r0 into entries[r24];
    add r3 6u64 into r25;
    cast r1 r25 into r26 as Index;
    hash.bhp256 r26 into r27 as field;
    set r0 into entries[r27];
    add r3 7u64 into r28;
    cast r1 r28 into r29 as Index;
    hash.bhp256 r29 into r30 as field;
    set r0 into entries[r30];
    add r3 8u64 into r31;
    cast r1 r31 into r32 as Index;
    hash.bhp256 r32 into r33 as field;
    set r0 into entries[r33];
    add r3 9u64 into r34;
    cast r1 r34 into r35 as Index;
    hash.bhp256 r35 into r36 as field;
    set r0 into entries[r36];
    add r3 10u64 into r37;
    set r37 into total_entries[r1];
    cast r1 r0 into r38 as Entrant;
    hash.bhp256 r38 into r39 as field;
    get.or_use user_entries[r39] 0u16 into r40;
    add r40 10u16 into r41;
    set r41 into user_entries[r39];

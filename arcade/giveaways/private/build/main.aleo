import puzzle_arcade_ticket_v002.aleo;
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
    hash.psd2 r5 into r6 as field;
    get entries[r6] into r7;
    cast r0 r7 into r8 as Entrant;
    hash.psd2 r8 into r9 as field;
    get.or_use has_won[r9] false into r10;
    assert.eq r10 false;
    get.or_use total_winners[r0] 0u64 into r11;
    hash.psd2 r8 into r12 as field;
    set true into has_won[r12];
    add r11 1u64 into r13;
    set r13 into total_winners[r0];
    cast r0 r11 into r14 as Index;
    hash.psd2 r14 into r15 as field;
    set r7 into winners[r15];

function buy_one_entry:
    input r0 as field.private;
    input r1 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v002.aleo/spend r1 1000000u64 into r2;
    cast r0 r1.owner into r3 as Entrant;
    hash.psd2 r3 into r4 as field;
    async buy_one_entry r1.owner r0 r4 into r5;
    output r2 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    output r5 as par_giveaways_v1.aleo/buy_one_entry.future;

finalize buy_one_entry:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as field.public;
    get.or_use is_open[r1] false into r3;
    assert.eq r3 true;
    get.or_use total_entries[r1] 0u64 into r4;
    add r4 1u64 into r5;
    get.or_use max_entries[r1] 0u64 into r6;
    lte r5 r6 into r7;
    assert.eq r7 true;
    cast r1 r4 into r8 as Index;
    hash.psd2 r8 into r9 as field;
    set r0 into entries[r9];
    add r4 1u64 into r10;
    set r10 into total_entries[r1];
    get.or_use user_entries[r2] 0u16 into r11;
    add r11 1u16 into r12;
    set r12 into user_entries[r2];

function buy_two_entries:
    input r0 as field.private;
    input r1 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v002.aleo/spend r1 2000000u64 into r2;
    cast r0 r1.owner into r3 as Entrant;
    hash.psd2 r3 into r4 as field;
    async buy_two_entries r1.owner r0 r4 into r5;
    output r2 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    output r5 as par_giveaways_v1.aleo/buy_two_entries.future;

finalize buy_two_entries:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as field.public;
    get.or_use is_open[r1] false into r3;
    assert.eq r3 true;
    get.or_use total_entries[r1] 0u64 into r4;
    add r4 2u64 into r5;
    get.or_use max_entries[r1] 0u64 into r6;
    lte r5 r6 into r7;
    assert.eq r7 true;
    add r4 0u64 into r8;
    cast r1 r8 into r9 as Index;
    hash.psd2 r9 into r10 as field;
    set r0 into entries[r10];
    add r4 1u64 into r11;
    cast r1 r11 into r12 as Index;
    hash.psd2 r12 into r13 as field;
    set r0 into entries[r13];
    add r4 2u64 into r14;
    set r14 into total_entries[r1];
    get.or_use user_entries[r2] 0u16 into r15;
    add r15 2u16 into r16;
    set r16 into user_entries[r2];

function buy_three_entries:
    input r0 as field.private;
    input r1 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v002.aleo/spend r1 3000000u64 into r2;
    cast r0 r1.owner into r3 as Entrant;
    hash.psd2 r3 into r4 as field;
    async buy_three_entries r1.owner r0 r4 into r5;
    output r2 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    output r5 as par_giveaways_v1.aleo/buy_three_entries.future;

finalize buy_three_entries:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as field.public;
    get.or_use is_open[r1] false into r3;
    assert.eq r3 true;
    get.or_use total_entries[r1] 0u64 into r4;
    add r4 3u64 into r5;
    get.or_use max_entries[r1] 0u64 into r6;
    lte r5 r6 into r7;
    assert.eq r7 true;
    add r4 0u64 into r8;
    cast r1 r8 into r9 as Index;
    hash.psd2 r9 into r10 as field;
    set r0 into entries[r10];
    add r4 1u64 into r11;
    cast r1 r11 into r12 as Index;
    hash.psd2 r12 into r13 as field;
    set r0 into entries[r13];
    add r4 2u64 into r14;
    cast r1 r14 into r15 as Index;
    hash.psd2 r15 into r16 as field;
    set r0 into entries[r16];
    add r4 3u64 into r17;
    set r17 into total_entries[r1];
    get.or_use user_entries[r2] 0u16 into r18;
    add r18 3u16 into r19;
    set r19 into user_entries[r2];

function buy_four_entries:
    input r0 as field.private;
    input r1 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v002.aleo/spend r1 4000000u64 into r2;
    cast r0 r1.owner into r3 as Entrant;
    hash.psd2 r3 into r4 as field;
    async buy_four_entries r1.owner r0 r4 into r5;
    output r2 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    output r5 as par_giveaways_v1.aleo/buy_four_entries.future;

finalize buy_four_entries:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as field.public;
    get.or_use is_open[r1] false into r3;
    assert.eq r3 true;
    get.or_use total_entries[r1] 0u64 into r4;
    add r4 4u64 into r5;
    get.or_use max_entries[r1] 0u64 into r6;
    lte r5 r6 into r7;
    assert.eq r7 true;
    add r4 0u64 into r8;
    cast r1 r8 into r9 as Index;
    hash.psd2 r9 into r10 as field;
    set r0 into entries[r10];
    add r4 1u64 into r11;
    cast r1 r11 into r12 as Index;
    hash.psd2 r12 into r13 as field;
    set r0 into entries[r13];
    add r4 2u64 into r14;
    cast r1 r14 into r15 as Index;
    hash.psd2 r15 into r16 as field;
    set r0 into entries[r16];
    add r4 3u64 into r17;
    cast r1 r17 into r18 as Index;
    hash.psd2 r18 into r19 as field;
    set r0 into entries[r19];
    add r4 4u64 into r20;
    set r20 into total_entries[r1];
    get.or_use user_entries[r2] 0u16 into r21;
    add r21 4u16 into r22;
    set r22 into user_entries[r2];

function buy_five_entries:
    input r0 as field.private;
    input r1 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v002.aleo/spend r1 5000000u64 into r2;
    cast r0 r1.owner into r3 as Entrant;
    hash.psd2 r3 into r4 as field;
    async buy_five_entries r1.owner r0 r4 into r5;
    output r2 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    output r5 as par_giveaways_v1.aleo/buy_five_entries.future;

finalize buy_five_entries:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as field.public;
    get.or_use is_open[r1] false into r3;
    assert.eq r3 true;
    get.or_use total_entries[r1] 0u64 into r4;
    add r4 5u64 into r5;
    get.or_use max_entries[r1] 0u64 into r6;
    lte r5 r6 into r7;
    assert.eq r7 true;
    add r4 0u64 into r8;
    cast r1 r8 into r9 as Index;
    hash.psd2 r9 into r10 as field;
    set r0 into entries[r10];
    add r4 1u64 into r11;
    cast r1 r11 into r12 as Index;
    hash.psd2 r12 into r13 as field;
    set r0 into entries[r13];
    add r4 2u64 into r14;
    cast r1 r14 into r15 as Index;
    hash.psd2 r15 into r16 as field;
    set r0 into entries[r16];
    add r4 3u64 into r17;
    cast r1 r17 into r18 as Index;
    hash.psd2 r18 into r19 as field;
    set r0 into entries[r19];
    add r4 4u64 into r20;
    cast r1 r20 into r21 as Index;
    hash.psd2 r21 into r22 as field;
    set r0 into entries[r22];
    add r4 5u64 into r23;
    set r23 into total_entries[r1];
    get.or_use user_entries[r2] 0u16 into r24;
    add r24 5u16 into r25;
    set r25 into user_entries[r2];

function buy_six_entries:
    input r0 as field.private;
    input r1 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v002.aleo/spend r1 6000000u64 into r2;
    cast r0 r1.owner into r3 as Entrant;
    hash.psd2 r3 into r4 as field;
    async buy_six_entries r1.owner r0 r4 into r5;
    output r2 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    output r5 as par_giveaways_v1.aleo/buy_six_entries.future;

finalize buy_six_entries:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as field.public;
    get.or_use is_open[r1] false into r3;
    assert.eq r3 true;
    get.or_use total_entries[r1] 0u64 into r4;
    add r4 6u64 into r5;
    get.or_use max_entries[r1] 0u64 into r6;
    lte r5 r6 into r7;
    assert.eq r7 true;
    add r4 0u64 into r8;
    cast r1 r8 into r9 as Index;
    hash.psd2 r9 into r10 as field;
    set r0 into entries[r10];
    add r4 1u64 into r11;
    cast r1 r11 into r12 as Index;
    hash.psd2 r12 into r13 as field;
    set r0 into entries[r13];
    add r4 2u64 into r14;
    cast r1 r14 into r15 as Index;
    hash.psd2 r15 into r16 as field;
    set r0 into entries[r16];
    add r4 3u64 into r17;
    cast r1 r17 into r18 as Index;
    hash.psd2 r18 into r19 as field;
    set r0 into entries[r19];
    add r4 4u64 into r20;
    cast r1 r20 into r21 as Index;
    hash.psd2 r21 into r22 as field;
    set r0 into entries[r22];
    add r4 5u64 into r23;
    cast r1 r23 into r24 as Index;
    hash.psd2 r24 into r25 as field;
    set r0 into entries[r25];
    add r4 6u64 into r26;
    set r26 into total_entries[r1];
    get.or_use user_entries[r2] 0u16 into r27;
    add r27 6u16 into r28;
    set r28 into user_entries[r2];

function buy_seven_entries:
    input r0 as field.private;
    input r1 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v002.aleo/spend r1 7000000u64 into r2;
    cast r0 r1.owner into r3 as Entrant;
    hash.psd2 r3 into r4 as field;
    async buy_seven_entries r1.owner r0 r4 into r5;
    output r2 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    output r5 as par_giveaways_v1.aleo/buy_seven_entries.future;

finalize buy_seven_entries:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as field.public;
    get.or_use is_open[r1] false into r3;
    assert.eq r3 true;
    get.or_use total_entries[r1] 0u64 into r4;
    add r4 7u64 into r5;
    get.or_use max_entries[r1] 0u64 into r6;
    lte r5 r6 into r7;
    assert.eq r7 true;
    add r4 0u64 into r8;
    cast r1 r8 into r9 as Index;
    hash.psd2 r9 into r10 as field;
    set r0 into entries[r10];
    add r4 1u64 into r11;
    cast r1 r11 into r12 as Index;
    hash.psd2 r12 into r13 as field;
    set r0 into entries[r13];
    add r4 2u64 into r14;
    cast r1 r14 into r15 as Index;
    hash.psd2 r15 into r16 as field;
    set r0 into entries[r16];
    add r4 3u64 into r17;
    cast r1 r17 into r18 as Index;
    hash.psd2 r18 into r19 as field;
    set r0 into entries[r19];
    add r4 4u64 into r20;
    cast r1 r20 into r21 as Index;
    hash.psd2 r21 into r22 as field;
    set r0 into entries[r22];
    add r4 5u64 into r23;
    cast r1 r23 into r24 as Index;
    hash.psd2 r24 into r25 as field;
    set r0 into entries[r25];
    add r4 6u64 into r26;
    cast r1 r26 into r27 as Index;
    hash.psd2 r27 into r28 as field;
    set r0 into entries[r28];
    add r4 7u64 into r29;
    set r29 into total_entries[r1];
    get.or_use user_entries[r2] 0u16 into r30;
    add r30 7u16 into r31;
    set r31 into user_entries[r2];

function buy_eight_entries:
    input r0 as field.private;
    input r1 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v002.aleo/spend r1 8000000u64 into r2;
    cast r0 r1.owner into r3 as Entrant;
    hash.psd2 r3 into r4 as field;
    async buy_eight_entries r1.owner r0 r4 into r5;
    output r2 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    output r5 as par_giveaways_v1.aleo/buy_eight_entries.future;

finalize buy_eight_entries:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as field.public;
    get.or_use is_open[r1] false into r3;
    assert.eq r3 true;
    get.or_use total_entries[r1] 0u64 into r4;
    add r4 8u64 into r5;
    get.or_use max_entries[r1] 0u64 into r6;
    lte r5 r6 into r7;
    assert.eq r7 true;
    add r4 0u64 into r8;
    cast r1 r8 into r9 as Index;
    hash.psd2 r9 into r10 as field;
    set r0 into entries[r10];
    add r4 1u64 into r11;
    cast r1 r11 into r12 as Index;
    hash.psd2 r12 into r13 as field;
    set r0 into entries[r13];
    add r4 2u64 into r14;
    cast r1 r14 into r15 as Index;
    hash.psd2 r15 into r16 as field;
    set r0 into entries[r16];
    add r4 3u64 into r17;
    cast r1 r17 into r18 as Index;
    hash.psd2 r18 into r19 as field;
    set r0 into entries[r19];
    add r4 4u64 into r20;
    cast r1 r20 into r21 as Index;
    hash.psd2 r21 into r22 as field;
    set r0 into entries[r22];
    add r4 5u64 into r23;
    cast r1 r23 into r24 as Index;
    hash.psd2 r24 into r25 as field;
    set r0 into entries[r25];
    add r4 6u64 into r26;
    cast r1 r26 into r27 as Index;
    hash.psd2 r27 into r28 as field;
    set r0 into entries[r28];
    add r4 7u64 into r29;
    cast r1 r29 into r30 as Index;
    hash.psd2 r30 into r31 as field;
    set r0 into entries[r31];
    add r4 8u64 into r32;
    set r32 into total_entries[r1];
    get.or_use user_entries[r2] 0u16 into r33;
    add r33 8u16 into r34;
    set r34 into user_entries[r2];

function buy_nine_entries:
    input r0 as field.private;
    input r1 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v002.aleo/spend r1 9000000u64 into r2;
    cast r0 r1.owner into r3 as Entrant;
    hash.psd2 r3 into r4 as field;
    async buy_nine_entries r1.owner r0 r4 into r5;
    output r2 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    output r5 as par_giveaways_v1.aleo/buy_nine_entries.future;

finalize buy_nine_entries:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as field.public;
    get.or_use is_open[r1] false into r3;
    assert.eq r3 true;
    get.or_use total_entries[r1] 0u64 into r4;
    add r4 9u64 into r5;
    get.or_use max_entries[r1] 0u64 into r6;
    lte r5 r6 into r7;
    assert.eq r7 true;
    add r4 0u64 into r8;
    cast r1 r8 into r9 as Index;
    hash.psd2 r9 into r10 as field;
    set r0 into entries[r10];
    add r4 1u64 into r11;
    cast r1 r11 into r12 as Index;
    hash.psd2 r12 into r13 as field;
    set r0 into entries[r13];
    add r4 2u64 into r14;
    cast r1 r14 into r15 as Index;
    hash.psd2 r15 into r16 as field;
    set r0 into entries[r16];
    add r4 3u64 into r17;
    cast r1 r17 into r18 as Index;
    hash.psd2 r18 into r19 as field;
    set r0 into entries[r19];
    add r4 4u64 into r20;
    cast r1 r20 into r21 as Index;
    hash.psd2 r21 into r22 as field;
    set r0 into entries[r22];
    add r4 5u64 into r23;
    cast r1 r23 into r24 as Index;
    hash.psd2 r24 into r25 as field;
    set r0 into entries[r25];
    add r4 6u64 into r26;
    cast r1 r26 into r27 as Index;
    hash.psd2 r27 into r28 as field;
    set r0 into entries[r28];
    add r4 7u64 into r29;
    cast r1 r29 into r30 as Index;
    hash.psd2 r30 into r31 as field;
    set r0 into entries[r31];
    add r4 8u64 into r32;
    cast r1 r32 into r33 as Index;
    hash.psd2 r33 into r34 as field;
    set r0 into entries[r34];
    add r4 9u64 into r35;
    set r35 into total_entries[r1];
    get.or_use user_entries[r2] 0u16 into r36;
    add r36 9u16 into r37;
    set r37 into user_entries[r2];

function buy_ten_entries:
    input r0 as field.private;
    input r1 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v002.aleo/spend r1 10000000u64 into r2;
    cast r0 r1.owner into r3 as Entrant;
    hash.psd2 r3 into r4 as field;
    async buy_ten_entries r1.owner r0 r4 into r5;
    output r2 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    output r5 as par_giveaways_v1.aleo/buy_ten_entries.future;

finalize buy_ten_entries:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as field.public;
    get.or_use is_open[r1] false into r3;
    assert.eq r3 true;
    get.or_use total_entries[r1] 0u64 into r4;
    add r4 10u64 into r5;
    get.or_use max_entries[r1] 0u64 into r6;
    lte r5 r6 into r7;
    assert.eq r7 true;
    add r4 0u64 into r8;
    cast r1 r8 into r9 as Index;
    hash.psd2 r9 into r10 as field;
    set r0 into entries[r10];
    add r4 1u64 into r11;
    cast r1 r11 into r12 as Index;
    hash.psd2 r12 into r13 as field;
    set r0 into entries[r13];
    add r4 2u64 into r14;
    cast r1 r14 into r15 as Index;
    hash.psd2 r15 into r16 as field;
    set r0 into entries[r16];
    add r4 3u64 into r17;
    cast r1 r17 into r18 as Index;
    hash.psd2 r18 into r19 as field;
    set r0 into entries[r19];
    add r4 4u64 into r20;
    cast r1 r20 into r21 as Index;
    hash.psd2 r21 into r22 as field;
    set r0 into entries[r22];
    add r4 5u64 into r23;
    cast r1 r23 into r24 as Index;
    hash.psd2 r24 into r25 as field;
    set r0 into entries[r25];
    add r4 6u64 into r26;
    cast r1 r26 into r27 as Index;
    hash.psd2 r27 into r28 as field;
    set r0 into entries[r28];
    add r4 7u64 into r29;
    cast r1 r29 into r30 as Index;
    hash.psd2 r30 into r31 as field;
    set r0 into entries[r31];
    add r4 8u64 into r32;
    cast r1 r32 into r33 as Index;
    hash.psd2 r33 into r34 as field;
    set r0 into entries[r34];
    add r4 9u64 into r35;
    cast r1 r35 into r36 as Index;
    hash.psd2 r36 into r37 as field;
    set r0 into entries[r37];
    add r4 10u64 into r38;
    set r38 into total_entries[r1];
    get.or_use user_entries[r2] 0u16 into r39;
    add r39 10u16 into r40;
    set r40 into user_entries[r2];

import puzzle_arcade_ticket_v001.aleo;
import par_store_inventory_v1.aleo;
program par_giveaways.aleo;

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

function buy_one_entry:
    input r0 as field.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v001.aleo/spend r1 1000000u64 into r2;
    async buy_one_entry r1.owner r0 into r3;
    output r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r3 as par_giveaways.aleo/buy_one_entry.future;

finalize buy_one_entry:
    input r0 as address.public;
    input r1 as field.public;
    get.or_use total_entries[r1] 0u64 into r2;
    add r2 1u64 into r3;
    lt r3 50u64 into r4;
    assert.eq r4 true;
    cast r1 r2 into r5 as Index;
    hash.bhp256 r5 into r6 as field;
    set r0 into entries[r6];
    add r2 1u64 into r7;
    set r7 into total_entries[r1];
    cast r1 r0 into r8 as Entrant;
    hash.bhp256 r8 into r9 as field;
    get.or_use user_entries[r9] 0u16 into r10;
    add r10 1u16 into r11;
    set r11 into user_entries[r9];

function buy_two_entries:
    input r0 as field.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v001.aleo/spend r1 2000000u64 into r2;
    async buy_two_entries r1.owner r0 into r3;
    output r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r3 as par_giveaways.aleo/buy_two_entries.future;

finalize buy_two_entries:
    input r0 as address.public;
    input r1 as field.public;
    get.or_use total_entries[r1] 0u64 into r2;
    add r2 2u64 into r3;
    lt r3 50u64 into r4;
    assert.eq r4 true;
    add r2 0u64 into r5;
    cast r1 r5 into r6 as Index;
    hash.bhp256 r6 into r7 as field;
    set r0 into entries[r7];
    add r2 1u64 into r8;
    cast r1 r8 into r9 as Index;
    hash.bhp256 r9 into r10 as field;
    set r0 into entries[r10];
    add r2 2u64 into r11;
    set r11 into total_entries[r1];
    cast r1 r0 into r12 as Entrant;
    hash.bhp256 r12 into r13 as field;
    get.or_use user_entries[r13] 0u16 into r14;
    add r14 2u16 into r15;
    set r15 into user_entries[r13];

function buy_three_entries:
    input r0 as field.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v001.aleo/spend r1 3000000u64 into r2;
    async buy_three_entries r1.owner r0 into r3;
    output r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r3 as par_giveaways.aleo/buy_three_entries.future;

finalize buy_three_entries:
    input r0 as address.public;
    input r1 as field.public;
    get.or_use total_entries[r1] 0u64 into r2;
    add r2 3u64 into r3;
    lt r3 50u64 into r4;
    assert.eq r4 true;
    add r2 0u64 into r5;
    cast r1 r5 into r6 as Index;
    hash.bhp256 r6 into r7 as field;
    set r0 into entries[r7];
    add r2 1u64 into r8;
    cast r1 r8 into r9 as Index;
    hash.bhp256 r9 into r10 as field;
    set r0 into entries[r10];
    add r2 2u64 into r11;
    cast r1 r11 into r12 as Index;
    hash.bhp256 r12 into r13 as field;
    set r0 into entries[r13];
    add r2 3u64 into r14;
    set r14 into total_entries[r1];
    cast r1 r0 into r15 as Entrant;
    hash.bhp256 r15 into r16 as field;
    get.or_use user_entries[r16] 0u16 into r17;
    add r17 3u16 into r18;
    set r18 into user_entries[r16];

function buy_four_entries:
    input r0 as field.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v001.aleo/spend r1 4000000u64 into r2;
    async buy_four_entries r1.owner r0 into r3;
    output r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r3 as par_giveaways.aleo/buy_four_entries.future;

finalize buy_four_entries:
    input r0 as address.public;
    input r1 as field.public;
    get.or_use total_entries[r1] 0u64 into r2;
    add r2 4u64 into r3;
    lt r3 50u64 into r4;
    assert.eq r4 true;
    add r2 0u64 into r5;
    cast r1 r5 into r6 as Index;
    hash.bhp256 r6 into r7 as field;
    set r0 into entries[r7];
    add r2 1u64 into r8;
    cast r1 r8 into r9 as Index;
    hash.bhp256 r9 into r10 as field;
    set r0 into entries[r10];
    add r2 2u64 into r11;
    cast r1 r11 into r12 as Index;
    hash.bhp256 r12 into r13 as field;
    set r0 into entries[r13];
    add r2 3u64 into r14;
    cast r1 r14 into r15 as Index;
    hash.bhp256 r15 into r16 as field;
    set r0 into entries[r16];
    add r2 4u64 into r17;
    set r17 into total_entries[r1];
    cast r1 r0 into r18 as Entrant;
    hash.bhp256 r18 into r19 as field;
    get.or_use user_entries[r19] 0u16 into r20;
    add r20 4u16 into r21;
    set r21 into user_entries[r19];

function buy_five_entries:
    input r0 as field.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v001.aleo/spend r1 5000000u64 into r2;
    async buy_five_entries r1.owner r0 into r3;
    output r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r3 as par_giveaways.aleo/buy_five_entries.future;

finalize buy_five_entries:
    input r0 as address.public;
    input r1 as field.public;
    get.or_use total_entries[r1] 0u64 into r2;
    add r2 5u64 into r3;
    lt r3 50u64 into r4;
    assert.eq r4 true;
    add r2 0u64 into r5;
    cast r1 r5 into r6 as Index;
    hash.bhp256 r6 into r7 as field;
    set r0 into entries[r7];
    add r2 1u64 into r8;
    cast r1 r8 into r9 as Index;
    hash.bhp256 r9 into r10 as field;
    set r0 into entries[r10];
    add r2 2u64 into r11;
    cast r1 r11 into r12 as Index;
    hash.bhp256 r12 into r13 as field;
    set r0 into entries[r13];
    add r2 3u64 into r14;
    cast r1 r14 into r15 as Index;
    hash.bhp256 r15 into r16 as field;
    set r0 into entries[r16];
    add r2 4u64 into r17;
    cast r1 r17 into r18 as Index;
    hash.bhp256 r18 into r19 as field;
    set r0 into entries[r19];
    add r2 5u64 into r20;
    set r20 into total_entries[r1];
    cast r1 r0 into r21 as Entrant;
    hash.bhp256 r21 into r22 as field;
    get.or_use user_entries[r22] 0u16 into r23;
    add r23 5u16 into r24;
    set r24 into user_entries[r22];

function buy_six_entries:
    input r0 as field.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v001.aleo/spend r1 6000000u64 into r2;
    async buy_six_entries r1.owner r0 into r3;
    output r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r3 as par_giveaways.aleo/buy_six_entries.future;

finalize buy_six_entries:
    input r0 as address.public;
    input r1 as field.public;
    get.or_use total_entries[r1] 0u64 into r2;
    add r2 6u64 into r3;
    lt r3 50u64 into r4;
    assert.eq r4 true;
    add r2 0u64 into r5;
    cast r1 r5 into r6 as Index;
    hash.bhp256 r6 into r7 as field;
    set r0 into entries[r7];
    add r2 1u64 into r8;
    cast r1 r8 into r9 as Index;
    hash.bhp256 r9 into r10 as field;
    set r0 into entries[r10];
    add r2 2u64 into r11;
    cast r1 r11 into r12 as Index;
    hash.bhp256 r12 into r13 as field;
    set r0 into entries[r13];
    add r2 3u64 into r14;
    cast r1 r14 into r15 as Index;
    hash.bhp256 r15 into r16 as field;
    set r0 into entries[r16];
    add r2 4u64 into r17;
    cast r1 r17 into r18 as Index;
    hash.bhp256 r18 into r19 as field;
    set r0 into entries[r19];
    add r2 5u64 into r20;
    cast r1 r20 into r21 as Index;
    hash.bhp256 r21 into r22 as field;
    set r0 into entries[r22];
    add r2 6u64 into r23;
    set r23 into total_entries[r1];
    cast r1 r0 into r24 as Entrant;
    hash.bhp256 r24 into r25 as field;
    get.or_use user_entries[r25] 0u16 into r26;
    add r26 6u16 into r27;
    set r27 into user_entries[r25];

function buy_seven_entries:
    input r0 as field.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v001.aleo/spend r1 7000000u64 into r2;
    async buy_seven_entries r1.owner r0 into r3;
    output r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r3 as par_giveaways.aleo/buy_seven_entries.future;

finalize buy_seven_entries:
    input r0 as address.public;
    input r1 as field.public;
    get.or_use total_entries[r1] 0u64 into r2;
    add r2 7u64 into r3;
    lt r3 50u64 into r4;
    assert.eq r4 true;
    add r2 0u64 into r5;
    cast r1 r5 into r6 as Index;
    hash.bhp256 r6 into r7 as field;
    set r0 into entries[r7];
    add r2 1u64 into r8;
    cast r1 r8 into r9 as Index;
    hash.bhp256 r9 into r10 as field;
    set r0 into entries[r10];
    add r2 2u64 into r11;
    cast r1 r11 into r12 as Index;
    hash.bhp256 r12 into r13 as field;
    set r0 into entries[r13];
    add r2 3u64 into r14;
    cast r1 r14 into r15 as Index;
    hash.bhp256 r15 into r16 as field;
    set r0 into entries[r16];
    add r2 4u64 into r17;
    cast r1 r17 into r18 as Index;
    hash.bhp256 r18 into r19 as field;
    set r0 into entries[r19];
    add r2 5u64 into r20;
    cast r1 r20 into r21 as Index;
    hash.bhp256 r21 into r22 as field;
    set r0 into entries[r22];
    add r2 6u64 into r23;
    cast r1 r23 into r24 as Index;
    hash.bhp256 r24 into r25 as field;
    set r0 into entries[r25];
    add r2 7u64 into r26;
    set r26 into total_entries[r1];
    cast r1 r0 into r27 as Entrant;
    hash.bhp256 r27 into r28 as field;
    get.or_use user_entries[r28] 0u16 into r29;
    add r29 7u16 into r30;
    set r30 into user_entries[r28];

function buy_eight_entries:
    input r0 as field.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v001.aleo/spend r1 8000000u64 into r2;
    async buy_eight_entries r1.owner r0 into r3;
    output r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r3 as par_giveaways.aleo/buy_eight_entries.future;

finalize buy_eight_entries:
    input r0 as address.public;
    input r1 as field.public;
    get.or_use total_entries[r1] 0u64 into r2;
    add r2 8u64 into r3;
    lt r3 50u64 into r4;
    assert.eq r4 true;
    add r2 0u64 into r5;
    cast r1 r5 into r6 as Index;
    hash.bhp256 r6 into r7 as field;
    set r0 into entries[r7];
    add r2 1u64 into r8;
    cast r1 r8 into r9 as Index;
    hash.bhp256 r9 into r10 as field;
    set r0 into entries[r10];
    add r2 2u64 into r11;
    cast r1 r11 into r12 as Index;
    hash.bhp256 r12 into r13 as field;
    set r0 into entries[r13];
    add r2 3u64 into r14;
    cast r1 r14 into r15 as Index;
    hash.bhp256 r15 into r16 as field;
    set r0 into entries[r16];
    add r2 4u64 into r17;
    cast r1 r17 into r18 as Index;
    hash.bhp256 r18 into r19 as field;
    set r0 into entries[r19];
    add r2 5u64 into r20;
    cast r1 r20 into r21 as Index;
    hash.bhp256 r21 into r22 as field;
    set r0 into entries[r22];
    add r2 6u64 into r23;
    cast r1 r23 into r24 as Index;
    hash.bhp256 r24 into r25 as field;
    set r0 into entries[r25];
    add r2 7u64 into r26;
    cast r1 r26 into r27 as Index;
    hash.bhp256 r27 into r28 as field;
    set r0 into entries[r28];
    add r2 8u64 into r29;
    set r29 into total_entries[r1];
    cast r1 r0 into r30 as Entrant;
    hash.bhp256 r30 into r31 as field;
    get.or_use user_entries[r31] 0u16 into r32;
    add r32 8u16 into r33;
    set r33 into user_entries[r31];

function buy_nine_entries:
    input r0 as field.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v001.aleo/spend r1 9000000u64 into r2;
    async buy_nine_entries r1.owner r0 into r3;
    output r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r3 as par_giveaways.aleo/buy_nine_entries.future;

finalize buy_nine_entries:
    input r0 as address.public;
    input r1 as field.public;
    get.or_use total_entries[r1] 0u64 into r2;
    add r2 9u64 into r3;
    lt r3 50u64 into r4;
    assert.eq r4 true;
    add r2 0u64 into r5;
    cast r1 r5 into r6 as Index;
    hash.bhp256 r6 into r7 as field;
    set r0 into entries[r7];
    add r2 1u64 into r8;
    cast r1 r8 into r9 as Index;
    hash.bhp256 r9 into r10 as field;
    set r0 into entries[r10];
    add r2 2u64 into r11;
    cast r1 r11 into r12 as Index;
    hash.bhp256 r12 into r13 as field;
    set r0 into entries[r13];
    add r2 3u64 into r14;
    cast r1 r14 into r15 as Index;
    hash.bhp256 r15 into r16 as field;
    set r0 into entries[r16];
    add r2 4u64 into r17;
    cast r1 r17 into r18 as Index;
    hash.bhp256 r18 into r19 as field;
    set r0 into entries[r19];
    add r2 5u64 into r20;
    cast r1 r20 into r21 as Index;
    hash.bhp256 r21 into r22 as field;
    set r0 into entries[r22];
    add r2 6u64 into r23;
    cast r1 r23 into r24 as Index;
    hash.bhp256 r24 into r25 as field;
    set r0 into entries[r25];
    add r2 7u64 into r26;
    cast r1 r26 into r27 as Index;
    hash.bhp256 r27 into r28 as field;
    set r0 into entries[r28];
    add r2 8u64 into r29;
    cast r1 r29 into r30 as Index;
    hash.bhp256 r30 into r31 as field;
    set r0 into entries[r31];
    add r2 9u64 into r32;
    set r32 into total_entries[r1];
    cast r1 r0 into r33 as Entrant;
    hash.bhp256 r33 into r34 as field;
    get.or_use user_entries[r34] 0u16 into r35;
    add r35 9u16 into r36;
    set r36 into user_entries[r34];

function buy_ten_entries:
    input r0 as field.private;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v001.aleo/spend r1 10000000u64 into r2;
    async buy_ten_entries r1.owner r0 into r3;
    output r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r3 as par_giveaways.aleo/buy_ten_entries.future;

finalize buy_ten_entries:
    input r0 as address.public;
    input r1 as field.public;
    get.or_use total_entries[r1] 0u64 into r2;
    add r2 10u64 into r3;
    lt r3 50u64 into r4;
    assert.eq r4 true;
    add r2 0u64 into r5;
    cast r1 r5 into r6 as Index;
    hash.bhp256 r6 into r7 as field;
    set r0 into entries[r7];
    add r2 1u64 into r8;
    cast r1 r8 into r9 as Index;
    hash.bhp256 r9 into r10 as field;
    set r0 into entries[r10];
    add r2 2u64 into r11;
    cast r1 r11 into r12 as Index;
    hash.bhp256 r12 into r13 as field;
    set r0 into entries[r13];
    add r2 3u64 into r14;
    cast r1 r14 into r15 as Index;
    hash.bhp256 r15 into r16 as field;
    set r0 into entries[r16];
    add r2 4u64 into r17;
    cast r1 r17 into r18 as Index;
    hash.bhp256 r18 into r19 as field;
    set r0 into entries[r19];
    add r2 5u64 into r20;
    cast r1 r20 into r21 as Index;
    hash.bhp256 r21 into r22 as field;
    set r0 into entries[r22];
    add r2 6u64 into r23;
    cast r1 r23 into r24 as Index;
    hash.bhp256 r24 into r25 as field;
    set r0 into entries[r25];
    add r2 7u64 into r26;
    cast r1 r26 into r27 as Index;
    hash.bhp256 r27 into r28 as field;
    set r0 into entries[r28];
    add r2 8u64 into r29;
    cast r1 r29 into r30 as Index;
    hash.bhp256 r30 into r31 as field;
    set r0 into entries[r31];
    add r2 9u64 into r32;
    cast r1 r32 into r33 as Index;
    hash.bhp256 r33 into r34 as field;
    set r0 into entries[r34];
    add r2 10u64 into r35;
    set r35 into total_entries[r1];
    cast r1 r0 into r36 as Entrant;
    hash.bhp256 r36 into r37 as field;
    get.or_use user_entries[r37] 0u16 into r38;
    add r38 10u16 into r39;
    set r39 into user_entries[r37];

function draw_winner:
    input r0 as field.private;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo196a39wq9q8ea779cmlmff0c9pj2gl4f5e8fhjpvmufe5utuq7y8snz4h2l;
    async draw_winner r0 into r1;
    output r1 as par_giveaways.aleo/draw_winner.future;

finalize draw_winner:
    input r0 as field.public;
    get total_entries[r0] into r1;
    rand.chacha into r2 as u64;
    rem r2 r1 into r3;
    cast r0 r3 into r4 as Index;
    hash.bhp256 r4 into r5 as field;
    get entries[r5] into r6;
    cast r0 r6 into r7 as Entrant;
    hash.bhp256 r7 into r8 as field;
    get.or_use has_won[r8] false into r9;
    assert.eq r9 false;
    get.or_use total_winners[r0] 0u64 into r10;
    hash.bhp256 r7 into r11 as field;
    set true into has_won[r11];
    add r10 1u64 into r12;
    set r12 into total_winners[r0];
    cast r0 r10 into r13 as Index;
    hash.bhp256 r13 into r14 as field;
    set r6 into winners[r14];

function send_prize_to_winner:
    input r0 as address.public;
    input r1 as par_store_inventory_v1.aleo/Product.record;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo196a39wq9q8ea779cmlmff0c9pj2gl4f5e8fhjpvmufe5utuq7y8snz4h2l;
    call par_store_inventory_v1.aleo/fulfill r0 r1 into r2;
    output r2 as par_store_inventory_v1.aleo/Product.record;

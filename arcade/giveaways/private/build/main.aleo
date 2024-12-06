import puzzle_arcade_ticket_testing.aleo;
program giveaway_private.aleo;

struct Item:
    pt1 as u128;
    pt2 as u128;
    pt3 as u128;
    pt4 as u128;
    pt5 as u128;

record Prize:
    owner as address.private;
    item as Item.private;

mapping entries:
    key as u64.public;
    value as address.public;

mapping user_entries:
    key as address.public;
    value as u16.public;

mapping total_entries:
    key as u64.public;
    value as u64.public;

mapping winner:
    key as u64.public;
    value as address.public;

mapping has_won:
    key as address.public;
    value as boolean.public;

mapping winner_count:
    key as u64.public;
    value as u64.public;

function mint_prize:
    input r0 as u128.private;
    input r1 as u128.private;
    input r2 as u128.private;
    input r3 as u128.private;
    input r4 as u128.private;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo196a39wq9q8ea779cmlmff0c9pj2gl4f5e8fhjpvmufe5utuq7y8snz4h2l;
    cast r0 r1 r2 r3 r4 into r5 as Item;
    cast aleo196a39wq9q8ea779cmlmff0c9pj2gl4f5e8fhjpvmufe5utuq7y8snz4h2l r5 into r6 as Prize.record;
    output r6 as Prize.record;

function buy_one_entry:
    input r0 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_testing.aleo/spend r0 1000000u64 into r1;
    async buy_one_entry r0.owner into r2;
    output r1 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    output r2 as giveaway_private.aleo/buy_one_entry.future;

finalize buy_one_entry:
    input r0 as address.public;
    get.or_use total_entries[0u64] 0u64 into r1;
    set r0 into entries[r1];
    add r1 1u64 into r2;
    set r2 into total_entries[0u64];
    get.or_use user_entries[r0] 0u16 into r3;
    add r3 1u16 into r4;
    set r4 into user_entries[r0];

function buy_two_entries:
    input r0 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_testing.aleo/spend r0 2000000u64 into r1;
    async buy_two_entries r0.owner into r2;
    output r1 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    output r2 as giveaway_private.aleo/buy_two_entries.future;

finalize buy_two_entries:
    input r0 as address.public;
    get.or_use total_entries[0u64] 0u64 into r1;
    add r1 0u64 into r2;
    set r0 into entries[r2];
    add r1 1u64 into r3;
    set r0 into entries[r3];
    add r1 2u64 into r4;
    set r4 into total_entries[0u64];
    get.or_use user_entries[r0] 0u16 into r5;
    add r5 2u16 into r6;
    set r6 into user_entries[r0];

function buy_three_entries:
    input r0 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_testing.aleo/spend r0 3000000u64 into r1;
    async buy_three_entries r0.owner into r2;
    output r1 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    output r2 as giveaway_private.aleo/buy_three_entries.future;

finalize buy_three_entries:
    input r0 as address.public;
    get.or_use total_entries[0u64] 0u64 into r1;
    add r1 0u64 into r2;
    set r0 into entries[r2];
    add r1 1u64 into r3;
    set r0 into entries[r3];
    add r1 2u64 into r4;
    set r0 into entries[r4];
    add r1 3u64 into r5;
    set r5 into total_entries[0u64];
    get.or_use user_entries[r0] 0u16 into r6;
    add r6 3u16 into r7;
    set r7 into user_entries[r0];

function buy_four_entries:
    input r0 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_testing.aleo/spend r0 4000000u64 into r1;
    async buy_four_entries r0.owner into r2;
    output r1 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    output r2 as giveaway_private.aleo/buy_four_entries.future;

finalize buy_four_entries:
    input r0 as address.public;
    get.or_use total_entries[0u64] 0u64 into r1;
    add r1 0u64 into r2;
    set r0 into entries[r2];
    add r1 1u64 into r3;
    set r0 into entries[r3];
    add r1 2u64 into r4;
    set r0 into entries[r4];
    add r1 3u64 into r5;
    set r0 into entries[r5];
    add r1 4u64 into r6;
    set r6 into total_entries[0u64];
    get.or_use user_entries[r0] 0u16 into r7;
    add r7 4u16 into r8;
    set r8 into user_entries[r0];

function buy_five_entries:
    input r0 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_testing.aleo/spend r0 5000000u64 into r1;
    async buy_five_entries r0.owner into r2;
    output r1 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    output r2 as giveaway_private.aleo/buy_five_entries.future;

finalize buy_five_entries:
    input r0 as address.public;
    get.or_use total_entries[0u64] 0u64 into r1;
    add r1 0u64 into r2;
    set r0 into entries[r2];
    add r1 1u64 into r3;
    set r0 into entries[r3];
    add r1 2u64 into r4;
    set r0 into entries[r4];
    add r1 3u64 into r5;
    set r0 into entries[r5];
    add r1 4u64 into r6;
    set r0 into entries[r6];
    add r1 5u64 into r7;
    set r7 into total_entries[0u64];
    get.or_use user_entries[r0] 0u16 into r8;
    add r8 5u16 into r9;
    set r9 into user_entries[r0];

function buy_six_entries:
    input r0 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_testing.aleo/spend r0 6000000u64 into r1;
    async buy_six_entries r0.owner into r2;
    output r1 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    output r2 as giveaway_private.aleo/buy_six_entries.future;

finalize buy_six_entries:
    input r0 as address.public;
    get.or_use total_entries[0u64] 0u64 into r1;
    add r1 0u64 into r2;
    set r0 into entries[r2];
    add r1 1u64 into r3;
    set r0 into entries[r3];
    add r1 2u64 into r4;
    set r0 into entries[r4];
    add r1 3u64 into r5;
    set r0 into entries[r5];
    add r1 4u64 into r6;
    set r0 into entries[r6];
    add r1 5u64 into r7;
    set r0 into entries[r7];
    add r1 6u64 into r8;
    set r8 into total_entries[0u64];
    get.or_use user_entries[r0] 0u16 into r9;
    add r9 6u16 into r10;
    set r10 into user_entries[r0];

function buy_seven_entries:
    input r0 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_testing.aleo/spend r0 7000000u64 into r1;
    async buy_seven_entries r0.owner into r2;
    output r1 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    output r2 as giveaway_private.aleo/buy_seven_entries.future;

finalize buy_seven_entries:
    input r0 as address.public;
    get.or_use total_entries[0u64] 0u64 into r1;
    add r1 0u64 into r2;
    set r0 into entries[r2];
    add r1 1u64 into r3;
    set r0 into entries[r3];
    add r1 2u64 into r4;
    set r0 into entries[r4];
    add r1 3u64 into r5;
    set r0 into entries[r5];
    add r1 4u64 into r6;
    set r0 into entries[r6];
    add r1 5u64 into r7;
    set r0 into entries[r7];
    add r1 6u64 into r8;
    set r0 into entries[r8];
    add r1 7u64 into r9;
    set r9 into total_entries[0u64];
    get.or_use user_entries[r0] 0u16 into r10;
    add r10 7u16 into r11;
    set r11 into user_entries[r0];

function buy_eight_entries:
    input r0 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_testing.aleo/spend r0 8000000u64 into r1;
    async buy_eight_entries r0.owner into r2;
    output r1 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    output r2 as giveaway_private.aleo/buy_eight_entries.future;

finalize buy_eight_entries:
    input r0 as address.public;
    get.or_use total_entries[0u64] 0u64 into r1;
    add r1 0u64 into r2;
    set r0 into entries[r2];
    add r1 1u64 into r3;
    set r0 into entries[r3];
    add r1 2u64 into r4;
    set r0 into entries[r4];
    add r1 3u64 into r5;
    set r0 into entries[r5];
    add r1 4u64 into r6;
    set r0 into entries[r6];
    add r1 5u64 into r7;
    set r0 into entries[r7];
    add r1 6u64 into r8;
    set r0 into entries[r8];
    add r1 7u64 into r9;
    set r0 into entries[r9];
    add r1 8u64 into r10;
    set r10 into total_entries[0u64];
    get.or_use user_entries[r0] 0u16 into r11;
    add r11 8u16 into r12;
    set r12 into user_entries[r0];

function buy_nine_entries:
    input r0 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_testing.aleo/spend r0 9000000u64 into r1;
    async buy_nine_entries r0.owner into r2;
    output r1 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    output r2 as giveaway_private.aleo/buy_nine_entries.future;

finalize buy_nine_entries:
    input r0 as address.public;
    get.or_use total_entries[0u64] 0u64 into r1;
    add r1 0u64 into r2;
    set r0 into entries[r2];
    add r1 1u64 into r3;
    set r0 into entries[r3];
    add r1 2u64 into r4;
    set r0 into entries[r4];
    add r1 3u64 into r5;
    set r0 into entries[r5];
    add r1 4u64 into r6;
    set r0 into entries[r6];
    add r1 5u64 into r7;
    set r0 into entries[r7];
    add r1 6u64 into r8;
    set r0 into entries[r8];
    add r1 7u64 into r9;
    set r0 into entries[r9];
    add r1 8u64 into r10;
    set r0 into entries[r10];
    add r1 9u64 into r11;
    set r11 into total_entries[0u64];
    get.or_use user_entries[r0] 0u16 into r12;
    add r12 9u16 into r13;
    set r13 into user_entries[r0];

function buy_ten_entries:
    input r0 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_testing.aleo/spend r0 10000000u64 into r1;
    async buy_ten_entries r0.owner into r2;
    output r1 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    output r2 as giveaway_private.aleo/buy_ten_entries.future;

finalize buy_ten_entries:
    input r0 as address.public;
    get.or_use total_entries[0u64] 0u64 into r1;
    add r1 0u64 into r2;
    set r0 into entries[r2];
    add r1 1u64 into r3;
    set r0 into entries[r3];
    add r1 2u64 into r4;
    set r0 into entries[r4];
    add r1 3u64 into r5;
    set r0 into entries[r5];
    add r1 4u64 into r6;
    set r0 into entries[r6];
    add r1 5u64 into r7;
    set r0 into entries[r7];
    add r1 6u64 into r8;
    set r0 into entries[r8];
    add r1 7u64 into r9;
    set r0 into entries[r9];
    add r1 8u64 into r10;
    set r0 into entries[r10];
    add r1 9u64 into r11;
    set r0 into entries[r11];
    add r1 10u64 into r12;
    set r12 into total_entries[0u64];
    get.or_use user_entries[r0] 0u16 into r13;
    add r13 10u16 into r14;
    set r14 into user_entries[r0];

function draw_winner:
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo196a39wq9q8ea779cmlmff0c9pj2gl4f5e8fhjpvmufe5utuq7y8snz4h2l;
    async draw_winner into r0;
    output r0 as giveaway_private.aleo/draw_winner.future;

finalize draw_winner:
    get total_entries[0u64] into r0;
    rand.chacha into r1 as u64;
    rem r1 r0 into r2;
    get entries[r2] into r3;
    get.or_use has_won[r3] false into r4;
    assert.eq r4 false;
    get.or_use winner_count[0u64] 0u64 into r5;
    set true into has_won[r3];
    add r5 1u64 into r6;
    set r6 into winner_count[0u64];
    set r3 into winner[r5];

function send_prize_to_winner:
    input r0 as address.public;
    input r1 as Prize.record;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo196a39wq9q8ea779cmlmff0c9pj2gl4f5e8fhjpvmufe5utuq7y8snz4h2l;
    cast r0 r1.item into r2 as Prize.record;
    output r2 as Prize.record;

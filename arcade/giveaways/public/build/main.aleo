import puzzle_arcade_ticket_testing.aleo;
import credits.aleo;
program puzzle_raffle_testing2.aleo;

mapping entries:
    key as u16.public;
    value as address.public;

mapping user_entries:
    key as address.public;
    value as u16.public;

mapping total_entries:
    key as u16.public;
    value as u16.public;

mapping winner:
    key as u16.public;
    value as address.public;

mapping has_won:
    key as address.public;
    value as boolean.public;

mapping has_claimed:
    key as address.public;
    value as boolean.public;

mapping winner_count:
    key as u16.public;
    value as u16.public;

function fund:
    input r0 as u64.private;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1pkuty394j0000uedtqpazp4qejwmn2yshaac6qjr6wll25m9a5psuggt6d;
    call credits.aleo/transfer_public_as_signer puzzle_raffle_testing2.aleo r0 into r1;
    async fund r1 into r2;
    output r2 as puzzle_raffle_testing2.aleo/fund.future;

finalize fund:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    await r0;

function buy_one_entry:
    input r0 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_testing.aleo/spend r0 1000000u64 into r1;
    async buy_one_entry r0.owner into r2;
    output r1 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    output r2 as puzzle_raffle_testing2.aleo/buy_one_entry.future;

finalize buy_one_entry:
    input r0 as address.public;
    get.or_use total_entries[0u16] 0u16 into r1;
    set r0 into entries[r1];
    add r1 1u16 into r2;
    set r2 into total_entries[0u16];
    get.or_use user_entries[r0] 0u16 into r3;
    add r3 1u16 into r4;
    set r4 into user_entries[r0];

function buy_two_entries:
    input r0 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_testing.aleo/spend r0 2000000u64 into r1;
    async buy_two_entries r0.owner into r2;
    output r1 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    output r2 as puzzle_raffle_testing2.aleo/buy_two_entries.future;

finalize buy_two_entries:
    input r0 as address.public;
    get.or_use total_entries[0u16] 0u16 into r1;
    add r1 0u16 into r2;
    set r0 into entries[r2];
    add r1 1u16 into r3;
    set r0 into entries[r3];
    add r1 2u16 into r4;
    set r4 into total_entries[0u16];
    get.or_use user_entries[r0] 0u16 into r5;
    add r5 2u16 into r6;
    set r6 into user_entries[r0];

function buy_three_entries:
    input r0 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_testing.aleo/spend r0 3000000u64 into r1;
    async buy_three_entries r0.owner into r2;
    output r1 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    output r2 as puzzle_raffle_testing2.aleo/buy_three_entries.future;

finalize buy_three_entries:
    input r0 as address.public;
    get.or_use total_entries[0u16] 0u16 into r1;
    add r1 0u16 into r2;
    set r0 into entries[r2];
    add r1 1u16 into r3;
    set r0 into entries[r3];
    add r1 2u16 into r4;
    set r0 into entries[r4];
    add r1 3u16 into r5;
    set r5 into total_entries[0u16];
    get.or_use user_entries[r0] 0u16 into r6;
    add r6 3u16 into r7;
    set r7 into user_entries[r0];

function buy_four_entries:
    input r0 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_testing.aleo/spend r0 4000000u64 into r1;
    async buy_four_entries r0.owner into r2;
    output r1 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    output r2 as puzzle_raffle_testing2.aleo/buy_four_entries.future;

finalize buy_four_entries:
    input r0 as address.public;
    get.or_use total_entries[0u16] 0u16 into r1;
    add r1 0u16 into r2;
    set r0 into entries[r2];
    add r1 1u16 into r3;
    set r0 into entries[r3];
    add r1 2u16 into r4;
    set r0 into entries[r4];
    add r1 3u16 into r5;
    set r0 into entries[r5];
    add r1 4u16 into r6;
    set r6 into total_entries[0u16];
    get.or_use user_entries[r0] 0u16 into r7;
    add r7 4u16 into r8;
    set r8 into user_entries[r0];

function buy_five_entries:
    input r0 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_testing.aleo/spend r0 5000000u64 into r1;
    async buy_five_entries r0.owner into r2;
    output r1 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    output r2 as puzzle_raffle_testing2.aleo/buy_five_entries.future;

finalize buy_five_entries:
    input r0 as address.public;
    get.or_use total_entries[0u16] 0u16 into r1;
    add r1 0u16 into r2;
    set r0 into entries[r2];
    add r1 1u16 into r3;
    set r0 into entries[r3];
    add r1 2u16 into r4;
    set r0 into entries[r4];
    add r1 3u16 into r5;
    set r0 into entries[r5];
    add r1 4u16 into r6;
    set r0 into entries[r6];
    add r1 5u16 into r7;
    set r7 into total_entries[0u16];
    get.or_use user_entries[r0] 0u16 into r8;
    add r8 5u16 into r9;
    set r9 into user_entries[r0];

function buy_six_entries:
    input r0 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_testing.aleo/spend r0 6000000u64 into r1;
    async buy_six_entries r0.owner into r2;
    output r1 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    output r2 as puzzle_raffle_testing2.aleo/buy_six_entries.future;

finalize buy_six_entries:
    input r0 as address.public;
    get.or_use total_entries[0u16] 0u16 into r1;
    add r1 0u16 into r2;
    set r0 into entries[r2];
    add r1 1u16 into r3;
    set r0 into entries[r3];
    add r1 2u16 into r4;
    set r0 into entries[r4];
    add r1 3u16 into r5;
    set r0 into entries[r5];
    add r1 4u16 into r6;
    set r0 into entries[r6];
    add r1 5u16 into r7;
    set r0 into entries[r7];
    add r1 6u16 into r8;
    set r8 into total_entries[0u16];
    get.or_use user_entries[r0] 0u16 into r9;
    add r9 6u16 into r10;
    set r10 into user_entries[r0];

function buy_seven_entries:
    input r0 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_testing.aleo/spend r0 7000000u64 into r1;
    async buy_seven_entries r0.owner into r2;
    output r1 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    output r2 as puzzle_raffle_testing2.aleo/buy_seven_entries.future;

finalize buy_seven_entries:
    input r0 as address.public;
    get.or_use total_entries[0u16] 0u16 into r1;
    add r1 0u16 into r2;
    set r0 into entries[r2];
    add r1 1u16 into r3;
    set r0 into entries[r3];
    add r1 2u16 into r4;
    set r0 into entries[r4];
    add r1 3u16 into r5;
    set r0 into entries[r5];
    add r1 4u16 into r6;
    set r0 into entries[r6];
    add r1 5u16 into r7;
    set r0 into entries[r7];
    add r1 6u16 into r8;
    set r0 into entries[r8];
    add r1 7u16 into r9;
    set r9 into total_entries[0u16];
    get.or_use user_entries[r0] 0u16 into r10;
    add r10 7u16 into r11;
    set r11 into user_entries[r0];

function buy_eight_entries:
    input r0 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_testing.aleo/spend r0 8000000u64 into r1;
    async buy_eight_entries r0.owner into r2;
    output r1 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    output r2 as puzzle_raffle_testing2.aleo/buy_eight_entries.future;

finalize buy_eight_entries:
    input r0 as address.public;
    get.or_use total_entries[0u16] 0u16 into r1;
    add r1 0u16 into r2;
    set r0 into entries[r2];
    add r1 1u16 into r3;
    set r0 into entries[r3];
    add r1 2u16 into r4;
    set r0 into entries[r4];
    add r1 3u16 into r5;
    set r0 into entries[r5];
    add r1 4u16 into r6;
    set r0 into entries[r6];
    add r1 5u16 into r7;
    set r0 into entries[r7];
    add r1 6u16 into r8;
    set r0 into entries[r8];
    add r1 7u16 into r9;
    set r0 into entries[r9];
    add r1 8u16 into r10;
    set r10 into total_entries[0u16];
    get.or_use user_entries[r0] 0u16 into r11;
    add r11 8u16 into r12;
    set r12 into user_entries[r0];

function buy_nine_entries:
    input r0 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_testing.aleo/spend r0 9000000u64 into r1;
    async buy_nine_entries r0.owner into r2;
    output r1 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    output r2 as puzzle_raffle_testing2.aleo/buy_nine_entries.future;

finalize buy_nine_entries:
    input r0 as address.public;
    get.or_use total_entries[0u16] 0u16 into r1;
    add r1 0u16 into r2;
    set r0 into entries[r2];
    add r1 1u16 into r3;
    set r0 into entries[r3];
    add r1 2u16 into r4;
    set r0 into entries[r4];
    add r1 3u16 into r5;
    set r0 into entries[r5];
    add r1 4u16 into r6;
    set r0 into entries[r6];
    add r1 5u16 into r7;
    set r0 into entries[r7];
    add r1 6u16 into r8;
    set r0 into entries[r8];
    add r1 7u16 into r9;
    set r0 into entries[r9];
    add r1 8u16 into r10;
    set r0 into entries[r10];
    add r1 9u16 into r11;
    set r11 into total_entries[0u16];
    get.or_use user_entries[r0] 0u16 into r12;
    add r12 9u16 into r13;
    set r13 into user_entries[r0];

function buy_ten_entries:
    input r0 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_testing.aleo/spend r0 10000000u64 into r1;
    async buy_ten_entries r0.owner into r2;
    output r1 as puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket.record;
    output r2 as puzzle_raffle_testing2.aleo/buy_ten_entries.future;

finalize buy_ten_entries:
    input r0 as address.public;
    get.or_use total_entries[0u16] 0u16 into r1;
    add r1 0u16 into r2;
    set r0 into entries[r2];
    add r1 1u16 into r3;
    set r0 into entries[r3];
    add r1 2u16 into r4;
    set r0 into entries[r4];
    add r1 3u16 into r5;
    set r0 into entries[r5];
    add r1 4u16 into r6;
    set r0 into entries[r6];
    add r1 5u16 into r7;
    set r0 into entries[r7];
    add r1 6u16 into r8;
    set r0 into entries[r8];
    add r1 7u16 into r9;
    set r0 into entries[r9];
    add r1 8u16 into r10;
    set r0 into entries[r10];
    add r1 9u16 into r11;
    set r0 into entries[r11];
    add r1 10u16 into r12;
    set r12 into total_entries[0u16];
    get.or_use user_entries[r0] 0u16 into r13;
    add r13 10u16 into r14;
    set r14 into user_entries[r0];

function draw_winner:
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1pkuty394j0000uedtqpazp4qejwmn2yshaac6qjr6wll25m9a5psuggt6d;
    async draw_winner into r0;
    output r0 as puzzle_raffle_testing2.aleo/draw_winner.future;

finalize draw_winner:
    get total_entries[0u16] into r0;
    rand.chacha into r1 as u64;
    cast r1 into r2 as u16;
    rem r2 r0 into r3;
    get entries[r3] into r4;
    get.or_use has_won[r4] false into r5;
    assert.eq r5 false;
    get.or_use winner_count[0u16] 0u16 into r6;
    set true into has_won[r4];
    add r6 1u16 into r7;
    set r7 into winner_count[0u16];
    set r4 into winner[r6];

function send_prize_to_winner:
    input r0 as address.private;
    call credits.aleo/transfer_public r0 1000000u64 into r1;
    async send_prize_to_winner r1 r0 into r2;
    output r2 as puzzle_raffle_testing2.aleo/send_prize_to_winner.future;

finalize send_prize_to_winner:
    input r0 as credits.aleo/transfer_public.future;
    input r1 as address.public;
    await r0;
    get.or_use has_claimed[r1] false into r2;
    assert.eq r2 false;
    set true into has_claimed[r1];
    get.or_use has_won[r1] false into r3;
    assert.eq r3 true;

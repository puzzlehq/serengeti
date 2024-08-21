import puzzle_arcade_ticket_v001.aleo;
program puzzle_raffle_082124.aleo;


struct PrivateKey:
    pk_pt1 as u128;
    pk_pt2 as u128;

record Prize:
    owner as address.private;
    private_key as PrivateKey.private;

record AuditPrize:
    owner as address.private;
    minter as address.private;
    private_key as PrivateKey.private;


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
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw;
    cast r0 r1 into r2 as PrivateKey;
    cast aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw r2 into r3 as Prize.record;
    cast r0 r1 into r4 as PrivateKey;
    cast aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw r4 into r5 as AuditPrize.record;
    output r3 as Prize.record;
    output r5 as AuditPrize.record;



function buy_one_entry:
    input r0 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v001.aleo/spend r0 1000000u64 into r1;
    async buy_one_entry r0.owner into r2;
    output r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r2 as puzzle_raffle_082124.aleo/buy_one_entry.future;

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
    input r0 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v001.aleo/spend r0 2000000u64 into r1;
    async buy_two_entries r0.owner into r2;
    output r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r2 as puzzle_raffle_082124.aleo/buy_two_entries.future;

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
    input r0 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v001.aleo/spend r0 3000000u64 into r1;
    async buy_three_entries r0.owner into r2;
    output r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r2 as puzzle_raffle_082124.aleo/buy_three_entries.future;

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
    input r0 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v001.aleo/spend r0 4000000u64 into r1;
    async buy_four_entries r0.owner into r2;
    output r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r2 as puzzle_raffle_082124.aleo/buy_four_entries.future;

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
    input r0 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v001.aleo/spend r0 5000000u64 into r1;
    async buy_five_entries r0.owner into r2;
    output r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r2 as puzzle_raffle_082124.aleo/buy_five_entries.future;

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
    input r0 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v001.aleo/spend r0 6000000u64 into r1;
    async buy_six_entries r0.owner into r2;
    output r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r2 as puzzle_raffle_082124.aleo/buy_six_entries.future;

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
    input r0 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v001.aleo/spend r0 7000000u64 into r1;
    async buy_seven_entries r0.owner into r2;
    output r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r2 as puzzle_raffle_082124.aleo/buy_seven_entries.future;

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
    input r0 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v001.aleo/spend r0 8000000u64 into r1;
    async buy_eight_entries r0.owner into r2;
    output r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r2 as puzzle_raffle_082124.aleo/buy_eight_entries.future;

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
    input r0 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v001.aleo/spend r0 9000000u64 into r1;
    async buy_nine_entries r0.owner into r2;
    output r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r2 as puzzle_raffle_082124.aleo/buy_nine_entries.future;

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
    input r0 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v001.aleo/spend r0 10000000u64 into r1;
    async buy_ten_entries r0.owner into r2;
    output r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r2 as puzzle_raffle_082124.aleo/buy_ten_entries.future;

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




function buy_eleven_entries:
    input r0 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v001.aleo/spend r0 11000000u64 into r1;
    async buy_eleven_entries r0.owner into r2;
    output r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r2 as puzzle_raffle_082124.aleo/buy_eleven_entries.future;

finalize buy_eleven_entries:
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
    set r0 into entries[r12];
    add r1 11u64 into r13;
    set r13 into total_entries[0u64];
    get.or_use user_entries[r0] 0u16 into r14;
    add r14 11u16 into r15;
    set r15 into user_entries[r0];




function buy_twelve_entries:
    input r0 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v001.aleo/spend r0 12000000u64 into r1;
    async buy_twelve_entries r0.owner into r2;
    output r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r2 as puzzle_raffle_082124.aleo/buy_twelve_entries.future;

finalize buy_twelve_entries:
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
    set r0 into entries[r12];
    add r1 11u64 into r13;
    set r0 into entries[r13];
    add r1 12u64 into r14;
    set r14 into total_entries[0u64];
    get.or_use user_entries[r0] 0u16 into r15;
    add r15 12u16 into r16;
    set r16 into user_entries[r0];




function buy_thirteen_entries:
    input r0 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v001.aleo/spend r0 13000000u64 into r1;
    async buy_thirteen_entries r0.owner into r2;
    output r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r2 as puzzle_raffle_082124.aleo/buy_thirteen_entries.future;

finalize buy_thirteen_entries:
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
    set r0 into entries[r12];
    add r1 11u64 into r13;
    set r0 into entries[r13];
    add r1 12u64 into r14;
    set r0 into entries[r14];
    add r1 13u64 into r15;
    set r15 into total_entries[0u64];
    get.or_use user_entries[r0] 0u16 into r16;
    add r16 13u16 into r17;
    set r17 into user_entries[r0];




function buy_fourteen_entries:
    input r0 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v001.aleo/spend r0 14000000u64 into r1;
    async buy_fourteen_entries r0.owner into r2;
    output r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r2 as puzzle_raffle_082124.aleo/buy_fourteen_entries.future;

finalize buy_fourteen_entries:
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
    set r0 into entries[r12];
    add r1 11u64 into r13;
    set r0 into entries[r13];
    add r1 12u64 into r14;
    set r0 into entries[r14];
    add r1 13u64 into r15;
    set r0 into entries[r15];
    add r1 14u64 into r16;
    set r16 into total_entries[0u64];
    get.or_use user_entries[r0] 0u16 into r17;
    add r17 14u16 into r18;
    set r18 into user_entries[r0];




function draw_winner:
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw;
    async draw_winner into r0;
    output r0 as puzzle_raffle_082124.aleo/draw_winner.future;

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
    assert.eq self.caller aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw;
    cast r0 r1.private_key into r2 as Prize.record;
    output r2 as Prize.record;

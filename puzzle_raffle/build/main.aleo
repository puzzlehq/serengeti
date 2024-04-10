program puzzle_raffle_v003.aleo;

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

record AuditPrizeToWinner:
    owner as address.private;
    winner as address.private;
    private_key as PrivateKey.private;


mapping entries:
	key as u64.public;
	value as address.public;


mapping total_entries:
	key as u64.public;
	value as u64.public;


mapping winner:
	key as u32.public;
	value as address.public;

function mint_prize:
    input r0 as u128.private;
    input r1 as u128.private;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    cast r0 r1 into r2 as PrivateKey;
    cast aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw r2 into r3 as Prize.record;
    cast r0 r1 into r4 as PrivateKey;
    cast aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw r4 into r5 as AuditPrize.record;
    output r3 as Prize.record;
    output r5 as AuditPrize.record;


function add_one_raffle_entry:
    input r0 as address.public;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_one_raffle_entry r0 into r1;
    output r1 as puzzle_raffle_v003.aleo/add_one_raffle_entry.future;

finalize add_one_raffle_entry:
    input r0 as address.public;
    get.or_use total_entries[0u64] 0u64 into r1;
    set r0 into entries[r1];
    add r1 1u64 into r2;
    set r2 into total_entries[0u64];


function add_two_raffle_entries:
    input r0 as address.public;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_two_raffle_entries r0 into r1;
    output r1 as puzzle_raffle_v003.aleo/add_two_raffle_entries.future;

finalize add_two_raffle_entries:
    input r0 as address.public;
    get.or_use total_entries[0u64] 0u64 into r1;
    set r0 into entries[r1];
    add r1 1u64 into r2;
    set r0 into entries[r2];
    add r1 2u64 into r3;
    set r3 into total_entries[0u64];


function add_three_raffle_entries:
    input r0 as address.public;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_three_raffle_entries r0 into r1;
    output r1 as puzzle_raffle_v003.aleo/add_three_raffle_entries.future;

finalize add_three_raffle_entries:
    input r0 as address.public;
    get.or_use total_entries[0u64] 0u64 into r1;
    set r0 into entries[r1];
    add r1 1u64 into r2;
    set r0 into entries[r2];
    add r1 2u64 into r3;
    set r0 into entries[r3];
    add r1 3u64 into r4;
    set r4 into total_entries[0u64];


function add_four_raffle_entries:
    input r0 as address.public;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_four_raffle_entries r0 into r1;
    output r1 as puzzle_raffle_v003.aleo/add_four_raffle_entries.future;

finalize add_four_raffle_entries:
    input r0 as address.public;
    get.or_use total_entries[0u64] 0u64 into r1;
    set r0 into entries[r1];
    add r1 1u64 into r2;
    set r0 into entries[r2];
    add r1 2u64 into r3;
    set r0 into entries[r3];
    add r1 3u64 into r4;
    set r0 into entries[r4];
    add r1 4u64 into r5;
    set r5 into total_entries[0u64];


function add_five_raffle_entries:
    input r0 as address.public;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_five_raffle_entries r0 into r1;
    output r1 as puzzle_raffle_v003.aleo/add_five_raffle_entries.future;

finalize add_five_raffle_entries:
    input r0 as address.public;
    get.or_use total_entries[0u64] 0u64 into r1;
    set r0 into entries[r1];
    add r1 1u64 into r2;
    set r0 into entries[r2];
    add r1 2u64 into r3;
    set r0 into entries[r3];
    add r1 3u64 into r4;
    set r0 into entries[r4];
    add r1 4u64 into r5;
    set r0 into entries[r5];
    add r1 5u64 into r6;
    set r6 into total_entries[0u64];


function add_six_raffle_entries:
    input r0 as address.public;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_six_raffle_entries r0 into r1;
    output r1 as puzzle_raffle_v003.aleo/add_six_raffle_entries.future;

finalize add_six_raffle_entries:
    input r0 as address.public;
    get.or_use total_entries[0u64] 0u64 into r1;
    set r0 into entries[r1];
    add r1 1u64 into r2;
    set r0 into entries[r2];
    add r1 2u64 into r3;
    set r0 into entries[r3];
    add r1 3u64 into r4;
    set r0 into entries[r4];
    add r1 4u64 into r5;
    set r0 into entries[r5];
    add r1 5u64 into r6;
    set r0 into entries[r6];
    add r1 6u64 into r7;
    set r7 into total_entries[0u64];


function add_seven_raffle_entries:
    input r0 as address.public;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_seven_raffle_entries r0 into r1;
    output r1 as puzzle_raffle_v003.aleo/add_seven_raffle_entries.future;

finalize add_seven_raffle_entries:
    input r0 as address.public;
    get.or_use total_entries[0u64] 0u64 into r1;
    set r0 into entries[r1];
    add r1 1u64 into r2;
    set r0 into entries[r2];
    add r1 2u64 into r3;
    set r0 into entries[r3];
    add r1 3u64 into r4;
    set r0 into entries[r4];
    add r1 4u64 into r5;
    set r0 into entries[r5];
    add r1 5u64 into r6;
    set r0 into entries[r6];
    add r1 6u64 into r7;
    set r0 into entries[r7];
    add r1 7u64 into r8;
    set r8 into total_entries[0u64];


function add_eight_raffle_entries:
    input r0 as address.public;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_eight_raffle_entries r0 into r1;
    output r1 as puzzle_raffle_v003.aleo/add_eight_raffle_entries.future;

finalize add_eight_raffle_entries:
    input r0 as address.public;
    get.or_use total_entries[0u64] 0u64 into r1;
    set r0 into entries[r1];
    add r1 1u64 into r2;
    set r0 into entries[r2];
    add r1 2u64 into r3;
    set r0 into entries[r3];
    add r1 3u64 into r4;
    set r0 into entries[r4];
    add r1 4u64 into r5;
    set r0 into entries[r5];
    add r1 5u64 into r6;
    set r0 into entries[r6];
    add r1 6u64 into r7;
    set r0 into entries[r7];
    add r1 7u64 into r8;
    set r0 into entries[r8];
    add r1 8u64 into r9;
    set r9 into total_entries[0u64];


function add_nine_raffle_entries:
    input r0 as address.public;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_nine_raffle_entries r0 into r1;
    output r1 as puzzle_raffle_v003.aleo/add_nine_raffle_entries.future;

finalize add_nine_raffle_entries:
    input r0 as address.public;
    get.or_use total_entries[0u64] 0u64 into r1;
    set r0 into entries[r1];
    add r1 1u64 into r2;
    set r0 into entries[r2];
    add r1 2u64 into r3;
    set r0 into entries[r3];
    add r1 3u64 into r4;
    set r0 into entries[r4];
    add r1 4u64 into r5;
    set r0 into entries[r5];
    add r1 5u64 into r6;
    set r0 into entries[r6];
    add r1 6u64 into r7;
    set r0 into entries[r7];
    add r1 7u64 into r8;
    set r0 into entries[r8];
    add r1 8u64 into r9;
    set r0 into entries[r9];
    add r1 9u64 into r10;
    set r10 into total_entries[0u64];


function add_ten_raffle_entries:
    input r0 as address.public;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_ten_raffle_entries r0 into r1;
    output r1 as puzzle_raffle_v003.aleo/add_ten_raffle_entries.future;

finalize add_ten_raffle_entries:
    input r0 as address.public;
    get.or_use total_entries[0u64] 0u64 into r1;
    set r0 into entries[r1];
    add r1 1u64 into r2;
    set r0 into entries[r2];
    add r1 2u64 into r3;
    set r0 into entries[r3];
    add r1 3u64 into r4;
    set r0 into entries[r4];
    add r1 4u64 into r5;
    set r0 into entries[r5];
    add r1 5u64 into r6;
    set r0 into entries[r6];
    add r1 6u64 into r7;
    set r0 into entries[r7];
    add r1 7u64 into r8;
    set r0 into entries[r8];
    add r1 8u64 into r9;
    set r0 into entries[r9];
    add r1 9u64 into r10;
    set r0 into entries[r10];
    add r1 10u64 into r11;
    set r11 into total_entries[0u64];


function add_eleven_raffle_entries:
    input r0 as address.public;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_eleven_raffle_entries r0 into r1;
    output r1 as puzzle_raffle_v003.aleo/add_eleven_raffle_entries.future;

finalize add_eleven_raffle_entries:
    input r0 as address.public;
    get.or_use total_entries[0u64] 0u64 into r1;
    set r0 into entries[r1];
    add r1 1u64 into r2;
    set r0 into entries[r2];
    add r1 2u64 into r3;
    set r0 into entries[r3];
    add r1 3u64 into r4;
    set r0 into entries[r4];
    add r1 4u64 into r5;
    set r0 into entries[r5];
    add r1 5u64 into r6;
    set r0 into entries[r6];
    add r1 6u64 into r7;
    set r0 into entries[r7];
    add r1 7u64 into r8;
    set r0 into entries[r8];
    add r1 8u64 into r9;
    set r0 into entries[r9];
    add r1 9u64 into r10;
    set r0 into entries[r10];
    add r1 10u64 into r11;
    set r0 into entries[r11];
    add r1 11u64 into r12;
    set r12 into total_entries[0u64];


function add_twelve_raffle_entries:
    input r0 as address.public;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_twelve_raffle_entries r0 into r1;
    output r1 as puzzle_raffle_v003.aleo/add_twelve_raffle_entries.future;

finalize add_twelve_raffle_entries:
    input r0 as address.public;
    get.or_use total_entries[0u64] 0u64 into r1;
    set r0 into entries[r1];
    add r1 1u64 into r2;
    set r0 into entries[r2];
    add r1 2u64 into r3;
    set r0 into entries[r3];
    add r1 3u64 into r4;
    set r0 into entries[r4];
    add r1 4u64 into r5;
    set r0 into entries[r5];
    add r1 5u64 into r6;
    set r0 into entries[r6];
    add r1 6u64 into r7;
    set r0 into entries[r7];
    add r1 7u64 into r8;
    set r0 into entries[r8];
    add r1 8u64 into r9;
    set r0 into entries[r9];
    add r1 9u64 into r10;
    set r0 into entries[r10];
    add r1 10u64 into r11;
    set r0 into entries[r11];
    add r1 11u64 into r12;
    set r0 into entries[r12];
    add r1 12u64 into r13;
    set r13 into total_entries[0u64];


function add_thirteen_raffle_entries:
    input r0 as address.public;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_thirteen_raffle_entries r0 into r1;
    output r1 as puzzle_raffle_v003.aleo/add_thirteen_raffle_entries.future;

finalize add_thirteen_raffle_entries:
    input r0 as address.public;
    get.or_use total_entries[0u64] 0u64 into r1;
    set r0 into entries[r1];
    add r1 1u64 into r2;
    set r0 into entries[r2];
    add r1 2u64 into r3;
    set r0 into entries[r3];
    add r1 3u64 into r4;
    set r0 into entries[r4];
    add r1 4u64 into r5;
    set r0 into entries[r5];
    add r1 5u64 into r6;
    set r0 into entries[r6];
    add r1 6u64 into r7;
    set r0 into entries[r7];
    add r1 7u64 into r8;
    set r0 into entries[r8];
    add r1 8u64 into r9;
    set r0 into entries[r9];
    add r1 9u64 into r10;
    set r0 into entries[r10];
    add r1 10u64 into r11;
    set r0 into entries[r11];
    add r1 11u64 into r12;
    set r0 into entries[r12];
    add r1 12u64 into r13;
    set r0 into entries[r13];
    add r1 13u64 into r14;
    set r14 into total_entries[0u64];


function add_fourteen_raffle_entries:
    input r0 as address.public;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_fourteen_raffle_entries r0 into r1;
    output r1 as puzzle_raffle_v003.aleo/add_fourteen_raffle_entries.future;

finalize add_fourteen_raffle_entries:
    input r0 as address.public;
    get.or_use total_entries[0u64] 0u64 into r1;
    set r0 into entries[r1];
    add r1 1u64 into r2;
    set r0 into entries[r2];
    add r1 2u64 into r3;
    set r0 into entries[r3];
    add r1 3u64 into r4;
    set r0 into entries[r4];
    add r1 4u64 into r5;
    set r0 into entries[r5];
    add r1 5u64 into r6;
    set r0 into entries[r6];
    add r1 6u64 into r7;
    set r0 into entries[r7];
    add r1 7u64 into r8;
    set r0 into entries[r8];
    add r1 8u64 into r9;
    set r0 into entries[r9];
    add r1 9u64 into r10;
    set r0 into entries[r10];
    add r1 10u64 into r11;
    set r0 into entries[r11];
    add r1 11u64 into r12;
    set r0 into entries[r12];
    add r1 12u64 into r13;
    set r0 into entries[r13];
    add r1 13u64 into r14;
    set r0 into entries[r14];
    add r1 14u64 into r15;
    set r15 into total_entries[0u64];


function add_fifteen_raffle_entries:
    input r0 as address.public;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_fifteen_raffle_entries r0 into r1;
    output r1 as puzzle_raffle_v003.aleo/add_fifteen_raffle_entries.future;

finalize add_fifteen_raffle_entries:
    input r0 as address.public;
    get.or_use total_entries[0u64] 0u64 into r1;
    set r0 into entries[r1];
    add r1 1u64 into r2;
    set r0 into entries[r2];
    add r1 2u64 into r3;
    set r0 into entries[r3];
    add r1 3u64 into r4;
    set r0 into entries[r4];
    add r1 4u64 into r5;
    set r0 into entries[r5];
    add r1 5u64 into r6;
    set r0 into entries[r6];
    add r1 6u64 into r7;
    set r0 into entries[r7];
    add r1 7u64 into r8;
    set r0 into entries[r8];
    add r1 8u64 into r9;
    set r0 into entries[r9];
    add r1 9u64 into r10;
    set r0 into entries[r10];
    add r1 10u64 into r11;
    set r0 into entries[r11];
    add r1 11u64 into r12;
    set r0 into entries[r12];
    add r1 12u64 into r13;
    set r0 into entries[r13];
    add r1 13u64 into r14;
    set r0 into entries[r14];
    add r1 14u64 into r15;
    set r0 into entries[r15];
    add r1 15u64 into r16;
    set r16 into total_entries[0u64];


function draw_winner:
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async draw_winner into r0;
    output r0 as puzzle_raffle_v003.aleo/draw_winner.future;

finalize draw_winner:
    get total_entries[0u64] into r0;
    rand.chacha into r1 as u64;
    rem r1 r0 into r2;
    get entries[r2] into r3;
    set r3 into winner[0u32];


function send_prize_to_winner:
    input r0 as address.public;
    input r1 as Prize.record;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw;
    cast r0 r1.private_key into r2 as Prize.record;
    cast aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw r0 r1.private_key into r3 as AuditPrizeToWinner.record;
    async send_prize_to_winner r0 into r4;
    output r2 as Prize.record;
    output r3 as AuditPrizeToWinner.record;
    output r4 as puzzle_raffle_v003.aleo/send_prize_to_winner.future;

finalize send_prize_to_winner:
    input r0 as address.public;
    get winner[0u32] into r1;
    assert.eq r0 r1;

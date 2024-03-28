program puzz_usdc_giveaway_v005.aleo;

struct pk:
    pk_pt1 as u128;
    pk_pt2 as u128;

record GiveawayAccount:
    owner as address.private;
    private_key as pk.private;

record AuditGiveawayAccount:
    owner as address.private;
    minter as address.private;
    private_key as pk.private;


mapping entry_index:
	key as u64.public;
	value as address.public;


mapping entry_count:
	key as u64.public;
	value as u64.public;


mapping winner:
	key as address.public;
	value as u32.public;

function set_prize:
    input r0 as address.private;
    input r1 as u64.private;
    input r2 as u64.private;
    input r3 as u64.private;
    input r4 as u128.private;
    input r5 as u128.private;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    cast r4 r5 into r6 as pk;
    cast r0 r6 into r7 as GiveawayAccount.record;
    cast r4 r5 into r8 as pk;
    cast aleo1fan3jt83xvs5m4pqppmeghv4ypsan5aq4clwt4hnfv8pq90evqqq4dj6p6 r0 r8 into r9 as AuditGiveawayAccount.record;
    output r7 as GiveawayAccount.record;
    output r9 as AuditGiveawayAccount.record;


function add_raffle_entry:
    input r0 as address.public;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_raffle_entry r0 into r1;
    output r1 as puzz_usdc_giveaway_v005.aleo/add_raffle_entry.future;

finalize add_raffle_entry:
    input r0 as address.public;
    get.or_use entry_count[0u64] 0u64 into r1;
    set r0 into entry_index[r1];
    add r1 1u64 into r2;
    set r2 into entry_count[0u64];


function add_two_raffle_entries:
    input r0 as address.public;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_two_raffle_entries r0 into r1;
    output r1 as puzz_usdc_giveaway_v005.aleo/add_two_raffle_entries.future;

finalize add_two_raffle_entries:
    input r0 as address.public;
    get.or_use entry_count[0u64] 0u64 into r1;
    set r0 into entry_index[r1];
    add r1 1u64 into r2;
    set r0 into entry_index[r2];
    add r1 2u64 into r3;
    set r3 into entry_count[0u64];


function add_three_raffle_entries:
    input r0 as address.public;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_three_raffle_entries r0 into r1;
    output r1 as puzz_usdc_giveaway_v005.aleo/add_three_raffle_entries.future;

finalize add_three_raffle_entries:
    input r0 as address.public;
    get.or_use entry_count[0u64] 0u64 into r1;
    set r0 into entry_index[r1];
    add r1 1u64 into r2;
    set r0 into entry_index[r2];
    add r1 2u64 into r3;
    set r0 into entry_index[r3];
    add r1 3u64 into r4;
    set r4 into entry_count[0u64];


function add_four_raffle_entries:
    input r0 as address.public;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_four_raffle_entries r0 into r1;
    output r1 as puzz_usdc_giveaway_v005.aleo/add_four_raffle_entries.future;

finalize add_four_raffle_entries:
    input r0 as address.public;
    get.or_use entry_count[0u64] 0u64 into r1;
    set r0 into entry_index[r1];
    add r1 1u64 into r2;
    set r0 into entry_index[r2];
    add r1 2u64 into r3;
    set r0 into entry_index[r3];
    add r1 3u64 into r4;
    set r0 into entry_index[r4];
    add r1 4u64 into r5;
    set r5 into entry_count[0u64];


function add_five_raffle_entries:
    input r0 as address.public;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_five_raffle_entries r0 into r1;
    output r1 as puzz_usdc_giveaway_v005.aleo/add_five_raffle_entries.future;

finalize add_five_raffle_entries:
    input r0 as address.public;
    get.or_use entry_count[0u64] 0u64 into r1;
    set r0 into entry_index[r1];
    add r1 1u64 into r2;
    set r0 into entry_index[r2];
    add r1 2u64 into r3;
    set r0 into entry_index[r3];
    add r1 3u64 into r4;
    set r0 into entry_index[r4];
    add r1 4u64 into r5;
    set r0 into entry_index[r5];
    add r1 5u64 into r6;
    set r6 into entry_count[0u64];


function add_six_raffle_entries:
    input r0 as address.public;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_six_raffle_entries r0 into r1;
    output r1 as puzz_usdc_giveaway_v005.aleo/add_six_raffle_entries.future;

finalize add_six_raffle_entries:
    input r0 as address.public;
    get.or_use entry_count[0u64] 0u64 into r1;
    set r0 into entry_index[r1];
    add r1 1u64 into r2;
    set r0 into entry_index[r2];
    add r1 2u64 into r3;
    set r0 into entry_index[r3];
    add r1 3u64 into r4;
    set r0 into entry_index[r4];
    add r1 4u64 into r5;
    set r0 into entry_index[r5];
    add r1 5u64 into r6;
    set r0 into entry_index[r6];
    add r1 6u64 into r7;
    set r7 into entry_count[0u64];


function add_seven_raffle_entries:
    input r0 as address.public;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_seven_raffle_entries r0 into r1;
    output r1 as puzz_usdc_giveaway_v005.aleo/add_seven_raffle_entries.future;

finalize add_seven_raffle_entries:
    input r0 as address.public;
    get.or_use entry_count[0u64] 0u64 into r1;
    set r0 into entry_index[r1];
    add r1 1u64 into r2;
    set r0 into entry_index[r2];
    add r1 2u64 into r3;
    set r0 into entry_index[r3];
    add r1 3u64 into r4;
    set r0 into entry_index[r4];
    add r1 4u64 into r5;
    set r0 into entry_index[r5];
    add r1 5u64 into r6;
    set r0 into entry_index[r6];
    add r1 6u64 into r7;
    set r0 into entry_index[r7];
    add r1 7u64 into r8;
    set r8 into entry_count[0u64];


function add_eight_raffle_entries:
    input r0 as address.public;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_eight_raffle_entries r0 into r1;
    output r1 as puzz_usdc_giveaway_v005.aleo/add_eight_raffle_entries.future;

finalize add_eight_raffle_entries:
    input r0 as address.public;
    get.or_use entry_count[0u64] 0u64 into r1;
    set r0 into entry_index[r1];
    add r1 1u64 into r2;
    set r0 into entry_index[r2];
    add r1 2u64 into r3;
    set r0 into entry_index[r3];
    add r1 3u64 into r4;
    set r0 into entry_index[r4];
    add r1 4u64 into r5;
    set r0 into entry_index[r5];
    add r1 5u64 into r6;
    set r0 into entry_index[r6];
    add r1 6u64 into r7;
    set r0 into entry_index[r7];
    add r1 7u64 into r8;
    set r0 into entry_index[r8];
    add r1 8u64 into r9;
    set r9 into entry_count[0u64];


function add_nine_raffle_entries:
    input r0 as address.public;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_nine_raffle_entries r0 into r1;
    output r1 as puzz_usdc_giveaway_v005.aleo/add_nine_raffle_entries.future;

finalize add_nine_raffle_entries:
    input r0 as address.public;
    get.or_use entry_count[0u64] 0u64 into r1;
    set r0 into entry_index[r1];
    add r1 1u64 into r2;
    set r0 into entry_index[r2];
    add r1 2u64 into r3;
    set r0 into entry_index[r3];
    add r1 3u64 into r4;
    set r0 into entry_index[r4];
    add r1 4u64 into r5;
    set r0 into entry_index[r5];
    add r1 5u64 into r6;
    set r0 into entry_index[r6];
    add r1 6u64 into r7;
    set r0 into entry_index[r7];
    add r1 7u64 into r8;
    set r0 into entry_index[r8];
    add r1 8u64 into r9;
    set r0 into entry_index[r9];
    add r1 9u64 into r10;
    set r10 into entry_count[0u64];


function add_ten_raffle_entries:
    input r0 as address.public;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_ten_raffle_entries r0 into r1;
    output r1 as puzz_usdc_giveaway_v005.aleo/add_ten_raffle_entries.future;

finalize add_ten_raffle_entries:
    input r0 as address.public;
    get.or_use entry_count[0u64] 0u64 into r1;
    set r0 into entry_index[r1];
    add r1 1u64 into r2;
    set r0 into entry_index[r2];
    add r1 2u64 into r3;
    set r0 into entry_index[r3];
    add r1 3u64 into r4;
    set r0 into entry_index[r4];
    add r1 4u64 into r5;
    set r0 into entry_index[r5];
    add r1 5u64 into r6;
    set r0 into entry_index[r6];
    add r1 6u64 into r7;
    set r0 into entry_index[r7];
    add r1 7u64 into r8;
    set r0 into entry_index[r8];
    add r1 8u64 into r9;
    set r0 into entry_index[r9];
    add r1 9u64 into r10;
    set r0 into entry_index[r10];
    add r1 10u64 into r11;
    set r11 into entry_count[0u64];


function add_eleven_raffle_entries:
    input r0 as address.public;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_eleven_raffle_entries r0 into r1;
    output r1 as puzz_usdc_giveaway_v005.aleo/add_eleven_raffle_entries.future;

finalize add_eleven_raffle_entries:
    input r0 as address.public;
    get.or_use entry_count[0u64] 0u64 into r1;
    set r0 into entry_index[r1];
    add r1 1u64 into r2;
    set r0 into entry_index[r2];
    add r1 2u64 into r3;
    set r0 into entry_index[r3];
    add r1 3u64 into r4;
    set r0 into entry_index[r4];
    add r1 4u64 into r5;
    set r0 into entry_index[r5];
    add r1 5u64 into r6;
    set r0 into entry_index[r6];
    add r1 6u64 into r7;
    set r0 into entry_index[r7];
    add r1 7u64 into r8;
    set r0 into entry_index[r8];
    add r1 8u64 into r9;
    set r0 into entry_index[r9];
    add r1 9u64 into r10;
    set r0 into entry_index[r10];
    add r1 10u64 into r11;
    set r0 into entry_index[r11];
    add r1 11u64 into r12;
    set r12 into entry_count[0u64];


function add_twelve_raffle_entries:
    input r0 as address.public;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_twelve_raffle_entries r0 into r1;
    output r1 as puzz_usdc_giveaway_v005.aleo/add_twelve_raffle_entries.future;

finalize add_twelve_raffle_entries:
    input r0 as address.public;
    get.or_use entry_count[0u64] 0u64 into r1;
    set r0 into entry_index[r1];
    add r1 1u64 into r2;
    set r0 into entry_index[r2];
    add r1 2u64 into r3;
    set r0 into entry_index[r3];
    add r1 3u64 into r4;
    set r0 into entry_index[r4];
    add r1 4u64 into r5;
    set r0 into entry_index[r5];
    add r1 5u64 into r6;
    set r0 into entry_index[r6];
    add r1 6u64 into r7;
    set r0 into entry_index[r7];
    add r1 7u64 into r8;
    set r0 into entry_index[r8];
    add r1 8u64 into r9;
    set r0 into entry_index[r9];
    add r1 9u64 into r10;
    set r0 into entry_index[r10];
    add r1 10u64 into r11;
    set r0 into entry_index[r11];
    add r1 11u64 into r12;
    set r0 into entry_index[r12];
    add r1 12u64 into r13;
    set r13 into entry_count[0u64];


function add_thirteen_raffle_entries:
    input r0 as address.public;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_thirteen_raffle_entries r0 into r1;
    output r1 as puzz_usdc_giveaway_v005.aleo/add_thirteen_raffle_entries.future;

finalize add_thirteen_raffle_entries:
    input r0 as address.public;
    get.or_use entry_count[0u64] 0u64 into r1;
    set r0 into entry_index[r1];
    add r1 1u64 into r2;
    set r0 into entry_index[r2];
    add r1 2u64 into r3;
    set r0 into entry_index[r3];
    add r1 3u64 into r4;
    set r0 into entry_index[r4];
    add r1 4u64 into r5;
    set r0 into entry_index[r5];
    add r1 5u64 into r6;
    set r0 into entry_index[r6];
    add r1 6u64 into r7;
    set r0 into entry_index[r7];
    add r1 7u64 into r8;
    set r0 into entry_index[r8];
    add r1 8u64 into r9;
    set r0 into entry_index[r9];
    add r1 9u64 into r10;
    set r0 into entry_index[r10];
    add r1 10u64 into r11;
    set r0 into entry_index[r11];
    add r1 11u64 into r12;
    set r0 into entry_index[r12];
    add r1 12u64 into r13;
    set r0 into entry_index[r13];
    add r1 13u64 into r14;
    set r14 into entry_count[0u64];


function add_fourteen_raffle_entries:
    input r0 as address.public;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_fourteen_raffle_entries r0 into r1;
    output r1 as puzz_usdc_giveaway_v005.aleo/add_fourteen_raffle_entries.future;

finalize add_fourteen_raffle_entries:
    input r0 as address.public;
    get.or_use entry_count[0u64] 0u64 into r1;
    set r0 into entry_index[r1];
    add r1 1u64 into r2;
    set r0 into entry_index[r2];
    add r1 2u64 into r3;
    set r0 into entry_index[r3];
    add r1 3u64 into r4;
    set r0 into entry_index[r4];
    add r1 4u64 into r5;
    set r0 into entry_index[r5];
    add r1 5u64 into r6;
    set r0 into entry_index[r6];
    add r1 6u64 into r7;
    set r0 into entry_index[r7];
    add r1 7u64 into r8;
    set r0 into entry_index[r8];
    add r1 8u64 into r9;
    set r0 into entry_index[r9];
    add r1 9u64 into r10;
    set r0 into entry_index[r10];
    add r1 10u64 into r11;
    set r0 into entry_index[r11];
    add r1 11u64 into r12;
    set r0 into entry_index[r12];
    add r1 12u64 into r13;
    set r0 into entry_index[r13];
    add r1 13u64 into r14;
    set r0 into entry_index[r14];
    add r1 14u64 into r15;
    set r15 into entry_count[0u64];


function add_fifteen_raffle_entries:
    input r0 as address.public;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_fifteen_raffle_entries r0 into r1;
    output r1 as puzz_usdc_giveaway_v005.aleo/add_fifteen_raffle_entries.future;

finalize add_fifteen_raffle_entries:
    input r0 as address.public;
    get.or_use entry_count[0u64] 0u64 into r1;
    set r0 into entry_index[r1];
    add r1 1u64 into r2;
    set r0 into entry_index[r2];
    add r1 2u64 into r3;
    set r0 into entry_index[r3];
    add r1 3u64 into r4;
    set r0 into entry_index[r4];
    add r1 4u64 into r5;
    set r0 into entry_index[r5];
    add r1 5u64 into r6;
    set r0 into entry_index[r6];
    add r1 6u64 into r7;
    set r0 into entry_index[r7];
    add r1 7u64 into r8;
    set r0 into entry_index[r8];
    add r1 8u64 into r9;
    set r0 into entry_index[r9];
    add r1 9u64 into r10;
    set r0 into entry_index[r10];
    add r1 10u64 into r11;
    set r0 into entry_index[r11];
    add r1 11u64 into r12;
    set r0 into entry_index[r12];
    add r1 12u64 into r13;
    set r0 into entry_index[r13];
    add r1 13u64 into r14;
    set r0 into entry_index[r14];
    add r1 14u64 into r15;
    set r0 into entry_index[r15];
    add r1 15u64 into r16;
    set r16 into entry_count[0u64];


function determine_raffle_winner:
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async determine_raffle_winner into r0;
    output r0 as puzz_usdc_giveaway_v005.aleo/determine_raffle_winner.future;

finalize determine_raffle_winner:
    get entry_count[0u64] into r0;
    rand.chacha into r1 as u64;
    rem r1 r0 into r2;
    get entry_index[r2] into r3;
    set 0u32 into winner[r3];


function send_prize_to_winner:
    input r0 as address.public;
    input r1 as GiveawayAccount.record;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    cast r0 r1.private_key into r2 as GiveawayAccount.record;
    cast aleo1fan3jt83xvs5m4pqppmeghv4ypsan5aq4clwt4hnfv8pq90evqqq4dj6p6 r0 r1.private_key into r3 as AuditGiveawayAccount.record;
    output r2 as GiveawayAccount.record;
    output r3 as AuditGiveawayAccount.record;

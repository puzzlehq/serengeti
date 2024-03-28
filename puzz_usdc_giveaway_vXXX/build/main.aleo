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
    input r1 as address.private;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_two_raffle_entries r0 r1 into r2;
    output r2 as puzz_usdc_giveaway_v005.aleo/add_two_raffle_entries.future;

finalize add_two_raffle_entries:
    input r0 as address.public;
    input r1 as address.public;
    get.or_use entry_count[0u64] 0u64 into r2;
    set r0 into entry_index[r2];
    add r2 1u64 into r3;
    set r1 into entry_index[r3];
    add r2 2u64 into r4;
    set r4 into entry_count[0u64];


function add_three_raffle_entries:
    input r0 as address.public;
    input r1 as address.private;
    input r2 as address.private;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_three_raffle_entries r0 r1 r2 into r3;
    output r3 as puzz_usdc_giveaway_v005.aleo/add_three_raffle_entries.future;

finalize add_three_raffle_entries:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as address.public;
    get.or_use entry_count[0u64] 0u64 into r3;
    set r0 into entry_index[r3];
    add r3 1u64 into r4;
    set r1 into entry_index[r4];
    add r3 2u64 into r5;
    set r2 into entry_index[r5];
    add r3 3u64 into r6;
    set r6 into entry_count[0u64];


function add_four_raffle_entries:
    input r0 as address.public;
    input r1 as address.private;
    input r2 as address.private;
    input r3 as address.private;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_four_raffle_entries r0 r1 r2 r3 into r4;
    output r4 as puzz_usdc_giveaway_v005.aleo/add_four_raffle_entries.future;

finalize add_four_raffle_entries:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as address.public;
    input r3 as address.public;
    get.or_use entry_count[0u64] 0u64 into r4;
    set r0 into entry_index[r4];
    add r4 1u64 into r5;
    set r1 into entry_index[r5];
    add r4 2u64 into r6;
    set r2 into entry_index[r6];
    add r4 3u64 into r7;
    set r3 into entry_index[r7];
    add r4 4u64 into r8;
    set r8 into entry_count[0u64];


function add_five_raffle_entries:
    input r0 as address.public;
    input r1 as address.private;
    input r2 as address.private;
    input r3 as address.private;
    input r4 as address.private;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_five_raffle_entries r0 r1 r2 r3 r4 into r5;
    output r5 as puzz_usdc_giveaway_v005.aleo/add_five_raffle_entries.future;

finalize add_five_raffle_entries:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as address.public;
    input r3 as address.public;
    input r4 as address.public;
    get.or_use entry_count[0u64] 0u64 into r5;
    set r0 into entry_index[r5];
    add r5 1u64 into r6;
    set r1 into entry_index[r6];
    add r5 2u64 into r7;
    set r2 into entry_index[r7];
    add r5 3u64 into r8;
    set r3 into entry_index[r8];
    add r5 4u64 into r9;
    set r4 into entry_index[r9];
    add r5 5u64 into r10;
    set r10 into entry_count[0u64];


function add_six_raffle_entries:
    input r0 as address.public;
    input r1 as address.private;
    input r2 as address.private;
    input r3 as address.private;
    input r4 as address.private;
    input r5 as address.private;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_six_raffle_entries r0 r1 r2 r3 r4 r5 into r6;
    output r6 as puzz_usdc_giveaway_v005.aleo/add_six_raffle_entries.future;

finalize add_six_raffle_entries:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as address.public;
    input r3 as address.public;
    input r4 as address.public;
    input r5 as address.public;
    get.or_use entry_count[0u64] 0u64 into r6;
    set r0 into entry_index[r6];
    add r6 1u64 into r7;
    set r1 into entry_index[r7];
    add r6 2u64 into r8;
    set r2 into entry_index[r8];
    add r6 3u64 into r9;
    set r3 into entry_index[r9];
    add r6 4u64 into r10;
    set r4 into entry_index[r10];
    add r6 5u64 into r11;
    set r5 into entry_index[r11];
    add r6 6u64 into r12;
    set r12 into entry_count[0u64];


function add_seven_raffle_entries:
    input r0 as address.public;
    input r1 as address.private;
    input r2 as address.private;
    input r3 as address.private;
    input r4 as address.private;
    input r5 as address.private;
    input r6 as address.private;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_seven_raffle_entries r0 r1 r2 r3 r4 r5 r6 into r7;
    output r7 as puzz_usdc_giveaway_v005.aleo/add_seven_raffle_entries.future;

finalize add_seven_raffle_entries:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as address.public;
    input r3 as address.public;
    input r4 as address.public;
    input r5 as address.public;
    input r6 as address.public;
    get.or_use entry_count[0u64] 0u64 into r7;
    set r0 into entry_index[r7];
    add r7 1u64 into r8;
    set r1 into entry_index[r8];
    add r7 2u64 into r9;
    set r2 into entry_index[r9];
    add r7 3u64 into r10;
    set r3 into entry_index[r10];
    add r7 4u64 into r11;
    set r4 into entry_index[r11];
    add r7 5u64 into r12;
    set r5 into entry_index[r12];
    add r7 6u64 into r13;
    set r6 into entry_index[r13];
    add r7 7u64 into r14;
    set r14 into entry_count[0u64];


function add_eight_raffle_entries:
    input r0 as address.public;
    input r1 as address.private;
    input r2 as address.private;
    input r3 as address.private;
    input r4 as address.private;
    input r5 as address.private;
    input r6 as address.private;
    input r7 as address.private;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_eight_raffle_entries r0 r1 r2 r3 r4 r5 r6 r7 into r8;
    output r8 as puzz_usdc_giveaway_v005.aleo/add_eight_raffle_entries.future;

finalize add_eight_raffle_entries:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as address.public;
    input r3 as address.public;
    input r4 as address.public;
    input r5 as address.public;
    input r6 as address.public;
    input r7 as address.public;
    get.or_use entry_count[0u64] 0u64 into r8;
    set r0 into entry_index[r8];
    add r8 1u64 into r9;
    set r1 into entry_index[r9];
    add r8 2u64 into r10;
    set r2 into entry_index[r10];
    add r8 3u64 into r11;
    set r3 into entry_index[r11];
    add r8 4u64 into r12;
    set r4 into entry_index[r12];
    add r8 5u64 into r13;
    set r5 into entry_index[r13];
    add r8 6u64 into r14;
    set r6 into entry_index[r14];
    add r8 7u64 into r15;
    set r7 into entry_index[r15];
    add r8 8u64 into r16;
    set r16 into entry_count[0u64];


function add_nine_raffle_entries:
    input r0 as address.public;
    input r1 as address.private;
    input r2 as address.private;
    input r3 as address.private;
    input r4 as address.private;
    input r5 as address.private;
    input r6 as address.private;
    input r7 as address.private;
    input r8 as address.private;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_nine_raffle_entries r0 r1 r2 r3 r4 r5 r6 r7 r8 into r9;
    output r9 as puzz_usdc_giveaway_v005.aleo/add_nine_raffle_entries.future;

finalize add_nine_raffle_entries:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as address.public;
    input r3 as address.public;
    input r4 as address.public;
    input r5 as address.public;
    input r6 as address.public;
    input r7 as address.public;
    input r8 as address.public;
    get.or_use entry_count[0u64] 0u64 into r9;
    set r0 into entry_index[r9];
    add r9 1u64 into r10;
    set r1 into entry_index[r10];
    add r9 2u64 into r11;
    set r2 into entry_index[r11];
    add r9 3u64 into r12;
    set r3 into entry_index[r12];
    add r9 4u64 into r13;
    set r4 into entry_index[r13];
    add r9 5u64 into r14;
    set r5 into entry_index[r14];
    add r9 6u64 into r15;
    set r6 into entry_index[r15];
    add r9 7u64 into r16;
    set r7 into entry_index[r16];
    add r9 8u64 into r17;
    set r8 into entry_index[r17];
    add r9 9u64 into r18;
    set r18 into entry_count[0u64];


function add_ten_raffle_entries:
    input r0 as address.public;
    input r1 as address.private;
    input r2 as address.private;
    input r3 as address.private;
    input r4 as address.private;
    input r5 as address.private;
    input r6 as address.private;
    input r7 as address.private;
    input r8 as address.private;
    input r9 as address.private;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_ten_raffle_entries r0 r1 r2 r3 r4 r5 r6 r7 r8 r9 into r10;
    output r10 as puzz_usdc_giveaway_v005.aleo/add_ten_raffle_entries.future;

finalize add_ten_raffle_entries:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as address.public;
    input r3 as address.public;
    input r4 as address.public;
    input r5 as address.public;
    input r6 as address.public;
    input r7 as address.public;
    input r8 as address.public;
    input r9 as address.public;
    get.or_use entry_count[0u64] 0u64 into r10;
    set r0 into entry_index[r10];
    add r10 1u64 into r11;
    set r1 into entry_index[r11];
    add r10 2u64 into r12;
    set r2 into entry_index[r12];
    add r10 3u64 into r13;
    set r3 into entry_index[r13];
    add r10 4u64 into r14;
    set r4 into entry_index[r14];
    add r10 5u64 into r15;
    set r5 into entry_index[r15];
    add r10 6u64 into r16;
    set r6 into entry_index[r16];
    add r10 7u64 into r17;
    set r7 into entry_index[r17];
    add r10 8u64 into r18;
    set r8 into entry_index[r18];
    add r10 9u64 into r19;
    set r9 into entry_index[r19];
    add r10 10u64 into r20;
    set r20 into entry_count[0u64];


function add_eleven_raffle_entries:
    input r0 as address.public;
    input r1 as address.private;
    input r2 as address.private;
    input r3 as address.private;
    input r4 as address.private;
    input r5 as address.private;
    input r6 as address.private;
    input r7 as address.private;
    input r8 as address.private;
    input r9 as address.private;
    input r10 as address.private;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_eleven_raffle_entries r0 r1 r2 r3 r4 r5 r6 r7 r8 r9 r10 into r11;
    output r11 as puzz_usdc_giveaway_v005.aleo/add_eleven_raffle_entries.future;

finalize add_eleven_raffle_entries:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as address.public;
    input r3 as address.public;
    input r4 as address.public;
    input r5 as address.public;
    input r6 as address.public;
    input r7 as address.public;
    input r8 as address.public;
    input r9 as address.public;
    input r10 as address.public;
    get.or_use entry_count[0u64] 0u64 into r11;
    set r0 into entry_index[r11];
    add r11 1u64 into r12;
    set r1 into entry_index[r12];
    add r11 2u64 into r13;
    set r2 into entry_index[r13];
    add r11 3u64 into r14;
    set r3 into entry_index[r14];
    add r11 4u64 into r15;
    set r4 into entry_index[r15];
    add r11 5u64 into r16;
    set r5 into entry_index[r16];
    add r11 6u64 into r17;
    set r6 into entry_index[r17];
    add r11 7u64 into r18;
    set r7 into entry_index[r18];
    add r11 8u64 into r19;
    set r8 into entry_index[r19];
    add r11 9u64 into r20;
    set r9 into entry_index[r20];
    add r11 10u64 into r21;
    set r10 into entry_index[r21];
    add r11 11u64 into r22;
    set r22 into entry_count[0u64];


function add_twelve_raffle_entries:
    input r0 as address.public;
    input r1 as address.private;
    input r2 as address.private;
    input r3 as address.private;
    input r4 as address.private;
    input r5 as address.private;
    input r6 as address.private;
    input r7 as address.private;
    input r8 as address.private;
    input r9 as address.private;
    input r10 as address.private;
    input r11 as address.private;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_twelve_raffle_entries r0 r1 r2 r3 r4 r5 r6 r7 r8 r9 r10 r11 into r12;
    output r12 as puzz_usdc_giveaway_v005.aleo/add_twelve_raffle_entries.future;

finalize add_twelve_raffle_entries:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as address.public;
    input r3 as address.public;
    input r4 as address.public;
    input r5 as address.public;
    input r6 as address.public;
    input r7 as address.public;
    input r8 as address.public;
    input r9 as address.public;
    input r10 as address.public;
    input r11 as address.public;
    get.or_use entry_count[0u64] 0u64 into r12;
    set r0 into entry_index[r12];
    add r12 1u64 into r13;
    set r1 into entry_index[r13];
    add r12 2u64 into r14;
    set r2 into entry_index[r14];
    add r12 3u64 into r15;
    set r3 into entry_index[r15];
    add r12 4u64 into r16;
    set r4 into entry_index[r16];
    add r12 5u64 into r17;
    set r5 into entry_index[r17];
    add r12 6u64 into r18;
    set r6 into entry_index[r18];
    add r12 7u64 into r19;
    set r7 into entry_index[r19];
    add r12 8u64 into r20;
    set r8 into entry_index[r20];
    add r12 9u64 into r21;
    set r9 into entry_index[r21];
    add r12 10u64 into r22;
    set r10 into entry_index[r22];
    add r12 11u64 into r23;
    set r11 into entry_index[r23];
    add r12 12u64 into r24;
    set r24 into entry_count[0u64];


function add_thirteen_raffle_entries:
    input r0 as address.public;
    input r1 as address.private;
    input r2 as address.private;
    input r3 as address.private;
    input r4 as address.private;
    input r5 as address.private;
    input r6 as address.private;
    input r7 as address.private;
    input r8 as address.private;
    input r9 as address.private;
    input r10 as address.private;
    input r11 as address.private;
    input r12 as address.private;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_thirteen_raffle_entries r0 r1 r2 r3 r4 r5 r6 r7 r8 r9 r10 r11 r12 into r13;
    output r13 as puzz_usdc_giveaway_v005.aleo/add_thirteen_raffle_entries.future;

finalize add_thirteen_raffle_entries:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as address.public;
    input r3 as address.public;
    input r4 as address.public;
    input r5 as address.public;
    input r6 as address.public;
    input r7 as address.public;
    input r8 as address.public;
    input r9 as address.public;
    input r10 as address.public;
    input r11 as address.public;
    input r12 as address.public;
    get.or_use entry_count[0u64] 0u64 into r13;
    set r0 into entry_index[r13];
    add r13 1u64 into r14;
    set r1 into entry_index[r14];
    add r13 2u64 into r15;
    set r2 into entry_index[r15];
    add r13 3u64 into r16;
    set r3 into entry_index[r16];
    add r13 4u64 into r17;
    set r4 into entry_index[r17];
    add r13 5u64 into r18;
    set r5 into entry_index[r18];
    add r13 6u64 into r19;
    set r6 into entry_index[r19];
    add r13 7u64 into r20;
    set r7 into entry_index[r20];
    add r13 8u64 into r21;
    set r8 into entry_index[r21];
    add r13 9u64 into r22;
    set r9 into entry_index[r22];
    add r13 10u64 into r23;
    set r10 into entry_index[r23];
    add r13 11u64 into r24;
    set r11 into entry_index[r24];
    add r13 12u64 into r25;
    set r12 into entry_index[r25];
    add r13 13u64 into r26;
    set r26 into entry_count[0u64];


function add_fourteen_raffle_entries:
    input r0 as address.public;
    input r1 as address.private;
    input r2 as address.private;
    input r3 as address.private;
    input r4 as address.private;
    input r5 as address.private;
    input r6 as address.private;
    input r7 as address.private;
    input r8 as address.private;
    input r9 as address.private;
    input r10 as address.private;
    input r11 as address.private;
    input r12 as address.private;
    input r13 as address.private;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_fourteen_raffle_entries r0 r1 r2 r3 r4 r5 r6 r7 r8 r9 r10 r11 r12 r13 into r14;
    output r14 as puzz_usdc_giveaway_v005.aleo/add_fourteen_raffle_entries.future;

finalize add_fourteen_raffle_entries:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as address.public;
    input r3 as address.public;
    input r4 as address.public;
    input r5 as address.public;
    input r6 as address.public;
    input r7 as address.public;
    input r8 as address.public;
    input r9 as address.public;
    input r10 as address.public;
    input r11 as address.public;
    input r12 as address.public;
    input r13 as address.public;
    get.or_use entry_count[0u64] 0u64 into r14;
    set r0 into entry_index[r14];
    add r14 1u64 into r15;
    set r1 into entry_index[r15];
    add r14 2u64 into r16;
    set r2 into entry_index[r16];
    add r14 3u64 into r17;
    set r3 into entry_index[r17];
    add r14 4u64 into r18;
    set r4 into entry_index[r18];
    add r14 5u64 into r19;
    set r5 into entry_index[r19];
    add r14 6u64 into r20;
    set r6 into entry_index[r20];
    add r14 7u64 into r21;
    set r7 into entry_index[r21];
    add r14 8u64 into r22;
    set r8 into entry_index[r22];
    add r14 9u64 into r23;
    set r9 into entry_index[r23];
    add r14 10u64 into r24;
    set r10 into entry_index[r24];
    add r14 11u64 into r25;
    set r11 into entry_index[r25];
    add r14 12u64 into r26;
    set r12 into entry_index[r26];
    add r14 13u64 into r27;
    set r13 into entry_index[r27];
    add r14 14u64 into r28;
    set r28 into entry_count[0u64];


function add_fifteen_raffle_entries:
    input r0 as address.public;
    input r1 as address.private;
    input r2 as address.private;
    input r3 as address.private;
    input r4 as address.private;
    input r5 as address.private;
    input r6 as address.private;
    input r7 as address.private;
    input r8 as address.private;
    input r9 as address.private;
    input r10 as address.private;
    input r11 as address.private;
    input r12 as address.private;
    input r13 as address.private;
    input r14 as address.private;
    assert.eq self.caller self.signer;
    assert.eq self.caller aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn;
    async add_fifteen_raffle_entries r0 r1 r2 r3 r4 r5 r6 r7 r8 r9 r10 r11 r12 r13 r14 into r15;
    output r15 as puzz_usdc_giveaway_v005.aleo/add_fifteen_raffle_entries.future;

finalize add_fifteen_raffle_entries:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as address.public;
    input r3 as address.public;
    input r4 as address.public;
    input r5 as address.public;
    input r6 as address.public;
    input r7 as address.public;
    input r8 as address.public;
    input r9 as address.public;
    input r10 as address.public;
    input r11 as address.public;
    input r12 as address.public;
    input r13 as address.public;
    input r14 as address.public;
    get.or_use entry_count[0u64] 0u64 into r15;
    set r0 into entry_index[r15];
    add r15 1u64 into r16;
    set r1 into entry_index[r16];
    add r15 2u64 into r17;
    set r2 into entry_index[r17];
    add r15 3u64 into r18;
    set r3 into entry_index[r18];
    add r15 4u64 into r19;
    set r4 into entry_index[r19];
    add r15 5u64 into r20;
    set r5 into entry_index[r20];
    add r15 6u64 into r21;
    set r6 into entry_index[r21];
    add r15 7u64 into r22;
    set r7 into entry_index[r22];
    add r15 8u64 into r23;
    set r8 into entry_index[r23];
    add r15 9u64 into r24;
    set r9 into entry_index[r24];
    add r15 10u64 into r25;
    set r10 into entry_index[r25];
    add r15 11u64 into r26;
    set r11 into entry_index[r26];
    add r15 12u64 into r27;
    set r12 into entry_index[r27];
    add r15 13u64 into r28;
    set r13 into entry_index[r28];
    add r15 14u64 into r29;
    set r14 into entry_index[r29];
    add r15 15u64 into r30;
    set r30 into entry_count[0u64];


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

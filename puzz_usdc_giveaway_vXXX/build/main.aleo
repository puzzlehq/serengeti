program puzz_usdc_giveaway_v002.aleo;

record GiveawayAccount:
    owner as address.private;
    amount as u64.private;
    asset_type as u64.private;
    date as u64.private;
    private_key as field.private;

record AuditGiveawayAccount:
    owner as address.private;
    minter as address.private;
    amount as u64.private;
    asset_type as u64.private;
    date as u64.private;
    private_key as field.private;

record AuditGiftCard:
    owner as address.private;
    minter as address.private;
    amount as u64.private;
    asset_type as u64.private;
    date as u64.private;
    private_key as u64.private;


mapping entry_index:
	key as u64.public;
	value as address.public;


mapping entry_count:
	key as u64.public;
	value as u64.public;


mapping winner:
	key as address.public;
	value as u32.public;


mapping test_cha:
	key as u64.public;
	value as u64.public;

function set_prize:
    input r0 as address.private;
    input r1 as u64.private;
    input r2 as u64.private;
    input r3 as u64.private;
    input r4 as field.private;
    cast r0 r1 r2 r3 r4 into r5 as GiveawayAccount.record;
    cast aleo1fan3jt83xvs5m4pqppmeghv4ypsan5aq4clwt4hnfv8pq90evqqq4dj6p6 r0 r1 r2 r3 r4 into r6 as AuditGiveawayAccount.record;
    output r5 as GiveawayAccount.record;
    output r6 as AuditGiveawayAccount.record;


function add_raffle_entry:
    input r0 as address.public;
    async add_raffle_entry r0 into r1;
    output r1 as puzz_usdc_giveaway_v002.aleo/add_raffle_entry.future;

finalize add_raffle_entry:
    input r0 as address.public;
    get.or_use entry_count[0u64] 0u64 into r1;
    add r1 1u64 into r2;
    set r2 into entry_count[0u64];
    set r0 into entry_index[r1];


function add_five_raffle_entries:
    input r0 as address.public;
    async add_five_raffle_entries r0 into r1;
    output r1 as puzz_usdc_giveaway_v002.aleo/add_five_raffle_entries.future;

finalize add_five_raffle_entries:
    input r0 as address.public;
    get.or_use entry_count[0u64] 0u64 into r1;
    add r1 1u64 into r2;
    set r2 into entry_count[0u64];
    set r0 into entry_index[r1];
    get entry_count[0u64] into r3;
    add r3 1u64 into r4;
    set r4 into entry_count[0u64];
    set r0 into entry_index[r3];
    get entry_count[0u64] into r5;
    add r5 1u64 into r6;
    set r6 into entry_count[0u64];
    set r0 into entry_index[r5];
    get entry_count[0u64] into r7;
    add r7 1u64 into r8;
    set r8 into entry_count[0u64];
    set r0 into entry_index[r7];
    get entry_count[0u64] into r9;
    add r9 1u64 into r10;
    set r10 into entry_count[0u64];
    set r0 into entry_index[r9];


function add_eight_raffle_entries:
    input r0 as address.public;
    async add_eight_raffle_entries r0 into r1;
    output r1 as puzz_usdc_giveaway_v002.aleo/add_eight_raffle_entries.future;

finalize add_eight_raffle_entries:
    input r0 as address.public;
    get.or_use entry_count[0u64] 0u64 into r1;
    add r1 1u64 into r2;
    set r2 into entry_count[0u64];
    set r0 into entry_index[r1];
    get entry_count[0u64] into r3;
    add r3 1u64 into r4;
    set r4 into entry_count[0u64];
    set r0 into entry_index[r3];
    get entry_count[0u64] into r5;
    add r5 1u64 into r6;
    set r6 into entry_count[0u64];
    set r0 into entry_index[r5];
    get entry_count[0u64] into r7;
    add r7 1u64 into r8;
    set r8 into entry_count[0u64];
    set r0 into entry_index[r7];
    get entry_count[0u64] into r9;
    add r9 1u64 into r10;
    set r10 into entry_count[0u64];
    set r0 into entry_index[r9];
    get entry_count[0u64] into r11;
    add r11 1u64 into r12;
    set r12 into entry_count[0u64];
    set r0 into entry_index[r11];
    get entry_count[0u64] into r13;
    add r13 1u64 into r14;
    set r14 into entry_count[0u64];
    set r0 into entry_index[r13];
    get entry_count[0u64] into r15;
    add r15 1u64 into r16;
    set r16 into entry_count[0u64];
    set r0 into entry_index[r15];


function determine_raffle_winner:
    async determine_raffle_winner into r0;
    output r0 as puzz_usdc_giveaway_v002.aleo/determine_raffle_winner.future;

finalize determine_raffle_winner:
    get entry_count[0u64] into r0;
    rand.chacha into r1 as u64;
    rem r1 r0 into r2;
    get entry_index[r2] into r3;
    set block.height into winner[r3];


function test_cha_cha:
    input r0 as u64.public;
    async test_cha_cha r0 into r1;
    output r1 as puzz_usdc_giveaway_v002.aleo/test_cha_cha.future;

finalize test_cha_cha:
    input r0 as u64.public;
    rand.chacha into r1 as u64;
    rem r1 r0 into r2;
    set r2 into test_cha[0u64];


function send_prize_to_winner:
    input r0 as address.public;
    input r1 as GiveawayAccount.record;
    cast r0 r1.amount r1.asset_type r1.date r1.private_key into r2 as GiveawayAccount.record;
    cast aleo1fan3jt83xvs5m4pqppmeghv4ypsan5aq4clwt4hnfv8pq90evqqq4dj6p6 r0 r1.amount r1.asset_type r1.date r1.private_key into r3 as AuditGiveawayAccount.record;
    output r2 as GiveawayAccount.record;
    output r3 as AuditGiveawayAccount.record;

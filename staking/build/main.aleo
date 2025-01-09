import credits.aleo;
program puzzle_staking_k1.aleo;

struct bond_state:
    validator as address;
    microcredits as u64;

struct unbond_state:
    microcredits as u64;
    height as u32;

struct withdrawal_state:
    microcredits as u64;
    claim_block as u32;

mapping is_initialized:
    key as u8.public;
    value as boolean.public;

mapping commission_percent:
    key as u8.public;
    value as u128.public;

mapping validator:
    key as u8.public;
    value as address.public;

mapping total_balance:
    key as u8.public;
    value as u64.public;

mapping pending_deposits:
    key as u8.public;
    value as u64.public;

mapping total_shares:
    key as u8.public;
    value as u64.public;

mapping delegator_shares:
    key as address.public;
    value as u64.public;

mapping pending_withdrawal:
    key as u8.public;
    value as u64.public;

mapping current_batch_height:
    key as u8.public;
    value as u32.public;

mapping withdrawals:
    key as address.public;
    value as withdrawal_state.public;

mapping batch_totals:
    key as u32.public;
    value as u64.public;

function initialize:
    input r0 as u128.public;
    input r1 as address.public;
    assert.eq self.caller aleo1f7zquf7ax3u0gprx6vek9ww9hhz36kgwjkuujq3stxfqc8n9nq8qq4y8ng;
    lt r0 1_000_000u128 into r2;
    assert.eq r2 true;
    lte r0 500u128 into r3;
    assert.eq r3 true;
    assert.neq r1 puzzle_staking_k1.aleo;
    async initialize r0 r1 into r4;
    output r4 as puzzle_staking_k1.aleo/initialize.future;

finalize initialize:
    input r0 as u128.public;
    input r1 as address.public;
    get.or_use is_initialized[0u8] false into r2;
    assert.eq r2 false;
    set true into is_initialized[0u8];
    set r0 into commission_percent[0u8];
    set r1 into validator[0u8];
    set 0u64 into total_shares[0u8];
    set 0u64 into total_balance[0u8];
    set 0u64 into pending_deposits[0u8];
    set 0u64 into pending_withdrawal[0u8];
    set 0u64 into pending_withdrawal[1u8];
    set 0u32 into current_batch_height[0u8];

function initial_deposit:
    input r0 as u64.public;
    assert.eq self.caller aleo1f7zquf7ax3u0gprx6vek9ww9hhz36kgwjkuujq3stxfqc8n9nq8qq4y8ng;
    gte r0 10_000_000_000u64 into r1;
    assert.eq r1 true;
    call credits.aleo/transfer_public_as_signer puzzle_staking_k1.aleo r0 into r2;
    call credits.aleo/bond_public aleo1zdzzxfrhgzlhh89vqpf4384ewqs0g32wqzvdeltzlynq25hkju8s38953f puzzle_staking_k1.aleo r0 into r3;
    async initial_deposit r2 r3 r0 into r4;
    output r4 as puzzle_staking_k1.aleo/initial_deposit.future;

finalize initial_deposit:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as credits.aleo/bond_public.future;
    input r2 as u64.public;
    await r0;
    await r1;
    get is_initialized[0u8] into r3;
    assert.eq r3 true;
    get.or_use total_balance[0u8] 0u64 into r4;
    get.or_use total_shares[0u8] 0u64 into r5;
    assert.eq r4 0u64;
    assert.eq r5 0u64;
    set r2 into total_balance[0u8];
    mul r2 1_000_000u64 into r6;
    set r6 into total_shares[0u8];
    set r6 into delegator_shares[aleo1f7zquf7ax3u0gprx6vek9ww9hhz36kgwjkuujq3stxfqc8n9nq8qq4y8ng];

function deposit_public:
    input r0 as u64.public;
    call credits.aleo/transfer_public_as_signer puzzle_staking_k1.aleo r0 into r1;
    async deposit_public r1 self.caller r0 into r2;
    output r2 as puzzle_staking_k1.aleo/deposit_public.future;

finalize deposit_public:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as address.public;
    input r2 as u64.public;
    await r0;
    cast puzzle_staking_k1.aleo 0u64 into r3 as bond_state;
    get.or_use total_balance[0u8] 0u64 into r4;
    get.or_use total_shares[0u8] 0u64 into r5;
    get.or_use pending_deposits[0u8] 0u64 into r6;
    cast r4 into r7 as u128;
    cast r6 into r8 as u128;
    add r7 r8 into r9;
    cast r5 into r10 as u128;
    cast r2 into r11 as u128;
    add r9 r11 into r12;
    mul r10 r12 into r13;
    div r13 r9 into r14;
    cast r5 into r15 as u128;
    sub r14 r15 into r16;
    cast r16 into r17 as u64;
    is.eq r17 0u64 into r18;
    gt r2 0u64 into r19;
    and r18 r19 into r20;
    ternary r20 1u64 r17 into r21;
    get.or_use delegator_shares[r1] 0u64 into r22;
    add r22 r21 into r23;
    set r23 into delegator_shares[r1];
    add r5 r21 into r24;
    set r24 into total_shares[0u8];
    add r6 r2 into r25;
    set r25 into pending_deposits[0u8];

function bond_deposits:
    input r0 as u64.public;
    call credits.aleo/bond_public aleo1zdzzxfrhgzlhh89vqpf4384ewqs0g32wqzvdeltzlynq25hkju8s38953f puzzle_staking_k1.aleo r0 into r1;
    async bond_deposits r1 r0 into r2;
    output r2 as puzzle_staking_k1.aleo/bond_deposits.future;

finalize bond_deposits:
    input r0 as credits.aleo/bond_public.future;
    input r1 as u64.public;
    await r0;
    gt r1 0u64 into r2;
    assert.eq r2 true;
    get.or_use credits.aleo/account[puzzle_staking_k1.aleo] 0u64 into r3;
    get pending_withdrawal[0u8] into r4;
    get pending_deposits[0u8] into r5;
    gte r3 r4 into r6;
    assert.eq r6 true;
    gt r5 0u64 into r7;
    assert.eq r7 true;
    lte r1 r5 into r8;
    assert.eq r8 true;
    get total_balance[0u8] into r9;
    add r9 r1 into r10;
    set r10 into total_balance[0u8];
    sub r5 r1 into r11;
    set r11 into pending_deposits[0u8];

function bond_all:
    input r0 as u64.public;
    call credits.aleo/bond_public aleo1zdzzxfrhgzlhh89vqpf4384ewqs0g32wqzvdeltzlynq25hkju8s38953f puzzle_staking_k1.aleo r0 into r1;
    async bond_all r1 r0 into r2;
    output r2 as puzzle_staking_k1.aleo/bond_all.future;

finalize bond_all:
    input r0 as credits.aleo/bond_public.future;
    input r1 as u64.public;
    await r0;
    gt r1 0u64 into r2;
    assert.eq r2 true;
    get pending_deposits[0u8] into r3;
    gt r3 0u64 into r4;
    assert.eq r4 true;
    lte r1 r3 into r5;
    assert.eq r5 true;
    get total_balance[0u8] into r6;
    add r6 r3 into r7;
    set r7 into total_balance[0u8];
    sub r3 r1 into r8;
    set r8 into pending_deposits[0u8];

function withdraw_public:
    input r0 as u64.public;
    input r1 as u64.public;
    gt r0 0u64 into r2;
    assert.eq r2 true;
    gt r1 0u64 into r3;
    assert.eq r3 true;
    call credits.aleo/unbond_public puzzle_staking_k1.aleo r1 into r4;
    async withdraw_public r4 r0 r1 self.caller into r5;
    output r5 as puzzle_staking_k1.aleo/withdraw_public.future;

finalize withdraw_public:
    input r0 as credits.aleo/unbond_public.future;
    input r1 as u64.public;
    input r2 as u64.public;
    input r3 as address.public;
    await r0;
    contains withdrawals[r3] into r4;
    assert.eq r4 false;
    get.or_use current_batch_height[0u8] 0u32 into r5;
    add block.height 360u32 into r6;
    is.eq r5 0u32 into r7;
    gte r5 r6 into r8;
    or r7 r8 into r9;
    assert.eq r9 true;
    get.or_use total_balance[0u8] 0u64 into r10;
    get.or_use pending_deposits[0u8] 0u64 into r11;
    get.or_use total_shares[0u8] 0u64 into r12;
    get.or_use delegator_shares[r3] 0u64 into r13;
    gte r13 r1 into r14;
    assert.eq r14 true;
    gte r12 r1 into r15;
    assert.eq r15 true;
    cast 0u64 0u32 into r16 as unbond_state;
    get.or_use credits.aleo/unbonding[puzzle_staking_k1.aleo] r16 into r17;
    get pending_withdrawal[0u8] into r18;
    sub r17.microcredits r18 into r19;
    sub r19 r2 into r20;
    add r20 r11 into r21;
    gte r21 10_000_000_000u64 into r22;
    cast puzzle_staking_k1.aleo 0u64 into r23 as bond_state;
    get.or_use credits.aleo/bonded[puzzle_staking_k1.aleo] r23 into r24;
    gte r24.microcredits 10_000_000_000u64 into r25;
    not r22 into r26;
    or r25 r26 into r27;
    assert.eq r27 true;
    add r24.microcredits r19 into r28;
    cast r10 into r29 as u128;
    cast r11 into r30 as u128;
    add r29 r30 into r31;
    cast r28 into r32 as i64;
    cast r31 into r33 as i64;
    sub r32 r33 into r34;
    gt r34 0i64 into r35;
    ternary r35 r34 0i64 into r36;
    get commission_percent[0u8] into r37;
    cast r36 into r38 as u64;
    gt r38 0u64 into r39;
    cast r36 into r40 as u128;
    mul r40 r37 into r41;
    div r41 1_000_000u128 into r42;
    cast r42 into r43 as u64;
    ternary r39 r43 0u64 into r44;
    cast r36 into r45 as u64;
    sub r45 r44 into r46;
    cast r31 into r47 as u64;
    add r47 r46 into r48;
    add r48 r44 into r49;
    cast r1 into r50 as u128;
    cast r49 into r51 as u128;
    mul r50 r51 into r52;
    mul r52 1_000_000u128 into r53;
    cast r12 into r54 as u128;
    div r53 r54 into r55;
    div r55 1_000_000u128 into r56;
    cast r1 into r57 as u128;
    cast r49 into r58 as u128;
    mul r57 r58 into r59;
    cast r12 into r60 as u128;
    cast 1_000_000u64 into r61 as u128;
    mul r60 r61 into r62;
    div r59 r62 into r63;
    gt r63 0u128 into r64;
    ternary r64 r63 1u128 into r65;
    cast r2 into r66 as u128;
    gte r56 r66 into r67;
    assert.eq r67 true;
    cast r2 into r68 as u128;
    gte r68 r65 into r69;
    assert.eq r69 true;
    add r5 1u32 into r70;
    mul r70 5u32 into r71;
    sub r13 r1 into r72;
    set r72 into delegator_shares[r3];
    sub r12 r1 into r73;
    set r73 into total_shares[0u8];
    sub r10 r2 into r74;
    set r74 into total_balance[0u8];
    cast r2 r71 into r75 as withdrawal_state;
    set r75 into withdrawals[r3];
    get.or_use batch_totals[r70] 0u64 into r76;
    add r76 r2 into r77;
    set r77 into batch_totals[r70];
    get.or_use pending_withdrawal[0u8] 0u64 into r78;
    add r78 r2 into r79;
    set r79 into pending_withdrawal[0u8];

function claim_unbond:
    call credits.aleo/claim_unbond_public puzzle_staking_k1.aleo into r0;
    async claim_unbond r0 into r1;
    output r1 as puzzle_staking_k1.aleo/claim_unbond.future;

finalize claim_unbond:
    input r0 as credits.aleo/claim_unbond_public.future;
    await r0;
    get pending_withdrawal[0u8] into r1;
    get pending_withdrawal[1u8] into r2;
    set 0u64 into pending_withdrawal[0u8];
    add r2 r1 into r3;
    set r3 into pending_withdrawal[1u8];

function claim_withdrawal:
    input r0 as u64.public;
    gt r0 0u64 into r1;
    assert.eq r1 true;
    call credits.aleo/transfer_public self.caller r0 into r2;
    async claim_withdrawal r2 self.caller r0 into r3;
    output r3 as puzzle_staking_k1.aleo/claim_withdrawal.future;

finalize claim_withdrawal:
    input r0 as credits.aleo/transfer_public.future;
    input r1 as address.public;
    input r2 as u64.public;
    await r0;
    contains withdrawals[r1] into r3;
    assert.eq r3 true;
    get withdrawals[r1] into r4;
    div block.height 5u32 into r5;
    gte block.height r4.claim_block into r6;
    assert.eq r6 true;
    assert.eq r4.microcredits r2;
    get pending_withdrawal[1u8] into r7;
    gte r7 r2 into r8;
    assert.eq r8 true;
    sub r7 r2 into r9;
    set r9 into pending_withdrawal[1u8];
    remove withdrawals[r1];

function forced_unbond_withdraw:
    input r0 as u64.public;
    input r1 as u64.public;
    call credits.aleo/transfer_public self.caller r1 into r2;
    async forced_unbond_withdraw r2 r0 r1 self.caller into r3;
    output r3 as puzzle_staking_k1.aleo/forced_unbond_withdraw.future;

finalize forced_unbond_withdraw:
    input r0 as credits.aleo/transfer_public.future;
    input r1 as u64.public;
    input r2 as u64.public;
    input r3 as address.public;
    await r0;
    contains withdrawals[r3] into r4;
    assert.eq r4 false;
    cast puzzle_staking_k1.aleo 0u64 into r5 as bond_state;
    get.or_use credits.aleo/bonded[puzzle_staking_k1.aleo] r5 into r6;
    assert.eq r6.microcredits 0u64;
    get pending_deposits[0u8] into r7;
    get pending_withdrawal[0u8] into r8;
    assert.eq r7 0u64;
    assert.eq r8 0u64;
    get.or_use total_shares[0u8] 0u64 into r9;
    get.or_use delegator_shares[r3] 0u64 into r10;
    gte r10 r1 into r11;
    assert.eq r11 true;
    gte r9 r1 into r12;
    assert.eq r12 true;
    get total_balance[0u8] into r13;
    cast r1 into r14 as u128;
    cast r13 into r15 as u128;
    mul r14 r15 into r16;
    mul r16 1_000_000u128 into r17;
    cast r9 into r18 as u128;
    div r17 r18 into r19;
    div r19 1_000_000u128 into r20;
    cast r20 into r21 as u64;
    assert.eq r2 r21;
    sub r10 r1 into r22;
    set r22 into delegator_shares[r3];
    sub r9 r1 into r23;
    set r23 into total_shares[0u8];
    sub r13 r2 into r24;
    set r24 into total_balance[0u8];

function get_commission_test:
    input r0 as u128.private;
    input r1 as u128.private;
    mul r0 r1 into r2;
    div r2 1_000_000u128 into r3;
    cast r3 into r4 as u64;
    output r4 as u64.private;

function set_commission_percent:
    input r0 as u128.public;
    assert.eq self.caller aleo1f7zquf7ax3u0gprx6vek9ww9hhz36kgwjkuujq3stxfqc8n9nq8qq4y8ng;
    lt r0 1_000_000u128 into r1;
    assert.eq r1 true;
    lte r0 500u128 into r2;
    assert.eq r2 true;
    async set_commission_percent r0 into r3;
    output r3 as puzzle_staking_k1.aleo/set_commission_percent.future;

finalize set_commission_percent:
    input r0 as u128.public;
    get.or_use total_balance[0u8] 0u64 into r1;
    get.or_use total_shares[0u8] 0u64 into r2;
    get.or_use delegator_shares[aleo1f7zquf7ax3u0gprx6vek9ww9hhz36kgwjkuujq3stxfqc8n9nq8qq4y8ng] 0u64 into r3;
    cast puzzle_staking_k1.aleo 0u64 into r4 as bond_state;
    get.or_use credits.aleo/bonded[puzzle_staking_k1.aleo] r4 into r5;
    cast r5.microcredits into r6 as i64;
    cast r1 into r7 as i64;
    sub r6 r7 into r8;
    gt r8 0i64 into r9;
    cast r8 into r10 as u64;
    ternary r9 r10 0u64 into r11;
    get commission_percent[0u8] into r12;
    cast r11 into r13 as u128;
    mul r13 r12 into r14;
    div r14 1_000_000u128 into r15;
    cast r15 into r16 as u64;
    sub r11 r16 into r17;
    add r1 r17 into r18;
    cast r16 into r19 as u128;
    cast r2 into r20 as u128;
    mul r19 r20 into r21;
    mul r21 1_000_000u128 into r22;
    cast r18 into r23 as u128;
    div r22 r23 into r24;
    div r24 1_000_000u128 into r25;
    cast r25 into r26 as u64;
    is.eq r26 0u64 into r27;
    gt r16 0u64 into r28;
    and r27 r28 into r29;
    ternary r29 1u64 r26 into r30;
    add r3 r30 into r31;
    set r31 into delegator_shares[aleo1f7zquf7ax3u0gprx6vek9ww9hhz36kgwjkuujq3stxfqc8n9nq8qq4y8ng];
    add r2 r30 into r32;
    set r32 into total_shares[0u8];
    add r18 r16 into r33;
    set r33 into total_balance[0u8];
    set r0 into commission_percent[0u8];

function claim_commission:
    assert.eq self.caller aleo1f7zquf7ax3u0gprx6vek9ww9hhz36kgwjkuujq3stxfqc8n9nq8qq4y8ng;
    async claim_commission into r0;
    output r0 as puzzle_staking_k1.aleo/claim_commission.future;

finalize claim_commission:
    get.or_use total_balance[0u8] 0u64 into r0;
    get.or_use total_shares[0u8] 0u64 into r1;
    get.or_use delegator_shares[aleo1f7zquf7ax3u0gprx6vek9ww9hhz36kgwjkuujq3stxfqc8n9nq8qq4y8ng] 0u64 into r2;
    cast puzzle_staking_k1.aleo 0u64 into r3 as bond_state;
    get.or_use credits.aleo/bonded[puzzle_staking_k1.aleo] r3 into r4;
    cast r4.microcredits into r5 as i64;
    cast r0 into r6 as i64;
    sub r5 r6 into r7;
    gt r7 0i64 into r8;
    cast r7 into r9 as u64;
    ternary r8 r9 0u64 into r10;
    get commission_percent[0u8] into r11;
    cast r10 into r12 as u128;
    mul r12 r11 into r13;
    div r13 1_000_000u128 into r14;
    cast r14 into r15 as u64;
    sub r10 r15 into r16;
    add r0 r16 into r17;
    cast r15 into r18 as u128;
    cast r1 into r19 as u128;
    mul r18 r19 into r20;
    mul r20 1_000_000u128 into r21;
    cast r17 into r22 as u128;
    div r21 r22 into r23;
    div r23 1_000_000u128 into r24;
    cast r24 into r25 as u64;
    is.eq r25 0u64 into r26;
    gt r15 0u64 into r27;
    and r26 r27 into r28;
    ternary r28 1u64 r25 into r29;
    add r2 r29 into r30;
    set r30 into delegator_shares[aleo1f7zquf7ax3u0gprx6vek9ww9hhz36kgwjkuujq3stxfqc8n9nq8qq4y8ng];
    add r1 r29 into r31;
    set r31 into total_shares[0u8];
    add r17 r15 into r32;
    set r32 into total_balance[0u8];

function get_new_batch_height_test:
    input r0 as u32.private;
    add r0 1_000u32 into r1;
    output r1 as u32.private;

function create_withdraw_claim:
    input r0 as u64.public;
    async create_withdraw_claim r0 self.caller into r1;
    output r1 as puzzle_staking_k1.aleo/create_withdraw_claim.future;

finalize create_withdraw_claim:
    input r0 as u64.public;
    input r1 as address.public;
    contains withdrawals[r1] into r2;
    assert.eq r2 false;
    get.or_use total_balance[0u8] 0u64 into r3;
    get.or_use total_shares[0u8] 0u64 into r4;
    get.or_use delegator_shares[r1] 0u64 into r5;
    gte r5 r0 into r6;
    assert.eq r6 true;
    cast puzzle_staking_k1.aleo 0u64 into r7 as bond_state;
    get.or_use credits.aleo/bonded[puzzle_staking_k1.aleo] r7 into r8;
    cast r8.microcredits into r9 as i64;
    cast r3 into r10 as i64;
    sub r9 r10 into r11;
    gt r11 0i64 into r12;
    cast r11 into r13 as u64;
    ternary r12 r13 0u64 into r14;
    get commission_percent[0u8] into r15;
    cast r14 into r16 as u128;
    mul r16 r15 into r17;
    div r17 1_000_000u128 into r18;
    cast r18 into r19 as u64;
    sub r14 r19 into r20;
    add r3 r20 into r21;
    add r21 r19 into r22;
    cast r0 into r23 as u128;
    cast r22 into r24 as u128;
    mul r23 r24 into r25;
    mul r25 1_000_000u128 into r26;
    cast r4 into r27 as u128;
    div r26 r27 into r28;
    div r28 1_000_000u128 into r29;
    cast r29 into r30 as u64;
    sub r5 r0 into r31;
    set r31 into delegator_shares[r1];
    sub r4 r0 into r32;
    set r32 into total_shares[0u8];
    sub r22 r30 into r33;
    set r33 into total_balance[0u8];
    add block.height 360u32 into r34;
    cast r30 r34 into r35 as withdrawal_state;
    set r35 into withdrawals[r1];
    get.or_use pending_withdrawal[1u8] 0u64 into r36;
    add r36 r30 into r37;
    set r37 into pending_withdrawal[1u8];

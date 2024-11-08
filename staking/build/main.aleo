import credits.aleo;
program puzzle_staking_w2.aleo;

struct bond_state:
    validator as address;
    microcredits as u64;


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
    lt r0 1_000u128 into r2;
    assert.eq r2 true;
    lte r0 500u128 into r3;
    assert.eq r3 true;
    assert.neq r1 puzzle_staking_w2.aleo;
    async initialize r0 r1 into r4;
    output r4 as puzzle_staking_w2.aleo/initialize.future;

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
    call credits.aleo/transfer_public_as_signer puzzle_staking_w2.aleo r0 into r2;
    call credits.aleo/bond_public aleo1zdzzxfrhgzlhh89vqpf4384ewqs0g32wqzvdeltzlynq25hkju8s38953f puzzle_staking_w2.aleo r0 into r3;
    async initial_deposit r2 r3 r0 into r4;
    output r4 as puzzle_staking_w2.aleo/initial_deposit.future;

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
    mul r2 1_000u64 into r6;
    set r6 into total_shares[0u8];
    set r6 into delegator_shares[aleo1f7zquf7ax3u0gprx6vek9ww9hhz36kgwjkuujq3stxfqc8n9nq8qq4y8ng];






function deposit_public:
    input r0 as u64.public;
    call credits.aleo/transfer_public_as_signer puzzle_staking_w2.aleo r0 into r1;
    async deposit_public r1 self.caller r0 into r2;
    output r2 as puzzle_staking_w2.aleo/deposit_public.future;

finalize deposit_public:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as address.public;
    input r2 as u64.public;
    await r0;
    cast puzzle_staking_w2.aleo 0u64 into r3 as bond_state;
    get.or_use credits.aleo/bonded[puzzle_staking_w2.aleo] r3 into r4;
    get.or_use total_balance[0u8] 0u64 into r5;
    get.or_use total_shares[0u8] 0u64 into r6;
    get.or_use pending_deposits[0u8] 0u64 into r7;
    cast r5 into r8 as u128;
    cast r7 into r9 as u128;
    add r8 r9 into r10;
    cast r2 into r11 as u128;
    cast r6 into r12 as u128;
    is.eq r12 0u128 into r13;
    cast 1_000u64 into r14 as u128;
    mul r11 r14 into r15;
    mul r11 r12 into r16;
    div r16 r10 into r17;
    ternary r13 r15 r17 into r18;
    is.eq r18 0u128 into r19;
    gt r11 0u128 into r20;
    and r19 r20 into r21;
    cast r18 into r22 as u64;
    ternary r21 1u64 r22 into r23;
    gt r23 0u64 into r24;
    is.eq r2 0u64 into r25;
    or r24 r25 into r26;
    assert.eq r26 true;
    is.eq r23 0u64 into r27;
    gt r2 0u64 into r28;
    and r27 r28 into r29;
    ternary r29 1u64 r23 into r30;
    get.or_use delegator_shares[r1] 0u64 into r31;
    add r31 r30 into r32;
    set r32 into delegator_shares[r1];
    add r6 r30 into r33;
    set r33 into total_shares[0u8];
    add r7 r2 into r34;
    set r34 into pending_deposits[0u8];




function bond_deposits:
    input r0 as u64.public;
    call credits.aleo/bond_public aleo1zdzzxfrhgzlhh89vqpf4384ewqs0g32wqzvdeltzlynq25hkju8s38953f puzzle_staking_w2.aleo r0 into r1;
    async bond_deposits r1 r0 into r2;
    output r2 as puzzle_staking_w2.aleo/bond_deposits.future;

finalize bond_deposits:
    input r0 as credits.aleo/bond_public.future;
    input r1 as u64.public;
    await r0;
    get.or_use credits.aleo/account[puzzle_staking_w2.aleo] 0u64 into r2;
    get pending_withdrawal[0u8] into r3;
    get pending_deposits[0u8] into r4;
    gte r2 r3 into r5;
    assert.eq r5 true;
    gt r4 0u64 into r6;
    assert.eq r6 true;
    get total_balance[0u8] into r7;
    add r7 r1 into r8;
    set r8 into total_balance[0u8];
    sub r4 r1 into r9;
    set r9 into pending_deposits[0u8];




function bond_all:
    input r0 as u64.public;
    call credits.aleo/bond_public aleo1zdzzxfrhgzlhh89vqpf4384ewqs0g32wqzvdeltzlynq25hkju8s38953f puzzle_staking_w2.aleo r0 into r1;
    async bond_all r1 r0 into r2;
    output r2 as puzzle_staking_w2.aleo/bond_all.future;

finalize bond_all:
    input r0 as credits.aleo/bond_public.future;
    input r1 as u64.public;
    await r0;
    get pending_deposits[0u8] into r2;
    gt r2 0u64 into r3;
    assert.eq r3 true;
    get total_balance[0u8] into r4;
    add r4 r2 into r5;
    set r5 into total_balance[0u8];
    sub r2 r1 into r6;
    set r6 into pending_deposits[0u8];




function emergency_withdraw:
    input r0 as u64.private;
    call credits.aleo/transfer_public aleo1f7zquf7ax3u0gprx6vek9ww9hhz36kgwjkuujq3stxfqc8n9nq8qq4y8ng r0 into r1;
    async emergency_withdraw r1 into r2;
    output r2 as puzzle_staking_w2.aleo/emergency_withdraw.future;

finalize emergency_withdraw:
    input r0 as credits.aleo/transfer_public.future;
    await r0;






function withdraw_public:
    input r0 as u64.public;
    input r1 as u64.public;
    gt r0 0u64 into r2;
    assert.eq r2 true;
    gt r1 0u64 into r3;
    assert.eq r3 true;
    call credits.aleo/unbond_public puzzle_staking_w2.aleo r1 into r4;
    async withdraw_public r4 r0 r1 self.caller into r5;
    output r5 as puzzle_staking_w2.aleo/withdraw_public.future;

finalize withdraw_public:
    input r0 as credits.aleo/unbond_public.future;
    input r1 as u64.public;
    input r2 as u64.public;
    input r3 as address.public;
    await r0;
    contains withdrawals[r3] into r4;
    assert.eq r4 false;
    get.or_use total_balance[0u8] 0u64 into r5;
    get.or_use total_shares[0u8] 0u64 into r6;
    get.or_use delegator_shares[r3] 0u64 into r7;
    gte r7 r1 into r8;
    assert.eq r8 true;
    gte r6 r1 into r9;
    assert.eq r9 true;
    cast puzzle_staking_w2.aleo 0u64 into r10 as bond_state;
    get.or_use credits.aleo/bonded[puzzle_staking_w2.aleo] r10 into r11;
    cast r11.microcredits into r12 as i64;
    cast r5 into r13 as i64;
    sub r12 r13 into r14;
    gt r14 0i64 into r15;
    ternary r15 r14 0i64 into r16;
    get commission_percent[0u8] into r17;
    cast r16 into r18 as u64;
    gt r18 0u64 into r19;
    cast r16 into r20 as u128;
    mul r20 r17 into r21;
    div r21 1_000u128 into r22;
    cast r22 into r23 as u64;
    ternary r19 r23 0u64 into r24;
    cast r16 into r25 as u64;
    sub r25 r24 into r26;
    add r5 r26 into r27;
    add r27 r24 into r28;
    cast r1 into r29 as u128;
    cast r28 into r30 as u128;
    mul r29 r30 into r31;
    mul r31 1_000_000u128 into r32;
    cast r6 into r33 as u128;
    div r32 r33 into r34;
    div r34 1_000_000u128 into r35;
    cast r1 into r36 as u128;
    cast r28 into r37 as u128;
    mul r36 r37 into r38;
    cast r6 into r39 as u128;
    cast 1_000u64 into r40 as u128;
    mul r39 r40 into r41;
    div r38 r41 into r42;
    gt r42 0u128 into r43;
    ternary r43 r42 1u128 into r44;
    cast r2 into r45 as u128;
    gte r35 r45 into r46;
    assert.eq r46 true;
    cast r2 into r47 as u128;
    gte r47 r44 into r48;
    assert.eq r48 true;
    div block.height 5u32 into r49;
    add r49 1u32 into r50;
    mul r50 5u32 into r51;
    sub r7 r1 into r52;
    set r52 into delegator_shares[r3];
    sub r6 r1 into r53;
    set r53 into total_shares[0u8];
    sub r28 r2 into r54;
    set r54 into total_balance[0u8];
    cast r2 r51 into r55 as withdrawal_state;
    set r55 into withdrawals[r3];
    get.or_use batch_totals[r50] 0u64 into r56;
    add r56 r2 into r57;
    set r57 into batch_totals[r50];
    get.or_use pending_withdrawal[0u8] 0u64 into r58;
    add r58 r2 into r59;
    set r59 into pending_withdrawal[0u8];




function claim_unbond:
    call credits.aleo/claim_unbond_public puzzle_staking_w2.aleo into r0;
    async claim_unbond r0 into r1;
    output r1 as puzzle_staking_w2.aleo/claim_unbond.future;

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
    output r3 as puzzle_staking_w2.aleo/claim_withdrawal.future;

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



function get_commission_test:
    input r0 as u128.private;
    input r1 as u128.private;
    mul r0 r1 into r2;
    div r2 1_000u128 into r3;
    cast r3 into r4 as u64;
    output r4 as u64.private;




function calculate_new_shares_test:
    input r0 as u128.private;
    input r1 as u128.private;
    input r2 as u128.private;
    input r3 as u128.private;
    add r0 r1 into r4;
    add r4 r2 into r5;
    mul r3 r5 into r6;
    div r6 r4 into r7;
    sub r7 r3 into r8;
    cast r8 into r9 as u64;
    output r9 as u64.private;



function set_commission_percent:
    input r0 as u128.public;
    assert.eq self.caller aleo1f7zquf7ax3u0gprx6vek9ww9hhz36kgwjkuujq3stxfqc8n9nq8qq4y8ng;
    lt r0 1_000u128 into r1;
    assert.eq r1 true;
    lte r0 500u128 into r2;
    assert.eq r2 true;
    async set_commission_percent r0 into r3;
    output r3 as puzzle_staking_w2.aleo/set_commission_percent.future;

finalize set_commission_percent:
    input r0 as u128.public;
    get.or_use total_balance[0u8] 0u64 into r1;
    get.or_use total_shares[0u8] 0u64 into r2;
    get.or_use delegator_shares[aleo1f7zquf7ax3u0gprx6vek9ww9hhz36kgwjkuujq3stxfqc8n9nq8qq4y8ng] 0u64 into r3;
    cast puzzle_staking_w2.aleo 0u64 into r4 as bond_state;
    get.or_use credits.aleo/bonded[puzzle_staking_w2.aleo] r4 into r5;
    cast r5.microcredits into r6 as i64;
    cast r1 into r7 as i64;
    sub r6 r7 into r8;
    gt r8 0i64 into r9;
    cast r8 into r10 as u64;
    ternary r9 r10 0u64 into r11;
    get commission_percent[0u8] into r12;
    cast r11 into r13 as u128;
    mul r13 r12 into r14;
    div r14 1_000u128 into r15;
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




function set_next_validator:
    input r0 as address.public;
    assert.eq self.caller aleo1f7zquf7ax3u0gprx6vek9ww9hhz36kgwjkuujq3stxfqc8n9nq8qq4y8ng;
    assert.neq r0 puzzle_staking_w2.aleo;
    async set_next_validator r0 into r1;
    output r1 as puzzle_staking_w2.aleo/set_next_validator.future;

finalize set_next_validator:
    input r0 as address.public;
    set r0 into validator[1u8];




function claim_commission:
    assert.eq self.caller aleo1f7zquf7ax3u0gprx6vek9ww9hhz36kgwjkuujq3stxfqc8n9nq8qq4y8ng;
    async claim_commission into r0;
    output r0 as puzzle_staking_w2.aleo/claim_commission.future;

finalize claim_commission:
    get.or_use total_balance[0u8] 0u64 into r0;
    get.or_use total_shares[0u8] 0u64 into r1;
    get.or_use delegator_shares[aleo1f7zquf7ax3u0gprx6vek9ww9hhz36kgwjkuujq3stxfqc8n9nq8qq4y8ng] 0u64 into r2;
    cast puzzle_staking_w2.aleo 0u64 into r3 as bond_state;
    get.or_use credits.aleo/bonded[puzzle_staking_w2.aleo] r3 into r4;
    cast r4.microcredits into r5 as i64;
    cast r0 into r6 as i64;
    sub r5 r6 into r7;
    gt r7 0i64 into r8;
    cast r7 into r9 as u64;
    ternary r8 r9 0u64 into r10;
    get commission_percent[0u8] into r11;
    cast r10 into r12 as u128;
    mul r12 r11 into r13;
    div r13 1_000u128 into r14;
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
    output r1 as puzzle_staking_w2.aleo/create_withdraw_claim.future;

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
    cast puzzle_staking_w2.aleo 0u64 into r7 as bond_state;
    get.or_use credits.aleo/bonded[puzzle_staking_w2.aleo] r7 into r8;
    cast r8.microcredits into r9 as i64;
    cast r3 into r10 as i64;
    sub r9 r10 into r11;
    gt r11 0i64 into r12;
    cast r11 into r13 as u64;
    ternary r12 r13 0u64 into r14;
    get commission_percent[0u8] into r15;
    cast r14 into r16 as u128;
    mul r16 r15 into r17;
    div r17 1_000u128 into r18;
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




import credits.aleo;
program puzzle_staking_v001.aleo;

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


function initialize:
    input r0 as u128.public;
    input r1 as address.public;
    assert.eq self.caller aleo1as9067txqeya80e720ge68pt9faj6ymy20drfr5a7stfntyk95rqmv9afs;
    lt r0 1_000u128 into r2;
    assert.eq r2 true;
    lte r0 500u128 into r3;
    assert.eq r3 true;
    assert.neq r1 puzzle_staking_v001.aleo;
    async initialize r0 r1 into r4;
    output r4 as puzzle_staking_v001.aleo/initialize.future;

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
    set 0u64 into pending_withdrawal[0u8];
    set 0u64 into pending_withdrawal[1u8];
    set 0u32 into current_batch_height[0u8];




function initial_deposit:
    input r0 as u64.public;
    assert.eq self.caller aleo1as9067txqeya80e720ge68pt9faj6ymy20drfr5a7stfntyk95rqmv9afs;
    call credits.aleo/transfer_public_as_signer puzzle_staking_v001.aleo r0 into r1;
    call credits.aleo/bond_public aleo1zdzzxfrhgzlhh89vqpf4384ewqs0g32wqzvdeltzlynq25hkju8s38953f puzzle_staking_v001.aleo r0 into r2;
    async initial_deposit r1 r2 r0 into r3;
    output r3 as puzzle_staking_v001.aleo/initial_deposit.future;

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
    set r6 into delegator_shares[aleo1as9067txqeya80e720ge68pt9faj6ymy20drfr5a7stfntyk95rqmv9afs];








function deposit_public:
    input r0 as u64.public;
    call credits.aleo/transfer_public_as_signer puzzle_staking_v001.aleo r0 into r1;
    call credits.aleo/bond_public aleo1zdzzxfrhgzlhh89vqpf4384ewqs0g32wqzvdeltzlynq25hkju8s38953f puzzle_staking_v001.aleo r0 into r2;
    async deposit_public r1 r2 self.caller r0 into r3;
    output r3 as puzzle_staking_v001.aleo/deposit_public.future;

finalize deposit_public:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as credits.aleo/bond_public.future;
    input r2 as address.public;
    input r3 as u64.public;
    await r0;
    await r1;
    cast puzzle_staking_v001.aleo 0u64 into r4 as bond_state;
    get.or_use credits.aleo/bonded[puzzle_staking_v001.aleo] r4 into r5;
    get.or_use total_balance[0u8] 0u64 into r6;
    get.or_use total_shares[0u8] 0u64 into r7;
    get.or_use delegator_shares[aleo1as9067txqeya80e720ge68pt9faj6ymy20drfr5a7stfntyk95rqmv9afs] 0u64 into r8;
    cast r5.microcredits into r9 as i64;
    cast r6 into r10 as i64;
    cast r3 into r11 as i64;
    add r10 r11 into r12;
    sub r9 r12 into r13;
    gt r13 0i64 into r14;
    cast r13 into r15 as u64;
    ternary r14 r15 0u64 into r16;
    get commission_percent[0u8] into r17;
    gt r16 0u64 into r18;
    cast r16 into r19 as u128;
    mul r19 r17 into r20;
    div r20 1_000u128 into r21;
    cast r21 into r22 as u64;
    ternary r18 r22 0u64 into r23;
    sub r16 r23 into r24;
    cast r6 into r25 as u128;
    cast r24 into r26 as u128;
    add r25 r26 into r27;
    gt r16 0u64 into r28;
    cast r23 into r29 as u128;
    cast r7 into r30 as u128;
    is.eq r30 0u128 into r31;
    cast r29 into r32 as u64;
    mul r29 r30 into r33;
    div r33 r27 into r34;
    cast r34 into r35 as u64;
    ternary r31 r32 r35 into r36;
    ternary r28 r36 0u64 into r37;
    add r8 r37 into r38;
    set r38 into delegator_shares[aleo1as9067txqeya80e720ge68pt9faj6ymy20drfr5a7stfntyk95rqmv9afs];
    add r7 r37 into r39;
    cast r27 into r40 as u64;
    add r40 r23 into r41;
    cast r41 into r42 as u128;
    cast r3 into r43 as u128;
    cast r39 into r44 as u128;
    is.eq r44 0u128 into r45;
    cast r43 into r46 as u64;
    mul r43 r44 into r47;
    div r47 r42 into r48;
    cast r48 into r49 as u64;
    ternary r45 r46 r49 into r50;
    gte r50 1u64 into r51;
    assert.eq r51 true;
    get.or_use delegator_shares[r2] 0u64 into r52;
    add r52 r50 into r53;
    set r53 into delegator_shares[r2];
    add r39 r50 into r54;
    set r54 into total_shares[0u8];
    add r41 r3 into r55;
    set r55 into total_balance[0u8];








function withdraw_public:
    input r0 as u64.public;
    input r1 as u64.public;
    call credits.aleo/unbond_public puzzle_staking_v001.aleo r1 into r2;
    async withdraw_public r2 r0 r1 self.caller into r3;
    output r3 as puzzle_staking_v001.aleo/withdraw_public.future;

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
    get delegator_shares[r3] into r10;
    gte r10 r1 into r11;
    assert.eq r11 true;
    cast 0u64 0u32 into r12 as unbond_state;
    get.or_use credits.aleo/unbonding[puzzle_staking_v001.aleo] r12 into r13;
    get pending_withdrawal[0u8] into r14;
    sub r13.microcredits r14 into r15;
    get pending_deposits[0u8] into r16;
    sub r15 r2 into r17;
    add r17 r16 into r18;
    gte r18 10_000_000_000u64 into r19;
    cast puzzle_staking_v001.aleo 0u64 into r20 as bond_state;
    get.or_use credits.aleo/bonded[puzzle_staking_v001.aleo] r20 into r21;
    gte r21.microcredits 10_000_000_000u64 into r22;
    not r19 into r23;
    or r22 r23 into r24;
    assert.eq r24 true;
    add r21.microcredits r15 into r25;
    get total_balance[0u8] into r26;
    get total_shares[0u8] into r27;
    gt r25 r26 into r28;
    cast r25 into r29 as i64;
    cast r26 into r30 as i64;
    sub r29 r30 into r31;
    ternary r28 r31 0i64 into r32;
    get commission_percent[0u8] into r33;
    cast r32 into r34 as u128;
    mul r34 r33 into r35;
    div r35 1_000u128 into r36;
    cast r36 into r37 as u64;
    cast r32 into r38 as u64;
    sub r38 r37 into r39;
    add r26 r39 into r40;
    cast r40 into r41 as u128;
    cast r16 into r42 as u128;
    cast r37 into r43 as u128;
    cast r27 into r44 as u128;
    add r41 r42 into r45;
    add r45 r43 into r46;
    mul r44 r46 into r47;
    div r47 r45 into r48;
    sub r48 r44 into r49;
    cast r49 into r50 as u64;
    get.or_use delegator_shares[aleo1as9067txqeya80e720ge68pt9faj6ymy20drfr5a7stfntyk95rqmv9afs] 0u64 into r51;
    add r51 r50 into r52;
    set r52 into delegator_shares[aleo1as9067txqeya80e720ge68pt9faj6ymy20drfr5a7stfntyk95rqmv9afs];
    add r27 r50 into r53;
    add r40 r37 into r54;
    cast r54 into r55 as u128;
    cast r16 into r56 as u128;
    add r55 r56 into r57;
    cast r1 into r58 as u128;
    cast r57 into r59 as u128;
    mul r58 r59 into r60;
    cast r53 into r61 as u128;
    div r60 r61 into r62;
    cast r2 into r63 as u128;
    gte r62 r63 into r64;
    assert.eq r64 true;
    add block.height 1_000u32 into r65;
    ternary r7 r65 r5 into r66;
    set r66 into current_batch_height[0u8];
    cast r2 r66 into r67 as withdrawal_state;
    set r67 into withdrawals[r3];
    add r14 r2 into r68;
    set r68 into pending_withdrawal[0u8];
    sub r54 r2 into r69;
    set r69 into total_balance[0u8];
    sub r53 r1 into r70;
    set r70 into total_shares[0u8];
    get delegator_shares[r3] into r71;
    sub r71 r1 into r72;
    set r72 into delegator_shares[r3];




function unbond_all:
    input r0 as u64.public;
    call credits.aleo/unbond_public puzzle_staking_v001.aleo r0 into r1;
    async unbond_all r1 into r2;
    output r2 as puzzle_staking_v001.aleo/unbond_all.future;

finalize unbond_all:
    input r0 as credits.aleo/unbond_public.future;
    await r0;
    cast puzzle_staking_v001.aleo 0u64 into r1 as bond_state;
    get.or_use credits.aleo/bonded[puzzle_staking_v001.aleo] r1 into r2;
    assert.eq r2.microcredits 0u64;
    cast 0u64 0u32 into r3 as unbond_state;
    get.or_use credits.aleo/unbonding[puzzle_staking_v001.aleo] r3 into r4;
    get pending_withdrawal[0u8] into r5;
    sub r4.microcredits r5 into r6;
    get total_balance[0u8] into r7;
    get total_shares[0u8] into r8;
    gt r6 r7 into r9;
    cast r6 into r10 as i64;
    cast r7 into r11 as i64;
    sub r10 r11 into r12;
    ternary r9 r12 0i64 into r13;
    get commission_percent[0u8] into r14;
    cast r13 into r15 as u128;
    mul r15 r14 into r16;
    div r16 1_000u128 into r17;
    cast r17 into r18 as u64;
    cast r13 into r19 as u64;
    sub r19 r18 into r20;
    add r7 r20 into r21;
    get pending_deposits[0u8] into r22;
    cast r21 into r23 as u128;
    cast r22 into r24 as u128;
    cast r18 into r25 as u128;
    cast r8 into r26 as u128;
    add r23 r24 into r27;
    add r27 r25 into r28;
    mul r26 r28 into r29;
    div r29 r27 into r30;
    sub r30 r26 into r31;
    cast r31 into r32 as u64;
    get.or_use delegator_shares[aleo1as9067txqeya80e720ge68pt9faj6ymy20drfr5a7stfntyk95rqmv9afs] 0u64 into r33;
    add r33 r32 into r34;
    set r34 into delegator_shares[aleo1as9067txqeya80e720ge68pt9faj6ymy20drfr5a7stfntyk95rqmv9afs];
    add r8 r32 into r35;
    set r35 into total_shares[0u8];
    add r21 r18 into r36;
    set r36 into total_balance[0u8];




function claim_unbond:
    call credits.aleo/claim_unbond_public puzzle_staking_v001.aleo into r0;
    async claim_unbond r0 into r1;
    output r1 as puzzle_staking_v001.aleo/claim_unbond.future;

finalize claim_unbond:
    input r0 as credits.aleo/claim_unbond_public.future;
    await r0;
    remove current_batch_height[0u8];
    get pending_withdrawal[0u8] into r1;
    get pending_withdrawal[1u8] into r2;
    add r2 r1 into r3;
    set 0u64 into pending_withdrawal[0u8];
    set r3 into pending_withdrawal[1u8];




function claim_withdrawal_public:
    input r0 as address.public;
    input r1 as u64.public;
    call credits.aleo/transfer_public r0 r1 into r2;
    async claim_withdrawal_public r2 r0 r1 into r3;
    output r3 as puzzle_staking_v001.aleo/claim_withdrawal_public.future;

finalize claim_withdrawal_public:
    input r0 as credits.aleo/transfer_public.future;
    input r1 as address.public;
    input r2 as u64.public;
    await r0;
    get withdrawals[r1] into r3;
    gte block.height r3.claim_block into r4;
    assert.eq r4 true;
    assert.eq r3.microcredits r2;
    remove withdrawals[r1];
    get pending_withdrawal[1u8] into r5;
    sub r5 r2 into r6;
    set r6 into pending_withdrawal[1u8];



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
    assert.eq self.caller aleo1as9067txqeya80e720ge68pt9faj6ymy20drfr5a7stfntyk95rqmv9afs;
    lt r0 1_000u128 into r1;
    assert.eq r1 true;
    lte r0 500u128 into r2;
    assert.eq r2 true;
    async set_commission_percent r0 into r3;
    output r3 as puzzle_staking_v001.aleo/set_commission_percent.future;

finalize set_commission_percent:
    input r0 as u128.public;
    cast puzzle_staking_v001.aleo 0u64 into r1 as bond_state;
    get.or_use credits.aleo/bonded[puzzle_staking_v001.aleo] r1 into r2;
    get total_balance[0u8] into r3;
    get total_shares[0u8] into r4;
    gt r2.microcredits r3 into r5;
    cast r2.microcredits into r6 as i64;
    cast r3 into r7 as i64;
    sub r6 r7 into r8;
    ternary r5 r8 0i64 into r9;
    get commission_percent[0u8] into r10;
    cast r9 into r11 as u128;
    mul r11 r10 into r12;
    div r12 1_000u128 into r13;
    cast r13 into r14 as u64;
    cast r9 into r15 as u64;
    sub r15 r14 into r16;
    add r3 r16 into r17;
    get pending_deposits[0u8] into r18;
    cast r17 into r19 as u128;
    cast r18 into r20 as u128;
    cast r14 into r21 as u128;
    cast r4 into r22 as u128;
    add r19 r20 into r23;
    add r23 r21 into r24;
    mul r22 r24 into r25;
    div r25 r23 into r26;
    sub r26 r22 into r27;
    cast r27 into r28 as u64;
    get.or_use delegator_shares[aleo1as9067txqeya80e720ge68pt9faj6ymy20drfr5a7stfntyk95rqmv9afs] 0u64 into r29;
    add r29 r28 into r30;
    set r30 into delegator_shares[aleo1as9067txqeya80e720ge68pt9faj6ymy20drfr5a7stfntyk95rqmv9afs];
    add r4 r28 into r31;
    set r31 into total_shares[0u8];
    add r17 r14 into r32;
    set r32 into total_balance[0u8];
    set r0 into commission_percent[0u8];




function set_next_validator:
    input r0 as address.public;
    assert.eq self.caller aleo1as9067txqeya80e720ge68pt9faj6ymy20drfr5a7stfntyk95rqmv9afs;
    assert.neq r0 puzzle_staking_v001.aleo;
    async set_next_validator r0 into r1;
    output r1 as puzzle_staking_v001.aleo/set_next_validator.future;

finalize set_next_validator:
    input r0 as address.public;
    set r0 into validator[1u8];




function claim_commission:
    assert.eq self.caller aleo1as9067txqeya80e720ge68pt9faj6ymy20drfr5a7stfntyk95rqmv9afs;
    async claim_commission into r0;
    output r0 as puzzle_staking_v001.aleo/claim_commission.future;

finalize claim_commission:
    cast puzzle_staking_v001.aleo 0u64 into r0 as bond_state;
    get.or_use credits.aleo/bonded[puzzle_staking_v001.aleo] r0 into r1;
    get total_balance[0u8] into r2;
    get total_shares[0u8] into r3;
    gt r1.microcredits r2 into r4;
    cast r1.microcredits into r5 as i64;
    cast r2 into r6 as i64;
    sub r5 r6 into r7;
    ternary r4 r7 0i64 into r8;
    get commission_percent[0u8] into r9;
    cast r8 into r10 as u128;
    mul r10 r9 into r11;
    div r11 1_000u128 into r12;
    cast r12 into r13 as u64;
    cast r8 into r14 as u64;
    sub r14 r13 into r15;
    add r2 r15 into r16;
    get pending_deposits[0u8] into r17;
    cast r16 into r18 as u128;
    cast r17 into r19 as u128;
    cast r13 into r20 as u128;
    cast r3 into r21 as u128;
    add r18 r19 into r22;
    add r22 r20 into r23;
    mul r21 r23 into r24;
    div r24 r22 into r25;
    sub r25 r21 into r26;
    cast r26 into r27 as u64;
    get.or_use delegator_shares[aleo1as9067txqeya80e720ge68pt9faj6ymy20drfr5a7stfntyk95rqmv9afs] 0u64 into r28;
    add r28 r27 into r29;
    set r29 into delegator_shares[aleo1as9067txqeya80e720ge68pt9faj6ymy20drfr5a7stfntyk95rqmv9afs];
    add r3 r27 into r30;
    set r30 into total_shares[0u8];
    add r16 r13 into r31;
    set r31 into total_balance[0u8];



function get_new_batch_height_test:
    input r0 as u32.private;
    add r0 1_000u32 into r1;
    output r1 as u32.private;



function create_withdraw_claim:
    input r0 as u64.public;
    async create_withdraw_claim r0 self.caller into r1;
    output r1 as puzzle_staking_v001.aleo/create_withdraw_claim.future;

finalize create_withdraw_claim:
    input r0 as u64.public;
    input r1 as address.public;
    contains withdrawals[r1] into r2;
    assert.eq r2 false;
    cast puzzle_staking_v001.aleo 0u64 into r3 as bond_state;
    get.or_use credits.aleo/bonded[puzzle_staking_v001.aleo] r3 into r4;
    assert.eq r4.microcredits 0u64;
    cast 0u64 0u32 into r5 as unbond_state;
    get.or_use credits.aleo/unbonding[puzzle_staking_v001.aleo] r5 into r6;
    assert.eq r6.microcredits 0u64;
    get delegator_shares[r1] into r7;
    gte r7 r0 into r8;
    assert.eq r8 true;
    get total_balance[0u8] into r9;
    get pending_deposits[0u8] into r10;
    cast r9 into r11 as u128;
    cast r10 into r12 as u128;
    add r11 r12 into r13;
    get total_shares[0u8] into r14;
    cast r0 into r15 as u128;
    mul r15 r13 into r16;
    cast r14 into r17 as u128;
    div r16 r17 into r18;
    cast r18 into r19 as u64;
    add block.height 1u32 into r20;
    cast r19 r20 into r21 as withdrawal_state;
    set r21 into withdrawals[r1];
    get pending_withdrawal[1u8] into r22;
    add r22 r19 into r23;
    set r23 into pending_withdrawal[1u8];
    cast r10 into r24 as i64;
    cast r19 into r25 as i64;
    sub r24 r25 into r26;
    gte r26 0i64 into r27;
    abs r26 into r28;
    cast r28 into r29 as u64;
    ternary r27 r29 0u64 into r30;
    ternary r27 0u64 r29 into r31;
    set r30 into pending_deposits[0u8];
    sub r9 r31 into r32;
    set r32 into total_balance[0u8];
    sub r14 r0 into r33;
    set r33 into total_shares[0u8];
    sub r7 r0 into r34;
    set r34 into delegator_shares[r1];


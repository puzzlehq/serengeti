import credits.aleo;
import time_oracle.aleo;
program grant_disbursement_puzzle_v4.aleo;

struct bond_state:
    validator as address;
    microcredits as u64;


struct admin_operation:
    arg as field;
    op_type as u8;
    request_id as u64;

struct Grant:
    credits_amount as u64;
    recipient_rewards_address as address;
    recipient_principal_address as address;
    start_timestamp as u64;
    cliff_timestamp as u64;
    fully_vested_timestamp as u64;
    is_processed as boolean;


mapping grants:
	key as u8.public;
	value as Grant.public;


function initialize:
    async initialize into r0;
    output r0 as grant_disbursement_puzzle_v4.aleo/initialize.future;

finalize initialize:
    contains grants[0u8] into r0;
    not r0 into r1;
    assert.eq r1 true;
    cast 10_000_000u64 aleo1qfvzv4y0eh39cwszelmu8r8ysvp70ljvj2t3vxjv26uc337ppufqjahahj aleo1f7zquf7ax3u0gprx6vek9ww9hhz36kgwjkuujq3stxfqc8n9nq8qq4y8ng 0u64 0u64 2_021_504u64 false into r2 as Grant;
    set r2 into grants[0u8];




function process_grant:
    input r0 as u8.private;
    input r1 as u64.private;
    call credits.aleo/transfer_public_as_signer grant_disbursement_puzzle_v4.aleo r1 into r2;
    call credits.aleo/bond_public aleo1zdzzxfrhgzlhh89vqpf4384ewqs0g32wqzvdeltzlynq25hkju8s38953f grant_disbursement_puzzle_v4.aleo r1 into r3;
    async process_grant r2 r3 r0 r1 r1 into r4;
    output r4 as grant_disbursement_puzzle_v4.aleo/process_grant.future;

finalize process_grant:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as credits.aleo/bond_public.future;
    input r2 as u8.public;
    input r3 as u64.public;
    input r4 as u64.public;
    await r0;
    await r1;
    get grants[r2] into r5;
    assert.eq r3 r5.credits_amount;
    not r5.is_processed into r6;
    assert.eq r6 true;
    cast r5.credits_amount r5.recipient_rewards_address r5.recipient_principal_address r5.start_timestamp r5.cliff_timestamp r5.fully_vested_timestamp true into r7 as Grant;
    set r7 into grants[r2];




function withdraw_rewards:
    input r0 as u8.private;
    input r1 as u64.private;
    call credits.aleo/unbond_public grant_disbursement_puzzle_v4.aleo r1 into r2;
    async withdraw_rewards r2 r0 r1 self.caller into r3;
    output r3 as grant_disbursement_puzzle_v4.aleo/withdraw_rewards.future;

finalize withdraw_rewards:
    input r0 as credits.aleo/unbond_public.future;
    input r1 as u8.public;
    input r2 as u64.public;
    input r3 as address.public;
    await r0;
    get grants[r1] into r4;
    assert.eq r3 r4.recipient_rewards_address;
    get time_oracle.aleo/timestamp[0u8] into r5;
    lt r5 r4.cliff_timestamp into r6;
    assert.eq r6 true;
    get credits.aleo/bonded[grant_disbursement_puzzle_v4.aleo] into r7;
    sub r7.microcredits r2 into r8;
    gt r8 10_000_000u64 into r9;
    assert.eq r9 true;
    cast r4.credits_amount r4.recipient_rewards_address r4.recipient_principal_address r4.start_timestamp r4.cliff_timestamp r4.fully_vested_timestamp r4.is_processed into r10 as Grant;
    set r10 into grants[r1];




function withdraw_principal:
    input r0 as u8.private;
    input r1 as u64.private;
    call credits.aleo/unbond_public grant_disbursement_puzzle_v4.aleo r1 into r2;
    async withdraw_principal r2 r0 r1 self.caller into r3;
    output r3 as grant_disbursement_puzzle_v4.aleo/withdraw_principal.future;

finalize withdraw_principal:
    input r0 as credits.aleo/unbond_public.future;
    input r1 as u8.public;
    input r2 as u64.public;
    input r3 as address.public;
    await r0;
    get grants[r1] into r4;
    assert.eq r3 r4.recipient_principal_address;
    get time_oracle.aleo/timestamp[0u8] into r5;
    gte r5 r4.cliff_timestamp into r6;
    assert.eq r6 true;
    sub r5 r4.start_timestamp into r7;
    sub r4.fully_vested_timestamp r4.start_timestamp into r8;
    cast r4.credits_amount into r9 as u128;
    cast r7 into r10 as u128;
    mul r9 r10 into r11;
    cast r8 into r12 as u128;
    div r11 r12 into r13;
    cast r4.credits_amount into r14 as u128;
    lt r13 r14 into r15;
    cast r4.credits_amount into r16 as u128;
    ternary r15 r13 r16 into r17;
    cast r4.credits_amount into r18 as u128;
    sub r18 r17 into r19;
    cast r2 into r20 as u128;
    lte r20 r13 into r21;
    assert.eq r21 true;
    cast r4.credits_amount r4.recipient_rewards_address r4.recipient_principal_address r4.start_timestamp r4.cliff_timestamp r4.fully_vested_timestamp r4.is_processed into r22 as Grant;
    set r22 into grants[r1];




function claim_withdrawal_public:
    input r0 as u64.private;
    call credits.aleo/claim_unbond_public grant_disbursement_puzzle_v4.aleo into r1;
    call credits.aleo/transfer_public aleo1f7zquf7ax3u0gprx6vek9ww9hhz36kgwjkuujq3stxfqc8n9nq8qq4y8ng r0 into r2;
    async claim_withdrawal_public r1 r2 into r3;
    output r3 as grant_disbursement_puzzle_v4.aleo/claim_withdrawal_public.future;

finalize claim_withdrawal_public:
    input r0 as credits.aleo/claim_unbond_public.future;
    input r1 as credits.aleo/transfer_public.future;
    await r0;
    await r1;


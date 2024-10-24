import credits.aleo;
import time_oracle.aleo;
program grant_disbursement_puzzle.aleo;

struct bond_state:
    validator as address;
    microcredits as u64;


struct admin_operation:
    arg as field;
    op_type as u8;
    request_id as u64;

struct Grant:
    credits_amount as u64;
    withdrawal_address as address;
    start_timestamp as u64;
    cliff_timestamp as u64;
    fully_vested_timestamp as u64;
    is_processed as boolean;


mapping grants:
	key as u8.public;
	value as Grant.public;


function claim_unbond_public:
    call credits.aleo/claim_unbond_public grant_disbursement_puzzle.aleo into r0;
    async claim_unbond_public r0 into r1;
    output r1 as grant_disbursement_puzzle.aleo/claim_unbond_public.future;

finalize claim_unbond_public:
    input r0 as credits.aleo/claim_unbond_public.future;
    await r0;




function initialize:
    async initialize into r0;
    output r0 as grant_disbursement_puzzle.aleo/initialize.future;

finalize initialize:
    contains grants[0u8] into r0;
    not r0 into r1;
    assert.eq r1 true;
    cast 500_000_000_000u64 aleo1pld4a6wdl9psu882ce4cz97uf3n9kk8dl2sm74dmu62sakw6qcrqfwc3h9 1725479626u64 1757015626u64 1757015686u64 false into r2 as Grant;
    set r2 into grants[0u8];




function process_grant:
    input r0 as u8.private;
    call credits.aleo/transfer_public_as_signer grant_disbursement_puzzle.aleo 500_000_000_000u64 into r1;
    call credits.aleo/bond_public aleo1q3gtqtd03fs7chhjdr8c4hf8vkwt96pf3vw28uytsdrnwt4hrs9sg7c62j grant_disbursement_puzzle.aleo 500_000_000_000u64 into r2;
    async process_grant r1 r2 r0 into r3;
    output r3 as grant_disbursement_puzzle.aleo/process_grant.future;

finalize process_grant:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as credits.aleo/bond_public.future;
    input r2 as u8.public;
    await r0;
    await r1;
    get grants[r2] into r3;
    not r3.is_processed into r4;
    assert.eq r4 true;
    cast r3.credits_amount r3.withdrawal_address r3.start_timestamp r3.cliff_timestamp r3.fully_vested_timestamp true into r5 as Grant;
    set r5 into grants[r2];




function withdraw_rewards:
    input r0 as u8.private;
    input r1 as u64.private;
    assert.eq self.caller aleo1pld4a6wdl9psu882ce4cz97uf3n9kk8dl2sm74dmu62sakw6qcrqfwc3h9;
    call credits.aleo/unbond_public grant_disbursement_puzzle.aleo r1 into r2;
    async withdraw_rewards r2 r0 r1 into r3;
    output r3 as grant_disbursement_puzzle.aleo/withdraw_rewards.future;

finalize withdraw_rewards:
    input r0 as credits.aleo/unbond_public.future;
    input r1 as u8.public;
    input r2 as u64.public;
    await r0;
    get grants[r1] into r3;
    get time_oracle.aleo/timestamp[0u8] into r4;
    lt r4 r3.cliff_timestamp into r5;
    assert.eq r5 true;
    get credits.aleo/bonded[grant_disbursement_puzzle.aleo] into r6;
    sub r6.microcredits r2 into r7;
    gte r7 r3.credits_amount into r8;
    assert.eq r8 true;




function withdraw_principal:
    input r0 as u8.private;
    input r1 as u64.private;
    assert.eq self.caller aleo1pld4a6wdl9psu882ce4cz97uf3n9kk8dl2sm74dmu62sakw6qcrqfwc3h9;
    call credits.aleo/unbond_public grant_disbursement_puzzle.aleo r1 into r2;
    async withdraw_principal r2 r0 r1 into r3;
    output r3 as grant_disbursement_puzzle.aleo/withdraw_principal.future;

finalize withdraw_principal:
    input r0 as credits.aleo/unbond_public.future;
    input r1 as u8.public;
    input r2 as u64.public;
    await r0;
    get grants[r1] into r3;
    get time_oracle.aleo/timestamp[0u8] into r4;
    gte r4 r3.cliff_timestamp into r5;
    assert.eq r5 true;
    sub r4 r3.start_timestamp into r6;
    sub r3.fully_vested_timestamp r3.start_timestamp into r7;
    mul r3.credits_amount r6 into r8;
    div r8 r7 into r9;
    lte r2 r9 into r10;
    assert.eq r10 true;




function withdraw:
    input r0 as u8.private;
    input r1 as u64.private;
    call credits.aleo/transfer_public aleo1pld4a6wdl9psu882ce4cz97uf3n9kk8dl2sm74dmu62sakw6qcrqfwc3h9 r1 into r2;
    async withdraw r2 r0 r1 into r3;
    output r3 as grant_disbursement_puzzle.aleo/withdraw.future;

finalize withdraw:
    input r0 as credits.aleo/transfer_public.future;
    input r1 as u8.public;
    input r2 as u64.public;
    await r0;
    get grants[r1] into r3;
    get credits.aleo/account[grant_disbursement_puzzle.aleo] into r4;
    get time_oracle.aleo/timestamp[0u8] into r5;
    lt r5 r3.cliff_timestamp into r6;
    branch.eq r6 false to end_then_0_0;
    sub r4 r2 into r7;
    gte r7 r3.credits_amount into r8;
    assert.eq r8 true;
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    sub r5 r3.start_timestamp into r9;
    sub r3.fully_vested_timestamp r3.start_timestamp into r10;
    mul r3.credits_amount r9 into r11;
    div r11 r10 into r12;
    lte r2 r12 into r13;
    assert.eq r13 true;
    position end_otherwise_0_1;


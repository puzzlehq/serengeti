import credits.aleo;
program grant_disbursement_puzzle.aleo;

struct bond_state:
    validator as address;
    microcredits as u64;


struct Grant:
    credits_amount as u64;
    credits_bonded_amount as u128;
    recipient_rewards_key as address;
    recipient_principal_key as address;
    start_height as u32;
    cliff_height as u32;
    fully_vested_height as u32;
    is_processed as boolean;


mapping grants:
	key as u8.public;
	value as Grant.public;


function initialize:
    async initialize into r0;
    output r0 as grant_disbursement_puzzle.aleo/initialize.future;

finalize initialize:
    contains grants[0u8] into r0;
    not r0 into r1;
    assert.eq r1 true;
    cast 500_000_000_000u64 0u128 aleo12shtwnmf49t5atmad2jnk3e58ahtp749d9trctt9z3wryxyzt5pspp0nd0 aleo1z9y9afh0h6dnyj3f0hvjc4mhayjy06fj42ppcq0rvpmmyky6fuzs449sjr block.height 1_000_000_000u32 2_000_000_000u32 false into r2 as Grant;
    set r2 into grants[0u8];




function process_grant:
    input r0 as u8.private;
    input r1 as u64.private;
    input r2 as u64.private;
    call credits.aleo/transfer_public_as_signer grant_disbursement_puzzle.aleo r1 into r3;
    call credits.aleo/bond_public aleo1q3gtqtd03fs7chhjdr8c4hf8vkwt96pf3vw28uytsdrnwt4hrs9sg7c62j grant_disbursement_puzzle.aleo r1 into r4;
    async process_grant r3 r4 r0 r1 r2 into r5;
    output r5 as grant_disbursement_puzzle.aleo/process_grant.future;

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
    cast r5.credits_amount r5.credits_bonded_amount r5.recipient_rewards_key r5.recipient_principal_key r5.start_height r5.cliff_height r5.fully_vested_height true into r7 as Grant;
    set r7 into grants[r2];




function withdraw_rewards:
    input r0 as u8.private;
    input r1 as u64.private;
    call credits.aleo/unbond_public grant_disbursement_puzzle.aleo r1 into r2;
    async withdraw_rewards r2 r0 r1 self.caller into r3;
    output r3 as grant_disbursement_puzzle.aleo/withdraw_rewards.future;

finalize withdraw_rewards:
    input r0 as credits.aleo/unbond_public.future;
    input r1 as u8.public;
    input r2 as u64.public;
    input r3 as address.public;
    await r0;
    get grants[r1] into r4;
    assert.eq r3 r4.recipient_rewards_key;
    lt block.height r4.cliff_height into r5;
    assert.eq r5 true;
    get credits.aleo/bonded[grant_disbursement_puzzle.aleo] into r6;
    cast r6.microcredits into r7 as u128;
    cast r2 into r8 as u128;
    sub r7 r8 into r9;
    gt r9 10_000_000u128 into r10;
    assert.eq r10 true;
    cast r2 into r11 as u128;
    sub r4.credits_bonded_amount r11 into r12;
    cast r4.credits_amount r12 r4.recipient_rewards_key r4.recipient_principal_key r4.start_height r4.cliff_height r4.fully_vested_height r4.is_processed into r13 as Grant;
    set r13 into grants[r1];




function withdraw_principal:
    input r0 as u8.private;
    input r1 as u64.private;
    call credits.aleo/unbond_public grant_disbursement_puzzle.aleo r1 into r2;
    async withdraw_principal r2 r0 r1 self.caller into r3;
    output r3 as grant_disbursement_puzzle.aleo/withdraw_principal.future;

finalize withdraw_principal:
    input r0 as credits.aleo/unbond_public.future;
    input r1 as u8.public;
    input r2 as u64.public;
    input r3 as address.public;
    await r0;
    get grants[r1] into r4;
    assert.eq r3 r4.recipient_principal_key;
    gte block.height r4.cliff_height into r5;
    assert.eq r5 true;
    sub block.height r4.start_height into r6;
    sub r4.fully_vested_height r4.start_height into r7;
    cast r4.credits_amount into r8 as u128;
    cast r6 into r9 as u128;
    mul r8 r9 into r10;
    cast r7 into r11 as u128;
    div r10 r11 into r12;
    cast r4.credits_amount into r13 as u128;
    lt r12 r13 into r14;
    cast r4.credits_amount into r15 as u128;
    ternary r14 r12 r15 into r16;
    cast r4.credits_amount into r17 as u128;
    sub r17 r16 into r18;
    cast r18 into r19 as u128;
    gte r4.credits_bonded_amount r19 into r20;
    assert.eq r20 true;
    cast r4.credits_amount r4.credits_bonded_amount r4.recipient_rewards_key r4.recipient_principal_key r4.start_height r4.cliff_height r4.fully_vested_height r4.is_processed into r21 as Grant;
    set r21 into grants[r1];




function claim_withdrawal_public:
    input r0 as u64.private;
    call credits.aleo/claim_unbond_public grant_disbursement_puzzle.aleo into r1;
    call credits.aleo/transfer_public aleo1z9y9afh0h6dnyj3f0hvjc4mhayjy06fj42ppcq0rvpmmyky6fuzs449sjr r0 into r2;
    async claim_withdrawal_public r1 r2 into r3;
    output r3 as grant_disbursement_puzzle.aleo/claim_withdrawal_public.future;

finalize claim_withdrawal_public:
    input r0 as credits.aleo/claim_unbond_public.future;
    input r1 as credits.aleo/transfer_public.future;
    await r0;
    await r1;


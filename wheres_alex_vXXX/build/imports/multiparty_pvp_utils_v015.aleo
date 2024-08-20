program multiparty_pvp_utils_v015.aleo;

struct Mssage:
    field_1 as field;
    field_2 as field;
    field_3 as field;
    field_4 as field;
    field_5 as field;

record Answer:
    owner as address.private;
    challenger_address as address.private;
    opponent_address as address.private;
    game_multisig as address.private;
    amount as u64.private;
    nonce as field.private;
    answer as u8.private;

record Key:
    owner as address.private;
    seed as field.private;
    amount as u64.private;
    game_multisig as address.private;


function mint_answer:
    input r0 as address.private;
    input r1 as address.private;
    input r2 as address.private;
    input r3 as u64.private;
    input r4 as field.private;
    input r5 as u8.private;
    input r6 as field.private;
    input r7 as field.private;
    input r8 as field.private;
    input r9 as field.private;
    input r10 as field.private;
    input r11 as signature.private;
    cast r6 r7 r8 r9 r10 into r12 as Mssage;
    sign.verify r11 r0 r12 into r13;
    assert.eq r13 true;
    cast r0 r0 r1 r2 r3 r4 r5 into r14 as Answer.record;
    output r14 as Answer.record;


function mint_multisig_key:
    input r0 as field.private;
    input r1 as u64.private;
    input r2 as address.private;
    input r3 as address.private;
    input r4 as address.private;
    cast r3 r0 r1 r4 into r5 as Key.record;
    output r5 as Key.record;


function reveal_answer:
    input r0 as Answer.record;
    cast r0.game_multisig r0.challenger_address r0.opponent_address r0.game_multisig r0.amount r0.nonce r0.answer into r1 as Answer.record;
    output r1 as Answer.record;

program multiparty_pvp_utils_v001.aleo;

struct Message:
    field_1 as field;
    field_2 as field;
    field_3 as field;
    field_4 as field;
    field_5 as field;

record Answer:
    owner as address.private;
    challenger_address as address.private;
    opponent_address as address.private;
    game_address as address.private;
    amount as u64.private;
    nonce as field.private;
    answer as field.private;
    message_1 as field.private;
    message_2 as field.private;
    message_3 as field.private;
    message_4 as field.private;
    message_5 as field.private;
    sig as signature.private;

record AuditMintAnswer:
    owner as address.private;
    answer_owner as address.private;
    challenger_address as address.private;
    opponent_address as address.private;
    game_address as address.private;
    amount as u64.private;
    nonce as field.private;
    answer as field.private;
    message_1 as field.private;
    message_2 as field.private;
    message_3 as field.private;
    message_4 as field.private;
    message_5 as field.private;
    sig as signature.private;


function mint_answer:
    input r0 as address.private;
    input r1 as address.private;
    input r2 as address.private;
    input r3 as u64.private;
    input r4 as field.private;
    input r5 as field.private;
    input r6 as field.private;
    input r7 as field.private;
    input r8 as field.private;
    input r9 as field.private;
    input r10 as field.private;
    input r11 as signature.private;
    cast r6 r7 r8 r9 r10 into r12 as Message;
    sign.verify r11 r0 r12 into r13;
    assert.eq true r13;
    cast r0 r0 r1 r2 r3 r4 r5 r6 r7 r8 r9 r10 r11 into r14 as Answer.record;
    cast aleo16hf8hfpwasnn9cf7k2c0dllc56nn7qt547qxgvgwu6pznw4trvqsx68kls r0 r0 r1 r2 r3 r4 r5 r6 r7 r8 r9 r10 r11 into r15 as AuditMintAnswer.record;
    output r14 as Answer.record;
    output r15 as AuditMintAnswer.record;

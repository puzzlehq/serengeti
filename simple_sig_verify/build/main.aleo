program simple_sig_verify.aleo;

struct Message:
    field_1 as field;
    field_2 as field;
    field_3 as field;
    field_4 as field;
    field_5 as field;

record MessageSignInfo:
    owner as address.private;
    message_1 as field.private;
    message_2 as field.private;
    message_3 as field.private;
    message_4 as field.private;
    message_5 as field.private;


function sig_verify:
    input r0 as MessageSignInfo.record;
    input r1 as signature.private;
    cast r0.message_1 r0.message_2 r0.message_3 r0.message_4 r0.message_5 into r2 as Message;
    sign.verify r1 r0.owner r2 into r3;
    output r3 as boolean.private;

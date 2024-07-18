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


function mint_message:
    input r0 as field.private;
    input r1 as field.private;
    input r2 as field.private;
    input r3 as field.private;
    input r4 as field.private;
    cast aleo16d0pn0dyrlfs3kqaklt9lpagyjagej93lzhzps50cyxp8m9p7gqs7krdgy r0 r1 r2 r3 r4 into r5 as MessageSignInfo.record;
    output r5 as MessageSignInfo.record;


function sig_verify:
    input r0 as field.private;
    input r1 as field.private;
    input r2 as field.private;
    input r3 as field.private;
    input r4 as field.private;
    input r5 as signature.private;
    cast r0 r1 r2 r3 r4 into r6 as Message;
    sign.verify r5 aleo16d0pn0dyrlfs3kqaklt9lpagyjagej93lzhzps50cyxp8m9p7gqs7krdgy r6 into r7;
    output r7 as boolean.private;

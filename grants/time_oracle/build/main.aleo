program time_oracle_puzz_test.aleo;

struct admin_operation:
    arg as field;
    op_type as u8;
    request_id as u64;


mapping timestamp:
	key as u8.public;
	value as u64.public;


mapping admin_operations:
	key as u64.public;
	value as admin_operation.public;


mapping admins:
	key as address.public;
	value as boolean.public;


function initialize:
    async initialize into r0;
    output r0 as time_oracle_puzz_test.aleo/initialize.future;

finalize initialize:
    contains timestamp[0u8] into r0;
    not r0 into r1;
    assert.eq r1 true;
    set 0u64 into timestamp[0u8];
    set true into admins[aleo1l9ku72ulu48cxrmapcd6k3srkhu5mj9y8wf0ypzgqar5fwf5cc8sajzqe0];




function update_timestamp:
    input r0 as u64.public;
    input r1 as signature.public;
    input r2 as address.public;
    input r3 as u64.public;
    hash.bhp256 r0 into r4 as field;
    cast r4 0u8 r3 into r5 as admin_operation;
    hash.bhp256 r5 into r6 as field;
    sign.verify r1 r2 r6 into r7;
    async update_timestamp r0 r2 r5 into r8;
    output r8 as time_oracle_puzz_test.aleo/update_timestamp.future;

finalize update_timestamp:
    input r0 as u64.public;
    input r1 as address.public;
    input r2 as admin_operation.public;
    get admins[r1] into r3;
    contains admin_operations[r2.request_id] into r4;
    assert.eq r4 false;
    set r2 into admin_operations[r2.request_id];
    set r0 into timestamp[0u8];




function update_admin:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as signature.public;
    input r3 as address.public;
    input r4 as u64.public;
    cast  r0 r1 into r5 as [address; 2u32];
    hash.bhp256 r5 into r6 as field;
    cast r6 1u8 r4 into r7 as admin_operation;
    hash.bhp256 r7 into r8 as field;
    sign.verify r2 r3 r8 into r9;
    async update_admin r0 r1 r3 r7 into r10;
    output r10 as time_oracle_puzz_test.aleo/update_admin.future;

finalize update_admin:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as address.public;
    input r3 as admin_operation.public;
    get admins[r2] into r4;
    contains admin_operations[r3.request_id] into r5;
    assert.eq r5 false;
    set r3 into admin_operations[r3.request_id];
    remove admins[r0];
    set true into admins[r1];


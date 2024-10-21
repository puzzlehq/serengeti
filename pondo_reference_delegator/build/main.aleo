import credits.aleo;
import pondo_oraclev1.aleo;
program reference_delegatorabcdef.aleo;


struct admin_operation:
    arg as field;
    op_type as u8;
    request_id as u64;


mapping initialized:
	key as u8.public;
	value as u8.public;


function initialize:
    call credits.aleo/transfer_public_as_signer reference_delegatorabcdef.aleo 10_000_000_000u64 into r0;
    call credits.aleo/bond_public aleo1zdzzxfrhgzlhh89vqpf4384ewqs0g32wqzvdeltzlynq25hkju8s38953f reference_delegatorabcdef.aleo 10_000_000_000u64 into r1;
    call pondo_oraclev1.aleo/propose_delegator aleo1zdzzxfrhgzlhh89vqpf4384ewqs0g32wqzvdeltzlynq25hkju8s38953f into r2;
    async initialize r0 r1 r2 into r3;
    output r3 as reference_delegatorabcdef.aleo/initialize.future;

finalize initialize:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as credits.aleo/bond_public.future;
    input r2 as pondo_oraclev1.aleo/propose_delegator.future;
    await r0;
    await r1;
    await r2;
    contains initialized[0u8] into r3;
    assert.eq r3 false;
    set 8u8 into initialized[0u8];




function remove:
    input r0 as u64.public;
    assert.eq self.caller aleo12mg4yjxtaejwm3aaxk8gugr5p4nddhdn8g5xr2hlfcasxf532qqq7yaga0;
    call credits.aleo/unbond_public reference_delegatorabcdef.aleo r0 into r1;
    call pondo_oraclev1.aleo/remove_delegator into r2;
    async remove r1 r2 into r3;
    output r3 as reference_delegatorabcdef.aleo/remove.future;

finalize remove:
    input r0 as credits.aleo/unbond_public.future;
    input r1 as pondo_oraclev1.aleo/remove_delegator.future;
    await r0;
    await r1;
    contains credits.aleo/bonded[reference_delegatorabcdef.aleo] into r2;
    assert.eq r2 false;




function withdraw:
    input r0 as u64.private;
    call credits.aleo/transfer_public aleo12mg4yjxtaejwm3aaxk8gugr5p4nddhdn8g5xr2hlfcasxf532qqq7yaga0 r0 into r1;
    async withdraw r1 into r2;
    output r2 as reference_delegatorabcdef.aleo/withdraw.future;

finalize withdraw:
    input r0 as credits.aleo/transfer_public.future;
    await r0;
    get.or_use credits.aleo/account[reference_delegatorabcdef.aleo] 0u64 into r1;
    assert.eq r1 0u64;


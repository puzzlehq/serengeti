import puzzle_arcade_coin_v001.aleo;
import puzzle_arcade_ticket_v001.aleo;
program cat_charmer_testing.aleo;

struct Result:
    nonce as field;
    tickets as u64;

mapping used_nonces:
    key as field.public;
    value as boolean.public;

function submit_game:
    input r0 as puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin.record;
    input r1 as Result.public;
    input r2 as signature.private;
    sign.verify r2 aleo1lvcratjds9m4cyq099at825x8076jlrcw5jj39kwk6ja5l2ktsqqz5v83a r1 into r3;
    assert.eq r3 true;
    lte r1.tickets 15000000u64 into r4;
    assert.eq r4 true;
    call puzzle_arcade_coin_v001.aleo/spend r0 1000000u64 into r5;
    call puzzle_arcade_ticket_v001.aleo/mint r0.owner r1.tickets into r6 r7;
    async submit_game r7 r1.nonce into r8;
    output r5 as puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin.record;
    output r6 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r8 as cat_charmer_testing.aleo/submit_game.future;

finalize submit_game:
    input r0 as puzzle_arcade_ticket_v001.aleo/mint.future;
    input r1 as field.public;
    get.or_use used_nonces[r1] false into r2;
    assert.eq r2 false;
    set true into used_nonces[r1];
    await r0;

import puzzle_arcade_ticket_v002.aleo;
program par_digital_assets_v2.aleo;

function purchase:
    input r0 as u16.private;
    input r1 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r2 as u64.private;
    call puzzle_arcade_ticket_v002.aleo/spend r1 r2 into r3;
    async purchase into r4;
    output r3 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    output r4 as par_digital_assets_v2.aleo/purchase.future;

finalize purchase:
    assert.eq true true;

function purchase2:
    input r0 as u16.private;
    input r1 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r2 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r3 as u64.private;
    add r1.amount r2.amount into r4;
    sub r4 r3 into r5;
    call puzzle_arcade_ticket_v002.aleo/spend r1 r1.amount into r6;
    sub r2.amount r5 into r7;
    call puzzle_arcade_ticket_v002.aleo/spend r2 r7 into r8;
    async purchase2 into r9;
    output r8 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    output r9 as par_digital_assets_v2.aleo/purchase2.future;

finalize purchase2:
    assert.eq true true;

function purchase3:
    input r0 as u16.private;
    input r1 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r2 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r3 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r4 as u64.private;
    add r1.amount r2.amount into r5;
    add r5 r3.amount into r6;
    sub r6 r4 into r7;
    call puzzle_arcade_ticket_v002.aleo/spend r1 r1.amount into r8;
    call puzzle_arcade_ticket_v002.aleo/spend r2 r2.amount into r9;
    sub r3.amount r7 into r10;
    call puzzle_arcade_ticket_v002.aleo/spend r3 r10 into r11;
    async purchase3 into r12;
    output r11 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    output r12 as par_digital_assets_v2.aleo/purchase3.future;

finalize purchase3:
    assert.eq true true;

function purchase4:
    input r0 as u16.private;
    input r1 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r2 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r3 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r4 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r5 as u64.private;
    add r1.amount r2.amount into r6;
    add r6 r3.amount into r7;
    add r7 r4.amount into r8;
    sub r8 r5 into r9;
    call puzzle_arcade_ticket_v002.aleo/spend r1 r1.amount into r10;
    call puzzle_arcade_ticket_v002.aleo/spend r2 r2.amount into r11;
    call puzzle_arcade_ticket_v002.aleo/spend r3 r3.amount into r12;
    sub r4.amount r9 into r13;
    call puzzle_arcade_ticket_v002.aleo/spend r4 r13 into r14;
    async purchase4 into r15;
    output r14 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    output r15 as par_digital_assets_v2.aleo/purchase4.future;

finalize purchase4:
    assert.eq true true;

function purchase5:
    input r0 as u16.private;
    input r1 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r2 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r3 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r4 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r5 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r6 as u64.private;
    add r1.amount r2.amount into r7;
    add r7 r3.amount into r8;
    add r8 r4.amount into r9;
    add r9 r5.amount into r10;
    sub r10 r6 into r11;
    call puzzle_arcade_ticket_v002.aleo/spend r1 r1.amount into r12;
    call puzzle_arcade_ticket_v002.aleo/spend r2 r2.amount into r13;
    call puzzle_arcade_ticket_v002.aleo/spend r3 r3.amount into r14;
    call puzzle_arcade_ticket_v002.aleo/spend r4 r4.amount into r15;
    sub r5.amount r11 into r16;
    call puzzle_arcade_ticket_v002.aleo/spend r5 r16 into r17;
    async purchase5 into r18;
    output r17 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    output r18 as par_digital_assets_v2.aleo/purchase5.future;

finalize purchase5:
    assert.eq true true;

function purchase6:
    input r0 as u16.private;
    input r1 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r2 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r3 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r4 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r5 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r6 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r7 as u64.private;
    add r1.amount r2.amount into r8;
    add r8 r3.amount into r9;
    add r9 r4.amount into r10;
    add r10 r5.amount into r11;
    add r11 r6.amount into r12;
    sub r12 r7 into r13;
    call puzzle_arcade_ticket_v002.aleo/spend r1 r1.amount into r14;
    call puzzle_arcade_ticket_v002.aleo/spend r2 r2.amount into r15;
    call puzzle_arcade_ticket_v002.aleo/spend r3 r3.amount into r16;
    call puzzle_arcade_ticket_v002.aleo/spend r4 r4.amount into r17;
    call puzzle_arcade_ticket_v002.aleo/spend r5 r5.amount into r18;
    sub r6.amount r13 into r19;
    call puzzle_arcade_ticket_v002.aleo/spend r6 r19 into r20;
    async purchase6 into r21;
    output r20 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    output r21 as par_digital_assets_v2.aleo/purchase6.future;

finalize purchase6:
    assert.eq true true;

function purchase7:
    input r0 as u16.private;
    input r1 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r2 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r3 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r4 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r5 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r6 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r7 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r8 as u64.private;
    add r1.amount r2.amount into r9;
    add r9 r3.amount into r10;
    add r10 r4.amount into r11;
    add r11 r5.amount into r12;
    add r12 r6.amount into r13;
    add r13 r7.amount into r14;
    sub r14 r8 into r15;
    call puzzle_arcade_ticket_v002.aleo/spend r1 r1.amount into r16;
    call puzzle_arcade_ticket_v002.aleo/spend r2 r2.amount into r17;
    call puzzle_arcade_ticket_v002.aleo/spend r3 r3.amount into r18;
    call puzzle_arcade_ticket_v002.aleo/spend r4 r4.amount into r19;
    call puzzle_arcade_ticket_v002.aleo/spend r5 r5.amount into r20;
    call puzzle_arcade_ticket_v002.aleo/spend r6 r6.amount into r21;
    sub r7.amount r15 into r22;
    call puzzle_arcade_ticket_v002.aleo/spend r7 r22 into r23;
    async purchase7 into r24;
    output r23 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    output r24 as par_digital_assets_v2.aleo/purchase7.future;

finalize purchase7:
    assert.eq true true;

function purchase8:
    input r0 as u16.private;
    input r1 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r2 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r3 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r4 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r5 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r6 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r7 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r8 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r9 as u64.private;
    add r1.amount r2.amount into r10;
    add r10 r3.amount into r11;
    add r11 r4.amount into r12;
    add r12 r5.amount into r13;
    add r13 r6.amount into r14;
    add r14 r7.amount into r15;
    add r15 r8.amount into r16;
    sub r16 r9 into r17;
    call puzzle_arcade_ticket_v002.aleo/spend r1 r1.amount into r18;
    call puzzle_arcade_ticket_v002.aleo/spend r2 r2.amount into r19;
    call puzzle_arcade_ticket_v002.aleo/spend r3 r3.amount into r20;
    call puzzle_arcade_ticket_v002.aleo/spend r4 r4.amount into r21;
    call puzzle_arcade_ticket_v002.aleo/spend r5 r5.amount into r22;
    call puzzle_arcade_ticket_v002.aleo/spend r6 r6.amount into r23;
    call puzzle_arcade_ticket_v002.aleo/spend r7 r7.amount into r24;
    sub r8.amount r17 into r25;
    call puzzle_arcade_ticket_v002.aleo/spend r8 r25 into r26;
    async purchase8 into r27;
    output r26 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    output r27 as par_digital_assets_v2.aleo/purchase8.future;

finalize purchase8:
    assert.eq true true;

function purchase9:
    input r0 as u16.private;
    input r1 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r2 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r3 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r4 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r5 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r6 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r7 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r8 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r9 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r10 as u64.private;
    add r1.amount r2.amount into r11;
    add r11 r3.amount into r12;
    add r12 r4.amount into r13;
    add r13 r5.amount into r14;
    add r14 r6.amount into r15;
    add r15 r7.amount into r16;
    add r16 r8.amount into r17;
    add r17 r9.amount into r18;
    sub r18 r10 into r19;
    call puzzle_arcade_ticket_v002.aleo/spend r1 r1.amount into r20;
    call puzzle_arcade_ticket_v002.aleo/spend r2 r2.amount into r21;
    call puzzle_arcade_ticket_v002.aleo/spend r3 r3.amount into r22;
    call puzzle_arcade_ticket_v002.aleo/spend r4 r4.amount into r23;
    call puzzle_arcade_ticket_v002.aleo/spend r5 r5.amount into r24;
    call puzzle_arcade_ticket_v002.aleo/spend r6 r6.amount into r25;
    call puzzle_arcade_ticket_v002.aleo/spend r7 r7.amount into r26;
    call puzzle_arcade_ticket_v002.aleo/spend r8 r8.amount into r27;
    sub r9.amount r19 into r28;
    call puzzle_arcade_ticket_v002.aleo/spend r9 r28 into r29;
    async purchase9 into r30;
    output r29 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    output r30 as par_digital_assets_v2.aleo/purchase9.future;

finalize purchase9:
    assert.eq true true;

function purchase10:
    input r0 as u16.private;
    input r1 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r2 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r3 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r4 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r5 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r6 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r7 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r8 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r9 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r10 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    input r11 as u64.private;
    add r1.amount r2.amount into r12;
    add r12 r3.amount into r13;
    add r13 r4.amount into r14;
    add r14 r5.amount into r15;
    add r15 r6.amount into r16;
    add r16 r7.amount into r17;
    add r17 r8.amount into r18;
    add r18 r9.amount into r19;
    add r19 r10.amount into r20;
    sub r20 r11 into r21;
    call puzzle_arcade_ticket_v002.aleo/spend r1 r1.amount into r22;
    call puzzle_arcade_ticket_v002.aleo/spend r2 r2.amount into r23;
    call puzzle_arcade_ticket_v002.aleo/spend r3 r3.amount into r24;
    call puzzle_arcade_ticket_v002.aleo/spend r4 r4.amount into r25;
    call puzzle_arcade_ticket_v002.aleo/spend r5 r5.amount into r26;
    call puzzle_arcade_ticket_v002.aleo/spend r6 r6.amount into r27;
    call puzzle_arcade_ticket_v002.aleo/spend r7 r7.amount into r28;
    call puzzle_arcade_ticket_v002.aleo/spend r8 r8.amount into r29;
    call puzzle_arcade_ticket_v002.aleo/spend r9 r9.amount into r30;
    sub r10.amount r21 into r31;
    call puzzle_arcade_ticket_v002.aleo/spend r10 r31 into r32;
    async purchase10 into r33;
    output r32 as puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket.record;
    output r33 as par_digital_assets_v2.aleo/purchase10.future;

finalize purchase10:
    assert.eq true true;

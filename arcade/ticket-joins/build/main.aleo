import puzzle_arcade_ticket_v001.aleo;
program par_ticket_joins_v1.aleo;

function join6:
    input r0 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r3 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r4 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r5 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v001.aleo/spend r0 r0.amount into r6;
    call puzzle_arcade_ticket_v001.aleo/spend r1 r1.amount into r7;
    call puzzle_arcade_ticket_v001.aleo/spend r2 r2.amount into r8;
    call puzzle_arcade_ticket_v001.aleo/spend r3 r3.amount into r9;
    call puzzle_arcade_ticket_v001.aleo/spend r4 r4.amount into r10;
    call puzzle_arcade_ticket_v001.aleo/spend r5 r5.amount into r11;
    add r0.amount r1.amount into r12;
    add r12 r2.amount into r13;
    add r13 r3.amount into r14;
    add r14 r4.amount into r15;
    add r15 r5.amount into r16;
    call puzzle_arcade_ticket_v001.aleo/mint self.signer r16 into r17 r18;
    async join6 r18 into r19;
    output r17 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r19 as par_ticket_joins_v1.aleo/join6.future;

finalize join6:
    input r0 as puzzle_arcade_ticket_v001.aleo/mint.future;
    await r0;

function join7:
    input r0 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r3 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r4 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r5 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r6 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v001.aleo/spend r0 r0.amount into r7;
    call puzzle_arcade_ticket_v001.aleo/spend r1 r1.amount into r8;
    call puzzle_arcade_ticket_v001.aleo/spend r2 r2.amount into r9;
    call puzzle_arcade_ticket_v001.aleo/spend r3 r3.amount into r10;
    call puzzle_arcade_ticket_v001.aleo/spend r4 r4.amount into r11;
    call puzzle_arcade_ticket_v001.aleo/spend r5 r5.amount into r12;
    call puzzle_arcade_ticket_v001.aleo/spend r6 r6.amount into r13;
    add r0.amount r1.amount into r14;
    add r14 r2.amount into r15;
    add r15 r3.amount into r16;
    add r16 r4.amount into r17;
    add r17 r5.amount into r18;
    add r18 r6.amount into r19;
    call puzzle_arcade_ticket_v001.aleo/mint self.signer r19 into r20 r21;
    async join7 r21 into r22;
    output r20 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r22 as par_ticket_joins_v1.aleo/join7.future;

finalize join7:
    input r0 as puzzle_arcade_ticket_v001.aleo/mint.future;
    await r0;

function join8:
    input r0 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r3 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r4 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r5 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r6 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r7 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v001.aleo/spend r0 r0.amount into r8;
    call puzzle_arcade_ticket_v001.aleo/spend r1 r1.amount into r9;
    call puzzle_arcade_ticket_v001.aleo/spend r2 r2.amount into r10;
    call puzzle_arcade_ticket_v001.aleo/spend r3 r3.amount into r11;
    call puzzle_arcade_ticket_v001.aleo/spend r4 r4.amount into r12;
    call puzzle_arcade_ticket_v001.aleo/spend r5 r5.amount into r13;
    call puzzle_arcade_ticket_v001.aleo/spend r6 r6.amount into r14;
    call puzzle_arcade_ticket_v001.aleo/spend r7 r7.amount into r15;
    add r0.amount r1.amount into r16;
    add r16 r2.amount into r17;
    add r17 r3.amount into r18;
    add r18 r4.amount into r19;
    add r19 r5.amount into r20;
    add r20 r6.amount into r21;
    add r21 r7.amount into r22;
    call puzzle_arcade_ticket_v001.aleo/mint self.signer r22 into r23 r24;
    async join8 r24 into r25;
    output r23 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r25 as par_ticket_joins_v1.aleo/join8.future;

finalize join8:
    input r0 as puzzle_arcade_ticket_v001.aleo/mint.future;
    await r0;

function join9:
    input r0 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r3 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r4 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r5 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r6 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r7 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r8 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v001.aleo/spend r0 r0.amount into r9;
    call puzzle_arcade_ticket_v001.aleo/spend r1 r1.amount into r10;
    call puzzle_arcade_ticket_v001.aleo/spend r2 r2.amount into r11;
    call puzzle_arcade_ticket_v001.aleo/spend r3 r3.amount into r12;
    call puzzle_arcade_ticket_v001.aleo/spend r4 r4.amount into r13;
    call puzzle_arcade_ticket_v001.aleo/spend r5 r5.amount into r14;
    call puzzle_arcade_ticket_v001.aleo/spend r6 r6.amount into r15;
    call puzzle_arcade_ticket_v001.aleo/spend r7 r7.amount into r16;
    call puzzle_arcade_ticket_v001.aleo/spend r8 r8.amount into r17;
    add r0.amount r1.amount into r18;
    add r18 r2.amount into r19;
    add r19 r3.amount into r20;
    add r20 r4.amount into r21;
    add r21 r5.amount into r22;
    add r22 r6.amount into r23;
    add r23 r7.amount into r24;
    add r24 r8.amount into r25;
    call puzzle_arcade_ticket_v001.aleo/mint self.signer r25 into r26 r27;
    async join9 r27 into r28;
    output r26 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r28 as par_ticket_joins_v1.aleo/join9.future;

finalize join9:
    input r0 as puzzle_arcade_ticket_v001.aleo/mint.future;
    await r0;

function join10:
    input r0 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r3 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r4 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r5 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r6 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r7 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r8 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r9 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v001.aleo/spend r0 r0.amount into r10;
    call puzzle_arcade_ticket_v001.aleo/spend r1 r1.amount into r11;
    call puzzle_arcade_ticket_v001.aleo/spend r2 r2.amount into r12;
    call puzzle_arcade_ticket_v001.aleo/spend r3 r3.amount into r13;
    call puzzle_arcade_ticket_v001.aleo/spend r4 r4.amount into r14;
    call puzzle_arcade_ticket_v001.aleo/spend r5 r5.amount into r15;
    call puzzle_arcade_ticket_v001.aleo/spend r6 r6.amount into r16;
    call puzzle_arcade_ticket_v001.aleo/spend r7 r7.amount into r17;
    call puzzle_arcade_ticket_v001.aleo/spend r8 r8.amount into r18;
    call puzzle_arcade_ticket_v001.aleo/spend r9 r9.amount into r19;
    add r0.amount r1.amount into r20;
    add r20 r2.amount into r21;
    add r21 r3.amount into r22;
    add r22 r4.amount into r23;
    add r23 r5.amount into r24;
    add r24 r6.amount into r25;
    add r25 r7.amount into r26;
    add r26 r8.amount into r27;
    add r27 r9.amount into r28;
    call puzzle_arcade_ticket_v001.aleo/mint self.signer r28 into r29 r30;
    async join10 r30 into r31;
    output r29 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r31 as par_ticket_joins_v1.aleo/join10.future;

finalize join10:
    input r0 as puzzle_arcade_ticket_v001.aleo/mint.future;
    await r0;

function join11:
    input r0 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r1 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r2 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r3 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r4 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r5 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r6 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r7 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r8 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r9 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r10 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    call puzzle_arcade_ticket_v001.aleo/spend r0 r0.amount into r11;
    call puzzle_arcade_ticket_v001.aleo/spend r1 r1.amount into r12;
    call puzzle_arcade_ticket_v001.aleo/spend r2 r2.amount into r13;
    call puzzle_arcade_ticket_v001.aleo/spend r3 r3.amount into r14;
    call puzzle_arcade_ticket_v001.aleo/spend r4 r4.amount into r15;
    call puzzle_arcade_ticket_v001.aleo/spend r5 r5.amount into r16;
    call puzzle_arcade_ticket_v001.aleo/spend r6 r6.amount into r17;
    call puzzle_arcade_ticket_v001.aleo/spend r7 r7.amount into r18;
    call puzzle_arcade_ticket_v001.aleo/spend r8 r8.amount into r19;
    call puzzle_arcade_ticket_v001.aleo/spend r9 r9.amount into r20;
    call puzzle_arcade_ticket_v001.aleo/spend r10 r10.amount into r21;
    add r0.amount r1.amount into r22;
    add r22 r2.amount into r23;
    add r23 r3.amount into r24;
    add r24 r4.amount into r25;
    add r25 r5.amount into r26;
    add r26 r6.amount into r27;
    add r27 r7.amount into r28;
    add r28 r8.amount into r29;
    add r29 r9.amount into r30;
    add r30 r10.amount into r31;
    call puzzle_arcade_ticket_v001.aleo/mint self.signer r31 into r32 r33;
    async join11 r33 into r34;
    output r32 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r34 as par_ticket_joins_v1.aleo/join11.future;

finalize join11:
    input r0 as puzzle_arcade_ticket_v001.aleo/mint.future;
    await r0;

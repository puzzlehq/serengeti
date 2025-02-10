import puzzle_arcade_ticket_v001.aleo;
import par_store_inventory_v5.aleo;
program par_store_14_v1.aleo;

struct Code:
    pt1 as u128;
    pt2 as u128;
    pt3 as u128;
    pt4 as u128;
    pt5 as u128;

function purchase14:
    input r0 as u16.private;
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
    input r11 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r12 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r13 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r14 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    input r15 as u64.private;
    add r1.amount r2.amount into r16;
    add r16 r3.amount into r17;
    add r17 r4.amount into r18;
    add r18 r5.amount into r19;
    add r19 r6.amount into r20;
    add r20 r7.amount into r21;
    add r21 r8.amount into r22;
    add r22 r9.amount into r23;
    add r23 r10.amount into r24;
    add r24 r11.amount into r25;
    add r25 r12.amount into r26;
    add r26 r13.amount into r27;
    add r27 r14.amount into r28;
    sub r28 r15 into r29;
    call puzzle_arcade_ticket_v001.aleo/spend r1 r1.amount into r30;
    call puzzle_arcade_ticket_v001.aleo/spend r2 r2.amount into r31;
    call puzzle_arcade_ticket_v001.aleo/spend r3 r3.amount into r32;
    call puzzle_arcade_ticket_v001.aleo/spend r4 r4.amount into r33;
    call puzzle_arcade_ticket_v001.aleo/spend r5 r5.amount into r34;
    call puzzle_arcade_ticket_v001.aleo/spend r6 r6.amount into r35;
    call puzzle_arcade_ticket_v001.aleo/spend r7 r7.amount into r36;
    call puzzle_arcade_ticket_v001.aleo/spend r8 r8.amount into r37;
    call puzzle_arcade_ticket_v001.aleo/spend r9 r9.amount into r38;
    call puzzle_arcade_ticket_v001.aleo/spend r10 r10.amount into r39;
    call puzzle_arcade_ticket_v001.aleo/spend r11 r11.amount into r40;
    call puzzle_arcade_ticket_v001.aleo/spend r12 r12.amount into r41;
    call puzzle_arcade_ticket_v001.aleo/spend r13 r13.amount into r42;
    sub r14.amount r29 into r43;
    call puzzle_arcade_ticket_v001.aleo/spend r14 r43 into r44;
    call par_store_inventory_v5.aleo/validate_purchase r0 r15 into r45;
    async purchase14 r45 into r46;
    output r44 as puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket.record;
    output r46 as par_store_14_v1.aleo/purchase14.future;

finalize purchase14:
    input r0 as par_store_inventory_v5.aleo/validate_purchase.future;
    await r0;

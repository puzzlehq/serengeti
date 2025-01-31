import puzzle_arcade_ticket_v001.aleo;

program par_ticket_joins_v1.aleo {
  transition join6(
    ticket1: PuzzleArcadeTicket,
    ticket2: PuzzleArcadeTicket,
    ticket3: PuzzleArcadeTicket,
    ticket4: PuzzleArcadeTicket,
    ticket5: PuzzleArcadeTicket,
    ticket6: PuzzleArcadeTicket
  ) -> (PuzzleArcadeTicket) {
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, ticket1.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket2, ticket2.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket3, ticket3.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket4, ticket4.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket5, ticket5.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket6, ticket6.amount);

    let joined: PuzzleArcadeTicket = PuzzleArcadeTicket {
      owner: self.signer,
      amount: ticket1.amount
        + ticket2.amount
        + ticket3.amount
        + ticket4.amount
        + ticket5.amount
    };

    return joined;
  }
}

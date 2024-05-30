program puzzle_arcade_ticket_v001.aleo {
  record PuzzleArcadeTicket {
    owner: address,
    amount: u64
  }

  transition mint(to: address, amount: u64) -> PuzzleArcadeTicket {
    // only the arcade contract can call mint
    let arcade: address = puzzle_arcade_v001.aleo;
    assert_eq(self.caller, arcade);

    let ticket: PuzzleArcadeTicket = PuzzleArcadeTicket {
      owner: to,
      amount
    };

    return (ticket);
  }

  transition join(
    ticket_one: PuzzleArcadeTicket,
    ticket_two: PuzzleArcadeTicket
  ) -> (PuzzleArcadeTicket) {
    // contracts can't call this
    assert_eq(self.caller, self.signer);

    // assert function caller is owner of both records
    assert(ticket_one.owner == self.signer);
    assert(ticket_two.owner == self.signer);

    // assert tickets have values > 0
    assert(ticket_one.amount > 0u64);
    assert(ticket_two.amount > 0u64);

    let joined: PuzzleArcadeTicket = PuzzleArcadeTicket {
      owner: self.signer,
      amount: ticket_one.amount + ticket_two.amount
    };

    return joined;
  }
}

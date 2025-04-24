program puzzle_arcade_ticket_testing.aleo {
  const OPERATOR: address = aleo1pkuty394j0000uedtqpazp4qejwmn2yshaac6qjr6wll25m9a5psuggt6d;

  // game programs that can mint tickets
  mapping registry: address => bool;

  record PuzzleArcadeTicket {
    owner: address,
    amount: u64
  }

  async transition add_program_to_registry(program_address: address) -> (Future) {
    assert_eq(self.caller, self.signer);
    assert_eq(self.caller, OPERATOR);
    return register_program(program_address);
  }

  async function register_program(program_address: address) {
    Mapping::set(registry, program_address, true);
  }

  async transition mint(public to: address, public amount: u64) -> (PuzzleArcadeTicket, Future) {
    let ticket: PuzzleArcadeTicket = PuzzleArcadeTicket {
      owner: to,
      amount
    };

    return (ticket, validate_caller(self.caller));
  }

  async function validate_caller(caller: address) {
    let registered: bool = Mapping::get_or_use(registry, caller, false);
    assert(registered);
  }

  transition spend(ticket: PuzzleArcadeTicket, public amount: u64) -> PuzzleArcadeTicket {
    assert(ticket.amount >= amount);
    return PuzzleArcadeTicket {
      owner: ticket.owner,
      amount: ticket.amount - amount
    };
  }

  transition join(
    ticket1: PuzzleArcadeTicket,
    ticket2: PuzzleArcadeTicket
  ) -> (PuzzleArcadeTicket) {
    // assert tickets have values > 0
    assert(ticket1.amount > 0u64);
    assert(ticket2.amount > 0u64);

    let joined: PuzzleArcadeTicket = PuzzleArcadeTicket {
      owner: self.signer,
      amount: ticket1.amount + ticket2.amount
    };

    return joined;
  }

  transition join3(
    ticket1: PuzzleArcadeTicket,
    ticket2: PuzzleArcadeTicket,
    ticket3: PuzzleArcadeTicket,
  ) -> (PuzzleArcadeTicket) {
    // assert tickets have values > 0
    assert(ticket1.amount > 0u64);
    assert(ticket2.amount > 0u64);
    assert(ticket3.amount > 0u64);

    let joined: PuzzleArcadeTicket = PuzzleArcadeTicket {
      owner: self.signer,
      amount: ticket1.amount + ticket2.amount + ticket3.amount
    };

    return joined;
  }

  transition join4(
    ticket1: PuzzleArcadeTicket,
    ticket2: PuzzleArcadeTicket,
    ticket3: PuzzleArcadeTicket,
    ticket4: PuzzleArcadeTicket,
  ) -> (PuzzleArcadeTicket) {
    // assert tickets have values > 0
    assert(ticket1.amount > 0u64);
    assert(ticket2.amount > 0u64);
    assert(ticket3.amount > 0u64);
    assert(ticket4.amount > 0u64);

    let joined: PuzzleArcadeTicket = PuzzleArcadeTicket {
      owner: self.signer,
      amount: ticket1.amount + ticket2.amount + ticket3.amount + ticket4.amount
    };

    return joined;
  }

  transition join5(
    ticket1: PuzzleArcadeTicket,
    ticket2: PuzzleArcadeTicket,
    ticket3: PuzzleArcadeTicket,
    ticket4: PuzzleArcadeTicket,
    ticket5: PuzzleArcadeTicket
  ) -> (PuzzleArcadeTicket) {
    // assert tickets have values > 0
    assert(ticket1.amount > 0u64);
    assert(ticket2.amount > 0u64);
    assert(ticket3.amount > 0u64);
    assert(ticket4.amount > 0u64);
    assert(ticket5.amount > 0u64);

    let joined: PuzzleArcadeTicket = PuzzleArcadeTicket {
      owner: self.signer,
      amount: ticket1.amount + ticket2.amount + ticket3.amount + ticket4.amount + ticket5.amount
    };

    return joined;
  }

}

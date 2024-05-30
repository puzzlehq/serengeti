program puzzle_arcade_ticket_v001.aleo {

  // game programs that can mint tickets
  mapping registry: address => bool;

  record PuzzleArcadeTicket {
    owner: address,
    amount: u64
  }

  async transition add_program_to_registry(program_address: address) -> (Future) {
    assert_eq(self.caller, self.signer);
    assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);
    return register_program(program_address);
  }

  async function register_program(program_address: address) {
    Mapping::set(registry, program_address, true);
  }

  async transition mint(to: address, amount: u64) -> (PuzzleArcadeTicket, Future) {
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

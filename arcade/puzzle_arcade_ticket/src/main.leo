program puzzle_arcade_ticket_v001.aleo {

  record PuzzleArcadeTicket {
    owner: address,
    amount: u64
  }

  // transition mint_private(amount: u64, to: address) -> PuzzleArcadeTicket {
  //   let admin: address = aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw;
  //   assert_eq(self.caller, self.signer);
  //   assert_eq(self.caller, admin);

  //   let ticket: PuzzleArcadeTicket = PuzzleArcadeTicket {
  //     owner: to,
  //     amount
  //   };

  //   return (ticket);
  // }

}

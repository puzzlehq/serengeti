import puzzle_arcade_v001.aleo;

program puzzle_spinner_v001.aleo {
    transition spin(
      public result: u64,
      arcade_coin: puzzle_arcade_v001.aleo/PuzzleArcadeCoin.record
    ) -> puzzle_arcade_v001.aleo/PuzzleArcadeTicket.record {
        // assert arcade operator is the caller
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);

        // mint tickets
        let tickets: puzzle_arcade_v001.aleo/PuzzleArcadeTicket = puzzle_arcade_v001.aleo/mint_tickets (
          arcade_coin,
          result
        );

        // deduct 1 coin
        let new_coin: puzzle_arcade_v001.aleo/

        // return tickets
        return (tickets, new_coin);
    }
}

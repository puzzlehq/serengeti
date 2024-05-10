import puzzle_arcade_v001.aleo;

// The 'puzzle_spinner' program.
program puzzle_spinner_v001.aleo {
    transition spin(
      public result: u64,
      arcade_coin: puzzle_arcade_v001.aleo/PuzzleArcadeCoin.record
    ) -> puzzle_arcade_v001.aleo/PuzzleArcadeTicket.record {
        // assert arcade operator is the caller
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);

        // mint tickets (or just cast it?)
        let tickets: puzzle_arcade_v001.aleo/PuzzleArcadeTicket = puzzle_arcade_v001.aleo/mint_tickets {
          owner: arcade_coin.owner,
          amount: result
        };

        // return tickets, burn coin
        return (tickets);
    }
}

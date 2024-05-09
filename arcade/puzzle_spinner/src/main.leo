import puzzle_arcade_v001.aleo;

// The 'puzzle_spinner' program.
program puzzle_spinner_v001.aleo {
    transition spin(
      public tickets: u32,
      arcade_coin: puzzle_arcade_v001.aleo/PuzzleArcadeCoin.record
    ) -> puzzle_arcade_v001.aleo/PuzzleArcadeTicket.record {
        // assert arcade operator is the caller
        // mint tickets (or just cast it?)
        // burn coin
        // return tickets
    }
}

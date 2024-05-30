import puzzle_arcade_coin_v001.aleo;
import puzzle_arcade_ticket_v001.aleo;
import puzzle_arcade_v001.aleo;

program puzzle_spinner_v001.aleo {
  transition spin(
    public result: u64,
    coin: puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin
  ) -> puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket {
    // assert arcade operator is the caller
    assert_eq(self.caller, self.signer);
    assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);

    let tickets: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket = puzzle_arcade_v001.aleo/mint (
      coin,
      result
    );

    return (tickets);
  }
}

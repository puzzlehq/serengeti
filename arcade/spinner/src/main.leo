import puzzle_arcade_coin_v001.aleo;
import puzzle_arcade_ticket_v001.aleo;

program puzzle_spinner_v001.aleo {
  async transition spin(
    public result: u64,
    coin: puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket, Future) {
    // assert arcade operator is the caller
    assert_eq(self.caller, self.signer);
    assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);

    let (ticket, future): (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket, Future) = puzzle_arcade_ticket_v001.aleo/mint (
      coin.owner,
      result
    );

    return (ticket, await_mint(future));
  }
  async function await_mint(f: Future) {
    f.await();
  }
}

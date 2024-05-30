import puzzle_arcade_coin_v001.aleo;
import puzzle_arcade_ticket_v001.aleo;

program puzzle_arcade_v001.aleo {

  // todo - use program registry as mapping instead of hardcoded

  transition mint(
    coin: puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin,
    amount: u64
  ) -> puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket {
    let spinner: address = puzzle_spinner_v001.aleo;
    assert_eq(self.caller, spinner);

    let ticket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_v001.aleo/mint (
      coin.owner,
      amount
    );

    return (ticket);
  }
}

import puzzle_arcade_coin_v002.aleo;
import puzzle_arcade_ticket_v001.aleo;

program puzzle_spinner_v002.aleo {
  struct Message {
    field_1: field,
    field_2: field,
    field_3: field,
    field_4: field,
    field_5: field,
  }

  async transition spin(
    public result: u64,
    coin: puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin,
    message_1: field,
    message_2: field,
    message_3: field,
    message_4: field,
    message_5: field,
    sig: signature,
  ) -> (puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin, puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket, Future) {
    // verify signature to guarantee arcade operator's consent
    let msg: Message = Message {
      field_1: message_1,
      field_2: message_2,
      field_3: message_3,
      field_4: message_4,
      field_5: message_5
    };
    assert_eq(sig.verify(aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw, msg), true);

    let spent_coin: puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin = puzzle_arcade_coin_v002.aleo/spend (coin);

    let (ticket, future): (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket, Future) = puzzle_arcade_ticket_v001.aleo/mint (
      coin.owner,
      result
    );

    return (spent_coin, ticket, await_mint(future));
  }
  async function await_mint(f: Future) {
    f.await();
  }
}

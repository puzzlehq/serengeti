import puzzle_arcade_coin_v001.aleo;
import puzzle_arcade_ticket_v001.aleo;

program cat_charmer_testing.aleo {
  const OPERATOR: address = aleo1lvcratjds9m4cyq099at825x8076jlrcw5jj39kwk6ja5l2ktsqqz5v83a;
  mapping used_nonces: field => bool;

  struct Result {
    nonce: field,
    tickets: u64
  }

  async transition submit_game(
    coin: puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin,
    public result: Result,
    sig: signature,
  ) -> (puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin, puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket, Future) {
    // verify signature to guarantee arcade operator's consent
    assert(sig.verify(OPERATOR, result));

    // verify tickets is valid amount
    let valid_tickets: bool = result.tickets <= 15000000u64;

    assert(valid_tickets);

    let spent_coin: puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin = puzzle_arcade_coin_v001.aleo/spend (coin, 1000000u64);

    let (ticket, future): (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket, Future) = puzzle_arcade_ticket_v001.aleo/mint (
      coin.owner,
      result.tickets
    );

    return (spent_coin, ticket, await_mint_and_verify_nonce(future, result.nonce));
  }

  async function await_mint_and_verify_nonce(f: Future, nonce: field) {
    // verify the nonce is unused
    let nonce_is_used: bool = Mapping::get_or_use(used_nonces, nonce, false);
    assert_eq(nonce_is_used, false);
    Mapping::set(used_nonces, nonce, true);
    f.await();
  }
}

import puzzle_arcade_coin_v001.aleo;
import puzzle_arcade_ticket_v001.aleo;

program par_spinner_v3.aleo {
  const OPERATOR: address = aleo196a39wq9q8ea779cmlmff0c9pj2gl4f5e8fhjpvmufe5utuq7y8snz4h2l;
  mapping used_nonces: field => bool;

  struct Result {
    nonce: field,
    tickets: u64
  }

  async transition spin(
    coin: puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin,
    public result: Result,
    sig: signature,
  ) -> (puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin, puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket, Future) {
    // verify signature to guarantee arcade operator's consent
    assert(sig.verify(OPERATOR, result));

    // verify tickets is valid amount
    let valid_tickets: bool = result.tickets == 0u64 || result.tickets == 1000000u64 || result.tickets == 2000000u64 || result.tickets == 3000000u64 || result.tickets == 5000000u64 || result.tickets == 10000000u64;
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

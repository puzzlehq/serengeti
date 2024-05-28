program puzzle_arcade_v001.aleo {

  record PuzzleArcadeCoin {
    owner: address,
    amount: u64
  }

  record PuzzleArcadeTicket {
    owner: address,
    amount: u64
  }

  transition mint_coin(to: address) -> PuzzleArcadeCoin {
    assert_eq(self.caller, self.signer);
    assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);

    let coin: PuzzleArcadeCoin = PuzzleArcadeCoin {
      owner: to,
      amount: 1000000u64
    };

    return (coin);
  }

  // future: only puzzle_spinner should be able to call this
  transition mint_tickets(coin: PuzzleArcadeCoin, amount: u64) -> PuzzleArcadeTicket {
    // let a: address = puzzle_spinner_v001.aleo;
    // assert_eq(self.caller, a);

    let ticket: PuzzleArcadeTicket = PuzzleArcadeTicket {
      owner: coin.owner,
      amount
    };

    return (ticket);
  }

}

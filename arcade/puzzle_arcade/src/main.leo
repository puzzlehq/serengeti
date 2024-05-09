program puzzle_arcade_v001.aleo {

  record PuzzleArcadeCoin {
    owner: address,
    amount: u64
  }

  record PuzzleArcadeTicket {
    owner: address,
    amount: u64
  }

  transition mint_coins(amount: u64, to: address) -> PuzzleArcadeCoin {
    let admin: address = aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw;
    assert_eq(self.caller, self.signer);
    assert_eq(self.caller, admin);

    let coin: PuzzleArcadeCoin = PuzzleArcadeCoin {
      owner: to,
      amount
    };

    return (coin);
  }

}

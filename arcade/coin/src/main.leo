program puzzle_arcade_coin_v001.aleo {
  record PuzzleArcadeCoin {
    owner: address,
    amount: u64
  }

  transition mint(public to: address, public amount: u64) -> PuzzleArcadeCoin {
    assert_eq(self.caller, self.signer);
    assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);

    let coin: PuzzleArcadeCoin = PuzzleArcadeCoin {
      owner: to,
      amount
    };

    return (coin);
  }

  transition spend(coin: PuzzleArcadeCoin, public amount: u64) -> PuzzleArcadeCoin {
    assert(coin.amount >= amount);
    return PuzzleArcadeCoin {
      owner: coin.owner,
      amount: coin.amount - amount
    };
  }
}

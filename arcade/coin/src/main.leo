program puzzle_arcade_coin_v002.aleo {
  const OPERATOR: address = aleo196a39wq9q8ea779cmlmff0c9pj2gl4f5e8fhjpvmufe5utuq7y8snz4h2l;

  record PuzzleArcadeCoin {
    owner: address,
    amount: u64
  }

  transition mint(public to: address, public amount: u64) -> PuzzleArcadeCoin {
    assert_eq(self.caller, self.signer);
    assert_eq(self.caller, OPERATOR);

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

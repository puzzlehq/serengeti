program puzzle_arcade_coin_v002.aleo {
  // game programs that can mint coins
  mapping registry: address => bool;

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

  async transition add_program_to_registry(program_address: address) -> (Future) {
    assert_eq(self.caller, self.signer);
    assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);
    return register_program(program_address);
  }

  async function register_program(program_address: address) {
    Mapping::set(registry, program_address, true);
  }

  async transition mint_program(public to: address, public amount: u64) -> (PuzzleArcadeCoin, Future) {
    let coin: PuzzleArcadeCoin = PuzzleArcadeCoin {
      owner: to,
      amount
    };

    return (coin, validate_caller(self.caller));
  }

  async function validate_caller(caller: address) {
    assert(Mapping::get_or_use(registry, caller, false));
  }
}

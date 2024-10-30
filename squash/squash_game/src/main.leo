import squash_time_oracle.aleo;

program squash_game.aleo {
  const SECONDS_IN_DAY: u64 = 86_400u64;

  record Squash {
    owner: address,
    kg: u64,
    last_water: u64 // Timestamp.time
  }

  transition mint (owner: address, timestamp: squash_time_oracle.aleo/Timestamp) -> Squash {
    return Squash {
      owner,
      kg: 0u64,
      last_water: timestamp.time
    };
  }

  transition water (
    squash: Squash,
    timestamp: squash_time_oracle.aleo/Timestamp
  ) -> Squash {
    // missed a day?
    if squash.last_water < timestamp.time - SECONDS_IN_DAY {
      let days_missed: u64 = (timestamp.time - squash.last_water) % SECONDS_IN_DAY;
      return Squash {
        owner: squash.owner,
        kg: squash.kg - (days_missed / 2000000u64),
        last_water: timestamp.time
      };
    // watered yesterday?
    } else if squash.last_water < timestamp.time {
      return Squash {
        owner: squash.owner,
        kg: squash.kg + 1u64,
        last_water: timestamp.time
      };
    } else {
      // double-water attempt -- noop
      return squash;
    }
  }
}

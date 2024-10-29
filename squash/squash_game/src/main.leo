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
    let watered_yesterday: bool = squash.last_water < timestamp.time - SECONDS_IN_DAY;

    if watered_yesterday {
      return Squash {
      owner: squash.owner,
      kg: squash.kg + 1u64,
      last_water: timestamp.time
    };
    } else {
      let days_missed: u64 = (timestamp.time - squash.last_water) % SECONDS_IN_DAY;
      return Squash {
        owner: squash.owner,
        kg: squash.kg - days_missed,
        last_water: timestamp.time
      };
    }
  }
}

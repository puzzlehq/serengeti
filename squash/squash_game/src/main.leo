import squash_time_oracle.aleo;

program squash_testing_4.aleo {
  record Squash {
    owner: address,
    kg: u64,
    last_water: u64 // Timestamp.time
  }

  // fee: 0.001505
  transition mint (owner: address, timestamp: squash_time_oracle.aleo/Timestamp) -> Squash {
    return Squash {
      owner,
      kg: 0u64,
      last_water: timestamp.time
    };
  }

  // fee: 0.002049
  transition water (
    squash: Squash, // 1731561125
    timestamp: squash_time_oracle.aleo/Timestamp, // 1731561000
    public now: u64, // 1731561220
    public delta: u64 // 600
  ) -> Squash {
    // missed a day?
    //    1731561125     <   1731561000 - 600
    if squash.last_water < timestamp.time - delta {
      let days_missed: u64 = ((timestamp.time - squash.last_water) / delta) + 1u64;
      let kg_penalty: u64 = days_missed / 2000000u64;
      let new_kg: u64 = squash.kg < kg_penalty ? 0u64 : squash.kg - kg_penalty;
      return Squash {
        owner: squash.owner,
        kg: new_kg,
        last_water: now
      };
    // watered yesterday?
    } else if squash.last_water < timestamp.time {
      return Squash {
        owner: squash.owner,
        kg: squash.kg + 1u64,
        last_water: now
      };
    } else {
      // double-water attempt -- bail
      assert(false);
      return squash;
    }
  }
}

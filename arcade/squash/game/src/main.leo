// testnet
// import timestamp_testing.aleo;
// import squash_testing.aleo;
// import puzzle_arcade_ticket_v001.aleo;
// import puzzle_arcade_coin_v001.aleo;

// mainnet
import squash_timestamp.aleo;
import squash_v2.aleo;
import puzzle_arcade_ticket_v002.aleo;
import puzzle_arcade_coin_v002.aleo;

program squash_v3.aleo {
  record Squash {
    owner: address,
    kg: u64,
    last_water: u64, // Timestamp.time
    level: u8, // one-way-street leveling system (aka this only goes up in order to protect against level-up-farmers)
    squash_name: u128,
    squash_id: u32, // random number, used to differentiate two squashes with the same name
  }

  // fee: 0.001505
  transition mint (parc: puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin, owner: address, squash_name: u128, squash_id: u32, timestamp: squash_timestamp.aleo/Timestamp) -> Squash {
    puzzle_arcade_coin_v002.aleo/spend(parc, parc.amount);
    return Squash {
      owner,
      kg: 1000000u64,
      last_water: timestamp.time,
      level: 0u8,
      squash_name,
      squash_id
    };
  }

  transition migrate_from_v2 (squash: squash_v2.aleo/Squash, squash_id: u32, timestamp: squash_timestamp.aleo/Timestamp) -> Squash {
    const OPERATOR: address = aleo12e0yyyqw0lfff8nufdss94k5hml9d9jl45rlfwu5l3e73wpu9s8sdznsev;
    assert_eq(self.caller, OPERATOR);

    let new_level: u8 = (squash.kg / 10000000u64) as u8;

    return Squash {
      owner: squash.owner,
      kg: squash.kg,
      last_water: timestamp.time,
      level: new_level,
      squash_name: squash.squash_name,
      squash_id
    };
  }

  // fee: 0.002049
  transition water (
    squash: Squash,
    timestamp: squash_timestamp.aleo/Timestamp,
    public now: u64,
    public delta: u64
  ) -> Squash {
    assert(now >= timestamp.time);
    assert(now >= squash.last_water);
    assert(timestamp.time >= squash.last_water);
    // missed a day?
    if squash.last_water < (timestamp.time - delta) {
      let days_missed: u64 = ((timestamp.time - squash.last_water) / delta) as u64;
      let kg_penalty: u64 = ((days_missed * 1000000u64) / 2u64) as u64;

      let squash_kg_i: i64 = squash.kg as i64;
      let kg_penalty_i: i64 = kg_penalty as i64;
      let diff_i: i64 = squash_kg_i - kg_penalty_i;
      let new_kg_i: i64 = squash_kg_i <= kg_penalty_i ? 0i64 : diff_i;

      let new_kg: u64 = new_kg_i as u64;
      return Squash {
        owner: squash.owner,
        kg: new_kg + 1000000u64,
        last_water: now,
        level: squash.level,
        squash_name: squash.squash_name,
        squash_id: squash.squash_id
      };
    // watered yesterday?
    } else if squash.last_water < timestamp.time {
      return Squash {
        owner: squash.owner,
        kg: squash.kg + 1000000u64,
        last_water: now,
        level: squash.level,
        squash_name: squash.squash_name,
        squash_id: squash.squash_id
      };
    } else {
      // double-water attempt -- bail
      assert(false);
      // make the compiler happy
      return squash;
    }
  }

  // only call this if the watering should level the squash up!
  async transition water_and_level_up(
    squash: Squash,
    timestamp: squash_timestamp.aleo/Timestamp,
    public now: u64,
    public delta: u64
  ) -> (Squash, puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket, Future) {
    assert(now >= timestamp.time);
    assert(now >= squash.last_water);
    assert(timestamp.time >= squash.last_water);

    if squash.last_water < (timestamp.time - delta - delta) {
      // missed two days? call water
      assert(false);
    // watered within two days?
    } else if squash.last_water < timestamp.time {
      // noop (pass-through case)
    } else {
      // double-water attempt -- bail
      assert(false);
    }

    // calculate new kg and new expected level
    // note: this assumes each level is 10kgs apart
    let new_kg: u64 = squash.kg + 1000000u64;
    let new_level: u8 = (new_kg / 10000000u64) as u8;

    // is this expected level is greater than the squash's current level?
    assert(new_level > squash.level);

    // mint the PART
    let (tickets, future): (puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket, Future) = puzzle_arcade_ticket_v002.aleo/mint (
      squash.owner,
      (new_level as u64) * 10000000u64
    );
    // return watered Squash, tickets, and await the ticket-minting
    return (
      Squash {
        owner: squash.owner,
        kg: new_kg,
        last_water: now,
        level: new_level,
        squash_name: squash.squash_name,
        squash_id: squash.squash_id
      },
      tickets,
      await_ticket_minting(future)
    );
  }
  async function await_ticket_minting(f: Future) {
    f.await();
  }
}
import timestamp_testing.aleo;
import puzzle_arcade_ticket_v001.aleo;

program squash_testing_5.aleo {
  const LEVEL_1: u64 = 10u64;
  const LEVEL_2: u64 = 20u64;
  const LEVEL_3: u64 = 30u64;
  const LEVEL_4: u64 = 40u64;
  const LEVEL_5: u64 = 50u64;

  record Squash {
    owner: address,
    kg: u64,
    last_water: u64, // Timestamp.time
    level: u8 // one-way-street leveling system (aka this only goes up in order to protect against level-up-farmers)
  }

  // fee: 0.001505
  transition mint (owner: address, timestamp: timestamp_testing.aleo/Timestamp) -> Squash {
    return Squash {
      owner,
      kg: 0u64,
      last_water: timestamp.time,
      level: 0u8
    };
  }

  // fee: 0.002049
  transition water (
    squash: Squash,
    timestamp: timestamp_testing.aleo/Timestamp,
    public now: u64,
    public delta: u64
  ) -> Squash {
    // missed a day?
    if squash.last_water < timestamp.time - delta {
      let days_missed: u64 = ((timestamp.time - squash.last_water) / delta);
      let kg_penalty: u64 = days_missed / 2000000u64;
      let new_kg: u64 = squash.kg < kg_penalty ? 0u64 : squash.kg - kg_penalty;
      return Squash {
        owner: squash.owner,
        kg: new_kg,
        last_water: now,
        level: squash.level
      };
    // watered yesterday?
    } else if squash.last_water < timestamp.time {
      return Squash {
        owner: squash.owner,
        kg: squash.kg + 1u64,
        last_water: now,
        level: squash.level
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
    timestamp: timestamp_testing.aleo/Timestamp, // 1731561000
    public now: u64, // 1731561220
    public delta: u64 // 600
  ) -> (Squash, puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket, Future) {
    if squash.last_water < timestamp.time - delta {
      // missed a day? call water
      assert(false);
    // watered yesterday?
    } else if squash.last_water < timestamp.time {
      // noop (pass-through case)
    } else {
      // double-water attempt -- bail
      assert(false);
    }

    // calculate new kg and new expected level
    // note: this assumes each level is 10kgs apart
    let new_kg: u64 = squash.kg + 1u64;
    let expected_level: u8 = (new_kg / 10u64) as u8;

    // is this expected level is greater than the squash's current level?
    assert(expected_level > squash.level);

    // mint the PART
    let (tickets, future): (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket, Future) = puzzle_arcade_ticket_v001.aleo/mint (
      squash.owner,
      (expected_level * 10u8) as u64
    );
    // return watered Squash, tickets, and await the ticket-minting
    return (
      Squash {
        owner: squash.owner,
        kg: new_kg,
        last_water: now,
        level: expected_level
      },
      tickets,
      await_ticket_minting(future)
    );
  }
  async function await_ticket_minting(f: Future) {
    f.await();
  }
}

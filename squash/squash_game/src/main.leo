import squash_time_oracle.aleo;
import puzzle_arcade_ticket_v001.aleo;

program squash_testing_4.aleo {
  const LEVEL_1: u64 = 10u64;
  const LEVEL_2: u64 = 20u64;
  const LEVEL_3: u64 = 30u64;
  const LEVEL_4: u64 = 40u64;
  const LEVEL_5: u64 = 50u64;

  record Squash {
    owner: address,
    kg: u64,
    last_water: u64 // Timestamp.time
    level: u8 // one-way-street leveling system (aka this only goes up in order to protect against level-up-farmers)
  }

  // fee: 0.001505
  transition mint (owner: address, timestamp: squash_time_oracle.aleo/Timestamp) -> Squash {
    return Squash {
      owner,
      kg: 0u64,
      last_water: timestamp.time,
      level: 0u8
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
      return squash;
    }
  }

  /**
    called post-water for a Squash that should have its level incremented

      - see if this expected level is greater than the Squash's current level
      - if so, mint it some PART
  */
  async transition level_up(squash: Squash) -> (Squash, puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket, Future) {
    // calculate the expected level from squash.kg
    // note: this assumes each level is 10kgs apart
    let expected_level: u8 = (squash.kg / 10u64) as u8;

    // assert(expected_level != 0u8 && squash.kg >= (expected_level * 10u8) as u64);
    // let new_level: u8 = expected_level + 1u8;
    // only set if the new level hasn't been met yet

    // is this expected level is greater than the Squash's current level?
    assert(expected_level > squash.level);

    // mint the PART too
    let (ticket, future): (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket, Future) = puzzle_arcade_ticket_v001.aleo/mint (
      squash.owner,
      (expected_level * 10u8) as u64
    );
    return (squash, ticket, await_ticket_minting(future));
  }
  async function await_ticket_minting(f: Future) {
    f.await();
  }
}

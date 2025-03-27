// testnet
// import squash_testing.aleo;
// import puzzle_arcade_ticket_v001.aleo;
// import puzzle_arcade_coin_v001.aleo;

// mainnet
import squash_v3.aleo;
import puzzle_arcade_ticket_v002.aleo;
import puzzle_arcade_coin_v002.aleo;

program squash_v4.aleo {
  const OPERATOR: address = aleo12e0yyyqw0lfff8nufdss94k5hml9d9jl45rlfwu5l3e73wpu9s8sdznsev;
  mapping day_start: u8 => u64;

  record Squash {
    owner: address,
    kg: u64,
    last_water: u64, // Timestamp.time
    level: u8, // one-way-street leveling system (aka this only goes up in order to protect against level-up-farmers)
    squash_name: u128,
    squash_id: u32, // random number, used to differentiate two squashes with the same name
  }

  async transition set_day_start(timestamp: u64) -> Future {
    return finalize_set_day_start(timestamp);
  }
  async function finalize_set_day_start(timestamp: u64) {
    Mapping::set(day_start, 0u8, timestamp);
  }

  // fee: ??? (old 0.001505)
  async transition mint (
    parc: puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin,
    owner: address,
    squash_name: u128,
    squash_id: u32,
    timestamp: u64
  ) -> (Squash, Future) {
    puzzle_arcade_coin_v002.aleo/spend(parc, parc.amount);
    let squash: Squash = Squash {
      owner,
      kg: 1000000u64,
      last_water: timestamp,
      level: 0u8,
      squash_name,
      squash_id
    };
    return (squash, finalize_mint(timestamp));
  }
  async function finalize_mint(timestamp: u64) {
    let current_timestamp: u64 = Mapping::get_or_use(day_start, 0u8, 0u64);
    assert_eq(timestamp, current_timestamp);
  }

  transition migrate_from_v3 (squash: squash_v3.aleo/Squash) -> Squash {
    assert_eq(self.caller, OPERATOR);
    return Squash {
      owner: squash.owner,
      kg: squash.kg,
      last_water: squash.last_water,
      level: squash.level,
      squash_name: squash.squash_name,
      squash_id: squash.squash_id
    };
  }

  // fee: 0.002049
  async transition water (
    squash: Squash,
    timestamp: u64,
    public now: u64,
    public delta: u64
  ) -> (Squash, Future) {
    assert(now >= timestamp);
    assert(now >= squash.last_water);
    assert(timestamp >= squash.last_water);

    let new_kg: u64 = squash.kg;

    // missed a day?
    if squash.last_water < (timestamp - delta) {
      let days_missed: u64 = ((timestamp - squash.last_water) / delta) as u64;
      let kg_penalty: u64 = ((days_missed * 1000000u64) / 2u64) as u64;
      let squash_kg_i: i64 = squash.kg as i64;
      let kg_penalty_i: i64 = kg_penalty as i64;
      let diff_i: i64 = squash_kg_i - kg_penalty_i;
      let new_kg_i: i64 = squash_kg_i <= kg_penalty_i ? 0i64 : diff_i;
      new_kg = new_kg_i as u64;
    // watered yesterday?
    } else if squash.last_water < timestamp {
      new_kg = squash.kg + 1000000u64;
    } else {
      // double-water attempt -- bail
      assert(false);
    }

    let watered_squash: Squash = Squash {
      owner: squash.owner,
      kg: new_kg,
      last_water: now,
      level: squash.level,
      squash_name: squash.squash_name,
      squash_id: squash.squash_id
    };
    return (watered_squash, finalize_water(timestamp));
  }
  async function finalize_water(timestamp: u64) {
    let current_timestamp: u64 = Mapping::get_or_use(day_start, 0u8, 0u64);
    assert_eq(timestamp, current_timestamp);
  }

  // only call this if the watering should level the squash up!
  async transition water_and_level_up(
    squash: Squash,
    timestamp: u64,
    public now: u64,
    public delta: u64
  ) -> (Squash, puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket, Future) {
    assert(now >= timestamp);
    assert(now >= squash.last_water);
    assert(timestamp >= squash.last_water);

    if squash.last_water < (timestamp - delta - delta) {
      // missed two days? call water
      assert(false);
    // watered within two days?
    } else if squash.last_water < timestamp {
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
    // max squash level is 4u8
    assert(new_level < 5u8);

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
      await_ticket_minting(timestamp, future)
    );
  }
  async function await_ticket_minting(timestamp: u64, f: Future) {
    let current_timestamp: u64 = Mapping::get_or_use(day_start, 0u8, 0u64);
    assert_eq(timestamp, current_timestamp);
    f.await();
  }

  // mints a squash with yesterday's timestamp so you can water today
  async transition mint_arbitrary_squash (owner: address, squash_name: u128, squash_id: u32, yesterday: u64, kg: u64, level: u8) -> (Squash, Future) {
    assert_eq(self.caller, OPERATOR);
    assert(level < 5u8);

    let squash: Squash = Squash {
      owner,
      kg,
      last_water: yesterday,
      level,
      squash_name,
      squash_id
    };
    return (squash, finalize_mint_arbitrary_squash(yesterday));
  }
  async function finalize_mint_arbitrary_squash(timestamp: u64) {
    let current_timestamp: u64 = Mapping::get_or_use(day_start, 0u8, 0u64);
    let yesterday: u64 = current_timestamp - 86400u64;
    assert_eq(timestamp, yesterday);
  }
}
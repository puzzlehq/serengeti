import puzzle_arcade_ticket_v002.aleo;
import par_store_inventory_v1.aleo;

program par_giveaways_v1.aleo {
    const OPERATOR: address = aleo196a39wq9q8ea779cmlmff0c9pj2gl4f5e8fhjpvmufe5utuq7y8snz4h2l;
    
    // whether or not a giveaway_id is accepting entries
    mapping is_open: field => bool;

    // max number of entries allowed for a giveaway_id
    mapping max_entries: field => u64;

    // used to namespace mapping keys by giveaway_id
    struct Index {
      giveaway_id: field,
      index: u64
    }

    // used for storing the raffle entries (multiple entries per address)
    //   i.e. 0 -> aleo1...asdf, 1 -> aleo1...ghjk
    // keys are hash(Index)
    mapping entries: field => address;

    // used for storing the number of entries a user has
    //   i.e. aleo1...asdf -> 5
    // keys are hash(Entrant)
    struct Entrant {
      giveaway_id: field,
      user: address
    }
    mapping user_entries: field => u16;

    // used for storing of total number of values in entries mapping
    //   i.e. 0field -> 1, 0field -> 2
    // keys are giveaway_ids
    mapping total_entries: field => u64;

    // 1u64 -> aleo1...lka
    // keys are hash(Index)
    mapping winners: field => address;
    
    // mapping to store winner aleo1... => true (if addr has won)
    // keys are hash(Entrant)
    mapping has_won: field => bool;
    
    // total number of winners
    // keys are giveaway_ids
    mapping total_winners: field => u64;

    async transition open(giveaway_id: field, maxentries: u64) -> Future {
      assert_eq(self.caller, self.signer);
      assert_eq(self.caller, OPERATOR);
      return finalize_open(giveaway_id, maxentries);
    }
    async function finalize_open(giveaway_id: field, maxentries: u64) {
      Mapping::set(is_open, giveaway_id, true);
      Mapping::set(max_entries, giveaway_id, maxentries);
    }
    async transition close(giveaway_id: field) -> Future {
      assert_eq(self.caller, self.signer);
      assert_eq(self.caller, OPERATOR);
      return finalize_close(giveaway_id);
    }
    async function finalize_close(giveaway_id: field) {
      Mapping::set(is_open, giveaway_id, false);
    }
    async transition draw_winner (giveaway_id: field) -> (Future) {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, OPERATOR);
        return await_draw_winner(giveaway_id);
    }
    async function await_draw_winner (giveaway_id: field) {
        // ensure the giveaway is closed
        assert_eq(Mapping::get_or_use(is_open, giveaway_id, false), false);

        // get total entries
        let num_entries: u64 = Mapping::get(total_entries, giveaway_id);
        // grab random number
        let random_number: u64 = ChaCha::rand_u64();
        // select winning index
        let winner_index: u64 = random_number % num_entries;
        // construct winning Index
        let winning_entry: Index = Index {
          giveaway_id,
          index: winner_index
        };
        let winning_entry_hash: field = Poseidon2::hash_to_field(winning_entry);
        // get address of winning entry
        let winner_address: address = Mapping::get(entries, winning_entry_hash);
        let winner: Entrant = Entrant {
          giveaway_id,
          user: winner_address
        };
        // true if addr has already won, false if not
        let has_addr_won: bool = Mapping::get_or_use(has_won, Poseidon2::hash_to_field(winner), false);

        // if the drawn address has already won, fail
        assert_eq(has_addr_won, false);

        // get the winner_count
        let current_winner_count: u64 = Mapping::get_or_use(total_winners, giveaway_id, 0u64);
        // set addr to true {aleo1...: true}
        Mapping::set(has_won, Poseidon2::hash_to_field(winner), true);
        // increment winner count for this giveaway
        Mapping::set(total_winners, giveaway_id, current_winner_count + 1u64);
        // record winner for this giveaway
        let current_winner_count_index: Index = Index {
          giveaway_id,
          index: current_winner_count
        };
        Mapping::set(winners, Poseidon2::hash_to_field(current_winner_count_index), winner_address);
    }

    async transition buy_one_entry (
      giveaway_id: field,
      ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket
    ) -> (
      puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket,
      Future
    ) {
        let spent_ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_v002.aleo/spend (ticket, 1000000u64);

        let entrant: Entrant = Entrant {
          giveaway_id,
          user: ticket.owner
        };
        let entrant_hash: field = Poseidon2::hash_to_field(entrant);
        return (spent_ticket, add_one_entry(ticket.owner, giveaway_id, entrant_hash));
    }
    async function add_one_entry (public user: address, public giveaway_id: field, entrant_hash: field) {
        // ensure the giveaway is open
        assert(Mapping::get_or_use(is_open, giveaway_id, false));

        // get current entries (default to 0)
        let current_entries: u64 = Mapping::get_or_use(total_entries, giveaway_id, 0u64);

        // ensure we won't go over the Mapping::get_or_use(max_entries, giveaway_id, 0u64) for this entry
        assert(current_entries + 1u64 <= Mapping::get_or_use(max_entries, giveaway_id, 0u64));

        // add entrant's entry to entries
        let entry_index: Index = Index {
          giveaway_id,
          index: current_entries
        };
        Mapping::set(entries, Poseidon2::hash_to_field(entry_index), user);

        // increment raffle total entries by 1
        Mapping::set(total_entries, giveaway_id, current_entries + 1u64);
        
        // increment user entries by 1
        let current_user_entries: u16 = Mapping::get_or_use(user_entries, entrant_hash, 0u16);
        Mapping::set(user_entries, entrant_hash, current_user_entries + 1u16);
    }

    async transition buy_two_entries (
      giveaway_id: field,
      ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket
    ) -> (
      puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket,
      Future
    ) {
        let spent_ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_v002.aleo/spend (ticket, 2000000u64);
        let entrant: Entrant = Entrant {
          giveaway_id,
          user: ticket.owner
        };
        let entrant_hash: field = Poseidon2::hash_to_field(entrant);
        return (spent_ticket, add_two_entries(ticket.owner, giveaway_id, entrant_hash));
    }
    async function add_two_entries (public user: address, public giveaway_id: field, entrant_hash: field) {
        assert(Mapping::get_or_use(is_open, giveaway_id, false));

        let current_entries: u64 = Mapping::get_or_use(total_entries, giveaway_id, 0u64);
        assert(current_entries + 2u64 <= Mapping::get_or_use(max_entries, giveaway_id, 0u64));

        for i: u64 in 0u64..2u64 {
            let entry_index: Index = Index {
                giveaway_id,
                index: current_entries + i
            };
            Mapping::set(entries, Poseidon2::hash_to_field(entry_index), user);
        }

        Mapping::set(total_entries, giveaway_id, current_entries + 2u64);
        
        let current_user_entries: u16 = Mapping::get_or_use(user_entries, entrant_hash, 0u16);
        Mapping::set(user_entries, entrant_hash, current_user_entries + 2u16);
    }

    async transition buy_three_entries (
      giveaway_id: field,
      ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket
    ) -> (
      puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket,
      Future
    ) {
        let spent_ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_v002.aleo/spend (ticket, 3000000u64);
        let entrant: Entrant = Entrant {
          giveaway_id,
          user: ticket.owner
        };
        let entrant_hash: field = Poseidon2::hash_to_field(entrant);
        return (spent_ticket, add_three_entries(ticket.owner, giveaway_id, entrant_hash));
    }
    async function add_three_entries (public user: address, public giveaway_id: field, entrant_hash: field) {
        assert(Mapping::get_or_use(is_open, giveaway_id, false));
        
        let current_entries: u64 = Mapping::get_or_use(total_entries, giveaway_id, 0u64);
        assert(current_entries + 3u64 <= Mapping::get_or_use(max_entries, giveaway_id, 0u64));

        for i: u64 in 0u64..3u64 {
            let entry_index: Index = Index {
                giveaway_id,
                index: current_entries + i
            };
            Mapping::set(entries, Poseidon2::hash_to_field(entry_index), user);
        }

        Mapping::set(total_entries, giveaway_id, current_entries + 3u64);
        
        let current_user_entries: u16 = Mapping::get_or_use(user_entries, entrant_hash, 0u16);
        Mapping::set(user_entries, entrant_hash, current_user_entries + 3u16);
    }

    async transition buy_four_entries(
      giveaway_id: field,
      ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket
    ) -> (
      puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket,
      Future
    ) {
        let spent_ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_v002.aleo/spend (ticket, 4000000u64);
        let entrant: Entrant = Entrant {
          giveaway_id,
          user: ticket.owner
        };
        let entrant_hash: field = Poseidon2::hash_to_field(entrant);
        return (spent_ticket, add_four_entries(ticket.owner, giveaway_id, entrant_hash));
    }
    async function add_four_entries(public user: address, public giveaway_id: field, entrant_hash: field) {
        assert(Mapping::get_or_use(is_open, giveaway_id, false));
        
        let current_entries: u64 = Mapping::get_or_use(total_entries, giveaway_id, 0u64);
        assert(current_entries + 4u64 <= Mapping::get_or_use(max_entries, giveaway_id, 0u64));

        for i: u64 in 0u64..4u64 {
            let entry_index: Index = Index {
                giveaway_id,
                index: current_entries + i
            };
            Mapping::set(entries, Poseidon2::hash_to_field(entry_index), user);
        }

        Mapping::set(total_entries, giveaway_id, current_entries + 4u64);
        
        let current_user_entries: u16 = Mapping::get_or_use(user_entries, entrant_hash, 0u16);
        Mapping::set(user_entries, entrant_hash, current_user_entries + 4u16);
    }

    async transition buy_five_entries(
      giveaway_id: field,
      ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket
    ) -> (
      puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket,
      Future
    ) {
        let spent_ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_v002.aleo/spend (ticket, 5000000u64);
        let entrant: Entrant = Entrant {
          giveaway_id,
          user: ticket.owner
        };
        let entrant_hash: field = Poseidon2::hash_to_field(entrant);
        return (spent_ticket, add_five_entries(ticket.owner, giveaway_id, entrant_hash));
    }
    async function add_five_entries(public user: address, public giveaway_id: field, entrant_hash: field) {
        assert(Mapping::get_or_use(is_open, giveaway_id, false));
        
        let current_entries: u64 = Mapping::get_or_use(total_entries, giveaway_id, 0u64);
        assert(current_entries + 5u64 <= Mapping::get_or_use(max_entries, giveaway_id, 0u64));

        for i: u64 in 0u64..5u64 {
            let entry_index: Index = Index {
                giveaway_id,
                index: current_entries + i
            };
            Mapping::set(entries, Poseidon2::hash_to_field(entry_index), user);
        }

        Mapping::set(total_entries, giveaway_id, current_entries + 5u64);
        
        let current_user_entries: u16 = Mapping::get_or_use(user_entries, entrant_hash, 0u16);
        Mapping::set(user_entries, entrant_hash, current_user_entries + 5u16);
    }

    async transition buy_six_entries(
      giveaway_id: field,
      ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket
    ) -> (
      puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket,
      Future
    ) {
        let spent_ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_v002.aleo/spend (ticket, 6000000u64);
        let entrant: Entrant = Entrant {
          giveaway_id,
          user: ticket.owner
        };
        let entrant_hash: field = Poseidon2::hash_to_field(entrant);
        return (spent_ticket, add_six_entries(ticket.owner, giveaway_id, entrant_hash));
    }
    async function add_six_entries(public user: address, public giveaway_id: field, entrant_hash: field) {
        assert(Mapping::get_or_use(is_open, giveaway_id, false));
        
        let current_entries: u64 = Mapping::get_or_use(total_entries, giveaway_id, 0u64);
        assert(current_entries + 6u64 <= Mapping::get_or_use(max_entries, giveaway_id, 0u64));

        for i: u64 in 0u64..6u64 {
            let entry_index: Index = Index {
                giveaway_id,
                index: current_entries + i
            };
            Mapping::set(entries, Poseidon2::hash_to_field(entry_index), user);
        }

        Mapping::set(total_entries, giveaway_id, current_entries + 6u64);
        
        let current_user_entries: u16 = Mapping::get_or_use(user_entries, entrant_hash, 0u16);
        Mapping::set(user_entries, entrant_hash, current_user_entries + 6u16);
    }

    async transition buy_seven_entries(
      giveaway_id: field,
      ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket
    ) -> (
      puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket,
      Future
    ) {
        let spent_ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_v002.aleo/spend (ticket, 7000000u64);
        let entrant: Entrant = Entrant {
          giveaway_id,
          user: ticket.owner
        };
        let entrant_hash: field = Poseidon2::hash_to_field(entrant);
        return (spent_ticket, add_seven_entries(ticket.owner, giveaway_id, entrant_hash));
    }
    async function add_seven_entries(public user: address, public giveaway_id: field, entrant_hash: field) {
        assert(Mapping::get_or_use(is_open, giveaway_id, false));
        
        let current_entries: u64 = Mapping::get_or_use(total_entries, giveaway_id, 0u64);
        assert(current_entries + 7u64 <= Mapping::get_or_use(max_entries, giveaway_id, 0u64));

        for i: u64 in 0u64..7u64 {
            let entry_index: Index = Index {
                giveaway_id,
                index: current_entries + i
            };
            Mapping::set(entries, Poseidon2::hash_to_field(entry_index), user);
        }

        Mapping::set(total_entries, giveaway_id, current_entries + 7u64);
        
        let current_user_entries: u16 = Mapping::get_or_use(user_entries, entrant_hash, 0u16);
        Mapping::set(user_entries, entrant_hash, current_user_entries + 7u16);
    }

    async transition buy_eight_entries(
      giveaway_id: field,
      ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket
    ) -> (
      puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket,
      Future
    ) {
        let spent_ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_v002.aleo/spend (ticket, 8000000u64);
        let entrant: Entrant = Entrant {
          giveaway_id,
          user: ticket.owner
        };
        let entrant_hash: field = Poseidon2::hash_to_field(entrant);
        return (spent_ticket, add_eight_entries(ticket.owner, giveaway_id, entrant_hash));
    }
    async function add_eight_entries(public user: address, public giveaway_id: field, entrant_hash: field) {
        assert(Mapping::get_or_use(is_open, giveaway_id, false));
        
        let current_entries: u64 = Mapping::get_or_use(total_entries, giveaway_id, 0u64);
        assert(current_entries + 8u64 <= Mapping::get_or_use(max_entries, giveaway_id, 0u64));

        for i: u64 in 0u64..8u64 {
            let entry_index: Index = Index {
                giveaway_id,
                index: current_entries + i
            };
            Mapping::set(entries, Poseidon2::hash_to_field(entry_index), user);
        }

        Mapping::set(total_entries, giveaway_id, current_entries + 8u64);
        
        let current_user_entries: u16 = Mapping::get_or_use(user_entries, entrant_hash, 0u16);
        Mapping::set(user_entries, entrant_hash, current_user_entries + 8u16);
    }

    async transition buy_nine_entries(
      giveaway_id: field,
      ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket
    ) -> (
      puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket,
      Future
    ) {
        let spent_ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_v002.aleo/spend (ticket, 9000000u64);
        let entrant: Entrant = Entrant {
          giveaway_id,
          user: ticket.owner
        };
        let entrant_hash: field = Poseidon2::hash_to_field(entrant);
        return (spent_ticket, add_nine_entries(ticket.owner, giveaway_id, entrant_hash));
    }
    async function add_nine_entries(public user: address, public giveaway_id: field, entrant_hash: field) {
        assert(Mapping::get_or_use(is_open, giveaway_id, false));
        
        let current_entries: u64 = Mapping::get_or_use(total_entries, giveaway_id, 0u64);
        assert(current_entries + 9u64 <= Mapping::get_or_use(max_entries, giveaway_id, 0u64));

        for i: u64 in 0u64..9u64 {
            let entry_index: Index = Index {
                giveaway_id,
                index: current_entries + i
            };
            Mapping::set(entries, Poseidon2::hash_to_field(entry_index), user);
        }

        Mapping::set(total_entries, giveaway_id, current_entries + 9u64);

        let current_user_entries: u16 = Mapping::get_or_use(user_entries, entrant_hash, 0u16);
        Mapping::set(user_entries, entrant_hash, current_user_entries + 9u16);
    }

    async transition buy_ten_entries(
      giveaway_id: field,
      ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket
    ) -> (
      puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket,
      Future
    ) {
        let spent_ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_v002.aleo/spend (ticket, 10000000u64);
        let entrant: Entrant = Entrant {
          giveaway_id,
          user: ticket.owner
        };
        let entrant_hash: field = Poseidon2::hash_to_field(entrant);
        return (spent_ticket, add_ten_entries(ticket.owner, giveaway_id, entrant_hash));
    }
    async function add_ten_entries(public user: address, public giveaway_id: field, entrant_hash: field) {
        assert(Mapping::get_or_use(is_open, giveaway_id, false));
        
        let current_entries: u64 = Mapping::get_or_use(total_entries, giveaway_id, 0u64);
        assert(current_entries + 10u64 <= Mapping::get_or_use(max_entries, giveaway_id, 0u64));

        for i: u64 in 0u64..10u64 {
            let entry_index: Index = Index {
                giveaway_id,
                index: current_entries + i
            };
            Mapping::set(entries, Poseidon2::hash_to_field(entry_index), user);
        }

        Mapping::set(total_entries, giveaway_id, current_entries + 10u64);
        
        let current_user_entries: u16 = Mapping::get_or_use(user_entries, entrant_hash, 0u16);
        Mapping::set(user_entries, entrant_hash, current_user_entries + 10u16);
    }
}
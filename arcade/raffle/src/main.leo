import puzzle_arcade_ticket_v002.aleo;

program puzzle_raffle_092524_v2.aleo {
    const OPERATOR: address = aleo196a39wq9q8ea779cmlmff0c9pj2gl4f5e8fhjpvmufe5utuq7y8snz4h2l;

    // used for storing the raffle entries (multiple entries per address)
    //   i.e. 0 -> aleo1...asdf, 1 -> aleo1...ghjk
    mapping entries: u64 => address;
    // used for storing the number of entries a user has
    //   i.e. aleo1...asdf -> 5
    mapping user_entries: address => u16;
    // used for storing of total number of values in entries mapping
    //   i.e. 0 -> 1, 0 -> 2
    mapping total_entries: u64 => u64;
    // 1u64 -> aleo1...lka
    mapping winner: u64 => address;
    // mapping to store winner aleo1... => true (if addr has won)
    mapping has_won: address => bool;
    // total number of winners
    mapping winner_count: u64 => u64;

    struct PrivateKey {
        pk_pt1: u128,
        pk_pt2: u128
    }

    record Prize {
        owner: address,
        private_key: PrivateKey,
    }

    record AuditPrize {
        owner: address,
        minter: address,
        private_key: PrivateKey,
    }

    transition mint_prize (pk_pt1: u128, pk_pt2: u128) -> (Prize, AuditPrize) {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, OPERATOR);

        let prize: Prize = Prize {
            owner: OPERATOR,
            private_key: PrivateKey {
                pk_pt1: pk_pt1,
                pk_pt2: pk_pt2
            },
        };

        let audit_prize: AuditPrize = AuditPrize {
            owner: OPERATOR,
            minter: OPERATOR,
            private_key: PrivateKey {
                pk_pt1: pk_pt1,
                pk_pt2: pk_pt2
            },
        };

        return (prize, audit_prize);
    }

    async transition buy_one_entry (ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket) -> (
      puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket,
      Future
    ) {
        let spent_ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_v002.aleo/spend (ticket, 1000000u64);
        return (spent_ticket, add_one_entry(ticket.owner));
    }
    async function add_one_entry (public participant: address) {
        // get current raffle count, if first entry, choose default of 0u64
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);
        // add address to entry mapping
        Mapping::set(entries, current_raffle_count, participant);
        // increment raffle total entries by 1
        Mapping::set(total_entries, 0u64, current_raffle_count + 1u64);
        // increment user entries by 1
        let current_user_entries: u16 = Mapping::get_or_use(user_entries, participant, 0u16);
        Mapping::set(user_entries, participant, current_user_entries + 1u16);
    }

    async transition buy_two_entries (ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket) -> (
      puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket,
      Future
    ) {
        let spent_ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_v002.aleo/spend (ticket, 2000000u64);
        return (spent_ticket, add_two_entries(ticket.owner));
    }
    async function add_two_entries (public participant: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);
        
        for i: u64 in 0u64..2u64 {
          Mapping::set(entries, current_raffle_count + i, participant);
        }

        Mapping::set(total_entries, 0u64, current_raffle_count + 2u64);

        let current_user_entries: u16 = Mapping::get_or_use(user_entries, participant, 0u16);
        Mapping::set(user_entries, participant, current_user_entries + 2u16);
    }

    async transition buy_three_entries (ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket) -> (
      puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket,
      Future
    ) {
        let spent_ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_v002.aleo/spend (ticket, 3000000u64);
        return (spent_ticket, add_three_entries(ticket.owner));
    }
    async function add_three_entries (public participant: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);
        
        for i: u64 in 0u64..3u64 {
          Mapping::set(entries, current_raffle_count + i, participant);
        }

        Mapping::set(total_entries, 0u64, current_raffle_count + 3u64);

        let current_user_entries: u16 = Mapping::get_or_use(user_entries, participant, 0u16);
        Mapping::set(user_entries, participant, current_user_entries + 3u16);
    }

    async transition buy_four_entries(ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket) -> (
      puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket,
      Future
    ) {
        let spent_ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_v002.aleo/spend (ticket, 4000000u64);
        return (spent_ticket, add_four_entries(ticket.owner));
    }
    async function add_four_entries(public participant: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);
        
        for i: u64 in 0u64..4u64 {
          Mapping::set(entries, current_raffle_count + i, participant);
        }

        Mapping::set(total_entries, 0u64, current_raffle_count + 4u64);

        let current_user_entries: u16 = Mapping::get_or_use(user_entries, participant, 0u16);
        Mapping::set(user_entries, participant, current_user_entries + 4u16);
    }

    async transition buy_five_entries(ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket) -> (
      puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket,
      Future
    ) {
        let spent_ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_v002.aleo/spend (ticket, 5000000u64);
        return (spent_ticket, add_five_entries(ticket.owner));
    }
    async function add_five_entries(public participant: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);
        
        for i: u64 in 0u64..5u64 {
          Mapping::set(entries, current_raffle_count + i, participant);
        }

        Mapping::set(total_entries, 0u64, current_raffle_count + 5u64);

        let current_user_entries: u16 = Mapping::get_or_use(user_entries, participant, 0u16);
        Mapping::set(user_entries, participant, current_user_entries + 5u16);
    }

    async transition buy_six_entries(ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket) -> (
      puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket,
      Future
    ) {
        let spent_ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_v002.aleo/spend (ticket, 6000000u64);
        return (spent_ticket, add_six_entries(ticket.owner));
    }
    async function add_six_entries(public participant: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);
        
        for i: u64 in 0u64..6u64 {
          Mapping::set(entries, current_raffle_count + i, participant);
        }

        Mapping::set(total_entries, 0u64, current_raffle_count + 6u64);

        let current_user_entries: u16 = Mapping::get_or_use(user_entries, participant, 0u16);
        Mapping::set(user_entries, participant, current_user_entries + 6u16);
    }

    async transition buy_seven_entries(ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket) -> (
      puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket,
      Future
    ) {
        let spent_ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_v002.aleo/spend (ticket, 7000000u64);
        return (spent_ticket, add_seven_entries(ticket.owner));
    }
    async function add_seven_entries(public participant: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);
        
        for i: u64 in 0u64..7u64 {
          Mapping::set(entries, current_raffle_count + i, participant);
        }

        Mapping::set(total_entries, 0u64, current_raffle_count + 7u64);

        let current_user_entries: u16 = Mapping::get_or_use(user_entries, participant, 0u16);
        Mapping::set(user_entries, participant, current_user_entries + 7u16);
    }

    async transition buy_eight_entries(ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket) -> (
      puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket,
      Future
    ) {
        let spent_ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_v002.aleo/spend (ticket, 8000000u64);
        return (spent_ticket, add_eight_entries(ticket.owner));
    }
    async function add_eight_entries(public participant: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);

        for i: u64 in 0u64..8u64 {
          Mapping::set(entries, current_raffle_count + i, participant);
        }

        Mapping::set(total_entries, 0u64, current_raffle_count + 8u64);

        let current_user_entries: u16 = Mapping::get_or_use(user_entries, participant, 0u16);
        Mapping::set(user_entries, participant, current_user_entries + 8u16);
    }

    async transition buy_nine_entries(ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket) -> (
      puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket,
      Future
    ) {
        let spent_ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_v002.aleo/spend (ticket, 9000000u64);
        return (spent_ticket, add_nine_entries(ticket.owner));
    }
    async function add_nine_entries(public participant: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);

        for i: u64 in 0u64..9u64 {
          Mapping::set(entries, current_raffle_count + i, participant);
        }

        Mapping::set(total_entries, 0u64, current_raffle_count + 9u64);

        let current_user_entries: u16 = Mapping::get_or_use(user_entries, participant, 0u16);
        Mapping::set(user_entries, participant, current_user_entries + 9u16);
    }

    async transition buy_ten_entries(ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket) -> (
      puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket,
      Future
    ) {
        let spent_ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_v002.aleo/spend (ticket, 10000000u64);
        return (spent_ticket, add_ten_entries(ticket.owner));
    }
    async function add_ten_entries(public participant: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);
        
        for i: u64 in 0u64..10u64 {
          Mapping::set(entries, current_raffle_count + i, participant);
        }

        Mapping::set(total_entries, 0u64, current_raffle_count + 10u64);

        let current_user_entries: u16 = Mapping::get_or_use(user_entries, participant, 0u16);
        Mapping::set(user_entries, participant, current_user_entries + 10u16);
    }

    // todo: allow draw winner to only be called once
    async transition draw_winner () -> (Future) {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, OPERATOR);
        return await_draw_winner();
    }
    async function await_draw_winner () {
        // get total entries
        let num_entries: u64 = Mapping::get(total_entries, 0u64);
        // grab random number
        let random_number: u64 = ChaCha::rand_u64();
        // select winning index
        let winner_index: u64 = random_number % num_entries;
        // get address at winning index
        let winner_address: address = Mapping::get(entries, winner_index);
        // true if addr has already won, false if not
        let has_addr_won: bool = Mapping::get_or_use(has_won, winner_address, false);

        // if the drawn address has already won, fail
        assert_eq(has_addr_won, false);

        // get the winner_count
        let current_winner_count: u64 = Mapping::get_or_use(winner_count, 0u64, 0u64);
        // set addr to true {aleo1...: true}
        Mapping::set(has_won, winner_address, true);
        // increment winner count {0u64: 1u64} and so on
        Mapping::set(winner_count, 0u64, current_winner_count + 1u64);
        // set winner { 1u64: aleo1...} ...
        Mapping::set(winner, current_winner_count, winner_address);
    }

    transition send_prize_to_winner (public winner_addr: address, public prize: Prize) -> (Prize) {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, OPERATOR);

        let prize_to_winner: Prize = Prize {
            owner: winner_addr,
            private_key: prize.private_key,
        };

        // let audit_prize_to_winner: AuditPrizeToWinner = AuditPrizeToWinner {
        //     owner: operator,
        //     winner: winner_addr,
        //     private_key: prize.private_key,
        // };

        return (prize_to_winner);
    }

    // finalize send_prize_to_winner (public winner_addr: address) {
    //     // get the current winner idx
    //     // let current_winner_count_idx: u64 = Mapping::get_or_use(winner_count, 0u64, 0u64);
    //     // get the current winner via the index (if draw_winner is called multiple times)
    //     // let winner_addr_from_mapping: address = Mapping::get(winner, current_winner_count_idx);
    //     // assert that this function is called with the winner_addr
    //     // assert_eq(winner_addr, winner_addr_from_mapping);
    // }
}
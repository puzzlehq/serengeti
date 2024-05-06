program puzzle_raffle_050124.aleo {
    // used for storing the raffle entries (multiple entries per address)
    //   i.e. 0 -> aleo1...asdf, 1 -> aleo1...ghjk
    mapping entries: u64 => address;
    // used for storing of total number of values in entries mapping
    //   i.e. 0 -> 1, 0 -> 2
    mapping total_entries: u64 => u64;
    // 1u32 -> aleo1...lka
    mapping winner: u32 => address;
    // mapping to store winner aleo1... => true (if addr has won)
    mapping has_won: address => bool;

    // winner_count
    mapping winner_count: u32 => u32;

    // winner_indexes
    mapping winner_idxs: u32 => u64;

    // mapping to store winner one
    mapping winner_one: u32 => address;
    // mapping to store winner two
    mapping winner_two: u32 => address;
    // mapping to store winner three
    mapping winner_three: u32 => address;

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

    record AuditPrizeToWinner {
        owner: address,
        winner: address,
        private_key: PrivateKey,
    }

    // set_prize function -- start
    // creates record onchain with privatekey for ETH that can be
    // used for marketing purposes
    // do we want this to post something to a mapping? Maybe a blockheight when it was sent?
    // or a blockheight when an automated function should call it?
    // we can also PROVE that this has some funds by:
    // A) signing message and verifying signature with address
    // B) generating the ethAddress from the private key and posting that in the mapping
    // C) -- this is also a nice way to guarantee something with minimal proofs -- wide design space here!
    // ab: how will we store eth private key on chain? as a field element?
    // need to be able to reverse the field element off chain into a private key. will we need to write custom logic for this?
    // todo: allow only one mint prize call
    transition mint_prize (pk_pt1: u128, pk_pt2: u128) -> (Prize, AuditPrize) {
        let operator: address = aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw;
        // todo: can we check if it is a valid eth pk here...
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, operator);

        let prize: Prize = Prize {
            owner: operator,
            private_key: PrivateKey {
                pk_pt1: pk_pt1,
                pk_pt2: pk_pt2
            },
        };

        let audit_prize: AuditPrize = AuditPrize {
            owner: operator,
            minter: operator,
            private_key: PrivateKey {
                pk_pt1: pk_pt1,
                pk_pt2: pk_pt2
            },
        };

        return (prize, audit_prize);
    }

    transition add_one_raffle_entry (public participant: address) {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);
        return then finalize(participant);
    }

    finalize add_one_raffle_entry (public participant: address) {
        // get current raffle count, if first entry, choose default of 0u64
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);
        // add address to entry mapping
        Mapping::set(entries, current_raffle_count, participant);
        // increment raffle count by 1
        Mapping::set(total_entries, 0u64, current_raffle_count + 1u64);
    }

    transition add_two_raffle_entries (public participant: address ) {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);
        return then finalize(participant);
    }

    finalize add_two_raffle_entries (public participant: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);
        Mapping::set(entries, current_raffle_count, participant);
        Mapping::set(entries, current_raffle_count + 1u64, participant);
        Mapping::set(total_entries, 0u64, current_raffle_count + 2u64);
    }

    transition add_three_raffle_entries (public participant: address) {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);
        return then finalize(participant);
    }

    finalize add_three_raffle_entries (public participant: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);
        Mapping::set(entries, current_raffle_count, participant);
        Mapping::set(entries, current_raffle_count + 1u64, participant);
        Mapping::set(entries, current_raffle_count + 2u64, participant);
        Mapping::set(total_entries, 0u64, current_raffle_count + 3u64);
    }

    transition add_four_raffle_entries(public participant: address) {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);
        return then finalize(participant);
    }

    finalize add_four_raffle_entries(public participant: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);
        Mapping::set(entries, current_raffle_count, participant);
        Mapping::set(entries, current_raffle_count + 1u64, participant);
        Mapping::set(entries, current_raffle_count + 2u64, participant);
        Mapping::set(entries, current_raffle_count + 3u64, participant);
        Mapping::set(total_entries, 0u64, current_raffle_count + 4u64);
    }

    transition add_five_raffle_entries(public participant: address,) {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);
        return then finalize(participant);
    }

    finalize add_five_raffle_entries(public participant: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);
        Mapping::set(entries, current_raffle_count, participant);
        Mapping::set(entries, current_raffle_count + 1u64, participant);
        Mapping::set(entries, current_raffle_count + 2u64, participant);
        Mapping::set(entries, current_raffle_count + 3u64, participant);
        Mapping::set(entries, current_raffle_count + 4u64, participant);
        Mapping::set(total_entries, 0u64, current_raffle_count + 5u64);
    }

    transition add_six_raffle_entries(public participant: address) {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);
        return then finalize(participant);
    }

    finalize add_six_raffle_entries(public participant: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);
        Mapping::set(entries, current_raffle_count, participant);
        Mapping::set(entries, current_raffle_count + 1u64, participant);
        Mapping::set(entries, current_raffle_count + 2u64, participant);
        Mapping::set(entries, current_raffle_count + 3u64, participant);
        Mapping::set(entries, current_raffle_count + 4u64, participant);
        Mapping::set(entries, current_raffle_count + 5u64, participant);
        Mapping::set(total_entries, 0u64, current_raffle_count + 6u64);
    }

    transition add_seven_raffle_entries(public participant: address) {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);
        return then finalize(participant);
    }

    finalize add_seven_raffle_entries(public participant: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);
        Mapping::set(entries, current_raffle_count, participant);
        Mapping::set(entries, current_raffle_count + 1u64, participant);
        Mapping::set(entries, current_raffle_count + 2u64, participant);
        Mapping::set(entries, current_raffle_count + 3u64, participant);
        Mapping::set(entries, current_raffle_count + 4u64, participant);
        Mapping::set(entries, current_raffle_count + 5u64, participant);
        Mapping::set(entries, current_raffle_count + 6u64, participant);
        Mapping::set(total_entries, 0u64, current_raffle_count + 7u64);
    }

    transition add_eight_raffle_entries(public participant: address) {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);
        return then finalize(participant);
    }

    finalize add_eight_raffle_entries(public participant: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);
        Mapping::set(entries, current_raffle_count, participant);
        Mapping::set(entries, current_raffle_count + 1u64, participant);
        Mapping::set(entries, current_raffle_count + 2u64, participant);
        Mapping::set(entries, current_raffle_count + 3u64, participant);
        Mapping::set(entries, current_raffle_count + 4u64, participant);
        Mapping::set(entries, current_raffle_count + 5u64, participant);
        Mapping::set(entries, current_raffle_count + 6u64, participant);
        Mapping::set(entries, current_raffle_count + 7u64, participant);
        Mapping::set(total_entries, 0u64, current_raffle_count + 8u64);
    }

    transition add_nine_raffle_entries(public participant: address) {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);
        return then finalize(participant);
    }

    finalize add_nine_raffle_entries(public participant: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);
        Mapping::set(entries, current_raffle_count, participant);
        Mapping::set(entries, current_raffle_count + 1u64, participant);
        Mapping::set(entries, current_raffle_count + 2u64, participant);
        Mapping::set(entries, current_raffle_count + 3u64, participant);
        Mapping::set(entries, current_raffle_count + 4u64, participant);
        Mapping::set(entries, current_raffle_count + 5u64, participant);
        Mapping::set(entries, current_raffle_count + 6u64, participant);
        Mapping::set(entries, current_raffle_count + 7u64, participant);
        Mapping::set(entries, current_raffle_count + 8u64, participant);
        Mapping::set(total_entries, 0u64, current_raffle_count + 9u64);
    }

    transition add_ten_raffle_entries(public participant: address) {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);
        return then finalize(participant);
    }

    finalize add_ten_raffle_entries(public participant: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);
        Mapping::set(entries, current_raffle_count, participant);
        Mapping::set(entries, current_raffle_count + 1u64, participant);
        Mapping::set(entries, current_raffle_count + 2u64, participant);
        Mapping::set(entries, current_raffle_count + 3u64, participant);
        Mapping::set(entries, current_raffle_count + 4u64, participant);
        Mapping::set(entries, current_raffle_count + 5u64, participant);
        Mapping::set(entries, current_raffle_count + 6u64, participant);
        Mapping::set(entries, current_raffle_count + 7u64, participant);
        Mapping::set(entries, current_raffle_count + 8u64, participant);
        Mapping::set(entries, current_raffle_count + 9u64, participant);
        Mapping::set(total_entries, 0u64, current_raffle_count + 10u64);
    }

    transition add_eleven_raffle_entries(public participant: address) {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);
        return then finalize(participant);
    }

    finalize add_eleven_raffle_entries(public participant: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);
        Mapping::set(entries, current_raffle_count, participant);
        Mapping::set(entries, current_raffle_count + 1u64, participant);
        Mapping::set(entries, current_raffle_count + 2u64, participant);
        Mapping::set(entries, current_raffle_count + 3u64, participant);
        Mapping::set(entries, current_raffle_count + 4u64, participant);
        Mapping::set(entries, current_raffle_count + 5u64, participant);
        Mapping::set(entries, current_raffle_count + 6u64, participant);
        Mapping::set(entries, current_raffle_count + 7u64, participant);
        Mapping::set(entries, current_raffle_count + 8u64, participant);
        Mapping::set(entries, current_raffle_count + 9u64, participant);
        Mapping::set(entries, current_raffle_count + 10u64, participant);
        Mapping::set(total_entries, 0u64, current_raffle_count + 11u64);
    }

    transition add_twelve_raffle_entries(public participant: address) {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);
        return then finalize(participant);
    }

    finalize add_twelve_raffle_entries(public participant: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);
        Mapping::set(entries, current_raffle_count, participant);
        Mapping::set(entries, current_raffle_count + 1u64, participant);
        Mapping::set(entries, current_raffle_count + 2u64, participant);
        Mapping::set(entries, current_raffle_count + 3u64, participant);
        Mapping::set(entries, current_raffle_count + 4u64, participant);
        Mapping::set(entries, current_raffle_count + 5u64, participant);
        Mapping::set(entries, current_raffle_count + 6u64, participant);
        Mapping::set(entries, current_raffle_count + 7u64, participant);
        Mapping::set(entries, current_raffle_count + 8u64, participant);
        Mapping::set(entries, current_raffle_count + 9u64, participant);
        Mapping::set(entries, current_raffle_count + 10u64, participant);
        Mapping::set(entries, current_raffle_count + 11u64, participant);
        Mapping::set(total_entries, 0u64, current_raffle_count + 12u64);
    }

    transition add_thirteen_raffle_entries(public participant: address) {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);
        return then finalize(participant);
    }

    finalize add_thirteen_raffle_entries(public participant: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);
        Mapping::set(entries, current_raffle_count, participant);
        Mapping::set(entries, current_raffle_count + 1u64, participant);
        Mapping::set(entries, current_raffle_count + 2u64, participant);
        Mapping::set(entries, current_raffle_count + 3u64, participant);
        Mapping::set(entries, current_raffle_count + 4u64, participant);
        Mapping::set(entries, current_raffle_count + 5u64, participant);
        Mapping::set(entries, current_raffle_count + 6u64, participant);
        Mapping::set(entries, current_raffle_count + 7u64, participant);
        Mapping::set(entries, current_raffle_count + 8u64, participant);
        Mapping::set(entries, current_raffle_count + 9u64, participant);
        Mapping::set(entries, current_raffle_count + 10u64, participant);
        Mapping::set(entries, current_raffle_count + 11u64, participant);
        Mapping::set(entries, current_raffle_count + 12u64, participant);
        Mapping::set(total_entries, 0u64, current_raffle_count + 13u64);
    }

    transition add_fourteen_raffle_entries(public participant: address) {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);
        return then finalize(participant);
    }

    finalize add_fourteen_raffle_entries(public participant: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);
        Mapping::set(entries, current_raffle_count, participant);
        Mapping::set(entries, current_raffle_count + 1u64, participant);
        Mapping::set(entries, current_raffle_count + 2u64, participant);
        Mapping::set(entries, current_raffle_count + 3u64, participant);
        Mapping::set(entries, current_raffle_count + 4u64, participant);
        Mapping::set(entries, current_raffle_count + 5u64, participant);
        Mapping::set(entries, current_raffle_count + 6u64, participant);
        Mapping::set(entries, current_raffle_count + 7u64, participant);
        Mapping::set(entries, current_raffle_count + 8u64, participant);
        Mapping::set(entries, current_raffle_count + 9u64, participant);
        Mapping::set(entries, current_raffle_count + 10u64, participant);
        Mapping::set(entries, current_raffle_count + 11u64, participant);
        Mapping::set(entries, current_raffle_count + 12u64, participant);
        Mapping::set(entries, current_raffle_count + 13u64, participant);
        Mapping::set(total_entries, 0u64, current_raffle_count + 14u64);
    }

    transition add_fifteen_raffle_entries(public participant: address) {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);
        return then finalize(participant);
    }

    finalize add_fifteen_raffle_entries(public participant: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);
        Mapping::set(entries, current_raffle_count, participant);
        Mapping::set(entries, current_raffle_count + 1u64, participant);
        Mapping::set(entries, current_raffle_count + 2u64, participant);
        Mapping::set(entries, current_raffle_count + 3u64, participant);
        Mapping::set(entries, current_raffle_count + 4u64, participant);
        Mapping::set(entries, current_raffle_count + 5u64, participant);
        Mapping::set(entries, current_raffle_count + 6u64, participant);
        Mapping::set(entries, current_raffle_count + 7u64, participant);
        Mapping::set(entries, current_raffle_count + 8u64, participant);
        Mapping::set(entries, current_raffle_count + 9u64, participant);
        Mapping::set(entries, current_raffle_count + 10u64, participant);
        Mapping::set(entries, current_raffle_count + 11u64, participant);
        Mapping::set(entries, current_raffle_count + 12u64, participant);
        Mapping::set(entries, current_raffle_count + 13u64, participant);
        Mapping::set(entries, current_raffle_count + 14u64, participant);
        Mapping::set(total_entries, 0u64, current_raffle_count + 15u64);
    }

    // todo: allow draw winner to only be called once
    transition draw_winner () {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);
        return then finalize;
    }

    finalize draw_winner () {
        // get total entries
        let num_entries: u64 = Mapping::get(total_entries, 0u64);
        // grab random number
        let random_number: u64 = ChaCha::rand_u64();
        // select winning index
        let winner_index: u64 = random_number % num_entries;
        // get address at winning index
        let winner_address: address = Mapping::get(entries, winner_index);
        // get the winner_count
        let current_winner_count: u32 = Mapping::get_or_use(winner_count, 0u32, 0u32);
        // true if addr has already won, false if not
        let has_addr_won: bool = Mapping::get_or_use(has_won, winner_address, false);

        // if the winner has never been selected
        if (has_addr_won.not()) {
            // set addr to true {aleo1...: true}
            Mapping::set(has_won, winner_address, true);
            // increment winner count {0u32: 1u32} and so on
            Mapping::set(winner_count, 0u32, current_winner_count + 1u32);
            // set winner { 1u32: aleo1...} ...
            Mapping::set(winner, current_winner_count, winner_address);
        }
    }

    // fn to draw 3 winners
    transition draw_three_winners () {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);
        return then finalize;
    }

    finalize draw_three_winners () {
        let num_entries: u64 = Mapping::get(total_entries, 0u64);
        for i: u32 in 0u32..3u32 {
            let random_number: u64 = ChaCha::rand_u64();
            let winner_index: u64 = random_number % num_entries;
            Mapping::set(winner_idxs, i, winner_index);
        }

        // grah the three random idxs
        let winner_idx_one: u64 = Mapping::get(winner_idxs, 0u32);
        let winner_idx_two: u64 = Mapping::get(winner_idxs, 1u32);
        let winner_idx_three: u64 = Mapping::get(winner_idxs, 2u32);

        // get the addresses at the three random idxs
        let winner_address_one: address = Mapping::get(entries, winner_idx_one);
        let winner_address_two: address = Mapping::get(entries, winner_idx_two);
        let winner_address_three: address = Mapping::get(entries, winner_idx_three);

        // assert that none of the addresses are equivalent
        assert_neq(winner_address_one, winner_address_two);
        assert_neq(winner_address_two, winner_address_three);
        assert_neq(winner_address_one, winner_address_three);

        // set each winner on each mapping
        Mapping::set(winner_one, 0u32, winner_address_one);
        Mapping::set(winner_two, 0u32, winner_address_two);
        Mapping::set(winner_three, 0u32, winner_address_three);

    }

    transition send_prize_to_winner (public winner_addr: address, public prize: Prize, public winner_idx: u32) -> (Prize, AuditPrizeToWinner) {
        let operator: address = aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw;
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, operator);


        let prize_to_winner: Prize = Prize {
            owner: winner_addr,
            private_key: prize.private_key,
        };

        let audit_prize_to_winner: AuditPrizeToWinner = AuditPrizeToWinner {
            owner: operator,
            winner: winner_addr,
            private_key: prize.private_key,
        };

        return (prize_to_winner, audit_prize_to_winner) then finalize (winner_addr, winner_idx);
    }

    finalize send_prize_to_winner (public winner_addr: address, public winner_idx: u32) {
        // get the current winner via the index (if draw_winner is called multiple times)
        let winner_addr_from_mapping: address = Mapping::get(winner, winner_idx);
        // assert that this function is called with the winner_addr
        assert_eq(winner_addr, winner_addr_from_mapping);
    }


    transition send_three_prizes_to_winners(
        public winner_addr_one: address,
        public winner_addr_two: address,
        public winner_addr_three: address,
        public winner_idx: u32,
        public prize_one: Prize,
        public prize_two: Prize,
        public prize_three: Prize,
    )
    {
        let operator: address = aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw;
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, operator);

        let prize_to_winner_one: Prize = Prize {
            owner: winner_addr_one,
            private_key: prize_one.private_key,
        };

        let audit_prize_to_winner_one: AuditPrizeToWinner = AuditPrizeToWinner {
            owner: operator,
            winner: winner_addr_one,
            private_key: prize_one.private_key,
        };

        let prize_to_winner_two: Prize = Prize {
            owner: winner_addr_two,
            private_key: prize_two.private_key,
        };

        let audit_prize_to_winner_two: AuditPrizeToWinner = AuditPrizeToWinner {
            owner: operator,
            winner: winner_addr_two,
            private_key: prize_two.private_key,
        };

        let prize_to_winner_three: Prize = Prize {
            owner: winner_addr_three,
            private_key: prize_three.private_key,
        };

        let audit_prize_to_winner_three: AuditPrizeToWinner = AuditPrizeToWinner {
            owner: operator,
            winner: winner_addr_three,
            private_key: prize_three.private_key,
        };


        return then finalize (winner_addr_one, winner_addr_two, winner_addr_three, winner_idx);

    }

    finalize send_three_prizes_to_winners (
        public winner_addr_one: address,
        public winner_addr_two: address,
        public winner_addr_three: address,
        public winner_idx: u32,
    )
    {
        // assert that the prizes are being sent to the official winners
        assert_eq(Mapping::get(winner_one, winner_idx), winner_addr_one);
        assert_eq(Mapping::get(winner_one, winner_idx), winner_addr_two);
        assert_eq(Mapping::get(winner_one, winner_idx), winner_addr_three);

    }


    // Potential future scope:
    // - pulling out of raffle
    // - automating raffle winner selection
    // https://www.youtube.com/watch?v=BARTutzwBrc -- Gelato solving this. Used a whole ass network. Out of scope for us
    // but we can try internally and would be cool

    // General Plan:
    // - Make functions -- functions should give idea about record structure & mappings -today
    // - Test with bash script -today
    // - Deploy with CLI and test on testnet with some giftcards - today
    // - Testing script for 20,000 people hitting this function -- this one will be tomorrow
}
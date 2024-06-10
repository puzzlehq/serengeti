program puzzle_raffle_v001.aleo {
    // used for storing the raffle entries (multiple entries per address)
    //   i.e. 0 -> aleo1...asdf, 1 -> aleo1...ghjk
    mapping entries: u64 => address;
    // used for storing of total number of values in entries mapping
    //   i.e. 0 -> 1, 0 -> 2
    mapping total_entries: u64 => u64;
    // 0u32 -> aleo1...lka
    mapping winner: u32 => address;
    // winner_count
    mapping winner_count: u32 => u32;

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

    // todo: allow only one mint_prize call?
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

    async transition buy_one_entry (public participant: address) -> Future {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);
        return add_one_entry(participant);
    }
    async function add_one_entry (public participant: address) {
        // get current raffle count, if first entry, choose default of 0u64
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);
        // add address to entry mapping
        Mapping::set(entries, current_raffle_count, participant);
        // increment raffle count by 1
        Mapping::set(total_entries, 0u64, current_raffle_count + 1u64);
    }

    async transition buy_two_entries (public participant: address ) -> Future {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);
        return add_two_entries(participant);
    }
    async function add_two_entries (public participant: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);
        Mapping::set(entries, current_raffle_count, participant);
        Mapping::set(entries, current_raffle_count + 1u64, participant);
        Mapping::set(total_entries, 0u64, current_raffle_count + 2u64);
    }

    async transition buy_three_entries (public participant: address) -> Future {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);
        return add_three_entries(participant);
    }
    async function add_three_entries (public participant: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);
        Mapping::set(entries, current_raffle_count, participant);
        Mapping::set(entries, current_raffle_count + 1u64, participant);
        Mapping::set(entries, current_raffle_count + 2u64, participant);
        Mapping::set(total_entries, 0u64, current_raffle_count + 3u64);
    }

    async transition buy_four_entries(public participant: address) -> Future {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);
        return add_four_entries(participant);
    }
    async function add_four_entries(public participant: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);
        Mapping::set(entries, current_raffle_count, participant);
        Mapping::set(entries, current_raffle_count + 1u64, participant);
        Mapping::set(entries, current_raffle_count + 2u64, participant);
        Mapping::set(entries, current_raffle_count + 3u64, participant);
        Mapping::set(total_entries, 0u64, current_raffle_count + 4u64);
    }

    async transition buy_five_entries(public participant: address) -> Future {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);
        return add_five_entries(participant);
    }
    async function add_five_entries(public participant: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);
        Mapping::set(entries, current_raffle_count, participant);
        Mapping::set(entries, current_raffle_count + 1u64, participant);
        Mapping::set(entries, current_raffle_count + 2u64, participant);
        Mapping::set(entries, current_raffle_count + 3u64, participant);
        Mapping::set(entries, current_raffle_count + 4u64, participant);
        Mapping::set(total_entries, 0u64, current_raffle_count + 5u64);
    }

    async transition buy_six_entries(public participant: address) -> Future {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);
        return add_six_entries(participant);
    }
    async function add_six_entries(public participant: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);
        Mapping::set(entries, current_raffle_count, participant);
        Mapping::set(entries, current_raffle_count + 1u64, participant);
        Mapping::set(entries, current_raffle_count + 2u64, participant);
        Mapping::set(entries, current_raffle_count + 3u64, participant);
        Mapping::set(entries, current_raffle_count + 4u64, participant);
        Mapping::set(entries, current_raffle_count + 5u64, participant);
        Mapping::set(total_entries, 0u64, current_raffle_count + 6u64);
    }

    async transition buy_seven_entries(public participant: address) -> Future {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);
        return add_seven_entries(participant);
    }
    async function add_seven_entries(public participant: address) {
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

    async transition buy_eight_entries(public participant: address) -> Future {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);
        return add_eight_entries(participant);
    }
    async function add_eight_entries(public participant: address) {
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

    async transition buy_nine_entries(public participant: address) -> Future {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);
        return add_nine_entries(participant);
    }
    async function add_nine_entries(public participant: address) {
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

    async transition buy_ten_entries(public participant: address) -> Future {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);
        return add_ten_entries(participant);
    }
    async function add_ten_entries(public participant: address) {
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

    async transition buy_eleven_entries(public participant: address) -> Future {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);
        return add_11_entries(participant);
    }
    async function add_11_entries(public participant: address) {
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

    async transition buy_twelve_entries(public participant: address) -> Future {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);
        return add_twelve_entries(participant);
    }
    async function add_twelve_entries(public participant: address) {
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

    async transition buy_thirteen_entries(public participant: address) -> Future {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);
        return add_thirteen_entries(participant);
    }
    async function add_thirteen_entries(public participant: address) {
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

    async transition buy_fourteen_entries(public participant: address) -> Future {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);
        return add_fourteen_entries(participant);
    }
    async function add_fourteen_entries(public participant: address) {
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

    async transition buy_fifteen_entries(public participant: address) -> Future {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);
        return add_fifteen_entries(participant);
    }
    async function add_fifteen_entries(public participant: address) {
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
    async transition draw_winner () -> (Future) {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);
        return draw_winner_finalize();
    }
    async function draw_winner_finalize () {
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
        // set the winner address
        Mapping::set(winner, current_winner_count, winner_address);
        // increment the winner count
        //todo: update this to fix this mapping being 1 ahead of other mapping
        Mapping::set(winner_count, 0u32, current_winner_count + 1u32);
    }

    transition send_prize_to_winner (public winner_addr: address, public prize: Prize) -> (Prize, AuditPrizeToWinner) {
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

        return (prize_to_winner, audit_prize_to_winner);
    }

    // finalize send_prize_to_winner (public winner_addr: address) {
    //     // get the current winner idx
    //     // let current_winner_count_idx: u32 = Mapping::get_or_use(winner_count, 0u32, 0u32);
    //     // get the current winner via the index (if draw_winner is called multiple times)
    //     // let winner_addr_from_mapping: address = Mapping::get(winner, current_winner_count_idx);
    //     // assert that this function is called with the winner_addr
    //     // assert_eq(winner_addr, winner_addr_from_mapping);
    // }
}
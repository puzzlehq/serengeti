program puzzle_raffle_v001.aleo {
    // used for storing the raffle entries (multiple entries per address)
    //   i.e. 0 -> aleo1...asdf, 1 -> aleo1...ghjk
    mapping entries: u64 => address;
    // used for storing of total number of values in entries mapping
    //   i.e. 0 -> 1, 0 -> 2
    mapping total_entries: u64 => u64;
    mapping winner: address => u32;

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
    transition mint_prize (pk_pt1: u128, pk_pt2: u128) -> (Prize, AuditPrize) {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn);

        let operator: address = aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw;

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
        assert_eq(self.caller, aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn);
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
        assert_eq(self.caller, aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn);
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
        assert_eq(self.caller, aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn);
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
        assert_eq(self.caller, aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn);
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
        assert_eq(self.caller, aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn);
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
        assert_eq(self.caller, aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn);
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
        assert_eq(self.caller, aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn);
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
        assert_eq(self.caller, aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn);
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
        assert_eq(self.caller, aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn);
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
        assert_eq(self.caller, aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn);
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
        assert_eq(self.caller, aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn);
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
        assert_eq(self.caller, aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn);
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
        assert_eq(self.caller, aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn);
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
        assert_eq(self.caller, aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn);
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
        assert_eq(self.caller, aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn);
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

    transition draw_winner () {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn);
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
        // set the winner address
        Mapping::set(winner, winner_address, 0u32);
    }

    transition send_prize_to_winner (public winner_addr: address, public prize: Prize) -> (Prize, AuditPrizeToWinner) {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw);

        let operator: address = aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw;

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
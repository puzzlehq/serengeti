// The 'puzz_usdc_giveaway_v002' program.
// Without nested imports -- puzzle pieces is going to need Piece Keepers to enforce

program puzz_usdc_giveaway_v005.aleo {
    // 0 -> aleo123, 1 -> aleo456
    mapping entry_index: u64 => address;
    // todo: 1- 15 raffle entry functions
    // 0 -> 1, 0 -> 2, and so on.
    mapping entry_count: u64 => u64;
    mapping winner: address => u32;

    struct pk {
        pk_pt1: u128,
        pk_pt2: u128
    }

    // Change Structure to USDC Giveaway
    // Never owned by multisig
    record GiveawayAccount {
        owner: address,
        // todo: remove these below
        private_key: pk,
    }

    record AuditGiveawayAccount {
        owner: address,
        minter: address,
        private_key: pk,
    }

    // Put Other Record Structs needed here
    // ...

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
    transition set_prize (to: address, amount: u64, asset_type: u64, date: u64, pk_pt1: u128, pk_pt2: u128) -> (GiveawayAccount, AuditGiveawayAccount) {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn);

        // set puzzle issuing address as issuer:
        let puzzle_issuer: address = aleo1fan3jt83xvs5m4pqppmeghv4ypsan5aq4clwt4hnfv8pq90evqqq4dj6p6;

        // no checks on minting right now. test actions and audit without address check

        // puzzle giveaway minted
        let minted_puzzle_giveaway: GiveawayAccount = GiveawayAccount {
            owner: to,
            private_key: pk {
                pk_pt1: pk_pt1,
                pk_pt2: pk_pt2
            },
        };

        // audit record for issuer to know supply
        let audit_giveaway: AuditGiveawayAccount = AuditGiveawayAccount {
            owner: puzzle_issuer,
            minter: to,
            private_key: pk {
                pk_pt1: pk_pt1,
                pk_pt2: pk_pt2
            },
        };

        return (minted_puzzle_giveaway, audit_giveaway);
    }

    // add_raffle_entry => add entry to raffle function
    // BIG need to investigate adding multiple entries in one go....
    // BIG need to investigate not using public mappings because going to get insanely expensive
    // BIG need to max size of public mapping
    // public mappings here should just be limited to staking & slashing
    transition add_raffle_entry (public participant: address) {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn);
        return then finalize(participant);
    }

    finalize add_raffle_entry (public participant: address) {
        // get current raffle count, if first entry, choose default of 0u64
        let current_raffle_count: u64 = Mapping::get_or_use(entry_count, 0u64, 0u64);
        // add address to entry mapping
        Mapping::set(entry_index, current_raffle_count, participant);
        // increment raffle count
        Mapping::set(entry_count, 0u64, current_raffle_count + 1u64);
    }

    transition add_two_raffle_entries (public participant: address, participant_two: address ) {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn);
        return then finalize(participant, participant_two);
    }

    finalize add_two_raffle_entries (public participant: address, participant_two: address ) {
        // get current_raffle_count
        let current_raffle_count: u64 = Mapping::get_or_use(entry_count, 0u64, 0u64);
        // Add addresses to entry mapping
        Mapping::set(entry_index, current_raffle_count, participant);
        Mapping::set(entry_index, current_raffle_count + 1u64, participant_two);
        // increment raffle count
        Mapping::set(entry_count, 0u64, current_raffle_count + 2u64);
    }

    transition add_three_raffle_entries (public participant: address, participant_two: address, participant_three: address ) {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn);
        return then finalize(participant, participant_two, participant_three);
    }

    finalize add_three_raffle_entries (public participant: address, participant_two: address, participant_three: address) {
        // get current_raffle_count
        let current_raffle_count: u64 = Mapping::get_or_use(entry_count, 0u64, 0u64);
        // Add addresses to entry mapping
        Mapping::set(entry_index, current_raffle_count, participant);
        Mapping::set(entry_index, current_raffle_count + 1u64, participant_two);
        Mapping::set(entry_index, current_raffle_count + 2u64, participant_three);
        // increment raffle count
        Mapping::set(entry_count, 0u64, current_raffle_count + 3u64);
    }

    transition add_four_raffle_entries(public participant: address, participant_two: address, participant_three: address, participant_four: address) {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn);
        return then finalize(participant, participant_two, participant_three, participant_four);
    }

    finalize add_four_raffle_entries(public participant: address, participant_two: address, participant_three: address, participant_four: address) {
        // Get current raffle count
        let current_raffle_count: u64 = Mapping::get_or_use(entry_count, 0u64, 0u64);
        // Add addresses to entry mapping
        Mapping::set(entry_index, current_raffle_count, participant);
        Mapping::set(entry_index, current_raffle_count + 1u64, participant_two);
        Mapping::set(entry_index, current_raffle_count + 2u64, participant_three);
        Mapping::set(entry_index, current_raffle_count + 3u64, participant_four);
        // Increment raffle count
        Mapping::set(entry_count, 0u64, current_raffle_count + 4u64);
    }

    transition add_five_raffle_entries(public participant: address, participant_two: address, participant_three: address, participant_four: address, participant_five: address) {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn);
        return then finalize(participant, participant_two, participant_three, participant_four, participant_five);
    }

    finalize add_five_raffle_entries(public participant: address, participant_two: address, participant_three: address, participant_four: address, participant_five: address) {
    // Get current raffle count
        let current_raffle_count: u64 = Mapping::get_or_use(entry_count, 0u64, 0u64);
        // Add addresses to entry mapping
        Mapping::set(entry_index, current_raffle_count, participant);
        Mapping::set(entry_index, current_raffle_count + 1u64, participant_two);
        Mapping::set(entry_index, current_raffle_count + 2u64, participant_three);
        Mapping::set(entry_index, current_raffle_count + 3u64, participant_four);
        Mapping::set(entry_index, current_raffle_count + 4u64, participant_five);
        // Increment raffle count
        Mapping::set(entry_count, 0u64, current_raffle_count + 5u64);
    }

    transition add_six_raffle_entries(public participant: address, participant_two: address, participant_three: address, participant_four: address, participant_five: address, participant_six: address) {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn);
        return then finalize(participant, participant_two, participant_three, participant_four, participant_five, participant_six);
    }

    finalize add_six_raffle_entries(public participant: address, participant_two: address, participant_three: address, participant_four: address, participant_five: address, participant_six: address) {
        // Get current raffle count
        let current_raffle_count: u64 = Mapping::get_or_use(entry_count, 0u64, 0u64);
        // Add addresses to entry mapping
        Mapping::set(entry_index, current_raffle_count, participant);
        Mapping::set(entry_index, current_raffle_count + 1u64, participant_two);
        Mapping::set(entry_index, current_raffle_count + 2u64, participant_three);
        Mapping::set(entry_index, current_raffle_count + 3u64, participant_four);
        Mapping::set(entry_index, current_raffle_count + 4u64, participant_five);
        Mapping::set(entry_index, current_raffle_count + 5u64, participant_six);
        // Increment raffle count
        Mapping::set(entry_count, 0u64, current_raffle_count + 6u64);
    }

    transition add_seven_raffle_entries(public participant: address, participant_two: address, participant_three: address, participant_four: address, participant_five: address, participant_six: address, participant_seven: address) {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn);
        return then finalize(participant, participant_two, participant_three, participant_four, participant_five, participant_six, participant_seven);
    }

    finalize add_seven_raffle_entries(public participant: address, participant_two: address, participant_three: address, participant_four: address, participant_five: address, participant_six: address, participant_seven: address) {
        // Get current raffle count
        let current_raffle_count: u64 = Mapping::get_or_use(entry_count, 0u64, 0u64);
        // Add addresses to entry mapping
        Mapping::set(entry_index, current_raffle_count, participant);
        Mapping::set(entry_index, current_raffle_count + 1u64, participant_two);
        Mapping::set(entry_index, current_raffle_count + 2u64, participant_three);
        Mapping::set(entry_index, current_raffle_count + 3u64, participant_four);
        Mapping::set(entry_index, current_raffle_count + 4u64, participant_five);
        Mapping::set(entry_index, current_raffle_count + 5u64, participant_six);
        Mapping::set(entry_index, current_raffle_count + 6u64, participant_seven);
        // Increment raffle count
        Mapping::set(entry_count, 0u64, current_raffle_count + 7u64);
    }

    transition add_eight_raffle_entries(public participant: address, participant_two: address, participant_three: address, participant_four: address, participant_five: address, participant_six: address, participant_seven: address, participant_eight: address) {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn);
        return then finalize(participant, participant_two, participant_three, participant_four, participant_five, participant_six, participant_seven, participant_eight);
    }

    finalize add_eight_raffle_entries(public participant: address, participant_two: address, participant_three: address, participant_four: address, participant_five: address, participant_six: address, participant_seven: address, participant_eight: address) {
        // Get current raffle count
        let current_raffle_count: u64 = Mapping::get_or_use(entry_count, 0u64, 0u64);
        // Add addresses to entry mapping
        Mapping::set(entry_index, current_raffle_count, participant);
        Mapping::set(entry_index, current_raffle_count + 1u64, participant_two);
        Mapping::set(entry_index, current_raffle_count + 2u64, participant_three);
        Mapping::set(entry_index, current_raffle_count + 3u64, participant_four);
        Mapping::set(entry_index, current_raffle_count + 4u64, participant_five);
        Mapping::set(entry_index, current_raffle_count + 5u64, participant_six);
        Mapping::set(entry_index, current_raffle_count + 6u64, participant_seven);
        Mapping::set(entry_index, current_raffle_count + 7u64, participant_eight);
        // Increment raffle count
        Mapping::set(entry_count, 0u64, current_raffle_count + 8u64);
    }

    transition add_nine_raffle_entries(public participant: address, participant_two: address, participant_three: address, participant_four: address, participant_five: address, participant_six: address, participant_seven: address, participant_eight: address, participant_nine: address) {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn);
        return then finalize(participant, participant_two, participant_three, participant_four, participant_five, participant_six, participant_seven, participant_eight, participant_nine);
    }

    finalize add_nine_raffle_entries(public participant: address, participant_two: address, participant_three: address, participant_four: address, participant_five: address, participant_six: address, participant_seven: address, participant_eight: address, participant_nine: address) {
        // Get current raffle count
        let current_raffle_count: u64 = Mapping::get_or_use(entry_count, 0u64, 0u64);
        // Add addresses to entry mapping
        Mapping::set(entry_index, current_raffle_count, participant);
        Mapping::set(entry_index, current_raffle_count + 1u64, participant_two);
        Mapping::set(entry_index, current_raffle_count + 2u64, participant_three);
        Mapping::set(entry_index, current_raffle_count + 3u64, participant_four);
        Mapping::set(entry_index, current_raffle_count + 4u64, participant_five);
        Mapping::set(entry_index, current_raffle_count + 5u64, participant_six);
        Mapping::set(entry_index, current_raffle_count + 6u64, participant_seven);
        Mapping::set(entry_index, current_raffle_count + 7u64, participant_eight);
        Mapping::set(entry_index, current_raffle_count + 8u64, participant_nine);
        // Increment raffle count
        Mapping::set(entry_count, 0u64, current_raffle_count + 9u64);
    }

    transition add_ten_raffle_entries(public participant: address, participant_two: address, participant_three: address, participant_four: address, participant_five: address, participant_six: address, participant_seven: address, participant_eight: address, participant_nine: address, participant_ten: address) {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn);
        return then finalize(participant, participant_two, participant_three, participant_four, participant_five, participant_six, participant_seven, participant_eight, participant_nine, participant_ten);
    }

    finalize add_ten_raffle_entries(public participant: address, participant_two: address, participant_three: address, participant_four: address, participant_five: address, participant_six: address, participant_seven: address, participant_eight: address, participant_nine: address, participant_ten: address) {
        // Get current raffle count
        let current_raffle_count: u64 = Mapping::get_or_use(entry_count, 0u64, 0u64);
        // Add addresses to entry mapping
        Mapping::set(entry_index, current_raffle_count, participant);
        Mapping::set(entry_index, current_raffle_count + 1u64, participant_two);
        Mapping::set(entry_index, current_raffle_count + 2u64, participant_three);
        Mapping::set(entry_index, current_raffle_count + 3u64, participant_four);
        Mapping::set(entry_index, current_raffle_count + 4u64, participant_five);
        Mapping::set(entry_index, current_raffle_count + 5u64, participant_six);
        Mapping::set(entry_index, current_raffle_count + 6u64, participant_seven);
        Mapping::set(entry_index, current_raffle_count + 7u64, participant_eight);
        Mapping::set(entry_index, current_raffle_count + 8u64, participant_nine);
        Mapping::set(entry_index, current_raffle_count + 9u64, participant_ten);
        // Increment raffle count by 10
        Mapping::set(entry_count, 0u64, current_raffle_count + 10u64);
    }

    transition add_eleven_raffle_entries(public participant: address, participant_two: address, participant_three: address, participant_four: address, participant_five: address, participant_six: address, participant_seven: address, participant_eight: address, participant_nine: address, participant_ten: address, participant_eleven: address) {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn);
        return then finalize(participant, participant_two, participant_three, participant_four, participant_five, participant_six, participant_seven, participant_eight, participant_nine, participant_ten, participant_eleven);
    }

    finalize add_eleven_raffle_entries(public participant: address, participant_two: address, participant_three: address, participant_four: address, participant_five: address, participant_six: address, participant_seven: address, participant_eight: address, participant_nine: address, participant_ten: address, participant_eleven: address) {
    // Get current raffle count
        let current_raffle_count: u64 = Mapping::get_or_use(entry_count, 0u64, 0u64);
        // Add addresses to entry mapping
        Mapping::set(entry_index, current_raffle_count, participant);
        Mapping::set(entry_index, current_raffle_count + 1u64, participant_two);
        Mapping::set(entry_index, current_raffle_count + 2u64, participant_three);
        Mapping::set(entry_index, current_raffle_count + 3u64, participant_four);
        Mapping::set(entry_index, current_raffle_count + 4u64, participant_five);
        Mapping::set(entry_index, current_raffle_count + 5u64, participant_six);
        Mapping::set(entry_index, current_raffle_count + 6u64, participant_seven);
        Mapping::set(entry_index, current_raffle_count + 7u64, participant_eight);
        Mapping::set(entry_index, current_raffle_count + 8u64, participant_nine);
        Mapping::set(entry_index, current_raffle_count + 9u64, participant_ten);
        Mapping::set(entry_index, current_raffle_count + 10u64, participant_eleven);
        // Increment raffle count by 11
        Mapping::set(entry_count, 0u64, current_raffle_count + 11u64);
    }

    transition add_twelve_raffle_entries(public participant: address, participant_two: address, participant_three: address, participant_four: address, participant_five: address, participant_six: address, participant_seven: address, participant_eight: address, participant_nine: address, participant_ten: address, participant_eleven: address, participant_twelve: address) {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn);
        return then finalize(participant, participant_two, participant_three, participant_four, participant_five, participant_six, participant_seven, participant_eight, participant_nine, participant_ten, participant_eleven, participant_twelve);
    }

    finalize add_twelve_raffle_entries(public participant: address, participant_two: address, participant_three: address, participant_four: address, participant_five: address, participant_six: address, participant_seven: address, participant_eight: address, participant_nine: address, participant_ten: address, participant_eleven: address, participant_twelve: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(entry_count, 0u64, 0u64);
        Mapping::set(entry_index, current_raffle_count, participant);
        Mapping::set(entry_index, current_raffle_count + 1u64, participant_two);
        Mapping::set(entry_index, current_raffle_count + 2u64, participant_three);
        Mapping::set(entry_index, current_raffle_count + 3u64, participant_four);
        Mapping::set(entry_index, current_raffle_count + 4u64, participant_five);
        Mapping::set(entry_index, current_raffle_count + 5u64, participant_six);
        Mapping::set(entry_index, current_raffle_count + 6u64, participant_seven);
        Mapping::set(entry_index, current_raffle_count + 7u64, participant_eight);
        Mapping::set(entry_index, current_raffle_count + 8u64, participant_nine);
        Mapping::set(entry_index, current_raffle_count + 9u64, participant_ten);
        Mapping::set(entry_index, current_raffle_count + 10u64, participant_eleven);
        Mapping::set(entry_index, current_raffle_count + 11u64, participant_twelve);
        Mapping::set(entry_count, 0u64, current_raffle_count + 12u64);
    }

    transition add_thirteen_raffle_entries(public participant: address, participant_two: address, participant_three: address, participant_four: address, participant_five: address, participant_six: address, participant_seven: address, participant_eight: address, participant_nine: address, participant_ten: address, participant_eleven: address, participant_twelve: address, participant_thirteen: address) {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn);
        return then finalize(participant, participant_two, participant_three, participant_four, participant_five, participant_six, participant_seven, participant_eight, participant_nine, participant_ten, participant_eleven, participant_twelve, participant_thirteen);
    }

    finalize add_thirteen_raffle_entries(public participant: address, participant_two: address, participant_three: address, participant_four: address, participant_five: address, participant_six: address, participant_seven: address, participant_eight: address, participant_nine: address, participant_ten: address, participant_eleven: address, participant_twelve: address, participant_thirteen: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(entry_count, 0u64, 0u64);
        Mapping::set(entry_index, current_raffle_count, participant);
        Mapping::set(entry_index, current_raffle_count + 1u64, participant_two);
        Mapping::set(entry_index, current_raffle_count + 2u64, participant_three);
        Mapping::set(entry_index, current_raffle_count + 3u64, participant_four);
        Mapping::set(entry_index, current_raffle_count + 4u64, participant_five);
        Mapping::set(entry_index, current_raffle_count + 5u64, participant_six);
        Mapping::set(entry_index, current_raffle_count + 6u64, participant_seven);
        Mapping::set(entry_index, current_raffle_count + 7u64, participant_eight);
        Mapping::set(entry_index, current_raffle_count + 8u64, participant_nine);
        Mapping::set(entry_index, current_raffle_count + 9u64, participant_ten);
        Mapping::set(entry_index, current_raffle_count + 10u64, participant_eleven);
        Mapping::set(entry_index, current_raffle_count + 11u64, participant_twelve);
        Mapping::set(entry_index, current_raffle_count + 12u64, participant_thirteen);
        // Increment raffle count by 13
        Mapping::set(entry_count, 0u64, current_raffle_count + 13u64);
    }

    transition add_fourteen_raffle_entries(public participant: address, participant_two: address, participant_three: address, participant_four: address, participant_five: address, participant_six: address, participant_seven: address, participant_eight: address, participant_nine: address, participant_ten: address, participant_eleven: address, participant_twelve: address, participant_thirteen: address, participant_fourteen: address) {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn);
        return then finalize(participant, participant_two, participant_three, participant_four, participant_five, participant_six, participant_seven, participant_eight, participant_nine, participant_ten, participant_eleven, participant_twelve, participant_thirteen, participant_fourteen);
    }

    finalize add_fourteen_raffle_entries(public participant: address, participant_two: address, participant_three: address, participant_four: address, participant_five: address, participant_six: address, participant_seven: address, participant_eight: address, participant_nine: address, participant_ten: address, participant_eleven: address, participant_twelve: address, participant_thirteen: address, participant_fourteen: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(entry_count, 0u64, 0u64);
        Mapping::set(entry_index, current_raffle_count, participant);
        Mapping::set(entry_index, current_raffle_count + 1u64, participant_two);
        Mapping::set(entry_index, current_raffle_count + 2u64, participant_three);
        Mapping::set(entry_index, current_raffle_count + 3u64, participant_four);
        Mapping::set(entry_index, current_raffle_count + 4u64, participant_five);
        Mapping::set(entry_index, current_raffle_count + 5u64, participant_six);
        Mapping::set(entry_index, current_raffle_count + 6u64, participant_seven);
        Mapping::set(entry_index, current_raffle_count + 7u64, participant_eight);
        Mapping::set(entry_index, current_raffle_count + 8u64, participant_nine);
        Mapping::set(entry_index, current_raffle_count + 9u64, participant_ten);
        Mapping::set(entry_index, current_raffle_count + 10u64, participant_eleven);
        Mapping::set(entry_index, current_raffle_count + 11u64, participant_twelve);
        Mapping::set(entry_index, current_raffle_count + 12u64, participant_thirteen);
        Mapping::set(entry_index, current_raffle_count + 13u64, participant_fourteen);
        // Increment raffle count by 14
        Mapping::set(entry_count, 0u64, current_raffle_count + 14u64);
    }

    transition add_fifteen_raffle_entries(public participant: address, participant_two: address, participant_three: address, participant_four: address, participant_five: address, participant_six: address, participant_seven: address, participant_eight: address, participant_nine: address, participant_ten: address, participant_eleven: address, participant_twelve: address, participant_thirteen: address, participant_fourteen: address, participant_fifteen: address) {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn);
        return then finalize(participant, participant_two, participant_three, participant_four, participant_five, participant_six, participant_seven, participant_eight, participant_nine, participant_ten, participant_eleven, participant_twelve, participant_thirteen, participant_fourteen, participant_fifteen);
    }

    finalize add_fifteen_raffle_entries(public participant: address, participant_two: address, participant_three: address, participant_four: address, participant_five: address, participant_six: address, participant_seven: address, participant_eight: address, participant_nine: address, participant_ten: address, participant_eleven: address, participant_twelve: address, participant_thirteen: address, participant_fourteen: address, participant_fifteen: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(entry_count, 0u64, 0u64);
        Mapping::set(entry_index, current_raffle_count, participant);
        Mapping::set(entry_index, current_raffle_count + 1u64, participant_two);
        Mapping::set(entry_index, current_raffle_count + 2u64, participant_three);
        Mapping::set(entry_index, current_raffle_count + 3u64, participant_four);
        Mapping::set(entry_index, current_raffle_count + 4u64, participant_five);
        Mapping::set(entry_index, current_raffle_count + 5u64, participant_six);
        Mapping::set(entry_index, current_raffle_count + 6u64, participant_seven);
        Mapping::set(entry_index, current_raffle_count + 7u64, participant_eight);
        Mapping::set(entry_index, current_raffle_count + 8u64, participant_nine);
        Mapping::set(entry_index, current_raffle_count + 9u64, participant_ten);
        Mapping::set(entry_index, current_raffle_count + 10u64, participant_eleven);
        Mapping::set(entry_index, current_raffle_count + 11u64, participant_twelve);
        Mapping::set(entry_index, current_raffle_count + 12u64, participant_thirteen);
        Mapping::set(entry_index, current_raffle_count + 13u64, participant_fourteen);
        Mapping::set(entry_index, current_raffle_count + 14u64, participant_fifteen);
        // Increment raffle count by 15
        Mapping::set(entry_count, 0u64, current_raffle_count + 15u64);
    }

    transition determine_raffle_winner () {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn);
        return then finalize;
    }

    // determine_raffle_winner => raffle winner selection function -- may be purely public
    // todo: spec out block ht things
    finalize determine_raffle_winner () {
        // get current raffle count
        let current_raffle_count: u64 = Mapping::get(entry_count, 0u64);
        // grab random number
        let random_number: u64 = ChaCha::rand_u64();
        // select winning number
        let winner_index: u64 = random_number % current_raffle_count;
        // get winner at index position
        let winning_address: address = Mapping::get(entry_index, winner_index);
        // set the winning address
        Mapping::set(winner, winning_address, 0u32);
    }

    // likely need to spec out set_price and send_prize to winner a bit more
    // think about best way to store private key, etc
    transition send_prize_to_winner (public winner_addr: address, public giveaway_record: GiveawayAccount) -> (GiveawayAccount, AuditGiveawayAccount) {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, aleo1nnrfst0v0zrmv809y9l55denfldx3ryn0nmelws0ffz0hx9mxcys84jxxn);

        // set puzzle issuing address as issuer:
        let puzzle_issuer: address = aleo1fan3jt83xvs5m4pqppmeghv4ypsan5aq4clwt4hnfv8pq90evqqq4dj6p6;

        let winner_record: GiveawayAccount = GiveawayAccount {
            owner: winner_addr,
            private_key: giveaway_record.private_key,
        };

        let audit_winner_record: AuditGiveawayAccount = AuditGiveawayAccount {
            owner: puzzle_issuer,
            minter: winner_addr,
            private_key: giveaway_record.private_key,
        };

        return (winner_record, audit_winner_record);
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
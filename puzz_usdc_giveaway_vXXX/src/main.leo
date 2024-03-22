// The 'puzz_usdc_giveaway_v002' program.
// Without nested imports -- puzzle pieces is going to need Piece Keepers to enforce

program puzz_usdc_giveaway_v004.aleo {
    // 0 -> aleo123, 1 -> aleo456
    mapping entry_index: u64 => address;
    // do we need a mapping for the entry count?
    // 0 -> 1, 0 -> 2, and so on.
    mapping entry_count: u64 => u64;
    mapping winner: address => u32;
    mapping test_cha: u64 => u64;
    mapping test_cha_count: u64 => u64;

    // Change Structure to USDC Giveaway
    // Never owned by multisig
    record GiveawayAccount {
        owner: address,
        amount: u64,
        asset_type: u64,
        date: u64,
        private_key: field,
    }

    record AuditGiveawayAccount {
        owner: address,
        minter: address,
        amount: u64,
        asset_type: u64,
        date: u64,
        private_key: field,
    }

    // Change structure to USDC giveaway
    record AuditGiftCard {
        owner: address,
        minter: address,
        amount: u64,
        asset_type: u64,
        date: u64,
        private_key: u64,
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
    transition set_prize (to: address, amount: u64, asset_type: u64, date: u64, private_key: field) -> (GiveawayAccount, AuditGiveawayAccount) {
        // TODO -- probably don't need to field here

        // set puzzle issuing address as issuer:
        let puzzle_issuer: address = aleo1fan3jt83xvs5m4pqppmeghv4ypsan5aq4clwt4hnfv8pq90evqqq4dj6p6;

        // no checks on minting right now. test actions and audit without address check

        // puzzle giveaway minted
        let minted_puzzle_giveaway: GiveawayAccount = GiveawayAccount {
            owner: to,
            amount: amount,
            asset_type: asset_type,
            date: date,
            private_key: private_key,
        };

        // audit record for issuer to know supply
        let audit_giveaway: AuditGiveawayAccount = AuditGiveawayAccount {
            owner: puzzle_issuer,
            minter: to,
            amount: amount,
            asset_type: asset_type,
            date: date,
            private_key: private_key,
        };

        return (minted_puzzle_giveaway, audit_giveaway);
    }

    // add_raffle_entry => add entry to raffle function
    // BIG need to investigate adding multiple entries in one go....
    // BIG need to investigate not using public mappings because going to get insanely expensive
    // BIG need to max size of public mapping
    // public mappings here should just be limited to staking & slashing
    transition add_raffle_entry (public participant: address) {
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

    // tbd if struct/record is better for this?
    // transition add_five_raffle_entries_for_loop (public participant: address)
    // {
    //     return then finalize (participant);
    // }

    // finalize add_five_raffle_entries_for_loop (public participant: address) {
    //     // todo: doesn't compile
    //     for i: u8 in 0u8..5u8 {
    //         // get current raffle count, if first entry, choose default of 0u64
    //         let current_raffle_count: u64 = Mapping::get_or_use(entry_count, 0u64, 0u64);
    //         // increment raffle count
    //         Mapping::set(entry_count, 0u64, current_raffle_count + 1u64);
    //         // add address to entry mapping
    //         Mapping::set(entry_index, current_raffle_count, participant);
    //     }
    // }

    transition add_five_raffle_entries (public participant: address) {
        return then finalize (participant);
    }

    finalize add_five_raffle_entries (public participant: address) {
        // 1st increment
        // get current_raffle_count
        let current_raffle_count: u64 = Mapping::get_or_use(entry_count, 0u64, 0u64);
        // add address to entry mapping
        Mapping::set(entry_index, current_raffle_count, participant);
        // increment raffle count
        Mapping::set(entry_count, 0u64, current_raffle_count + 1u64);

        // 2nd increment
        // get current_raffle_count
        current_raffle_count = Mapping::get(entry_count, 0u64);
        // add address to entry mapping
        Mapping::set(entry_index, current_raffle_count, participant);
        // increment raffle count
        Mapping::set(entry_count, 0u64, current_raffle_count + 1u64);

        // 3rd increment
        // get current_raffle_count
        current_raffle_count = Mapping::get(entry_count, 0u64);
        // add address to entry mapping
        Mapping::set(entry_index, current_raffle_count, participant);
        // increment raffle count
        Mapping::set(entry_count, 0u64, current_raffle_count + 1u64);

        // 4th increment
        // get current_raffle_count
        current_raffle_count = Mapping::get(entry_count, 0u64);
        // add address to entry mapping
        Mapping::set(entry_index, current_raffle_count, participant);
        // increment raffle count
        Mapping::set(entry_count, 0u64, current_raffle_count + 1u64);

        // 5th increment
        // get current_raffle_count
        current_raffle_count = Mapping::get(entry_count, 0u64);
        // add address to entry mapping
        Mapping::set(entry_index, current_raffle_count, participant);
        // increment raffle count
        Mapping::set(entry_count, 0u64, current_raffle_count + 1u64);

    }


    transition add_eight_raffle_entries (public participant: address) {
        return then finalize (participant);
    }

    finalize add_eight_raffle_entries (public participant: address) {
        // 1st increment
        // get current_raffle_count
        let current_raffle_count: u64 = Mapping::get_or_use(entry_count, 0u64, 0u64);
        // add address to entry mapping
        Mapping::set(entry_index, current_raffle_count, participant);
        // increment raffle count
        Mapping::set(entry_count, 0u64, current_raffle_count + 1u64);

        // 2nd increment
        // get current_raffle_count
        current_raffle_count = Mapping::get(entry_count, 0u64);
        // add address to entry mapping
        Mapping::set(entry_index, current_raffle_count, participant);
        // increment raffle count
        Mapping::set(entry_count, 0u64, current_raffle_count + 1u64);

        // 3rd increment
        // get current_raffle_count
        current_raffle_count = Mapping::get(entry_count, 0u64);
        // add address to entry mapping
        Mapping::set(entry_index, current_raffle_count, participant);
        // increment raffle count
        Mapping::set(entry_count, 0u64, current_raffle_count + 1u64);

        // 4th increment
        // get current_raffle_count
        current_raffle_count = Mapping::get(entry_count, 0u64);
        // add address to entry mapping
        Mapping::set(entry_index, current_raffle_count, participant);
        // increment raffle count
        Mapping::set(entry_count, 0u64, current_raffle_count + 1u64);

        // 5th increment
        // get current_raffle_count
        current_raffle_count = Mapping::get(entry_count, 0u64);
        // add address to entry mapping
        Mapping::set(entry_index, current_raffle_count, participant);
        // increment raffle count
        Mapping::set(entry_count, 0u64, current_raffle_count + 1u64);

        // 6th increment
        // get current_raffle_count
        current_raffle_count = Mapping::get(entry_count, 0u64);
        // add address to entry mapping
        Mapping::set(entry_index, current_raffle_count, participant);
        // increment raffle count
        Mapping::set(entry_count, 0u64, current_raffle_count + 1u64);

        // 7th increment
        // get current_raffle_count
        current_raffle_count = Mapping::get(entry_count, 0u64);
        // add address to entry mapping
        Mapping::set(entry_index, current_raffle_count, participant);
        // increment raffle count
        Mapping::set(entry_count, 0u64, current_raffle_count + 1u64);

        // 8th increment
        // get current_raffle_count
        current_raffle_count = Mapping::get(entry_count, 0u64);
        // add address to entry mapping
        Mapping::set(entry_index, current_raffle_count, participant);
        // increment raffle count
        Mapping::set(entry_count, 0u64, current_raffle_count + 1u64);

    }


    transition determine_raffle_winner () {
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
        Mapping::set(winner, winning_address, block.height);
    }


    // quick test function to make sure cha cha is doing what it is intended to do, might not be correct. need to research this tbh.
    transition test_cha_cha (public input: u64) {
        return then finalize(input);
    }

    finalize test_cha_cha (public cha_input: u64) {
        let random_number: u64 = ChaCha::rand_u64();
        let new_num: u64 = random_number % cha_input;
        // quick test to maintain history
        let current_cha_num: u64 = Mapping::get_or_use(test_cha_count, 0u64, 0u64);
        Mapping::set(test_cha, current_cha_num, new_num);
        Mapping::set(test_cha_count, 0u64, current_cha_num + 1u64);
    }

    // likely need to spec out set_price and send_prize to winner a bit more
    // think about best way to store private key, etc
    transition send_prize_to_winner (public winner_addr: address, public giveaway_record: GiveawayAccount) -> (GiveawayAccount, AuditGiveawayAccount) {

        // set puzzle issuing address as issuer:
        let puzzle_issuer: address = aleo1fan3jt83xvs5m4pqppmeghv4ypsan5aq4clwt4hnfv8pq90evqqq4dj6p6;

        let winner_record: GiveawayAccount = GiveawayAccount {
            owner: winner_addr,
            amount: giveaway_record.amount,
            asset_type: giveaway_record.asset_type,
            date: giveaway_record.date,
            private_key: giveaway_record.private_key,
        };

        let audit_winner_record: AuditGiveawayAccount = AuditGiveawayAccount {
            owner: puzzle_issuer,
            minter: winner_addr,
            amount: giveaway_record.amount,
            asset_type: giveaway_record.asset_type,
            date: giveaway_record.date,
            private_key: giveaway_record.private_key,
        };

        return (winner_record, audit_winner_record);
    }

    // placeholder if we need to use the finalize for anything
    // finalize send_prize_to_winner () {

    // }

    // sending prize to raffle winner function
    // should write out a record to raffle operator for winner.... get winner

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
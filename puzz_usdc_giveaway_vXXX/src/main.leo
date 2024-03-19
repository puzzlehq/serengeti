// The 'puzz_usdc_giveaway_v002' program.
// Without nested imports -- puzzle pieces is going to need Piece Keepers to enforce

program puzz_usdc_giveaway_v002.aleo {

    mapping entry_index: u64 => address;
    // do we need a mapping for the entry count?
    mapping entry_count: u64 => u64;
    mapping winner: address => bool;

    // Change Structure to USDC Giveaway
    // Never owned by multisig
    record GiveawayAccount {
        owner: address,
        amount: u64,
        asset_type: u64,
        date: u64,
        private_key: u64,
    }

    record AuditGiveawayAccount {
        owner: address,
        minter: address,
        amount: u64,
        asset_type: u64,
        date: u64,
        private_key: u64,
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
    transition set_prize (to: address, amount: u64, asset_type: u64, date: u64, private_key: u64) -> (GiveawayAccount, AuditGiveawayAccount) {
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
    transition add_raffle_entry(public participant: address) {
        return then finalize(participant);
    }

    finalize add_raffle_entry (public participant: address) {
        // get current raffle count, if first entry, choose default of 0u64
        let current_raffle_count: u64 = Mapping::get_or_use(entry_count, 0u64, 0u64);
        // increment raffle count
        Mapping::set(entry_count, 0u64, current_raffle_count + 1u64);
        // add address to entry mapping
        Mapping::set(entry_index, current_raffle_count, participant);
    }

    transition determine_raffle_winner() {
        return then finalize determine_raffle_winner();
    }

    // todo: spec out block ht things
    finalize determine_raffle_winner() {
        // get current raffle count
        let current_raffle_count: u64 = Mapping::get(entry_count, 0u64);
        // grab random number
        let random_number: u64 = ChaCha::rand_u64();
        // select winning number
        let winner_index: u64 = random_number % current_raffle_count;
        // get winner at index position
        let winning_address: address = Mapping::get(entry_index, winner_index);
        // set the winning address
        Mapping::set(winner, winning_address, true);
    }

    // determine_raffle_winner => raffle winner selection function -- may be purely public

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
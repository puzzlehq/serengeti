// The 'puzz_usdc_giveaway_v002' program.
// Without nested imports -- puzzle pieces is going to need Piece Keepers to enforce

program puzz_usdc_giveaway_v002.aleo {

    // Change Structure to USDC Giveaway
    // Never owned by multisig
    // ix: 0u32
    record GiftCard {
        owner: address,
        amount: u64,
        number: u64,
        date: u64,
        code: u64,
    }

    // Change structure to USDC giveaway
    // ix: 1u32
    record AuditGiftCard {
        owner: address,
        minter: address,
        amount: u64,
        number: u64,
        date: u64,
        code: u64,
    }

    // Put Other Record Structs needed here
    // ...

    // set_prize function -- start
    // creates record onchain with privatekey for ETH that can be
    // used for marketing purposes
    // do we want this to post something to a mapping? Maybe a blockheight when it was sent?
    // or a blockheight when an automated function should call it?
    transition set_prize (to: address, amount: u64, number: u64, date: u64, code: u64) -> (Gift, AuditGift) {
        // set puzzle issuing address as issuer:
        let puzzle_issuer: address = aleo10eu5uxfv6fa3u9v3z77espy3f24pgdrwe57veak9hjt8rwg4gy8qu96l3n;

        // no checks on minting right now. test actions and audit without address check

        // puzzle gift minted
        let minted_puzzle_gift: GiftCard = GiftCard {
            owner: to,
            amount: amount,
            number: number,
            date: date,
            code: code,
        };

        // audit record for issuer to know supply
        let audit_gift: AuditGiftCard = AuditGiftCard {
            owner: puzzle_issuer,
            minter: to,
            amount: amount,
            number: number,
            date: date,
            code: code,
        };

        return (minted_puzzle_gift, audit_gift);
    }

    // add entry to raffle function

    // raffle winner selection function -- may be purely public

    // sending prize to raffle winner function

    // Potential future scope:
    // - pulling out of raffle
    // - automating raffle winner selection
    // https://www.youtube.com/watch?v=BARTutzwBrc -- Gelato solving this

    // General Plan:
    // - Make functions -- functions should give idea about record structure & mappings -today
    // - Test with bash script -today
    // - Deploy with CLI and test on testnet with some giftcards - today
    // - Testing script for 20,000 people hitting this function -- this one will be tomorrow
}
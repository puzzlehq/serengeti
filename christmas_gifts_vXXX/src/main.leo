// The 'christmas_gifts_v002' program.
// Without nested imports -- puzzle pieces is going to need Piece Keepers to enforce

program puzzle_pieces_v016.aleo {

    // Never owned by multisig
    // ix: 0u32
    record Gift {
        owner: address,
        amount: u64,
        number: u64,
        date: u64,
        code: u64,
        ix: u32,
    }

    // ix: 1u32
    record AuditGift {
        owner: address,
        minter: address,
        amount: u64,
        number: u64,
        date: u64,
        code: u64,
        ix: u32,
    }


    transition mint_private (to: address, amount: u64, number: u64, date: u64, code: u64) -> (Gift, AuditGift) {
        // set puzzle issuing address as issuer:
        let puzzle_issuer: address = aleo10eu5uxfv6fa3u9v3z77espy3f24pgdrwe57veak9hjt8rwg4gy8qu96l3n;

        // no checks on minting right now. test actions and audit without address check

        // puzzle gift minted
        let minted_puzzle_gift: Gift = Gift {
            owner: to,
            amount: amount,
            number: number,
            date: date,
            code: code,
            ix: 0u32,
        };

        // audit record for issuer to know supply
        let audit_gift: AuditGift = AuditGift {
            owner: puzzle_issuer,
            minter: to,
            amount: amount,
            number: number,
            date: date,
            code: code,
            ix: 1u32,
        };

        return (minted_puzzle_gift, audit_gift);
    }
}
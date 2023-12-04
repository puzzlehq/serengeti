import puzzle_pieces_consume_test.leo;

// The 'puzzle_storefront_test' program.
program puzzle_storefront_test.aleo {
    
    // ix: 1u32 -- goes to person who redeemed
    record DiscountCode {
        owner: address,
        store: address,
        discount_code: u64,
        ix: u32,
    }

    // ix: 2u32 -- goes to person redeeming
    record DiscountCodeReceipt {
        owner: address,
        store: address,
        ix: u32,
    }

    // ix: 3u32 -- goes to storefront owner for sending discount code
    record PuzzlePieceRedeemedReceipt {
        owner: address,
        store: address,
        redeemer: address,
        amount_redeemed: u64,
        ix: u32,
    }

    // ix: 4u32 -- goes to auditor for record keeping of inbound redemptions
    record AuditPuzzlePieceRedeemed {
        owner: address,
        store: address,
        redeemer: address,
        amount_redeemed: u64,
        ix: u32,
    }

    // ix: 5u32 -- goes to auditor for record keeping of outbound sending discount codes
    record AuditDiscountCodeSent {
        owner: address,
        store: address,
        redeemer: address,
        amount_redeemed: u64,
        discount_code: u64,
        ix: u32,
    }


    // transition -- redeem_puzzle_pieces (Piece, id) -> DiscountCodeReceipt, PuzzlePieceRedeemedReceipt, AuditPuzzlePieceRedeemed
    transition redeem_puzzle_pieces (
        puzzle_piece: puzzle_pieces_consume_test.leo/Piece.record,
        id: u64
    ) -> (
        puzzle_pieces_consume_test.leo/Piece.record,
        puzzle_pieces_consume_test.leo/AuditConsumePieces.record,
        DiscountCodeReceipt,
        PuzzlePieceRedeemedReceipt,
        AuditPuzzlePieceRedeemed
    ) {
        let storefront_owner: address = aleo1s57x35veh7qmcckn6s7c96f226k949cym0y7d7uv7dh5tct7qgrq74swmm;
        let amount_required: u64 = 100u64;

        // check piece record is > 100 puzzle pieces before consuming
        assert(puzzle_piece.amount > amount_required);

        // check user submitted id matches this storefront_owner address
        assert_eq(id, 1u64 );

        // 

        // If pass checks -- consume the pieces and use the owner
        let (
            audit_consume_pieces,

        )

    }

    // transition -- send_discount_code (PuzzlePieceRedeemedReceipt) -> DiscountCode, AuditDiscountCodeSent
    
    transition main(public a: u32, b: u32) -> u32 {
        let c: u32 = a + b;
        return c;
    }
}

program multiparty_pvp_utils_v015.aleo {
    struct Mssage {
        field_1: field,
        field_2: field,
        field_3: field,
        field_4: field,
        field_5: field,
    }

    // owned by challenger
    record Answer {
        owner: address,
        challenger_address: address, // needed if owner == challenger ?
        opponent_address: address,
        game_multisig: address,
        amount: u64,
        nonce: field,
        answer: u8
    }

    // owned by opponent
    record Key {
        owner: address,
        seed: field,
        amount: u64,
        // challenger: address,
        // opponent: address,
        game_multisig: address,
    }

    // Created by challenger at start of the game
    // Enforce that challenger address is the person who receives Answer Record
    // Verify challenger is the one calling this by fresh signature check (can do self.caller later)
    transition mint_answer (
        challenger_address: address,
        opponent_address: address,
        game_multisig: address,
        amount: u64,
        nonce: field,
        answer: u8,
        message_1: field,
        message_2: field,
        message_3: field,
        message_4: field,
        message_5: field,
        sig: signature,
    ) -> (Answer) {
        let msg: Mssage = Mssage {
            field_1: message_1,
            field_2: message_2,
            field_3: message_3,
            field_4: message_4,
            field_5: message_5
        };

        // Verify signature against message to guarantee challenger is caller
        assert(sig.verify(challenger_address, msg));

        let answer_record: Answer = Answer {
            owner: challenger_address,
            challenger_address: challenger_address,
            opponent_address: opponent_address,
            game_multisig: game_multisig,
            amount: amount,
            nonce: nonce,
            answer: answer,
        };

        return (answer_record);
    }

    transition mint_multisig_key(
        seed: field,
        amount: u64,
        challenger: address,
        opponent: address,
        game_multisig: address,
    ) -> (Key) {
        // TODO -- could add a check here turning seed into multisig
        // not doing because need to turn SK_SIG_DOMAIN in keygen into
        // fields. Can do easier after string support

        let key: Key = Key {
            owner: opponent,
            seed: seed,
            amount: amount,
            // challenger: challenger,
            // opponent: opponent,
            game_multisig: game_multisig,
        };

        return (key);
    }

    // Only callable by challenger (Answer owner)
    // Reveals the answer by minting the Answer to the game_multisig
    transition reveal_answer (answer: Answer) -> (Answer) {
        let revealed_answer_record: Answer = Answer {
            owner: answer.game_multisig,
            challenger_address: answer.challenger_address,
            opponent_address: answer.opponent_address,
            game_multisig: answer.game_multisig,
            amount: answer.amount,
            nonce: answer.nonce,
            answer: answer.answer,
        };

        return (revealed_answer_record);
    }
}

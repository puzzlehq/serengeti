program multiparty_pvp_utils_v015.aleo {
    struct Mssage {
        field_1: field,
        field_2: field,
        field_3: field,
        field_4: field,
        field_5: field,
    }

    record Answer {
        owner: address, // challenger
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
    }

    record RevealAnswer {
        owner: address, // challenger
        challenger_address: address,
        opponent_address: address,
        game_multisig: address,
        amount: u64,
        nonce: field,
        answer: u8,
        sig: signature,
    }

    record Key {
        owner: address, // opponent
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
            message_1: message_1,
            message_2: message_2,
            message_3: message_3,
            message_4: message_4,
            message_5: message_5,
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

        let key_record: Key = Key {
            owner: opponent,
            seed: seed,
            amount: amount,
            // challenger: challenger,
            // opponent: opponent,
            game_multisig: game_multisig,
        };

        return (key_record);
    }

    // Only callable by the challenger.
    // Enforced by checkinig that owner == challenger (and caller when fixed)
    // a signature from the ClaimSignature record from the token is used here
    transition reveal_answer (
        answer: Answer,
        sig: signature,
    ) -> (RevealAnswer) {
        // Verify that owner is challenger
        assert_eq(answer.owner, answer.challenger_address);

        // Verify signature from Cagainst message to guarantee challenger is caller
        let msg: Mssage = Mssage {
            field_1: answer.message_1,
            field_2: answer.message_2,
            field_3: answer.message_3,
            field_4: answer.message_4,
            field_5: answer.message_5
        };

        assert(sig.verify(answer.challenger_address, msg));

        let revealed_answer_record: RevealAnswer = RevealAnswer {
            owner: answer.game_multisig,
            challenger_address: answer.challenger_address,
            opponent_address: answer.opponent_address,
            game_multisig: answer.game_multisig,
            amount: answer.amount,
            nonce: answer.nonce,
            answer: answer.answer,
            sig: sig,
        };

        return (revealed_answer_record);
    }
}

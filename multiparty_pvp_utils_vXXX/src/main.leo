// The 'multiparty_pvp_utils_v001' program.
program multiparty_pvp_utils_v001.aleo {
    struct Message {
        field_1: field,
        field_2: field,
        field_3: field,
        field_4: field,
        field_5: field,
    }
    
    record Answer {
        owner: address,
        challenger_address: address,
        opponent_address: address,
        game_address: address,
        amount: u64,
        nonce: field,
        answer: field,
        message_1: field,
        message_2: field,
        message_3: field,
        message_4: field,
        message_5: field,
        sig: signature
    }

    record AuditMintAnswer {
        owner: address,
        answer_owner: address,
        challenger_address: address,
        opponent_address: address,
        game_address: address,
        amount: u64,
        nonce: field,
        answer: field,
        message_1: field,
        message_2: field,
        message_3: field,
        message_4: field,
        message_5: field,
        sig: signature
    }

    // Created by challenger at start of the game
    // Enforce that challenger address is the person who receives Answer Record
    // Verify challenger is the one calling this by fresh signature check (can do self.caller later)
    transition mint_answer (
        challenger_address: address,
        opponent_address: address,
        game_address: address,
        amount: u64,
        nonce: field,
        answer: field,
        message_1: field,
        message_2: field,
        message_3: field,
        message_4: field,
        message_5: field,
        sig: signature,
    ) -> (Answer, AuditMintAnswer) {
        // set puzzle issuing address as issuer:
        let puzzle_issuer: address = aleo16hf8hfpwasnn9cf7k2c0dllc56nn7qt547qxgvgwu6pznw4trvqsx68kls;

        let msg: Message = Message {
            field_1: message_1,
            field_2: message_2,
            field_3: message_3,
            field_4: message_4,
            field_5: message_5
        };
        
        // Verify signature against message to guarantee challenger is caller
        let signature_check: bool = true;
        let is_valid_sig: bool = sig.verify(challenger_address, msg);
        assert_eq(signature_check,is_valid_sig);

        let answer_record: Answer = Answer {
            owner: challenger_address,
            challenger_address: challenger_address,
            opponent_address: opponent_address,
            game_address: game_address,
            amount: amount,
            nonce: nonce,
            answer: answer,
            message_1: message_1,
            message_2: message_2,
            message_3: message_3,
            message_4: message_4,
            message_5: message_5,
            sig: sig,
        };

        let audit_record: AuditMintAnswer = AuditMintAnswer {
            owner: puzzle_issuer,
            answer_owner: challenger_address,
            challenger_address: challenger_address,
            opponent_address: opponent_address,
            game_address: game_address,
            amount: amount,
            nonce: nonce,
            answer: answer,
            message_1: message_1,
            message_2: message_2,
            message_3: message_3,
            message_4: message_4,
            message_5: message_5,
            sig: sig,
        };


        return (answer_record, audit_record);
    }

    // Only callable by the challenger. 
    // Enforced by checkinig that owner == challenger (and caller when fixed)
    // a signature from the ClaimSignature record from the token is used here
    // transition consume_answer(
    //     answer: Answer,
    //     sig: signature,
    // ) -> (address, address, address, address, u64, field, field) {
    //     // Verify that owner is challenger
    //     assert_eq(answer.owner, answer.challenger_address);


    //     // Verify signature from Cagainst message to guarantee challenger is caller
    //     let msg: Message = Message {
    //         field_1: answer.message_1,
    //         field_2: answer.message_2,
    //         field_3: answer.message_3,
    //         field_4: answer.message_4,
    //         field_5: answer.message_5
    //     };

    //     let signature_check: bool = true;
    //     let is_valid_sig: bool = sig.verify(answer.challenger_address, msg);
    //     assert_eq(signature_check,is_valid_sig);

    //     // Verify signature matches the same signature from the Answer record
    //     assert_eq(sig, answer.sig);

    //     let answer_owner: address = answer.owner;
    //     let answer_challenger_address: address = answer.challenger_address;
    //     let answer_opponent_address: address = answer.opponent_address;
    //     let answer_game_address: address = answer.game_address;
    //     let answer_amount: u64 = answer.amount;
    //     let answer_nonce: field = answer.nonce;
    //     let answer_answer: field = answer.answer;

    //     return (
    //         answer_owner,
    //         answer_challenger_address,
    //         answer_opponent_address,
    //         answer_game_address,
    //         answer_amount,
    //         answer_nonce,
    //         answer_answer
    //     );
    // }
}

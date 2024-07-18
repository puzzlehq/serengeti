// The 'simple_sig_verify' program.
program simple_sig_verify.aleo {

    struct Message {
        field_1: field,
        field_2: field,
        field_3: field,
        field_4: field,
        field_5: field,
    }

    record MessageSignInfo {
        owner: address,
        message_1: field,
        message_2: field,
        message_3: field,
        message_4: field,
        message_5: field,
    }

    transition mint_message
    (
        message_1: field,
        message_2: field,
        message_3: field,
        message_4: field,
        message_5: field,
    ) -> MessageSignInfo
    {
        return MessageSignInfo {
            owner: aleo16d0pn0dyrlfs3kqaklt9lpagyjagej93lzhzps50cyxp8m9p7gqs7krdgy,
            message_1: message_1,
            message_2: message_2,
            message_3: message_3,
            message_4: message_4,
            message_5: message_5,
        };

    }

    transition sig_verify(
        // message_sign_info: MessageSignInfo,
        field_1: field,
        field_2: field,
        field_3: field,
        field_4: field,
        field_5: field,
        sig: signature
    ) -> bool {
        let msg: Message = Message {
            field_1: field_1,
            field_2: field_2,
            field_3: field_3,
            field_4: field_4,
            field_5: field_5
        };

        let is_valid_sig: bool = sig.verify(aleo16d0pn0dyrlfs3kqaklt9lpagyjagej93lzhzps50cyxp8m9p7gqs7krdgy, msg);

        return is_valid_sig;
    }
}

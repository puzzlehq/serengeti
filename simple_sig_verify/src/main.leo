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

    transition sig_verify(
        message_sign_info: MessageSignInfo,
        sig: signature
    ) -> bool {
        let msg: Message = Message {
            field_1: message_sign_info.message_1,
            field_2: message_sign_info.message_2,
            field_3: message_sign_info.message_3,
            field_4: message_sign_info.message_4,
            field_5: message_sign_info.message_5
        };

        let is_valid_sig: bool = sig.verify(message_sign_info.owner, msg);

        return is_valid_sig;
    }
}

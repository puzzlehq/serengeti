program simple_sig_verify.aleo {

    struct Message {
        data: field,
    }

    transition sig_verify(
        data: field,
        sig: signature
    ) -> bool {
        let msg: Message = Message { data };
        sig.verify(aleo16d0pn0dyrlfs3kqaklt9lpagyjagej93lzhzps50cyxp8m9p7gqs7krdgy, msg);
    }
}

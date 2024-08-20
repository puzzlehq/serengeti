import puzzle_pieces_v016.aleo;
import multiparty_pvp_utils_v015.aleo;

program wheres_alex_v019.aleo {
    record Game {
        owner: address,
        challenger_commit: field,
        opponent_answer: u8,
        total_pot: u64,
        challenger_address: address,
        opponent_address: address,
        game_multisig: address,
        game_state: u8,
    }

    // GAME STATE RECORDED ON NOTIFICATIONS
    // private game_state: field,
        // NORMAL FLOW
        // 1 -> challenger proposed game
        // 2 -> opponent matched wager
        // 3 -> accepted game
        // 4 -> challenger revealed answer
        // 5 -> finished game
        //
        // ALTERNATE EXIT PATHS
        // 6 -> timeout finished game
        // 0 -> Game reneged

    // your turn:
        // true -> your turn or ms turn
        // false -> awaiting other party turn

    // sent to opponent on propose game for FE/client detection.
    // consumed in match wager
    record GameReqNotification {
        owner: address, //opponent
        game_multisig: address,
        game_state: u8,
        your_turn: bool,
        total_pot: u64,
        challenger_address: address,
        opponent_address: address,
    }

    // sent to challenger on propose game for FE/client detection.
    // consumed in reveal answer
    // record WaitingAcceptanceNotification {
    //     owner: address, //opponent
    //     game_multisig: address,
    //     game_state: field,
    //     your_turn: bool,
    //     total_pot: u64,
    //     // challenger_address: address,
    //     // opponent_address: address,
    // }

    // record StakeRenegedNotification {
    //     owner: address, //opponent
    //     game_multisig: address,
    //     game_state: field,
    //     your_turn: bool,
    //     total_pot: u64,
    //     challenger_address: address,
    //     opponent_address: address,
    //     renege_address: address,
    // }

    // sent to challenger on submit wager for FE/client detection.
    // consumed in reveal answer
    // record ChallengerWagerNotification {
    //     owner: address, //opponent
    //     game_multisig: address,
    //     game_state: field,
    //     your_turn: bool,
    //     total_pot: u64,
    //     // challenger_address: address,
    //     // opponent_address: address,
    // }

    // record OpponentWagerNotification {
    //     owner: address, //opponent
    //     game_multisig: address,
    //     game_state: field,
    //     your_turn: bool,
    //     total_pot: u64,
    //     // challenger_address: address,
    //     // opponent_address: address,
    // }

    // sent to opponent on accept game for FE/client detection.
    // consumed in finish_game/claim total pot
    // record WaitingRevealNotification {
    //     owner: address, //opponent
    //     game_multisig: address,
    //     game_state: field,
    //     your_turn: bool,
    //     total_pot: u64,
    //     // challenger_address: address,
    //     // opponent_address: address,
    // }

    // sent to challenger on accept game for FE/client detection.
    // consumed in reveal answer
    record RevealAnswerNotification {
        owner: address, //opponent
        game_multisig: address,
        game_state: u8,
        your_turn: bool,
        total_pot: u64,
        // challenger_address: address,
        // opponent_address: address,
        opponent_answer: u8,
    }

    // sent to opponent on reveal answer for FE/client detection.
    record GameFinishReqNotification {
        owner: address, //opponent
        game_multisig: address,
        game_state: u8,
        your_turn: bool,
        total_pot: u64,
        // challenger_address: address,
        // opponent_address: address,
        challenger_answer: u8,
        opponent_answer: u8,
        // winner: address,
        // loser: address,
    }

    // sent to both opponent and challenger on finish game
    record GameFinishedNotification {
        owner: address,
        game_multisig: address,
        game_state: u8,
        total_pot: u64,
        // challenger_address: address,
        // opponent_address: address,
        // winner: address,
        // loser: address,
    }

    transition propose_game (
        // puzzle_pieces.stake_transfer_in() data
        wager_record: puzzle_pieces_v016.aleo/Piece,
        challenger_wager_amount: u64,
        sender: address, // Challenger address proposing game
        challenger: address,
        opponent: address,
        game_multisig: address,
        challenger_message_1: field, // from output of useSignature
        challenger_message_2: field,
        challenger_message_3: field,
        challenger_message_4: field,
        challenger_message_5: field,
        challenger_sig: signature, // from output of useSignature
        // multiparty_pvp_utils data
        challenger_nonce: field,
        challenger_answer: u8,
        game_multisig_seed: field, // game_multisig seed to send to user
        // wheres_alex data
    ) -> (
        puzzle_pieces_v016.aleo/PieceClaim,
        puzzle_pieces_v016.aleo/PieceStake,
        puzzle_pieces_v016.aleo/ClaimSignature,
        puzzle_pieces_v016.aleo/Piece,
        multiparty_pvp_utils_v015.aleo/Answer,
        multiparty_pvp_utils_v015.aleo/Key,
        Game,
        GameReqNotification,
        // WaitingAcceptanceNotification,
    ) {
        // assert contracts can't call this
        assert_eq(self.caller, self.signer);

        // random edge case, maybe unnecessary
        assert_neq(game_multisig, opponent);

        // assert that player 1s answer is either "in weeds" or "behind building"
        assert(challenger_answer == 0u8 || challenger_answer == 1u8);

        // hash the answer and nonce
        let challenger_commit: field = BHP256::commit_to_field(challenger_answer, challenger_nonce as scalar);

        // assert that the wager amount > 0 and wager record has at least that much
        assert((challenger_wager_amount > 0u64) && (wager_record.amount >= challenger_wager_amount));

        let (
            piece_claim_challenger,
            piece_stake_challenger,
            claim_signature_challenger,
            piece_change_challenger,
        ): (
            puzzle_pieces_v016.aleo/PieceClaim,
            puzzle_pieces_v016.aleo/PieceStake,
            puzzle_pieces_v016.aleo/ClaimSignature,
            puzzle_pieces_v016.aleo/Piece,
        ) = puzzle_pieces_v016.aleo/stake_transfer_in(
            wager_record,
            sender,
            challenger,
            opponent,
            game_multisig,
            challenger_wager_amount,
            challenger_message_1,
            challenger_message_2,
            challenger_message_3,
            challenger_message_4,
            challenger_message_5,
            challenger_sig
        );

        let key_record: multiparty_pvp_utils_v015.aleo/Key = multiparty_pvp_utils_v015.aleo/mint_multisig_key(
          game_multisig_seed,
          challenger_wager_amount,
          challenger,
          opponent,
          game_multisig
        );

        let game_request_notification_record: GameReqNotification = GameReqNotification {
            owner: opponent,
            game_multisig: game_multisig,
            game_state: 1u8,
            your_turn: true,
            total_pot: challenger_wager_amount + challenger_wager_amount,
            challenger_address: challenger,
            opponent_address: opponent,
        };

        // let game_waiting_acceptance_notification_record: WaitingAcceptanceNotification = WaitingAcceptanceNotification {
        //     owner: challenger, //challenger
        //     game_multisig: game_multisig,
        //     game_state: 1u8,
        //     your_turn: false,
        //     total_pot: challenger_wager_amount + challenger_wager_amount,
        //     challenger_address: challenger,
        //     opponent_address: opponent,
        // };

        let game_record: Game = Game {
            owner: game_multisig,
            challenger_commit: challenger_commit,
            opponent_answer: 0u8, // placeholder until opponent answer in accept_game
            total_pot: challenger_wager_amount + challenger_wager_amount,
            challenger_address: challenger,
            opponent_address: opponent,
            game_multisig: game_multisig,
            game_state: 1u8,
        };

        let (challenger_answer_record): multiparty_pvp_utils_v015.aleo/Answer = multiparty_pvp_utils_v015.aleo/mint_answer(
            challenger,
            opponent,
            game_multisig,
            challenger_wager_amount,
            challenger_nonce,
            challenger_answer,
            challenger_message_1,
            challenger_message_2,
            challenger_message_3,
            challenger_message_4,
            challenger_message_5,
            challenger_sig
        );

        return (
            piece_claim_challenger,
            piece_stake_challenger,
            claim_signature_challenger,
            piece_change_challenger,
            challenger_answer_record,
            key_record,
            game_record,
            game_request_notification_record,
            // game_waiting_acceptance_notification_record,
        );
    }

    // challenger calls this function with Multisig key and signature as input
    // that was submitted when proposing game and that exists on claim record
    // transition challenger_renege_stake
    // (
    //     waiting_accept_game_notification: WaitingAcceptanceNotification,
    //     piece_stake_challenger: puzzle_pieces_v016.aleo/PieceStake,
    //     piece_claim_challenger: puzzle_pieces_v016.aleo/PieceClaim,
    //     challenger_sig: signature,
    // ) -> (
    //     puzzle_pieces_v016.aleo/Piece,
    //     // puzzle_pieces_v016.aleo/AuditStakeOut,
    //     StakeRenegedNotification,
    //     StakeRenegedNotification,
    //     )
    // {
    //     // assert contracts can't call this
    //     assert_eq(self.caller, self.signer);

    //     let (piece_record): puzzle_pieces_v016.aleo/Piece = puzzle_pieces_v016.aleo/stake_transfer_out(piece_stake_challenger, piece_claim_challenger, challenger_sig);

    //     let notify_challenger_stake_reneged: StakeRenegedNotification = StakeRenegedNotification {
    //         owner: waiting_accept_game_notification.challenger_address, //opponent
    //         game_multisig: waiting_accept_game_notification.game_multisig,
    //         game_state: 0u8,
    //         your_turn: false,
    //         total_pot: waiting_accept_game_notification.total_pot,
    //         challenger_address: waiting_accept_game_notification.challenger_address,
    //         opponent_address: waiting_accept_game_notification.opponent_address,
    //         renege_address: waiting_accept_game_notification.challenger_address,
    //     };


    //     let notify_opponent_stake_reneged: StakeRenegedNotification = StakeRenegedNotification {
    //         owner: waiting_accept_game_notification.opponent_address, //opponent
    //         game_multisig: waiting_accept_game_notification.game_multisig,
    //         game_state: 0u8,
    //         your_turn: false,
    //         total_pot: waiting_accept_game_notification.total_pot,
    //         challenger_address: waiting_accept_game_notification.challenger_address,
    //         opponent_address: waiting_accept_game_notification.opponent_address,
    //         renege_address: waiting_accept_game_notification.challenger_address,
    //     };

    //     return (piece_record, notify_challenger_stake_reneged, notify_opponent_stake_reneged);

    // }

    transition submit_wager (
        opponent_wager_record: puzzle_pieces_v016.aleo/Piece,
        key_record: multiparty_pvp_utils_v015.aleo/Key,
        game_req_notification: GameReqNotification,
        opponent_message_1: field, //from output of useSignature
        opponent_message_2: field,
        opponent_message_3: field,
        opponent_message_4: field,
        opponent_message_5: field,
        opponent_sig: signature, //from output of useSignature
    ) -> (
        puzzle_pieces_v016.aleo/PieceClaim,
        puzzle_pieces_v016.aleo/PieceStake,
        puzzle_pieces_v016.aleo/ClaimSignature,
        puzzle_pieces_v016.aleo/Piece,
        // puzzle_pieces_v016.aleo/AuditStakeIn,
        // ChallengerWagerNotification,
        // OpponentWagerNotification,
    )
    {

        // Logic Checks
        // limit calls to only users
        assert_eq(self.caller, self.signer);

        // assert that the wager amount > 0 and wager inside credit == wager amt passed
        assert(opponent_wager_record.amount > 0u64);
        // assert that the wager record has >= total pot / 2u8
        assert(opponent_wager_record.amount >= game_req_notification.total_pot / 2u64);

        let (
            piece_claim_opponent,
            piece_stake_opponent,
            claim_signature_opponent,
            piece_change_opponent,
            // audit_stake_in_record,
        ): (
            puzzle_pieces_v016.aleo/PieceClaim,
            puzzle_pieces_v016.aleo/PieceStake,
            puzzle_pieces_v016.aleo/ClaimSignature,
            puzzle_pieces_v016.aleo/Piece,
            // puzzle_pieces_v016.aleo/AuditStakeIn
        ) = puzzle_pieces_v016.aleo/stake_transfer_in(
            opponent_wager_record,
            game_req_notification.opponent_address, // sender
            game_req_notification.challenger_address, // challenger
            game_req_notification.opponent_address,
            game_req_notification.game_multisig,
            game_req_notification.total_pot / 2u64, // divide total pot by 2
            opponent_message_1,
            opponent_message_2,
            opponent_message_3,
            opponent_message_4,
            opponent_message_5,
            opponent_sig,
        );

        // let challenger_submitted_wager_notification_record: ChallengerWagerNotification = ChallengerWagerNotification {
        //     owner: game_req_notification.challenger_address,
        //     game_multisig: game_req_notification.game_multisig,
        //     game_state: 2field,
        //     your_turn: false,
        //     total_pot: game_req_notification.total_pot,
        //     challenger_address: game_req_notification.challenger_address,
        //     opponent_address: game_req_notification.opponent_address,

        // };

        // let opponent_submitted_wager_notification_record: OpponentWagerNotification = OpponentWagerNotification {
        //     owner: game_req_notification.opponent_address,
        //     game_multisig: game_req_notification.game_multisig,
        //     game_state: 2field,
        //     your_turn: true,
        //     total_pot: game_req_notification.total_pot,
        //     challenger_address: game_req_notification.challenger_address,
        //     opponent_address: game_req_notification.opponent_address,
        // };

        return (
            piece_claim_opponent,
            piece_stake_opponent,
            claim_signature_opponent,
            piece_change_opponent,
            // audit_stake_in_record,
            // challenger_submitted_wager_notification_record,
            // opponent_submitted_wager_notification_record,
        );
    }


    // opponent calls this function with Multisig key and signature as input
    // that was submitted when submitting wager that exists on claim record
    // transition opponent_renege_stake
    // (
    //     waiting_accept_game_notification: WaitingAcceptanceNotification,
    //     piece_stake_opponent: puzzle_pieces_v016.aleo/PieceStake,
    //     piece_claim_opponent: puzzle_pieces_v016.aleo/PieceClaim,
    //     opponent_sig: signature,
    // ) -> (
    //     puzzle_pieces_v016.aleo/Piece,
    //     // puzzle_pieces_v016.aleo/AuditStakeOut,
    //     StakeRenegedNotification,
    //     StakeRenegedNotification,
    //     )
    // {
    //     // assert contracts can't call this
    //     assert_eq(self.caller, self.signer);

    //     let (piece_record): puzzle_pieces_v016.aleo/Piece = puzzle_pieces_v016.aleo/stake_transfer_out(piece_stake_opponent, piece_claim_opponent, opponent_sig);

    //     let notify_challenger_stake_reneged: StakeRenegedNotification = StakeRenegedNotification {
    //         owner: waiting_accept_game_notification.challenger_address, //opponent
    //         game_multisig: waiting_accept_game_notification.game_multisig,
    //         game_state: 0u8,
    //         your_turn: false,
    //         total_pot: waiting_accept_game_notification.total_pot,
    //         challenger_address: waiting_accept_game_notification.challenger_address,
    //         opponent_address: waiting_accept_game_notification.opponent_address,
    //         renege_address: waiting_accept_game_notification.opponent_address,
    //     };


    //     let notify_opponent_stake_reneged: StakeRenegedNotification = StakeRenegedNotification {
    //         owner: waiting_accept_game_notification.opponent_address, //opponent
    //         game_multisig: waiting_accept_game_notification.game_multisig,
    //         game_state: 0u8,
    //         your_turn: false,
    //         total_pot: waiting_accept_game_notification.total_pot,
    //         challenger_address: waiting_accept_game_notification.challenger_address,
    //         opponent_address: waiting_accept_game_notification.opponent_address,
    //         renege_address: waiting_accept_game_notification.opponent_address,
    //     };

    //     return (piece_record, notify_challenger_stake_reneged, notify_opponent_stake_reneged);

    // }

    // called by ms key after wager is confirmed on network
    transition accept_game
    (
        game_record: Game,
        opponent_answer: u8,
        piece_stake_challenger: puzzle_pieces_v016.aleo/PieceStake,
        piece_claim_challenger: puzzle_pieces_v016.aleo/PieceClaim,
        piece_stake_opponent: puzzle_pieces_v016.aleo/PieceStake,
        piece_claim_opponent: puzzle_pieces_v016.aleo/PieceClaim,
        block_ht: u32,
    ) -> (
        puzzle_pieces_v016.aleo/PieceJointStake,
        puzzle_pieces_v016.aleo/JointPieceTimeClaim,
        puzzle_pieces_v016.aleo/JointPieceState,
        // WaitingRevealNotification,
        RevealAnswerNotification,
        Game,
    )
    {
        // assert that the game address/multiisg is calling this
        assert_eq(game_record.owner, self.signer);

        // assert contracts can't call this
        assert_eq(self.caller, self.signer);

        // assert that opponent's answer is valid
        assert(opponent_answer == 0u8 || opponent_answer == 1u8);

        let (
            piece_joint_stake,
            joint_piece_time_claim,
            joint_piece_state,
        ): (
            puzzle_pieces_v016.aleo/PieceJointStake,
            puzzle_pieces_v016.aleo/JointPieceTimeClaim,
            puzzle_pieces_v016.aleo/JointPieceState,
        ) = puzzle_pieces_v016.aleo/transfer_stakes_to_joint(
            piece_stake_challenger,
            piece_claim_challenger,
            piece_stake_opponent,
            piece_claim_opponent,
            block_ht,
        );

        // sent to opponent on accept_game
        // let waiting_reveal_answer_notifcation_record: WaitingRevealNotification = WaitingRevealNotification {
        //     owner: game_record.opponent_address,
        //     game_multisig: game_record.owner,
        //     game_state: 3field,
        //     your_turn: false,
        //     total_pot: game_record.total_pot,
        //     // challenger_address: game_record.challenger_address,
        //     // opponent_address: game_record.opponent_address,
        // };

        // sent to challenger on accept_game
        let reveal_answer_notification_record: RevealAnswerNotification = RevealAnswerNotification {
            owner: game_record.challenger_address,
            game_multisig: game_record.owner,
            game_state: 3u8,
            your_turn: true,
            total_pot: game_record.total_pot,
            // challenger_address: game_record.challenger_address,
            // opponent_address: game_record.opponent_address,
            opponent_answer: opponent_answer,
        };

        let updated_game_record: Game = Game {
            owner: game_record.owner,
            challenger_commit: game_record.challenger_commit,
            opponent_answer: opponent_answer,
            total_pot: game_record.total_pot,
            challenger_address: game_record.challenger_address,
            opponent_address: game_record.opponent_address,
            game_multisig: game_record.game_multisig,
            game_state: 3u8,
        };

        return (
            piece_joint_stake,
            joint_piece_time_claim,
            joint_piece_state,
            // waiting_reveal_answer_notifcation_record,
            reveal_answer_notification_record,
            updated_game_record,
        );
    }


    // finalize accept_game
    // (
    //     block_ht: u32,
    // )
    // {
    //     // block every 5 seconds or so
    //     // would need to wait for time between `accept_game` req. from client to being proved
    //     // ~ 5s per block
    //     // leeway of 100 blocks = 100 * 5 = 500 / 60 = ~8.33 mins.
    //     // assert that block_ht passed in is within 1000 blocks of current block ht.
    //     //
    //     // Check legit block height as input
    //     let current_block_ht: u32 = block.height;
    //     assert(block_ht >= current_block_ht - 1000u32);
    //     assert(block_ht <= current_block_ht + 1000u32);
    // }

    // called by challenger to reveal answer record
    transition reveal_answer_game
    (
        reveal_answer_notification_record: RevealAnswerNotification,
        challenger_answer_record: multiparty_pvp_utils_v015.aleo/Answer,
        joint_piece_state: puzzle_pieces_v016.aleo/JointPieceState,
        challenger_claim_signature: puzzle_pieces_v016.aleo/ClaimSignature,
    ) -> (
        multiparty_pvp_utils_v015.aleo/Answer,
        puzzle_pieces_v016.aleo/JointPieceWinner,
        GameFinishReqNotification,
        GameFinishReqNotification,
    )
    {
        // assert that the correct state updater address is the challenger and the challenger
        // is invoking this
        assert_eq(joint_piece_state.state_updater_address, self.signer);

        // assert contracts can't call this
        assert_eq(self.caller, self.signer);

        // determine winner! If opponent correctly picked where the challenger hid alex, the opponent wins otherwise the challenger wins
        let winner_address: address = reveal_answer_notification_record.opponent_answer == challenger_answer_record.answer ? challenger_answer_record.opponent_address : challenger_answer_record.challenger_address;
        let loser_address: address = winner_address == challenger_answer_record.challenger_address ? challenger_answer_record.opponent_address : challenger_answer_record.challenger_address;
        // let challenger_sig: signature = challenger_claim_signature.sig;

        // retrieve revealedanswer record
        let (revealed_answer_record): multiparty_pvp_utils_v015.aleo/Answer = multiparty_pvp_utils_v015.aleo/reveal_answer(challenger_answer_record);

        let (joint_piece_winner): puzzle_pieces_v016.aleo/JointPieceWinner = puzzle_pieces_v016.aleo/joint_stake_state_update(joint_piece_state, challenger_claim_signature, winner_address);

        let game_finish_req_notification_record_opponent: GameFinishReqNotification = GameFinishReqNotification {
            owner: challenger_answer_record.opponent_address,
            game_multisig: challenger_answer_record.game_multisig,
            game_state: 4u8,
            your_turn: true,
            total_pot: joint_piece_state.amount,
            // challenger_address: challenger_answer_record.challenger_address,
            // opponent_address: challenger_answer_record.opponent_address,
            challenger_answer: challenger_answer_record.answer,
            opponent_answer: reveal_answer_notification_record.opponent_answer,
            // winner: winner_address,
            // loser: loser_address,
        };

        let game_finish_req_notification_record_challenger: GameFinishReqNotification = GameFinishReqNotification{
            owner: challenger_answer_record.challenger_address,
            game_multisig: challenger_answer_record.game_multisig,
            game_state: 4u8,
            your_turn: true,
            total_pot: joint_piece_state.amount,
            // challenger_address: challenger_answer_record.challenger_address,
            // opponent_address: challenger_answer_record.opponent_address,
            challenger_answer: challenger_answer_record.answer,
            opponent_answer: reveal_answer_notification_record.opponent_answer,
            // winner: winner_address,
            // loser: loser_address,
        };

        return (revealed_answer_record, joint_piece_winner, game_finish_req_notification_record_opponent, game_finish_req_notification_record_challenger);
    }

    // called by ms key to finish the game and get the total pot!
    transition finish_game
    (
        game_record: Game,
        joint_piece_winner: puzzle_pieces_v016.aleo/JointPieceWinner,
        piece_joint_stake: puzzle_pieces_v016.aleo/PieceJointStake,
        joint_piece_time_claim: puzzle_pieces_v016.aleo/JointPieceTimeClaim,
    ) -> (
        puzzle_pieces_v016.aleo/Piece,
        Game,
        GameFinishedNotification,
        GameFinishedNotification)
    {
        // assert that the game address/multiisg is calling this
        assert_eq(game_record.owner, self.signer);

        // assert contracts can't call this
        assert_eq(self.caller, self.signer);

        let loser_address: address = joint_piece_winner.winner == game_record.challenger_address ? game_record.opponent_address : game_record.challenger_address;

        let (piece_record): puzzle_pieces_v016.aleo/Piece = puzzle_pieces_v016.aleo/joint_stake_transfer_to_winner(
            joint_piece_winner,
            piece_joint_stake,
            joint_piece_time_claim,
        );

        let updated_game_record: Game = Game {
            owner: game_record.owner,
            challenger_commit: game_record.challenger_commit,
            opponent_answer: game_record.opponent_answer,
            total_pot: game_record.total_pot,
            challenger_address: game_record.challenger_address,
            opponent_address: game_record.opponent_address,
            game_multisig: game_record.game_multisig,
            game_state: 5u8,
        };

        let game_finished_notification_challenger_record: GameFinishedNotification = GameFinishedNotification {
            owner: game_record.challenger_address,
            game_multisig: game_record.game_multisig,
            game_state: 5u8,
            // your_turn: false,
            total_pot: game_record.total_pot,
            // challenger_address: game_record.challenger_address,
            // opponent_address: game_record.opponent_address,
            // winner: joint_piece_winner.winner,
            // loser: loser_address,
        };

        let game_finished_notification_opponent_record: GameFinishedNotification = GameFinishedNotification {
            owner: game_record.opponent_address,
            game_multisig: game_record.game_multisig,
            game_state: 5u8,
            // your_turn: false,
            total_pot: game_record.total_pot,
            // challenger_address: game_record.challenger_address,
            // opponent_address: game_record.opponent_address,
            // winner: joint_piece_winner.winner,
            // loser: loser_address,
        };

        return (piece_record, updated_game_record, game_finished_notification_challenger_record, game_finished_notification_opponent_record);
    }

    // called by ms key via opponent to finish the game and get the total pot!
    // transition finish_game_by_timeout(
    //     game_record: Game,
    //     piece_joint_stake: puzzle_pieces_v016.aleo/PieceJointStake,
    //     joint_piece_time_claim: puzzle_pieces_v016.aleo/JointPieceTimeClaim,
    //     sig: signature, // use from ClaimSignature record on FE, can't consume in this fxn bc claim is owned by multisig
    // ) -> (
    //     puzzle_pieces_v016.aleo/Piece,
    //     // puzzle_pieces_v016.aleo/AuditTransferToWinner,
    //     Game,
    //     GameFinishedNotification,
    //     GameFinishedNotification)
    // {
    //     // assert that the game address/multiisg is calling this
    //     assert_eq(game_record.owner, self.signer);

    //     // assert contracts can't call this
    //     assert_eq(self.caller, self.signer);

    //     // Update the game state
    //     let updated_game_record: Game = Game {
    //         owner: game_record.owner,
    //         challenger_commit: game_record.challenger_commit,
    //         opponent_answer: game_record.opponent_answer,
    //         total_pot: game_record.total_pot,
    //         challenger_address: game_record.challenger_address,
    //         opponent_address: game_record.opponent_address,
    //         game_multisig: game_record.game_multisig,
    //         game_state: 6field,
    //     };

    //     // Notification to challenger of game finished
    //     let game_finished_notification_challenger_record: GameFinishedNotification = GameFinishedNotification {
    //         owner: game_record.challenger_address,
    //         game_multisig: game_record.game_multisig,
    //         game_state: 6field,
    //         your_turn: false,
    //         total_pot: game_record.total_pot,
    //         challenger_address: game_record.challenger_address,
    //         opponent_address: game_record.opponent_address,
    //         winner: game_record.opponent_address,
    //         loser: game_record.challenger_address,
    //     };

    //     // Notification to opponent of game finished
    //     let game_finished_notification_opponent_record: GameFinishedNotification = GameFinishedNotification {
    //         owner: game_record.opponent_address,
    //         game_multisig: game_record.game_multisig,
    //         game_state: 6field,
    //         your_turn: false,
    //         total_pot: game_record.total_pot,
    //         challenger_address: game_record.challenger_address,
    //         opponent_address: game_record.opponent_address,
    //         winner: game_record.opponent_address,
    //         loser: game_record.challenger_address,
    //     };

    //     // Payout to winner
    //     let (piece_record_winner): puzzle_pieces_v016.aleo/Piece = puzzle_pieces_v016.aleo/joint_timeout_to_opponent(piece_joint_stake, joint_piece_time_claim, sig);

    //     return (
    //         piece_record_winner,
    //         // audit_transfer_to_winner_record,
    //         updated_game_record,
    //         game_finished_notification_challenger_record,
    //         game_finished_notification_opponent_record
    //     );
    // }

}
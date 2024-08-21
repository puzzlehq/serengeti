import puzzle_multiparty_coin_v001.aleo;

program wheres_alex_v019.aleo {
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
        game_multisig: address,
    }

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

    // sent to opponent on propose_game
    // consumed in submit_wager
    record Proposal {
        owner: address, // opponent
        game_multisig: address,
        game_state: u8,
        total_pot: u64,
        challenger_address: address
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

    // called by challenger
    transition propose_game (
        // puzzle_pieces.stake_transfer_in() data
        wager: puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin,
        wager_amount: u64,
        challenger: address,
        opponent: address,
        game_multisig: address,
        message_1: field, // from output of useSignature
        message_2: field,
        message_3: field,
        message_4: field,
        message_5: field,
        sig: signature, // from output of useSignature
        // multiparty_pvp_utils data
        nonce: field,
        answer: u8,
        game_multisig_seed: field, // game_multisig seed to send to user
        // wheres_alex data
    ) -> (
        puzzle_multiparty_coin_v001.aleo/StakeClaim,
        puzzle_multiparty_coin_v001.aleo/Stake,
        puzzle_multiparty_coin_v001.aleo/ClaimSignature,
        puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin,
        Answer,
        Key,
        Game,
        Proposal,
    ) {
        // assert contracts can't call this
        assert_eq(self.caller, self.signer);

        // random edge case, maybe unnecessary
        assert_neq(game_multisig, opponent);

        // assert that the answer is valid
        assert(answer == 0u8 || answer == 1u8);

        // commit to answer by hashing the answer and nonce
        let answer_commitment: field = BHP256::commit_to_field(answer, nonce as scalar);

        // assert that the wager amount > 0 and wager record has at least that much
        assert((wager_amount > 0u64) && (wager.amount >= wager_amount));

        // transfer wager to multisig
        let (
            piece_claim,
            piece_stake,
            claim_signature,
            piece_change,
        ): (
            puzzle_multiparty_coin_v001.aleo/StakeClaim,
            puzzle_multiparty_coin_v001.aleo/Stake,
            puzzle_multiparty_coin_v001.aleo/ClaimSignature,
            puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin,
        ) = puzzle_multiparty_coin_v001.aleo/stake_transfer_in(
            wager,
            wager_amount,
            challenger,
            opponent,
            game_multisig,
            message_1,
            message_2,
            message_3,
            message_4,
            message_5,
            sig
        );

        // let key: multiparty_pvp_utils_v015.aleo/Key = 
        //   multiparty_pvp_utils_v015.aleo/mint_multisig_key(
        //     game_multisig_seed,
        //     opponent,
        //     game_multisig
        //   );
        let key: Key = Key {
            owner: opponent,
            seed: game_multisig_seed,
            game_multisig: game_multisig,
        };

        let proposal: Proposal = Proposal {
            owner: opponent,
            game_multisig: game_multisig,
            game_state: 1u8,
            total_pot: wager_amount + wager_amount,
            challenger_address: challenger,
        };

        let game: Game = Game {
            owner: game_multisig,
            challenger_commit: answer_commitment,
            opponent_answer: 0u8, // placeholder until opponent answer in accept_game
            total_pot: wager_amount + wager_amount,
            challenger_address: challenger,
            opponent_address: opponent,
            game_multisig: game_multisig,
            game_state: 1u8,
        };

        // let (challenger_answer): multiparty_pvp_utils_v015.aleo/Answer = 
        //   multiparty_pvp_utils_v015.aleo/mint_answer(
        //       challenger,
        //       opponent,
        //       game_multisig,
        //       wager_amount,
        //       nonce,
        //       answer,
        //   );

        let answer_: Answer = Answer {
            owner: challenger,
            challenger_address: challenger,
            opponent_address: opponent,
            game_multisig: game_multisig,
            amount: wager_amount,
            nonce: nonce,
            answer: answer,
        };

        return (
            piece_claim,
            piece_stake,
            claim_signature,
            piece_change,
            answer_,
            key,
            game,
            proposal,
        );
    }

    // challenger calls this function with Multisig key and signature as input
    // that was submitted when proposing game and that exists on claim record
    // transition challenger_renege_stake
    // (
    //     waiting_accept_game_notification: WaitingAcceptanceNotification,
    //     piece_stake_challenger: puzzle_multiparty_coin_v001.aleo/Stake,
    //     piece_claim_challenger: puzzle_multiparty_coin_v001.aleo/StakeClaim,
    //     challenger_sig: signature,
    // ) -> (
    //     puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin,
    //     // puzzle_multiparty_coin_v001.aleo/AuditStakeOut,
    //     StakeRenegedNotification,
    //     StakeRenegedNotification,
    //     )
    // {
    //     // assert contracts can't call this
    //     assert_eq(self.caller, self.signer);

    //     let (piece_record): puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin = puzzle_multiparty_coin_v001.aleo/stake_transfer_out(piece_stake_challenger, piece_claim_challenger, challenger_sig);

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

    // called by opponent
    transition submit_wager (
        wager: puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin,
        key: Key,
        proposal: Proposal,
        message_1: field,
        message_2: field,
        message_3: field,
        message_4: field,
        message_5: field,
        sig: signature,
    ) -> (
        puzzle_multiparty_coin_v001.aleo/StakeClaim,
        puzzle_multiparty_coin_v001.aleo/Stake,
        puzzle_multiparty_coin_v001.aleo/ClaimSignature,
        puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin,
    )
    {
        // assert that the wager record has enough to match the proposal
        assert(wager.amount >= proposal.total_pot / 2u64);

        let (
            piece_claim_opponent,
            piece_stake_opponent,
            claim_signature_opponent,
            piece_change_opponent,
        ): (
            puzzle_multiparty_coin_v001.aleo/StakeClaim,
            puzzle_multiparty_coin_v001.aleo/Stake,
            puzzle_multiparty_coin_v001.aleo/ClaimSignature,
            puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin,
        ) = puzzle_multiparty_coin_v001.aleo/stake_transfer_in(
            wager,
            proposal.total_pot / 2u64, // amount = half total_pot
            proposal.challenger_address,
            self.signer,
            proposal.game_multisig,
            message_1,
            message_2,
            message_3,
            message_4,
            message_5,
            sig,
        );

        return (
            piece_claim_opponent,
            piece_stake_opponent,
            claim_signature_opponent,
            piece_change_opponent,
        );
    }


    // opponent calls this function with Multisig key and signature as input
    // that was submitted when submitting wager that exists on claim record
    // transition opponent_renege_stake
    // (
    //     waiting_accept_game_notification: WaitingAcceptanceNotification,
    //     piece_stake_opponent: puzzle_multiparty_coin_v001.aleo/Stake,
    //     piece_claim_opponent: puzzle_multiparty_coin_v001.aleo/StakeClaim,
    //     opponent_sig: signature,
    // ) -> (
    //     puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin,
    //     // puzzle_multiparty_coin_v001.aleo/AuditStakeOut,
    //     StakeRenegedNotification,
    //     StakeRenegedNotification,
    //     )
    // {
    //     // assert contracts can't call this
    //     assert_eq(self.caller, self.signer);

    //     let (piece_record): puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin = puzzle_multiparty_coin_v001.aleo/stake_transfer_out(piece_stake_opponent, piece_claim_opponent, opponent_sig);

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

    // called by opponent (via ms key) after wager is confirmed on network
    transition accept_game
    (
        game: Game,
        opponent_answer: u8,
        stake_challenger: puzzle_multiparty_coin_v001.aleo/Stake,
        claim_challenger: puzzle_multiparty_coin_v001.aleo/StakeClaim,
        stake_opponent: puzzle_multiparty_coin_v001.aleo/Stake,
        claim_opponent: puzzle_multiparty_coin_v001.aleo/StakeClaim,
        block_ht: u32,
    ) -> (
        puzzle_multiparty_coin_v001.aleo/JointStake,
        puzzle_multiparty_coin_v001.aleo/JointTimeoutClaim,
        puzzle_multiparty_coin_v001.aleo/JointState,
        RevealAnswerNotification,
        Game,
    )
    {
        // assert that opponent's answer is valid
        assert(opponent_answer == 0u8 || opponent_answer == 1u8);

        let (
            piece_joint_stake,
            joint_piece_time_claim,
            joint_piece_state,
        ): (
            puzzle_multiparty_coin_v001.aleo/JointStake,
            puzzle_multiparty_coin_v001.aleo/JointTimeoutClaim,
            puzzle_multiparty_coin_v001.aleo/JointState,
        ) = puzzle_multiparty_coin_v001.aleo/join_stakes(
            stake_challenger,
            claim_challenger,
            stake_opponent,
            claim_opponent,
            block_ht,
        );

        // sent to challenger on accept_game
        let reveal_answer_notification: RevealAnswerNotification = RevealAnswerNotification {
            owner: game.challenger_address,
            game_multisig: game.owner,
            game_state: 3u8,
            your_turn: true,
            total_pot: game.total_pot,
            // challenger_address: game_record.challenger_address,
            // opponent_address: game_record.opponent_address,
            opponent_answer: opponent_answer,
        };

        // question -- is Game ever _not_ owned by the multisig?
        //   if so, can remove game_multisig?
        let updated_game: Game = Game {
            owner: game.owner,
            challenger_commit: game.challenger_commit,
            opponent_answer: opponent_answer,
            total_pot: game.total_pot,
            challenger_address: game.challenger_address,
            opponent_address: game.opponent_address,
            game_multisig: game.game_multisig,
            game_state: 3u8,
        };

        return (
            piece_joint_stake,
            joint_piece_time_claim,
            joint_piece_state,
            reveal_answer_notification,
            updated_game,
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
        challenger_answer: Answer,
        joint_state: puzzle_multiparty_coin_v001.aleo/JointState,
        challenger_claim_signature: puzzle_multiparty_coin_v001.aleo/ClaimSignature,
    ) -> (
        Answer,
        puzzle_multiparty_coin_v001.aleo/JointWinner,
        GameFinishReqNotification,
        GameFinishReqNotification,
    )
    {
        // assert that the correct state updater address is the challenger and the challenger
        // is invoking this
        assert_eq(joint_state.state_updater_address, self.signer);

        // assert contracts can't call this
        assert_eq(self.caller, self.signer);

        // determine winner! If opponent correctly picked where the challenger hid alex, the opponent wins otherwise the challenger wins
        let winner_address: address = reveal_answer_notification_record.opponent_answer == challenger_answer.answer ? challenger_answer.opponent_address : challenger_answer.challenger_address;
        let loser_address: address = winner_address == challenger_answer.challenger_address ? challenger_answer.opponent_address : challenger_answer.challenger_address;
        // let challenger_sig: signature = challenger_claim_signature.sig;

        // retrieve revealedanswer record
        // let (revealed_answer_record): multiparty_pvp_utils_v015.aleo/Answer = multiparty_pvp_utils_v015.aleo/reveal_answer(challenger_answer_record);
        let revealed_answer: Answer = Answer {
            owner: challenger_answer.game_multisig,
            challenger_address: challenger_answer.challenger_address,
            opponent_address: challenger_answer.opponent_address,
            game_multisig: challenger_answer.game_multisig,
            amount: challenger_answer.amount,
            nonce: challenger_answer.nonce,
            answer: challenger_answer.answer,
        };

        let (joint_winner): puzzle_multiparty_coin_v001.aleo/JointWinner = puzzle_multiparty_coin_v001.aleo/joint_stake_state_update(joint_state, challenger_claim_signature, winner_address);

        let game_finish_req_notification_record_opponent: GameFinishReqNotification = GameFinishReqNotification {
            owner: challenger_answer.opponent_address,
            game_multisig: challenger_answer.game_multisig,
            game_state: 4u8,
            your_turn: true,
            total_pot: joint_state.amount,
            // challenger_address: challenger_answer_record.challenger_address,
            // opponent_address: challenger_answer_record.opponent_address,
            challenger_answer: challenger_answer.answer,
            opponent_answer: reveal_answer_notification_record.opponent_answer,
            // winner: winner_address,
            // loser: loser_address,
        };

        let game_finish_req_notification_record_challenger: GameFinishReqNotification = GameFinishReqNotification{
            owner: challenger_answer.challenger_address,
            game_multisig: challenger_answer.game_multisig,
            game_state: 4u8,
            your_turn: true,
            total_pot: joint_state.amount,
            // challenger_address: challenger_answer_record.challenger_address,
            // opponent_address: challenger_answer_record.opponent_address,
            challenger_answer: challenger_answer.answer,
            opponent_answer: reveal_answer_notification_record.opponent_answer,
            // winner: winner_address,
            // loser: loser_address,
        };

        return (revealed_answer, joint_winner, game_finish_req_notification_record_opponent, game_finish_req_notification_record_challenger);
    }

    // called by ms key to finish the game and get the total pot!
    transition finish_game
    (
        game_record: Game,
        joint_winner: puzzle_multiparty_coin_v001.aleo/JointWinner,
        joint_stake: puzzle_multiparty_coin_v001.aleo/JointStake,
        joint_timeout_claim: puzzle_multiparty_coin_v001.aleo/JointTimeoutClaim,
    ) -> (
        puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin,
        Game,
        GameFinishedNotification,
        GameFinishedNotification)
    {
        // assert that the game address/multiisg is calling this
        assert_eq(game_record.owner, self.signer);

        // assert contracts can't call this
        assert_eq(self.caller, self.signer);

        let loser_address: address = joint_winner.winner == game_record.challenger_address ? game_record.opponent_address : game_record.challenger_address;

        let (piece_record): puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin = puzzle_multiparty_coin_v001.aleo/joint_stake_transfer_to_winner(
            joint_winner,
            joint_stake,
            joint_timeout_claim,
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
    //     piece_joint_stake: puzzle_multiparty_coin_v001.aleo/JointStake,
    //     joint_piece_time_claim: puzzle_multiparty_coin_v001.aleo/JointTimeoutClaim,
    //     sig: signature, // use from ClaimSignature record on FE, can't consume in this fxn bc claim is owned by multisig
    // ) -> (
    //     puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin,
    //     // puzzle_multiparty_coin_v001.aleo/AuditTransferToWinner,
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
    //     let (piece_record_winner): puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin = puzzle_multiparty_coin_v001.aleo/joint_timeout_to_opponent(piece_joint_stake, joint_piece_time_claim, sig);

    //     return (
    //         piece_record_winner,
    //         // audit_transfer_to_winner_record,
    //         updated_game_record,
    //         game_finished_notification_challenger_record,
    //         game_finished_notification_opponent_record
    //     );
    // }

}
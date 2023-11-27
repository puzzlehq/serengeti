import puzzle_pieces_v011.leo;
import multiparty_pvp_utils_v011.leo;

// todo: wait we're going to use alice's credits to send to multisig? need to add credits.leo but not supported yet per https://github.com/AleoHQ/leo/pull/2881
// imports deployed to separate address: https://t.me/c/1766615939/3581

// todo: the primary issue is that we need to consume owner rules inside of puzzle transfers but we can't do that?
// todo: actually does this matter, there is only 1 owner rules record floating?
// todo: can we consume it inside of this program?
// todo: since if we do not consume it inside the transfer then someone could rug?
// todo: also when transferring to winner will need to transfer both records
// todo: can we do this with inline functions?

// The 'coinflip' program.
program wheres_alex_v011.aleo {

    // todo: this will likely need to store each player answer
    // todo: may be best to store players in the game here on game record
    // todo: add block height to game record?
    record Game {
        owner: address,
        challenger_commit: field,
        opponent_answer: field,
        total_pot: u64,
        challenger_address: address,
        opponent_address: address,
        game_multisig: address,
        game_state: field,
        // private game_state: field,
        // 1 -> proposed game
        // 2 -> accepted game
        // 3 -> finished game
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
        game_state: field,
        your_turn: bool,
        total_pot: u64,
        challenger_address: address,
        opponent_address: address,
    }

    // sent to challenger on propose game for FE/client detection.
    // consumed in reveal answer
    record WaitingAcceptanceNotification {
        owner: address, //opponent
        game_multisig: address,
        game_state: field,
        your_turn: bool,
        total_pot: u64,
        challenger_address: address,
        opponent_address: address,
    }

    record StakeRenegedNotification {
        owner: address, //opponent
        game_multisig: address,
        game_state: field,
        your_turn: bool,
        total_pot: u64,
        challenger_address: address,
        opponent_address: address,
        renege_address: address,
    }

    // sent to challenger on submit wager for FE/client detection.
    // consumed in reveal answer
    record ChallengerWagerNotification {
        owner: address, //opponent
        game_multisig: address,
        game_state: field,
        your_turn: bool,
        total_pot: u64,
        challenger_address: address,
        opponent_address: address,
    }

    record OpponentWagerNotification {
        owner: address, //opponent
        game_multisig: address,
        game_state: field,
        your_turn: bool,
        total_pot: u64,
        challenger_address: address,
        opponent_address: address,
    }

    // sent to opponent on accept game for FE/client detection.
    // consumed in finish_game/claim total pot
    record WaitingRevealNotification {
        owner: address, //opponent
        game_multisig: address,
        game_state: field,
        your_turn: bool,
        total_pot: u64,
        challenger_address: address,
        opponent_address: address,
    }

    // sent to challenger on accept game for FE/client detection.
    // consumed in reveal answer
    record RevealAnswerNotification {
        owner: address, //opponent
        game_multisig: address,
        game_state: field,
        your_turn: bool,
        total_pot: u64,
        challenger_address: address,
        opponent_address: address,
        opponent_answer: field,
    }

    // sent to opponent on reveal answer for FE/client detection.
    record GameFinishReqNotification {
        owner: address, //opponent
        game_multisig: address,
        game_state: field,
        your_turn: bool,
        total_pot: u64,
        challenger_address: address,
        opponent_address: address,
    }

    // sent to both opponent and challenger on finish game
    record GameFinishedNotification {
        owner: address,
        game_multisig: address,
        game_state: field,
        your_turn: bool,
        total_pot: u64,
        challenger_address: address,
        opponent_address: address,
        winner: address,
        loser: address,
    }

    // New propose game
    transition propose_game (
        //puzzle_pieces.stake_transfer_in() data
        wager_record: puzzle_pieces_v011.leo/Piece.record,
        amount: u64,
        sender: address, // Challenger address proposing game
        challenger: address,
        opponent: address,
        game_multisig: address,
        message_1: field, //from output of useSignature
        message_2: field,
        message_3: field,
        message_4: field,
        message_5: field,
        sig: signature, //from output of useSignature
        //multiparty_pvp_utils data
        nonce: field,
        answer: field,
        seed: field, //game_multisig seed to send to user
        //wheres_alex data
    ) -> (
        puzzle_pieces_v011.leo/PieceClaim.record,
        puzzle_pieces_v011.leo/PieceStake.record,
        puzzle_pieces_v011.leo/ClaimSignature.record,
        puzzle_pieces_v011.leo/Piece.record,
        puzzle_pieces_v011.leo/AuditStakeIn.record,
        multiparty_pvp_utils_v011.leo/Answer.record,
        multiparty_pvp_utils_v011.leo/AuditMintAnswer.record,
        multiparty_pvp_utils_v011.leo/Key.record,
        multiparty_pvp_utils_v011.leo/AuditKey.record,
        Game,
        GameReqNotification,
        WaitingAcceptanceNotification,
    ) {

        // assert contracts can't call this
        assert_eq(self.caller, self.signer);

        // random edge case, maybe unnecessary
        assert_neq(game_multisig, opponent);

        // assert that player 1s answer is either "in weeds" or "behind building"
        assert(answer == 0field || answer == 1field);
        // hash the answer and nonce
        let challenger_commit: field = BHP256::commit_to_field(answer, nonce as scalar);

        // assert that the wager amount > 0 and wager inside credit == wager amt passed
        assert(amount > 0u64);
        // assert that the wager record has >= amount wagered
        assert(wager_record.amount >= amount);

        let (
            piece_claim,
            piece_stake,
            claim_signature,
            piece,
            audit_stake_in_record
        ): (
            PieceClaim,
            PieceStake,
            ClaimSignature,
            Piece,
            AuditStakeIn
        ) = puzzle_pieces_v011.leo/stake_transfer_in(
            wager_record,
            sender,
            challenger,
            opponent,
            game_multisig,
            amount,
            message_1,
            message_2,
            message_3,
            message_4,
            message_5,
            sig
        );

        let (
            key_record,
            audit_key_record
        ) : (
            Key,
            AuditKey
        ) = multiparty_pvp_utils_v011.leo/mint_multisig_key(seed,amount,challenger,opponent,game_multisig);

        let game_request_notification_record: GameReqNotification = GameReqNotification {
            owner: opponent, //opponent
            game_multisig: game_multisig,
            game_state: 1field,
            your_turn: true,
            total_pot: amount + amount,
            challenger_address: challenger,
            opponent_address: opponent,
        };

        let game_waiting_acceptance_notification_record: WaitingAcceptanceNotification = WaitingAcceptanceNotification {
            owner: challenger, //challenger
            game_multisig: game_multisig,
            game_state: 1field,
            your_turn: false,
            total_pot: amount + amount,
            challenger_address: challenger,
            opponent_address: opponent,
        };

        let game_record: Game = Game {
            owner: game_multisig,
            challenger_commit: challenger_commit,
            opponent_answer: answer,
            total_pot: amount + amount,
            challenger_address: challenger,
            opponent_address: opponent,
            game_multisig: game_multisig,
            game_state: 1field,
        };

        let (answer_record, audit_mint_answer_record):  (Answer, AuditMintAnswer) = multiparty_pvp_utils_v011.leo/mint_answer(
                challenger,
                opponent,
                game_multisig,
                amount,
                nonce,
                answer,
                message_1,
                message_2,
                message_3,
                message_4,
                message_5,
                sig
        );


        return (
            piece_claim,
            piece_stake,
            claim_signature,
            piece,
            audit_stake_in_record,
            answer_record,
            audit_mint_answer_record,
            key_record,
            audit_key_record,
            game_record,
            game_request_notification_record,
            game_waiting_acceptance_notification_record,
        );
    }

    // challenger calls this function with Multisig key and signature as input
    // that was submitted when proposing game and that exists on claim record
    transition challenger_renege_stake
    (
        waiting_accept_game_notification: WaitingAcceptanceNotification,
        piece_stake: puzzle_pieces_v011.leo/PieceStake.record,
        piece_claim: puzzle_pieces_v011.leo/PieceClaim.record,
        sig: signature,
    ) -> (
        puzzle_pieces_v011.leo/Piece.record,
        puzzle_pieces_v011.leo/AuditStakeOut.record,
        StakeRenegedNotification,
        StakeRenegedNotification,
        )
    {
        // assert contracts can't call this
        assert_eq(self.caller, self.signer);

        let (piece_record, audit_stake_out_record): (Piece, AuditStakeOut) = puzzle_pieces_v011.leo/stake_transfer_out(piece_stake, piece_claim, sig);

        let notify_challenger_stake_reneged: StakeRenegedNotification = StakeRenegedNotification {
            owner: waiting_accept_game_notification.challenger_address, //opponent
            game_multisig: waiting_accept_game_notification.game_multisig,
            game_state: 0field,
            your_turn: false,
            total_pot: waiting_accept_game_notification.total_pot,
            challenger_address: waiting_accept_game_notification.challenger_address,
            opponent_address: waiting_accept_game_notification.opponent_address,
            renege_address: waiting_accept_game_notification.challenger_address,
        };


        let notify_opponent_stake_reneged: StakeRenegedNotification = StakeRenegedNotification {
            owner: waiting_accept_game_notification.opponent_address, //opponent
            game_multisig: waiting_accept_game_notification.game_multisig,
            game_state: 0field,
            your_turn: false,
            total_pot: waiting_accept_game_notification.total_pot,
            challenger_address: waiting_accept_game_notification.challenger_address,
            opponent_address: waiting_accept_game_notification.opponent_address,
            renege_address: waiting_accept_game_notification.challenger_address,
        };

        return (piece_record, audit_stake_out_record, notify_challenger_stake_reneged, notify_opponent_stake_reneged);

    }

    // todo: implement renege for challenger


    transition submit_wager (
        wager_record: puzzle_pieces_v011.leo/Piece.record,
        key_record: multiparty_pvp_utils_v011.leo/Key.record,
        game_req_notification: GameReqNotification,
        message_1: field, //from output of useSignature
        message_2: field,
        message_3: field,
        message_4: field,
        message_5: field,
        sig: signature, //from output of useSignature
    ) -> (
        puzzle_pieces_v011.leo/PieceClaim.record,
        puzzle_pieces_v011.leo/PieceStake.record,
        puzzle_pieces_v011.leo/ClaimSignature.record,
        puzzle_pieces_v011.leo/Piece.record,
        puzzle_pieces_v011.leo/AuditStakeIn.record,
        ChallengerWagerNotification,
        OpponentWagerNotification,
    )
    {

        // Logic Checks
        // limit calls to only users
        assert_eq(self.caller, self.signer);

        // assert that the wager amount > 0 and wager inside credit == wager amt passed
        assert(wager_record.amount > 0u64);
        // assert that the wager record has >= total pot / 2u64
        assert(wager_record.amount >= game_req_notification.total_pot / 2u64);

        let (
            piece_claim,
            piece_stake,
            claim_signature,
            piece,
            audit_stake_in_record,
        ): (
            PieceClaim,
            PieceStake,
            ClaimSignature,
            Piece,
            AuditStakeIn
        ) = puzzle_pieces_v011.leo/stake_transfer_in(
            wager_record,
            game_req_notification.opponent_address, // sender
            game_req_notification.challenger_address, // challenger
            game_req_notification.opponent_address,
            game_req_notification.game_multisig,
            game_req_notification.total_pot / 2u64, // divide total pot by 2
            message_1,
            message_2,
            message_3,
            message_4,
            message_5,
            sig,
        );

        let challenger_submitted_wager_notification_record: ChallengerWagerNotification = ChallengerWagerNotification {
            owner: game_req_notification.challenger_address,
            game_multisig: game_req_notification.game_multisig,
            game_state: 2field,
            your_turn: false,
            total_pot: game_req_notification.total_pot,
            challenger_address: game_req_notification.challenger_address,
            opponent_address: game_req_notification.opponent_address,

        };

        let opponent_submitted_wager_notification_record: OpponentWagerNotification = OpponentWagerNotification {
            owner: game_req_notification.opponent_address,
            game_multisig: game_req_notification.game_multisig,
            game_state: 2field,
            your_turn: true,
            total_pot: game_req_notification.total_pot,
            challenger_address: game_req_notification.challenger_address,
            opponent_address: game_req_notification.opponent_address,
        };

        return (
            piece_claim,
            piece_stake,
            claim_signature,
            piece,
            audit_stake_in_record,
            challenger_submitted_wager_notification_record,
            opponent_submitted_wager_notification_record,
        );
    }
    // todo: implement renege for opponent

    // called by ms key after wager is confirmed on network
    transition accept_game
    (
        game_record: Game,
        opponent_answer: field,
        piece_stake_challenger: puzzle_pieces_v011.leo/PieceStake.record,
        piece_claim_challenger: puzzle_pieces_v011.leo/PieceClaim.record,
        piece_stake_opponent: puzzle_pieces_v011.leo/PieceStake.record,
        piece_claim_opponent: puzzle_pieces_v011.leo/PieceClaim.record,
        block_ht: u32,
    ) -> (
        puzzle_pieces_v011.leo/PieceJointStake.record,
        puzzle_pieces_v011.leo/JointPieceTimeClaim.record,
        puzzle_pieces_v011.leo/JointPieceState.record,
        puzzle_pieces_v011.leo/AuditJointStake.record,
        WaitingRevealNotification,
        RevealAnswerNotification,
        Game,
    )
    {

        // assert that the game address/multiisg is calling this
        assert_eq(game_record.owner, self.signer);

        // assert contracts can't call this
        assert_eq(self.caller, self.signer);

        let (
            piece_joint_stake,
            joint_piece_time_claim,
            joint_piece_state,
            audit_joint_stake
        ): (
            PieceJointStake,
            JointPieceTimeClaim,
            JointPieceState,
            AuditJointStake
        ) = puzzle_pieces_v011.leo/transfer_stakes_to_joint(
            piece_stake_challenger,
            piece_claim_challenger,
            piece_stake_opponent,
            piece_claim_opponent,
            block_ht,
        );

        // sent to opponent on accept_game
        // todo: how will user know they can claim if challenger never reveals answer?
        let waiting_reveal_answer_notifcation_record: WaitingRevealNotification = WaitingRevealNotification {
            owner: game_record.opponent_address,
            game_multisig: game_record.owner,
            game_state: 3field,
            your_turn: false,
            total_pot: game_record.total_pot,
            challenger_address: game_record.challenger_address,
            opponent_address: game_record.opponent_address,
        };

        // sent to challenger on accept_game
        let reveal_answer_notification_record: RevealAnswerNotification = RevealAnswerNotification {
            owner: game_record.challenger_address,
            game_multisig: game_record.owner,
            game_state: 3field,
            your_turn: true,
            total_pot: game_record.total_pot,
            challenger_address: game_record.challenger_address,
            opponent_address: game_record.opponent_address,
            opponent_answer: opponent_answer,
        };

        let updated_game_record: Game = Game {
            owner: game_record.owner,
            challenger_commit: game_record.challenger_commit,
            opponent_answer: game_record.opponent_answer,
            total_pot: game_record.total_pot,
            challenger_address: game_record.challenger_address,
            opponent_address: game_record.opponent_address,
            game_multisig: game_record.game_multisig,
            game_state: 2field,
        };

        return (
            piece_joint_stake,
            joint_piece_time_claim,
            joint_piece_state,
            audit_joint_stake,
            waiting_reveal_answer_notifcation_record,
            reveal_answer_notification_record,
            updated_game_record,
        ) then finalize (block_ht);
    }


    finalize accept_game
    (
        block_ht: u32,
    )
    {
        // block every 5 seconds or so
        // would need to wait for time between `accept_game` req. from client to being proved
        // ~ 5s per block
        // leeway of 100 blocks = 100 * 5 = 500 / 60 = ~8.33 mins.
        // assert that block_ht passed in is within 100 blocks of current block ht.
        //
        // Check legit block height as input
        let current_block_ht: u32 = block.height;
        assert(block_ht >= current_block_ht - 100u32);
        assert(block_ht <= current_block_ht + 100u32);
    }

    // called by challenger to reveal answer record
    transition reveal_answer_game
    (
        reveal_answer_notification_record: RevealAnswerNotification,
        answer_record: multiparty_pvp_utils_v011.leo/Answer.record,
        joint_piece_state: puzzle_pieces_v011.leo/JointPieceState.record,
        claim_signature: puzzle_pieces_v011.leo/ClaimSignature.record,
        // sig: signature // using claimSignature record from beginning for this
    ) -> (
        multiparty_pvp_utils_v011.leo/RevealAnswer.record,
        multiparty_pvp_utils_v011.leo/AuditRevealAnswer.record,
        puzzle_pieces_v011.leo/JointPieceWinner.record,
        puzzle_pieces_v011.leo/AuditJointPieceWinner.record,
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
        let winner_address: address = reveal_answer_notification_record.opponent_answer == answer_record.answer ? answer_record.opponent_address : answer_record.challenger_address;
        let sig: signature = claim_signature.sig;

        // retrieve revealedanswer record
        let (revealed_answer_record, audit_revealed_answer_record): (RevealAnswer, AuditRevealAnswer) = multiparty_pvp_utils_v011.leo/reveal_answer(answer_record, sig);

        let (joint_piece_winner, audit_joint_piece_winner): (JointPieceWinner, AuditJointPieceWinner) = puzzle_pieces_v011.leo/joint_stake_state_update(joint_piece_state, claim_signature, winner_address);

        let game_finish_req_notification_record_opponent: GameFinishReqNotification = GameFinishReqNotification {
            owner: answer_record.opponent_address,
            game_multisig: answer_record.game_address,
            game_state: 4field,
            your_turn: true,
            total_pot: joint_piece_state.amount,
            challenger_address: answer_record.challenger_address,
            opponent_address: answer_record.opponent_address,
        };

        let game_finish_req_notification_record_challenger: GameFinishReqNotification = GameFinishReqNotification{
            owner: answer_record.challenger_address,
            game_multisig: answer_record.game_address,
            game_state: 4field,
            your_turn: true,
            total_pot: joint_piece_state.amount,
            challenger_address: answer_record.challenger_address,
            opponent_address: answer_record.opponent_address,
        };

        return (revealed_answer_record, audit_revealed_answer_record, joint_piece_winner, audit_joint_piece_winner, game_finish_req_notification_record_opponent, game_finish_req_notification_record_challenger);
    }

    // called by ms key to finish the game and get the total pot!
    transition finish_game
    (
        game_record: Game,
        joint_piece_winner: puzzle_pieces_v011.leo/JointPieceWinner.record,
        piece_joint_stake: puzzle_pieces_v011.leo/PieceJointStake.record,
        joint_piece_time_claim: puzzle_pieces_v011.leo/JointPieceTimeClaim.record,
    ) -> (
        puzzle_pieces_v011.leo/Piece.record,
        puzzle_pieces_v011.leo/AuditTransferToWinner.record,
        puzzle_pieces_v011.leo/AuditPieceOwner.record,
        Game,
        GameFinishedNotification,
        GameFinishedNotification)
    {

        // assert that the game address/multiisg is calling this
        assert_eq(game_record.owner, self.signer);

        // assert contracts can't call this
        assert_eq(self.caller, self.signer);

        let loser_address: address = joint_piece_winner.winner == game_record.challenger_address ? game_record.opponent_address : game_record.challenger_address;

        let (piece_record, audit_transfer_to_winner_record, audit_piece_owner): (Piece, AuditTransferToWinner, AuditPieceOwner) = puzzle_pieces_v011.leo/joint_stake_transfer_to_winner(
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
            game_state: 3field
        };

        let game_finished_notification_challenger_record: GameFinishedNotification = GameFinishedNotification {
            owner: game_record.challenger_address,
            game_multisig: game_record.game_multisig,
            game_state: 5field,
            your_turn: false,
            total_pot: game_record.total_pot,
            challenger_address: game_record.challenger_address,
            opponent_address: game_record.opponent_address,
            winner: joint_piece_winner.winner,
            loser: loser_address,
        };

        let game_finished_notification_opponent_record: GameFinishedNotification = GameFinishedNotification {
            owner: game_record.opponent_address,
            game_multisig: game_record.game_multisig,
            game_state: 5field,
            your_turn: false,
            total_pot: game_record.total_pot,
            challenger_address: game_record.challenger_address,
            opponent_address: game_record.opponent_address,
            winner: joint_piece_winner.winner,
            loser: loser_address,
        };

        return (piece_record, audit_transfer_to_winner_record, audit_piece_owner, updated_game_record, game_finished_notification_challenger_record, game_finished_notification_opponent_record);
    }

    // called by ms key via opponent to finish the game and get the total pot!
    transition finish_game_by_timeout(
        game_record: Game,
        piece_joint_stake: puzzle_pieces_v011.leo/PieceJointStake.record,
        joint_piece_time_claim: puzzle_pieces_v011.leo/JointPieceTimeClaim.record,
        sig: signature, // use from ClaimSignature record on FE, can't consume in this fxn bc claim is owned by multisig
    ) -> (
        puzzle_pieces_v011.leo/Piece.record,
        puzzle_pieces_v011.leo/AuditTransferToWinner.record,
        Game,
        GameFinishedNotification,
        GameFinishedNotification)
    {
        // assert that the game address/multiisg is calling this
        assert_eq(game_record.owner, self.signer);

        // assert contracts can't call this
        assert_eq(self.caller, self.signer);

        // Update the game state
        let updated_game_record: Game = Game {
            owner: game_record.owner,
            challenger_commit: game_record.challenger_commit,
            opponent_answer: game_record.opponent_answer,
            total_pot: game_record.total_pot,
            challenger_address: game_record.challenger_address,
            opponent_address: game_record.opponent_address,
            game_multisig: game_record.game_multisig,
            game_state: 3field
        };

        // Notification to challenger of game finished
        let game_finished_notification_challenger_record: GameFinishedNotification = GameFinishedNotification {
            owner: game_record.challenger_address,
            game_multisig: game_record.game_multisig,
            game_state: 6field,
            your_turn: false,
            total_pot: game_record.total_pot,
            challenger_address: game_record.challenger_address,
            opponent_address: game_record.opponent_address,
            winner: game_record.opponent_address,
            loser: game_record.challenger_address,
        };

        // Notification to opponent of game finished
        let game_finished_notification_opponent_record: GameFinishedNotification = GameFinishedNotification {
            owner: game_record.opponent_address,
            game_multisig: game_record.game_multisig,
            game_state: 6field,
            your_turn: false,
            total_pot: game_record.total_pot,
            challenger_address: game_record.challenger_address,
            opponent_address: game_record.opponent_address,
            winner: game_record.opponent_address,
            loser: game_record.challenger_address,
        };

        // Payout to winner
        let (piece_record, audit_transfer_to_winner_record): (Piece, AuditTransferToWinner) = puzzle_pieces_v011.leo/joint_timeout_to_opponent(piece_joint_stake, joint_piece_time_claim, sig);

        return (
            piece_record,
            audit_transfer_to_winner_record,
            updated_game_record,
            game_finished_notification_challenger_record,
            game_finished_notification_opponent_record
        ) then finalize (joint_piece_time_claim.block_ht);
    }

    finalize finish_game_by_timeout (joint_time_claim_block_ht: u32) {
        // assert that 1000 blocks have passed (~ 83 minutes)
        let current_block_ht: u32 = block.height;
        let threshold_block_ht: u32 = joint_time_claim_block_ht + 1000u32;
        assert(current_block_ht > threshold_block_ht);
    }
}
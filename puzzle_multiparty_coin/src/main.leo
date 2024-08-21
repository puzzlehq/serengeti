import puzzle_arcade_coin_v001.aleo;

program puzzle_multiparty_coin_v001.aleo {
    struct Message {
        field_1: field,
        field_2: field,
        field_3: field,
        field_4: field,
        field_5: field,
    }

    // owned by multisig
    record Stake {
        owner: address,
        amount: u64,
        challenger: address,
        opponent: address,
        staker: address,
    }

    // owned by multisig
    record StakeClaim {
        owner: address,
        amount: u64,
        claimer: address,
        message_1: field,
        message_2: field,
        message_3: field,
        message_4: field,
        message_5: field,
        challenger: address,
        opponent: address,
    }

    // owned by individual
    record ClaimSignature {
        owner: address,
        sig: signature,
        amount: u64,
        game_multisig: address,
        challenger: address,
        opponent: address,
    }

    // owned by multsig
    record JointTimeoutClaim {
        owner: address,
        amount: u64,
        time_claimer_address: address,
        state_updater_address: address,
        message_1: field,
        message_2: field,
        message_3: field,
        message_4: field,
        message_5: field,
        game_multisig: address,
        challenger: address,
        opponent: address,
        block_ht: u32,
    }

    // owned by multisig
    record JointStake {
        owner: address,
        amount: u64,
        time_claimer_address: address,
        state_updater_address: address,
        block_ht: u32,
    }

    // For block height — user can set it but can’t pull it onchain to check until a finalize
    // So a multisig Alice may want to penalize Bob and take bob’s stake if he inputs the wrong on
    // - We should track who updates this multisig state to who sets block height to be able to penalize
    // something like adding input (address, sig) where address is individual key with signature set to something
    // and set JointPieceCreator: address (challenger or opponent) ---> question about what is field vulnerabilities for msg

    // owned by challenger only
    record JointState {
        owner: address,
        amount: u64,
        time_claimer_address: address,
        state_updater_address: address,
        message_1: field,
        message_2: field,
        message_3: field,
        message_4: field,
        message_5: field,
        challenger: address,
        opponent: address,
        game_multisig: address,
    }

    // owned by multisig
    record JointWinner {
        owner: address,
        amount: u64,
        time_claimer_address: address,
        state_updater_address: address,
        challenger: address,
        opponent: address,
        game_multisig: address,
        winner: address,
    }

    // output on transfer_joint_stake_to_winner -- use auditTransferToWinner to solve tracking games & winners -- use this data pipe for easier tracking notes
    record AuditPieceOwner {
        owner: address,
        piece_holder: address,
        amount: u64,
    }

    // transferring pieces into multisig for a 1v1 game between a challenger and an opponent
    // challenger and opponent both transfer pieces to the multisig and multisig gets two PieceStake
    // on accept_game, the two PieceStakes are merged into a JointStake
    // once challenger reveals answer, JointStake is converted to full amount of pieces & sent to winner
    //
    // Exit states exist such that:
    //   - challenger or opponent can retrieve their respective stake before locked in joint-stake
    //   - if challenger never reveals answer, after time T then joint-stake is awarded to opponent (ie an auto win)
    //
    // called by each individual key
    transition stake_transfer_in (
        coin: puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin,
        amount: u64,
        challenger: address,
        opponent: address,
        game_multisig: address,
        message_1: field,
        message_2: field,
        message_3: field,
        message_4: field,
        message_5: field,
        sig: signature
    ) -> (StakeClaim, Stake, ClaimSignature, puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin) {
        let stake_claim_receipt: StakeClaim = StakeClaim {
            owner: game_multisig,
            amount: amount,
            claimer: self.signer,
            message_1: message_1,
            message_2: message_2,
            message_3: message_3,
            message_4: message_4,
            message_5: message_5,
            challenger: challenger,
            opponent: opponent,
        };

        let stake: Stake = Stake {
            owner: game_multisig,
            amount: amount,
            challenger: challenger,
            opponent: opponent,
            staker: self.signer,
        };

        // claim signature to depositor -- signature against message and used to redeem
        let sender_claim_sig_record: ClaimSignature = ClaimSignature {
            owner: self.signer,
            sig: sig,
            amount: amount,
            game_multisig: game_multisig,
            challenger: challenger,
            opponent: opponent,
        };

        let change: puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin = puzzle_arcade_coin_v001.aleo/spend(
          coin, amount
        );

        return (stake_claim_receipt, stake, sender_claim_sig_record, change);
    }

    // Unstaking PieceStake from Multisig to Staker
    // Staker key signs message on Claim Record then
    // calls this function with Multisig key and signature as input
    //
    // stake amount returned is equal to amount in claim and returned to staking key
    transition stake_transfer_out (
        stake: Stake,
        piece_claim: StakeClaim,
        sig: signature
    ) -> (puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin) {
        // 1. Check Claim & Stake are from same game_multisig
        // assert_eq(piece_stake.owner, piece_claim.owner);

        // 2. Check Claim & Stake have the same game details
        // assert_eq(piece_stake.challenger,piece_claim.challenger);
        // assert_eq(piece_stake.opponent,piece_claim.opponent);
        // assert_eq(piece_stake.amount,piece_claim.amount);

        // 3. Check Claimer has verified this with a fresh signature against the message
        let msg: Message = Message {
            field_1: piece_claim.message_1,
            field_2: piece_claim.message_2,
            field_3: piece_claim.message_3,
            field_4: piece_claim.message_4,
            field_5: piece_claim.message_5
        };

        assert(sig.verify(piece_claim.claimer, msg));

        let piece_oot: puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin = puzzle_arcade_coin_v001.aleo/mint (
            piece_claim.claimer,
            piece_claim.amount,
        );

        return (piece_oot);
    }

    // Jointly staking both pieces to the Multisig
    // calls this function with the Multisig key
    // JointStake note amount is the combination of the two
    transition join_stakes(
        stake_challenger: Stake,
        claim_challenger: StakeClaim,
        stake_opponent: Stake,
        claim_opponent: StakeClaim,
        block_ht: u32 // good actor uses our api endpoint on FE to get blockheight and use as inputs
    ) -> (JointStake, JointTimeoutClaim, JointState) {
        let multisig: address = stake_challenger.owner;

        // 2. Check that the game state is the same for all
        let amount: u64 = stake_challenger.amount;
        // assert_eq(piece_claim_challenger.amount,amount);
        // assert_eq(piece_stake_opponent.amount,amount);
        // assert_eq(piece_claim_opponent.amount,amount);

        let challenger: address = stake_challenger.challenger;
        // assert_eq(piece_claim_challenger.challenger,challenger);
        // assert_eq(piece_stake_opponent.challenger,challenger);
        // assert_eq(piece_claim_opponent.challenger,challenger);

        let opponent: address = stake_challenger.opponent;
        // assert_eq(piece_claim_challenger.opponent,opponent);
        // assert_eq(piece_stake_opponent.opponent,opponent);
        // assert_eq(piece_claim_opponent.opponent,opponent);

        // 3. Check that claimer addresses match stake address
        // assert_eq(piece_claim_challenger.claimer, piece_stake_challenger.challenger);
        // assert_eq(piece_claim_opponent.claimer, piece_stake_opponent.opponent);

        // Create JointStake and send to multisig key
        let joint_stake: JointStake = JointStake {
            owner: multisig,
            amount: amount + amount,
            time_claimer_address: opponent,
            state_updater_address: challenger,
            block_ht: block_ht,
        };

        // Create JointState such that challenger can update state and send to
        let joint_state: JointState = JointState {
            owner: challenger,
            amount: amount + amount,
            time_claimer_address: opponent,
            state_updater_address: challenger,
            message_1: claim_challenger.message_1,
            message_2: claim_challenger.message_2,
            message_3: claim_challenger.message_3,
            message_4: claim_challenger.message_4,
            message_5: claim_challenger.message_5,
            challenger: challenger,
            opponent: opponent,
            game_multisig: multisig,
        };

        // Create JointTimeoutClaim -- note current block production is ~ 1 block/5 sec --> 12 blocks/min
        let joint_time_claim: JointTimeoutClaim = JointTimeoutClaim {
            owner: multisig,
            amount: amount + amount,
            time_claimer_address: opponent,
            state_updater_address: challenger,
            message_1: claim_opponent.message_1,
            message_2: claim_opponent.message_2,
            message_3: claim_opponent.message_3,
            message_4: claim_opponent.message_4,
            message_5: claim_opponent.message_5,
            game_multisig: multisig,
            challenger: challenger,
            opponent: opponent,
            block_ht: block_ht,
        };

        return (joint_stake, joint_time_claim, joint_state);
    }

    // Challenger calls this function with the challenger key
    // revealing answer and creating record with winner on it
    // Sends winner record to multisig to use to finish game
    //
    // This call is nested inside Reveal Answer in where's alex game
    //
    // Burns their claim signature record here
    transition joint_stake_state_update(
        joint_state: JointState,
        claim_signature: ClaimSignature,
        winner: address
    ) -> (JointWinner) {
        // 0. Check that owner matches
        // assert_eq(joint_piece_state.owner, sig.owner);

        // 1. Check that owner is the one allowed to udpate state
        // assert_eq(joint_piece_state.state_updater_address, sig.owner);
        // assert_eq(joint_piece_state.state_updater_address, sig.challenger);

        // 2. Check the rest of the details of the game
        // assert_eq(joint_piece_state.amount, sig.amount + sig.amount);
        // assert_eq(joint_piece_state.opponent,sig.opponent);
        // assert_eq(joint_piece_state.game_multisig,joint_piece_state.game_multisig);

        // 3. Check Claimer has verified this with a signature against the message from beginning
        let msg: Message = Message {
            field_1: joint_state.message_1,
            field_2: joint_state.message_2,
            field_3: joint_state.message_3,
            field_4: joint_state.message_4,
            field_5: joint_state.message_5
        };

        assert(claim_signature.sig.verify(joint_state.state_updater_address, msg));

        // The logic for the answer and computing winner is in wheres_alex program
        // The enforcement to prevent the challenger calling this function without going through
        // where's alex is via the puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin Keepers
        //
        // Logic is if a piece keeper sees that there is an address that is different from the answer record for the game,
        // then can submit to public mapping then person can not spend pieces again. Also lets you mint their amount
        // You also get a receipt to mint more pieces that you see their address has -- maybe?
        //
        // Just a simple check here to verify it's an opponent or challenger
        // check that sender is either challenger or opponent
        // if winner == joint_piece_state.challenger {
        //     assert_eq(winner,joint_piece_state.challenger);
        // } else {
        //     assert_eq(winner,joint_piece_state.opponent);
        // }

        let joint_winner: JointWinner = JointWinner {
            owner: joint_state.game_multisig,
            amount: joint_state.amount,
            time_claimer_address: joint_state.time_claimer_address,
            state_updater_address: joint_state.state_updater_address,
            challenger: joint_state.challenger,
            opponent: joint_state.opponent,
            game_multisig: joint_state.game_multisig,
            winner: winner,
        };

        return (joint_winner);
    }

    // Called with multisig key
    // Any multisig member calls this function to end the game and transfer the pieces
    transition joint_stake_transfer_to_winner(
        joint_piece_winner: JointWinner,
        piece_joint_stake: JointStake,
        joint_piece_time_claim: JointTimeoutClaim,
    ) -> (puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin) {
        // 0. Add a self.signer check against
        let game_multisig: address = joint_piece_winner.owner;
        // assert_eq(owner, self.signer);

        // 1. Check that all are from the same multisig
        // assert_eq(piece_joint_stake.owner, game_multisig);
        // assert_eq(joint_piece_time_claim.owner, game_multisig);

        // 2. Check that the game state is the same for all
        let amount: u64 = joint_piece_winner.amount;
        // assert_eq(piece_joint_stake.amount,amount);
        // assert_eq(joint_piece_time_claim.amount,amount);

        let challenger: address = joint_piece_winner.challenger;
        // assert_eq(piece_joint_stake.state_updater_address,challenger);
        // assert_eq(joint_piece_time_claim.challenger,challenger);

        let opponent: address = joint_piece_winner.opponent;
        // assert_eq(piece_joint_stake.time_claimer_address,opponent);
        // assert_eq(joint_piece_time_claim.opponent,opponent);

        // Check that winner is challenger or opponent
        let winner: address = joint_piece_winner.winner;
        if winner == piece_joint_stake.time_claimer_address {
            assert_eq(winner,piece_joint_stake.time_claimer_address);
        } else {
            assert_eq(winner,piece_joint_stake.state_updater_address);
        }

        let piece_to_winner: puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin = puzzle_arcade_coin_v001.aleo/mint (
            winner,
            amount,
        );

        return (piece_to_winner);
    }

    // The challenger has not updated joint piece state for a winner in time of blockheight
    // This is an auto-win for the opponent
    // The opponent then calls the below finish to win and convert stake to pieces via multisig key
    //
    // Assume signature used in this is done signature from ClaimSignature
    // we are going to be stranded with the ClaimSignature owned by the user's key
    //
    // If this is called -- we are going to be stranded with a ClaimSignature & JointState on the above
    //
    // called with the multisig key
    transition joint_timeout_to_opponent (
        joint_stake: JointStake,
        joint_timeout_claim: JointTimeoutClaim,
        sig: signature, // use from ClaimSignature record on FE, can't consume in this fxn bc claim is owned by multisig
    ) -> (puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin)
    {
        // 1. Check that all are from the same multisig
        let game_multisig: address = joint_timeout_claim.owner;
        assert_eq(joint_stake.owner, game_multisig);

        // 2. Check that the game state is the same for all
        let amount: u64 = joint_timeout_claim.amount;
        assert_eq(joint_stake.amount, amount);

        // 2. Check that the game state is the same for all
        let challenger: address = joint_timeout_claim.challenger;
        assert_eq(joint_stake.state_updater_address, challenger);

        let opponent: address = joint_timeout_claim.opponent;
        assert_eq(joint_stake.time_claimer_address, opponent);

        // 3. Check Claimer has verified this with a signature against the message from beginning
        // FE -- use the claim signature record for opponent address here to fill in
        let msg: Message = Message {
            field_1: joint_timeout_claim.message_1,
            field_2: joint_timeout_claim.message_2,
            field_3: joint_timeout_claim.message_3,
            field_4: joint_timeout_claim.message_4,
            field_5: joint_timeout_claim.message_5
        };

        assert(sig.verify(joint_timeout_claim.time_claimer_address, msg));

        let piece_to_winner: puzzle_arcade_coin_v001.aleo/PuzzleArcadeCoin = puzzle_arcade_coin_v001.aleo/mint (
            opponent,
            amount,
        );

        return (piece_to_winner);
    }
}
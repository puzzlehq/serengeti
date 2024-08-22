import puzzle_arcade_coin_v002.aleo;

// transferring pieces into multisig for a 1v1 game between a challenger and an opponent
// challenger and opponent both transfer pieces to the multisig and multisig gets two PieceStake
// on accept_game, the two PieceStakes are merged into a JointStake
// once challenger reveals answer, JointStake is converted to full amount of pieces & sent to winner
//
// Exit states exist such that:
//   - challenger or opponent can retrieve their respective stake before locked in joint-stake
//   - if challenger never reveals answer, after time T then joint-stake is awarded to opponent (ie an auto win)

program puzzle_multiparty_coin_v001.aleo {
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
    }

    // owned by multsig
    record JointTimeoutClaim {
        owner: address,
        amount: u64,
        challenger: address,
        opponent: address,
        block_height: u32,
    }

    // owned by multisig
    record JointStake {
        owner: address,
        amount: u64,
        block_height: u32,
    }

    // owned by challenger only
    record JointState {
        owner: address,
        amount: u64,
        opponent: address,
        game_multisig: address,
    }

    // owned by multisig
    record JointWinner {
        owner: address,
        amount: u64,
        challenger: address,
        opponent: address,
        winner: address,
    }

    // called by both challenger and opponent
    transition stake_transfer_in (
        coin: puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin, // burned
        amount: u64,
        challenger: address,
        opponent: address,
        game_multisig: address
    ) -> (StakeClaim, Stake, puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin) {
        let stake_claim: StakeClaim = StakeClaim {
            owner: game_multisig,
            amount: amount,
            claimer: self.signer
        };

        let stake: Stake = Stake {
            owner: game_multisig,
            amount: amount,
            challenger: challenger,
            opponent: opponent,
            staker: self.signer,
        };

        let change: puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin = puzzle_arcade_coin_v002.aleo/spend(
          coin, amount
        );

        return (stake_claim, stake, change);
    }

    // used for renege_stake and renege_stake_all
    // stake amount returned is equal to amount in claim and returned to staking key
    async transition stake_transfer_out (
        stake: Stake, // burned
        claim: StakeClaim // burned
    ) -> (puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin, Future) {
        let (coin, future): (puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin, Future) = puzzle_arcade_coin_v002.aleo/mint_program (
            claim.claimer,
            claim.amount,
        );
        return (coin, await_stake_transfer_out(future));
    }
    async function await_stake_transfer_out(f: Future) {
      f.await();
    }

    // called by multisig
    // joins stakes together, burns claims
    // after this point, the game must finish by either answer being revealed or timing out
    transition join_stakes(
        stake_challenger: Stake, // burned
        claim_challenger: StakeClaim, // burned
        stake_opponent: Stake, // burned
        claim_opponent: StakeClaim, // burned
        block_height: u32 // height at which the opponent can claim if answer is not revealed
    ) -> (JointStake, JointTimeoutClaim, JointState) {
        let multisig: address = self.signer;
        let amount: u64 = stake_challenger.amount;
        let challenger: address = stake_challenger.challenger;
        let opponent: address = stake_challenger.opponent;

        let joint_stake: JointStake = JointStake {
            owner: multisig,
            amount: amount + amount,
            block_height: block_height,
        };

         let timeout_claim: JointTimeoutClaim = JointTimeoutClaim {
            owner: multisig,
            amount: amount + amount,
            challenger: challenger,
            opponent: opponent,
            block_height: block_height,
        };

        let joint_state: JointState = JointState {
            owner: challenger,
            amount: amount + amount,
            opponent: opponent,
            game_multisig: multisig,
        };

        return (joint_stake, timeout_claim, joint_state);
    }

    // Challenger calls this function with the challenger key
    // revealing answer and creating record with winner on it
    // Sends winner record to multisig to use to finish game
    //
    // This call is nested inside Reveal Answer in where's alex game
    transition set_winner(
        joint_state: JointState, // burned
        winner: address,
        challenger: address
    ) -> (JointWinner) {
        // 2. Check the rest of the details of the game
        // assert_eq(joint_piece_state.amount, sig.amount + sig.amount);
        // assert_eq(joint_piece_state.opponent,sig.opponent);
        // assert_eq(joint_piece_state.game_multisig,joint_piece_state.game_multisig);

        // The logic for the answer and computing winner is in wheres_alex program
        // The enforcement to prevent the challenger calling this function without going through
        // where's alex is via the puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin Keepers
        //
        // Logic is if a piece keeper sees that there is an address that is different from the answer record for the game,
        // then can submit to public mapping then person can not spend pieces again. Also lets you mint_program their amount
        // You also get a receipt to mint_program more pieces that you see their address has -- maybe?
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
            challenger: challenger,
            opponent: joint_state.opponent,
            winner: winner,
        };

        return (joint_winner);
    }

    // Called with multisig key
    // Any multisig member calls this function to end the game and transfer the pieces
    async transition transfer_stake_to_winner(
        winner: JointWinner, // burned
        stake: JointStake, // burned
        timeout_claim: JointTimeoutClaim, // burned
    ) -> (puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin, Future) {
        let (winnings, future): (puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin, Future) = puzzle_arcade_coin_v002.aleo/mint_program (
            winner.winner,
            stake.amount,
        );
        return (winnings, await_transfer_stake_to_winner(future));
    }
    async function await_transfer_stake_to_winner(f: Future) {
      f.await();
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
    // called via finish_game_by_timeout
    async transition transfer_via_timeout (
        stake: JointStake, // burned
        timeout_claim: JointTimeoutClaim, // burned
    ) -> (puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin, Future)
    {
        // check that it's the same game
        assert_eq(stake.owner, timeout_claim.owner);
        assert_eq(stake.amount, timeout_claim.amount);

        let (winnings, future): (puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin, Future) = puzzle_arcade_coin_v002.aleo/mint_program (
            timeout_claim.opponent,
            timeout_claim.amount,
        );

        return (winnings, await_transfer_via_timeout(future));
    }
    async function await_transfer_via_timeout(f: Future) {
      f.await();
    }
}
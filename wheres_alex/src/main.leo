import puzzle_multiparty_coin_v001.aleo;

program wheres_alex_v001.aleo {
    // owned by challenger
    // sent to multisig on reveal_answer
    record Answer {
        owner: address,
        game_multisig: address,
        opponent: address,
        amount: u64,
        answer: u8
    }

    record Key {
        owner: address, // opponent
        seed: field,
        game_multisig: address,
    }

    // private game_state: u8:
    //   NORMAL FLOW
    //   1 -> challenger proposed game
    //   2 -> opponent matched wager
    //   3 -> accepted game
    //   4 -> challenger revealed answer
    //   5 -> finished game
    //   
    //   ALTERNATE EXIT PATHS
    //   6 -> timeout finished game
    //   0 -> Game reneged
    record Game {
        owner: address, // always multisig
        opponent_answer: u8,
        total_pot: u64,
        challenger: address,
        opponent: address,
        game_state: u8,
    }

    // sent to opponent on propose_game
    // consumed in submit_wager
    record Proposal {
        owner: address, // opponent
        game_multisig: address,
        game_state: u8,
        total_pot: u64,
        challenger: address
    }

    // sent to challenger on accept_game
    // consumed in reveal_answer
    record Guess {
        owner: address, // challenger
        guess: u8,
    }

    // called by challenger
    transition propose_game (
        wager: puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin,
        wager_amount: u64,
        challenger: address,
        opponent: address,
        game_multisig: address,
        answer: u8,
        game_multisig_seed: field,
    ) -> (
        puzzle_multiparty_coin_v001.aleo/StakeClaim,
        puzzle_multiparty_coin_v001.aleo/Stake,
        puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin,
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

        // assert that the wager amount > 0 and wager record has at least that much
        assert((wager_amount > 0u64) && (wager.amount >= wager_amount));

        // transfer wager to multisig
        let (
            claim,
            stake,
            change,
        ): (
            puzzle_multiparty_coin_v001.aleo/StakeClaim,
            puzzle_multiparty_coin_v001.aleo/Stake,
            puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin,
        ) = puzzle_multiparty_coin_v001.aleo/stake_transfer_in(
            wager,
            wager_amount,
            challenger,
            opponent,
            game_multisig
        );

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
            challenger: challenger,
        };

        let game: Game = Game {
            owner: game_multisig,
            opponent_answer: 0u8, // placeholder until opponent answer in accept_game
            total_pot: wager_amount + wager_amount,
            challenger: challenger,
            opponent: opponent,
            game_state: 1u8,
        };

        let answer_: Answer = Answer {
            owner: challenger,
            game_multisig: game_multisig,
            opponent: opponent,
            amount: wager_amount,
            answer: answer,
        };

        return (
            claim,
            stake,
            change,
            answer_,
            key,
            game,
            proposal,
        );
    }

    // called by opponent
    transition submit_wager (
        wager: puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin,
        key: Key,
        proposal: Proposal
    ) -> (
        puzzle_multiparty_coin_v001.aleo/StakeClaim,
        puzzle_multiparty_coin_v001.aleo/Stake,
        puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin,
    )
    {
        // assert that the wager record has enough to match the proposal
        assert(wager.amount >= proposal.total_pot / 2u64);

        return puzzle_multiparty_coin_v001.aleo/stake_transfer_in(
            wager,
            proposal.total_pot / 2u64, // amount = half of total_pot
            proposal.challenger,
            self.signer,
            proposal.game_multisig
        );
    }

    // any part can call this function with multisig key
    async transition renege_stake
    (
      stake: puzzle_multiparty_coin_v001.aleo/Stake,
      claim: puzzle_multiparty_coin_v001.aleo/StakeClaim,
    ) -> (puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin, Future) {
        let (coin, future): (puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin, Future) = puzzle_multiparty_coin_v001.aleo/stake_transfer_out(
          stake,
          claim,
        );
        return (coin, await_renege_stake(future));
    }
    async function await_renege_stake(f: Future) {
      f.await();
    }

    // any party can call this function with multisig key
    async transition renege_stake_all
    (
        stake_challenger: puzzle_multiparty_coin_v001.aleo/Stake,
        claim_challenger: puzzle_multiparty_coin_v001.aleo/StakeClaim,
        stake_opponent: puzzle_multiparty_coin_v001.aleo/Stake,
        claim_opponent: puzzle_multiparty_coin_v001.aleo/StakeClaim,
    ) ->
    (
        puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin,
        puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin,
        Future
    )
    {
        let (challenger_coin, future1): (puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin, Future) = puzzle_multiparty_coin_v001.aleo/stake_transfer_out(
          stake_challenger,
          claim_challenger,
        );

        let (opponent_coin, future2): (puzzle_arcade_coin_v002.aleo/PuzzleArcadeCoin, Future) = puzzle_multiparty_coin_v001.aleo/stake_transfer_out(
          stake_opponent,
          claim_opponent,
        );

        return (challenger_coin, opponent_coin, await_renege_stake_all(future1, future2));
    }
    async function await_renege_stake_all(f1: Future, f2: Future) {
      f1.await();
      f2.await();
    }

    // called by opponent (via ms key) after wager is confirmed on network
    transition accept_game
    (
        game: Game,
        opponent_answer: u8,
        stake_challenger: puzzle_multiparty_coin_v001.aleo/Stake,
        claim_challenger: puzzle_multiparty_coin_v001.aleo/StakeClaim,
        stake_opponent: puzzle_multiparty_coin_v001.aleo/Stake,
        claim_opponent: puzzle_multiparty_coin_v001.aleo/StakeClaim,
        block_height: u32,
    ) -> (
        puzzle_multiparty_coin_v001.aleo/JointStake,
        puzzle_multiparty_coin_v001.aleo/JointTimeoutClaim,
        puzzle_multiparty_coin_v001.aleo/JointState,
        Guess,
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
            block_height,
        );

        // sent to challenger on accept_game
        let guess: Guess = Guess {
            owner: game.challenger,
            guess: opponent_answer,
        };

        let updated_game: Game = Game {
            owner: game.owner,
            opponent_answer: opponent_answer,
            total_pot: game.total_pot,
            challenger: game.challenger,
            opponent: game.opponent,
            game_state: 3u8,
        };

        return (
            piece_joint_stake,
            joint_piece_time_claim,
            joint_piece_state,
            guess,
            updated_game,
        );
    }

    // called by challenger to reveal answer to multisig
    transition reveal_answer_game
    (
        opponent_guess: Guess,
        answer: Answer,
        joint_state: puzzle_multiparty_coin_v001.aleo/JointState,
    ) ->
    (
        Answer,
        puzzle_multiparty_coin_v001.aleo/JointWinner
    )
    {
        // determine winner! (note: can't use self.signer in ternary)
        let challenger: address = self.signer;
        let winner: address = opponent_guess.guess == answer.answer ? answer.opponent : challenger;

        // reveal the answer to the multisig
        let revealed_answer: Answer = Answer {
            owner: answer.game_multisig,
            game_multisig: answer.game_multisig,
            opponent: answer.opponent,
            amount: answer.amount,
            answer: answer.answer
        };

        // update joint_state with the winner
        let (joint_winner): puzzle_multiparty_coin_v001.aleo/JointWinner = puzzle_multiparty_coin_v001.aleo/set_winner(
          joint_state,
          winner,
          self.signer
        );

        return (revealed_answer, joint_winner);
    }

    // called by multisig key to finish the game and transfer winnings to winner
    async transition finish_game
    (
        game: Game,
        winner: puzzle_multiparty_coin_v001.aleo/JointWinner,
        stake: puzzle_multiparty_coin_v001.aleo/JointStake,
        timeout_claim: puzzle_multiparty_coin_v001.aleo/JointTimeoutClaim,
    ) -> (
        puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
        Game,
        Future
    )
    {
        let (winnings, future): (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket, Future) = puzzle_multiparty_coin_v001.aleo/transfer_stake_to_winner(
            winner,
            stake,
            timeout_claim,
        );

        let finished_game: Game = Game {
            owner: game.owner,
            opponent_answer: game.opponent_answer,
            total_pot: game.total_pot,
            challenger: game.challenger,
            opponent: game.opponent,
            game_state: 5u8,
        };

        return (winnings, finished_game, await_finish_game(future));
    }
    async function await_finish_game(f: Future) {
      f.await();
    }

    // called by multisig key via opponent to finish the game and get the total pot!
    async transition finish_game_by_timeout(
        game: Game,
        stake: puzzle_multiparty_coin_v001.aleo/JointStake,
        timeout_claim: puzzle_multiparty_coin_v001.aleo/JointTimeoutClaim,
    ) ->
    (
        puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
        Game,
        Future
    )
    {
        let finished_game: Game = Game {
            owner: game.owner,
            opponent_answer: game.opponent_answer,
            total_pot: game.total_pot,
            challenger: game.challenger,
            opponent: game.opponent,
            game_state: 6u8,
        };

        let (winnings, future): (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket, Future) = puzzle_multiparty_coin_v001.aleo/transfer_via_timeout(
          stake,
          timeout_claim
        );

        return (
          winnings,
          finished_game,
          check_height(timeout_claim.block_height, future)
        );
    }
    async function check_height(height: u32, f: Future) {
      assert(height > block.height);
      f.await();
    }
}
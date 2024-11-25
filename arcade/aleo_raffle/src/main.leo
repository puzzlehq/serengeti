import puzzle_arcade_ticket_testing.aleo;
import credits.aleo;

program puzzle_raffle_testing2.aleo {
    // set this every time we are starting up a new raffle
    const PRIZE_PER_WINNER: u64 = 1000000u64;

    const OPERATOR: address = aleo1pkuty394j0000uedtqpazp4qejwmn2yshaac6qjr6wll25m9a5psuggt6d;

    // used for storing the raffle entries (multiple entries per address)
    //   i.e. 0 -> aleo1...asdf, 1 -> aleo1...ghjk
    mapping entries: u64 => address;
    // used for storing the number of entries a user has
    //   i.e. aleo1...asdf -> 5
    mapping user_entries: address => u16;
    // used for storing of total number of values in entries mapping
    //   i.e. 0 -> 1, 0 -> 2
    mapping total_entries: u64 => u64;
    // 1u64 -> aleo1...lka
    mapping winner: u64 => address;
    // mapping to store winner aleo1... => true (if addr has won)
    mapping has_won: address => bool;
    // mapping to store whether a winner has claimed aleo1... => true (if addr has claimed)
    mapping has_claimed: address => bool;
    // total number of winners
    mapping winner_count: u64 => u64;

    async transition fund (microcredits: u64) -> Future {
      assert_eq(self.caller, self.signer);
      assert_eq(self.caller, OPERATOR);
      let f: Future = credits.aleo/transfer_public_as_signer(self.address, microcredits);
      return finalize_fund (f);
    }

    async function finalize_fund (f: Future) {
      f.await();
    }

    async transition buy_one_entry (ticket: puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket) -> (
      puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket,
      Future
    ) {
        let spent_ticket: puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_testing.aleo/spend (ticket, 1000000u64);
        return (spent_ticket, add_one_entry(ticket.owner));
    }
    async function add_one_entry (public participant: address) {
        // get current raffle count, if first entry, choose default of 0u64
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);
        // add address to entry mapping
        Mapping::set(entries, current_raffle_count, participant);
        // increment raffle total entries by 1
        Mapping::set(total_entries, 0u64, current_raffle_count + 1u64);
        // increment user entries by 1
        let current_user_entries: u16 = Mapping::get_or_use(user_entries, participant, 0u16);
        Mapping::set(user_entries, participant, current_user_entries + 1u16);
    }

    async transition buy_two_entries (ticket: puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket) -> (
      puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket,
      Future
    ) {
        let spent_ticket: puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_testing.aleo/spend (ticket, 2000000u64);
        return (spent_ticket, add_two_entries(ticket.owner));
    }
    async function add_two_entries (public participant: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);

        for i: u64 in 0u64..2u64 {
          Mapping::set(entries, current_raffle_count + i, participant);
        }

        Mapping::set(total_entries, 0u64, current_raffle_count + 2u64);

        let current_user_entries: u16 = Mapping::get_or_use(user_entries, participant, 0u16);
        Mapping::set(user_entries, participant, current_user_entries + 2u16);
    }

    async transition buy_three_entries (ticket: puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket) -> (
      puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket,
      Future
    ) {
        let spent_ticket: puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_testing.aleo/spend (ticket, 3000000u64);
        return (spent_ticket, add_three_entries(ticket.owner));
    }
    async function add_three_entries (public participant: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);

        for i: u64 in 0u64..3u64 {
          Mapping::set(entries, current_raffle_count + i, participant);
        }

        Mapping::set(total_entries, 0u64, current_raffle_count + 3u64);

        let current_user_entries: u16 = Mapping::get_or_use(user_entries, participant, 0u16);
        Mapping::set(user_entries, participant, current_user_entries + 3u16);
    }

    async transition buy_four_entries(ticket: puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket) -> (
      puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket,
      Future
    ) {
        let spent_ticket: puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_testing.aleo/spend (ticket, 4000000u64);
        return (spent_ticket, add_four_entries(ticket.owner));
    }
    async function add_four_entries(public participant: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);

        for i: u64 in 0u64..4u64 {
          Mapping::set(entries, current_raffle_count + i, participant);
        }

        Mapping::set(total_entries, 0u64, current_raffle_count + 4u64);

        let current_user_entries: u16 = Mapping::get_or_use(user_entries, participant, 0u16);
        Mapping::set(user_entries, participant, current_user_entries + 4u16);
    }

    async transition buy_five_entries(ticket: puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket) -> (
      puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket,
      Future
    ) {
        let spent_ticket: puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_testing.aleo/spend (ticket, 5000000u64);
        return (spent_ticket, add_five_entries(ticket.owner));
    }
    async function add_five_entries(public participant: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);

        for i: u64 in 0u64..5u64 {
          Mapping::set(entries, current_raffle_count + i, participant);
        }

        Mapping::set(total_entries, 0u64, current_raffle_count + 5u64);

        let current_user_entries: u16 = Mapping::get_or_use(user_entries, participant, 0u16);
        Mapping::set(user_entries, participant, current_user_entries + 5u16);
    }

    async transition buy_six_entries(ticket: puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket) -> (
      puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket,
      Future
    ) {
        let spent_ticket: puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_testing.aleo/spend (ticket, 6000000u64);
        return (spent_ticket, add_six_entries(ticket.owner));
    }
    async function add_six_entries(public participant: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);

        for i: u64 in 0u64..6u64 {
          Mapping::set(entries, current_raffle_count + i, participant);
        }

        Mapping::set(total_entries, 0u64, current_raffle_count + 6u64);

        let current_user_entries: u16 = Mapping::get_or_use(user_entries, participant, 0u16);
        Mapping::set(user_entries, participant, current_user_entries + 6u16);
    }

    async transition buy_seven_entries(ticket: puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket) -> (
      puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket,
      Future
    ) {
        let spent_ticket: puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_testing.aleo/spend (ticket, 7000000u64);
        return (spent_ticket, add_seven_entries(ticket.owner));
    }
    async function add_seven_entries(public participant: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);

        for i: u64 in 0u64..7u64 {
          Mapping::set(entries, current_raffle_count + i, participant);
        }

        Mapping::set(total_entries, 0u64, current_raffle_count + 7u64);

        let current_user_entries: u16 = Mapping::get_or_use(user_entries, participant, 0u16);
        Mapping::set(user_entries, participant, current_user_entries + 7u16);
    }

    async transition buy_eight_entries(ticket: puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket) -> (
      puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket,
      Future
    ) {
        let spent_ticket: puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_testing.aleo/spend (ticket, 8000000u64);
        return (spent_ticket, add_eight_entries(ticket.owner));
    }
    async function add_eight_entries(public participant: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);

        for i: u64 in 0u64..8u64 {
          Mapping::set(entries, current_raffle_count + i, participant);
        }

        Mapping::set(total_entries, 0u64, current_raffle_count + 8u64);

        let current_user_entries: u16 = Mapping::get_or_use(user_entries, participant, 0u16);
        Mapping::set(user_entries, participant, current_user_entries + 8u16);
    }

    async transition buy_nine_entries(ticket: puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket) -> (
      puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket,
      Future
    ) {
        let spent_ticket: puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_testing.aleo/spend (ticket, 9000000u64);
        return (spent_ticket, add_nine_entries(ticket.owner));
    }
    async function add_nine_entries(public participant: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);

        for i: u64 in 0u64..9u64 {
          Mapping::set(entries, current_raffle_count + i, participant);
        }

        Mapping::set(total_entries, 0u64, current_raffle_count + 9u64);

        let current_user_entries: u16 = Mapping::get_or_use(user_entries, participant, 0u16);
        Mapping::set(user_entries, participant, current_user_entries + 9u16);
    }

    async transition buy_ten_entries(ticket: puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket) -> (
      puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket,
      Future
    ) {
        let spent_ticket: puzzle_arcade_ticket_testing.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_testing.aleo/spend (ticket, 10000000u64);
        return (spent_ticket, add_ten_entries(ticket.owner));
    }
    async function add_ten_entries(public participant: address) {
        let current_raffle_count: u64 = Mapping::get_or_use(total_entries, 0u64, 0u64);

        for i: u64 in 0u64..10u64 {
          Mapping::set(entries, current_raffle_count + i, participant);
        }

        Mapping::set(total_entries, 0u64, current_raffle_count + 10u64);

        let current_user_entries: u16 = Mapping::get_or_use(user_entries, participant, 0u16);
        Mapping::set(user_entries, participant, current_user_entries + 10u16);
    }

    // todo: allow draw winner to only be called once
    async transition draw_winner () -> (Future) {
        assert_eq(self.caller, self.signer);
        assert_eq(self.caller, OPERATOR);
        return await_draw_winner();
    }
    async function await_draw_winner () {
        // get total entries
        let num_entries: u64 = Mapping::get(total_entries, 0u64);
        // grab random number
        let random_number: u64 = ChaCha::rand_u64();
        // select winning index
        let winner_index: u64 = random_number % num_entries;
        // get address at winning index
        let winner_address: address = Mapping::get(entries, winner_index);
        // true if addr has already won, false if not
        let has_addr_won: bool = Mapping::get_or_use(has_won, winner_address, false);

        // if the drawn address has already won, fail
        assert_eq(has_addr_won, false);

        // get the winner_count
        let current_winner_count: u64 = Mapping::get_or_use(winner_count, 0u64, 0u64);
        // set addr to true {aleo1...: true}
        Mapping::set(has_won, winner_address, true);
        // increment winner count {0u64: 1u64} and so on
        Mapping::set(winner_count, 0u64, current_winner_count + 1u64);
        // set winner { 1u64: aleo1...} ...
        Mapping::set(winner, current_winner_count, winner_address);
    }

    async transition send_prize_to_winner (winning_address: address, winning_amt_microcredits: u64) -> Future {
      let f: Future = credits.aleo/transfer_public(winning_address, winning_amt_microcredits);
      return finalize_send_prize_to_winner(f, winning_address, winning_amt_microcredits);
    }

    async function finalize_send_prize_to_winner (f: Future, winning_address: address, winning_amt_microcredits: u64) {
      f.await();

      // check that the user has not claimed yet
      let has_addr_claimed: bool = Mapping::get_or_use(has_claimed, winning_address, false);
      assert_eq(has_addr_claimed, false);
      // set the claim to true so a user cannot claim twice
      Mapping::set(has_claimed, winning_address, true);

      // make sure a user is not able to claim more than should be claimable
      assert(PRIZE_PER_WINNER >= winning_amt_microcredits);

      // make sure tha address has won the raffle
      let has_addr_won: bool = Mapping::get_or_use(has_won, winning_address, false);
      assert_eq(has_addr_won, true);
    }
}
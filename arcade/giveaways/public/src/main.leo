import puzzle_arcade_ticket_v001.aleo;
import credits.aleo;

program giveaway_public.aleo {
    const PRIZE_PER_WINNER: u64 = 1000000u64;
    const OPERATOR: address = aleo1pkuty394j0000uedtqpazp4qejwmn2yshaac6qjr6wll25m9a5psuggt6d;
    const MAX_ENTRIES: u16 = 20000u16;

    // used for storing the raffle entries (multiple entries per address)
    //   i.e. 0 -> aleo1...asdf, 1 -> aleo1...ghjk
    mapping entries: u16 => address;
    // used for storing the number of entries a user has
    //   i.e. aleo1...asdf -> 5
    mapping user_entries: address => u16;
    // used for storing of total number of values in entries mapping
    //   i.e. 0 -> 1, 0 -> 2
    mapping total_entries: u16 => u16;
    // 1u16 -> aleo1...lka
    mapping winner: u8 => address;
    // mapping to store winner aleo1... => true (if addr has won)
    mapping has_won: address => bool;
    // mapping to store whether a winner has claimed aleo1... => true (if addr has claimed)
    mapping has_claimed: address => bool;
    // total number of winners
    mapping winner_count: u8 => u8;

    async transition fund(microcredits: u64) -> Future {
      let f: Future = credits.aleo/transfer_public_as_signer(self.address, microcredits);
      return finalize_fund(f);
    }
    async function finalize_fund(f: Future) {
      f.await();
    }

    async transition buy_one_entry (ticket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket) -> (
      puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
      Future
    ) {
        let spent_ticket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_v001.aleo/spend (ticket, 1000000u64);
        return (spent_ticket, add_one_entry(ticket.owner));
    }
    async function add_one_entry (public participant: address) {
        // get current raffle count, if first entry, choose default of 0u16
        let current_raffle_count: u16 = Mapping::get_or_use(total_entries, 0u16, 0u16);
        assert(current_raffle_count + 1u16 < MAX_ENTRIES);

        // add address to entry mapping
        Mapping::set(entries, current_raffle_count, participant);
        // increment raffle total entries by 1
        Mapping::set(total_entries, 0u16, current_raffle_count + 1u16);
        // increment user entries by 1
        let current_user_entries: u16 = Mapping::get_or_use(user_entries, participant, 0u16);
        Mapping::set(user_entries, participant, current_user_entries + 1u16);
    }

    async transition buy_two_entries (ticket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket) -> (
      puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
      Future
    ) {
        let spent_ticket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_v001.aleo/spend (ticket, 2000000u64);
        return (spent_ticket, add_two_entries(ticket.owner));
    }
    async function add_two_entries (public participant: address) {
        let current_raffle_count: u16 = Mapping::get_or_use(total_entries, 0u16, 0u16);
        assert(current_raffle_count + 2u16 < MAX_ENTRIES);

        for i: u16 in 0u16..2u16 {
          Mapping::set(entries, current_raffle_count + i, participant);
        }

        Mapping::set(total_entries, 0u16, current_raffle_count + 2u16);

        let current_user_entries: u16 = Mapping::get_or_use(user_entries, participant, 0u16);
        Mapping::set(user_entries, participant, current_user_entries + 2u16);
    }

    async transition buy_three_entries (ticket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket) -> (
      puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
      Future
    ) {
        let spent_ticket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_v001.aleo/spend (ticket, 3000000u64);
        return (spent_ticket, add_three_entries(ticket.owner));
    }
    async function add_three_entries (public participant: address) {
        let current_raffle_count: u16 = Mapping::get_or_use(total_entries, 0u16, 0u16);
        assert(current_raffle_count + 3u16 < MAX_ENTRIES);

        for i: u16 in 0u16..3u16 {
          Mapping::set(entries, current_raffle_count + i, participant);
        }

        Mapping::set(total_entries, 0u16, current_raffle_count + 3u16);

        let current_user_entries: u16 = Mapping::get_or_use(user_entries, participant, 0u16);
        Mapping::set(user_entries, participant, current_user_entries + 3u16);
    }

    async transition buy_four_entries(ticket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket) -> (
      puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
      Future
    ) {
        let spent_ticket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_v001.aleo/spend (ticket, 4000000u64);
        return (spent_ticket, add_four_entries(ticket.owner));
    }
    async function add_four_entries(public participant: address) {
        let current_raffle_count: u16 = Mapping::get_or_use(total_entries, 0u16, 0u16);
        assert(current_raffle_count + 4u16 < MAX_ENTRIES);

        for i: u16 in 0u16..4u16 {
          Mapping::set(entries, current_raffle_count + i, participant);
        }

        Mapping::set(total_entries, 0u16, current_raffle_count + 4u16);

        let current_user_entries: u16 = Mapping::get_or_use(user_entries, participant, 0u16);
        Mapping::set(user_entries, participant, current_user_entries + 4u16);
    }

    async transition buy_five_entries(ticket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket) -> (
      puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
      Future
    ) {
        let spent_ticket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_v001.aleo/spend (ticket, 5000000u64);
        return (spent_ticket, add_five_entries(ticket.owner));
    }
    async function add_five_entries(public participant: address) {
        let current_raffle_count: u16 = Mapping::get_or_use(total_entries, 0u16, 0u16);
        assert(current_raffle_count + 5u16 < MAX_ENTRIES);

        for i: u16 in 0u16..5u16 {
          Mapping::set(entries, current_raffle_count + i, participant);
        }

        Mapping::set(total_entries, 0u16, current_raffle_count + 5u16);

        let current_user_entries: u16 = Mapping::get_or_use(user_entries, participant, 0u16);
        Mapping::set(user_entries, participant, current_user_entries + 5u16);
    }

    async transition buy_six_entries(ticket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket) -> (
      puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
      Future
    ) {
        let spent_ticket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_v001.aleo/spend (ticket, 6000000u64);
        return (spent_ticket, add_six_entries(ticket.owner));
    }
    async function add_six_entries(public participant: address) {
        let current_raffle_count: u16 = Mapping::get_or_use(total_entries, 0u16, 0u16);
        assert(current_raffle_count + 6u16 < MAX_ENTRIES);

        for i: u16 in 0u16..6u16 {
          Mapping::set(entries, current_raffle_count + i, participant);
        }

        Mapping::set(total_entries, 0u16, current_raffle_count + 6u16);

        let current_user_entries: u16 = Mapping::get_or_use(user_entries, participant, 0u16);
        Mapping::set(user_entries, participant, current_user_entries + 6u16);
    }

    async transition buy_seven_entries(ticket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket) -> (
      puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
      Future
    ) {
        let spent_ticket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_v001.aleo/spend (ticket, 7000000u64);
        return (spent_ticket, add_seven_entries(ticket.owner));
    }
    async function add_seven_entries(public participant: address) {
        let current_raffle_count: u16 = Mapping::get_or_use(total_entries, 0u16, 0u16);
        assert(current_raffle_count + 7u16 < MAX_ENTRIES);

        for i: u16 in 0u16..7u16 {
          Mapping::set(entries, current_raffle_count + i, participant);
        }

        Mapping::set(total_entries, 0u16, current_raffle_count + 7u16);

        let current_user_entries: u16 = Mapping::get_or_use(user_entries, participant, 0u16);
        Mapping::set(user_entries, participant, current_user_entries + 7u16);
    }

    async transition buy_eight_entries(ticket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket) -> (
      puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
      Future
    ) {
        let spent_ticket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_v001.aleo/spend (ticket, 8000000u64);
        return (spent_ticket, add_eight_entries(ticket.owner));
    }
    async function add_eight_entries(public participant: address) {
        let current_raffle_count: u16 = Mapping::get_or_use(total_entries, 0u16, 0u16);
        assert(current_raffle_count + 8u16 < MAX_ENTRIES);

        for i: u16 in 0u16..8u16 {
          Mapping::set(entries, current_raffle_count + i, participant);
        }

        Mapping::set(total_entries, 0u16, current_raffle_count + 8u16);

        let current_user_entries: u16 = Mapping::get_or_use(user_entries, participant, 0u16);
        Mapping::set(user_entries, participant, current_user_entries + 8u16);
    }

    async transition buy_nine_entries(ticket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket) -> (
      puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
      Future
    ) {
        let spent_ticket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_v001.aleo/spend (ticket, 9000000u64);
        return (spent_ticket, add_nine_entries(ticket.owner));
    }
    async function add_nine_entries(public participant: address) {
        let current_raffle_count: u16 = Mapping::get_or_use(total_entries, 0u16, 0u16);
        assert(current_raffle_count + 9u16 < MAX_ENTRIES);

        for i: u16 in 0u16..9u16 {
          Mapping::set(entries, current_raffle_count + i, participant);
        }

        Mapping::set(total_entries, 0u16, current_raffle_count + 9u16);

        let current_user_entries: u16 = Mapping::get_or_use(user_entries, participant, 0u16);
        Mapping::set(user_entries, participant, current_user_entries + 9u16);
    }

    async transition buy_ten_entries(ticket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket) -> (
      puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
      Future
    ) {
        let spent_ticket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_v001.aleo/spend (ticket, 10000000u64);
        return (spent_ticket, add_ten_entries(ticket.owner));
    }
    async function add_ten_entries(public participant: address) {
        let current_raffle_count: u16 = Mapping::get_or_use(total_entries, 0u16, 0u16);
        assert(current_raffle_count + 10u16 < MAX_ENTRIES);

        for i: u16 in 0u16..10u16 {
          Mapping::set(entries, current_raffle_count + i, participant);
        }

        Mapping::set(total_entries, 0u16, current_raffle_count + 10u16);

        let current_user_entries: u16 = Mapping::get_or_use(user_entries, participant, 0u16);
        Mapping::set(user_entries, participant, current_user_entries + 10u16);
    }

    async transition draw_winner () -> (Future) {
        assert_eq(self.signer, OPERATOR);
        return await_draw_winner();
    }
    async function await_draw_winner () {
        // get total entries
        let num_entries: u16 = Mapping::get(total_entries, 0u16);
        // grab random number
        let random_number: u64 = ChaCha::rand_u64();
        // select winning index
        let winner_index: u16 = random_number as u16 % num_entries;
        // get address at winning index
        let winner_address: address = Mapping::get(entries, winner_index);
        // true if addr has already won, false if not
        let has_addr_won: bool = Mapping::get_or_use(has_won, winner_address, false);

        // if the drawn address has already won, fail
        assert_eq(has_addr_won, false);

        // get the winner_count
        let current_winner_count: u8 = Mapping::get_or_use(winner_count, 0u8, 0u8);
        // set addr to true {aleo1...: true}
        Mapping::set(has_won, winner_address, true);
        // increment winner count {0u8: 1u8} and so on
        Mapping::set(winner_count, 0u8, current_winner_count + 1u8);
        // set winner { 1u16: aleo1...} ...
        Mapping::set(winner, current_winner_count, winner_address);
    }

    async transition send_prize_to_winner (winning_address: address) -> Future {
      assert_eq(self.signer, OPERATOR);
      let f: Future = credits.aleo/transfer_public(winning_address, PRIZE_PER_WINNER);
      return finalize_send_prize_to_winner(f, winning_address);
    }
    async function finalize_send_prize_to_winner (f: Future, winning_address: address) {
      f.await();

      // check that the user has not claimed yet
      let has_addr_claimed: bool = Mapping::get_or_use(has_claimed, winning_address, false);
      assert_eq(has_addr_claimed, false);
      // set the claim to true so a user cannot claim twice
      Mapping::set(has_claimed, winning_address, true);

      // make sure tha address has won the raffle
      let has_addr_won: bool = Mapping::get_or_use(has_won, winning_address, false);
      assert_eq(has_addr_won, true);
    }
}
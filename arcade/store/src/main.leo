import puzzle_arcade_ticket_v001.aleo;
import par_store_inventory_v3.aleo;

program par_store_v4.aleo {
  transition purchase(
    id: u128,
    ticket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    return puzzle_arcade_ticket_v001.aleo/spend(ticket, product.price);
  }

  transition two_part_purchase(
    id: u128,
    ticket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_two: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    puzzle_arcade_ticket_v001.aleo/spend(ticket, product.price);

    return puzzle_arcade_ticket_v001.aleo/spend(ticket_two, product.price);
  }

  transition three_part_purchase(
    id: u128,
    ticket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_two: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_three: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    puzzle_arcade_ticket_v001.aleo/spend(ticket, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_two, product.price);
    return puzzle_arcade_ticket_v001.aleo/spend(ticket_three, product.price);
  }

  transition four_part_purchase(
    id: u128,
    ticket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_two: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_three: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_four: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    puzzle_arcade_ticket_v001.aleo/spend(ticket, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_two, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_three, product.price);
    return puzzle_arcade_ticket_v001.aleo/spend(ticket_four, product.price);
  }

  transition five_part_purchase(
    id: u128,
    ticket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_two: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_three: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_four: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_five: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    puzzle_arcade_ticket_v001.aleo/spend(ticket, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_two, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_three, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_four, product.price);
    return puzzle_arcade_ticket_v001.aleo/spend(ticket_five, product.price);
  }

  transition six_part_purchase(
    id: u128,
    ticket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_two: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_three: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_four: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_five: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_six: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    puzzle_arcade_ticket_v001.aleo/spend(ticket, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_two, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_three, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_four, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_five, product.price);
    return puzzle_arcade_ticket_v001.aleo/spend(ticket_six, product.price);
  }

  transition seven_part_purchase(
    id: u128,
    ticket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_two: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_three: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_four: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_five: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_six: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_seven: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    puzzle_arcade_ticket_v001.aleo/spend(ticket, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_two, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_three, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_four, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_five, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_six, product.price);
    return puzzle_arcade_ticket_v001.aleo/spend(ticket_seven, product.price);
  }

  transition eight_part_purchase(
    id: u128,
    ticket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_two: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_three: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_four: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_five: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_six: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_seven: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_eight: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    puzzle_arcade_ticket_v001.aleo/spend(ticket, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_two, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_three, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_four, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_five, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_six, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_seven, product.price);
    return puzzle_arcade_ticket_v001.aleo/spend(ticket_eight, product.price);
  }

  transition nine_part_purchase(
    id: u128,
    ticket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_two: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_three: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_four: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_five: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_six: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_seven: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_eight: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_nine: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    puzzle_arcade_ticket_v001.aleo/spend(ticket, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_two, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_three, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_four, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_five, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_six, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_seven, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_eight, product.price);
    return puzzle_arcade_ticket_v001.aleo/spend(ticket_nine, product.price);
  }

  transition ten_part_purchase(
    id: u128,
    ticket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_two: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_three: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_four: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_five: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_six: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_seven: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_eight: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_nine: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_ten: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    puzzle_arcade_ticket_v001.aleo/spend(ticket, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_two, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_three, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_four, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_five, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_six, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_seven, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_eight, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_nine, product.price);
    return puzzle_arcade_ticket_v001.aleo/spend(ticket_ten, product.price);
  }

  transition eleven_part_purchase(
    id: u128,
    ticket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_two: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_three: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_four: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_five: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_six: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_seven: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_eight: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_nine: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_ten: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_eleven: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    puzzle_arcade_ticket_v001.aleo/spend(ticket, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_two, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_three, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_four, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_five, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_six, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_seven, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_eight, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_nine, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_ten, product.price);
    return puzzle_arcade_ticket_v001.aleo/spend(ticket_eleven, product.price);
  }

  transition twelve_part_purchase(
    id: u128,
    ticket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_two: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_three: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_four: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_five: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_six: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_seven: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_eight: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_nine: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_ten: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_eleven: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_twelve: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    puzzle_arcade_ticket_v001.aleo/spend(ticket, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_two, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_three, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_four, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_five, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_six, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_seven, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_eight, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_nine, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_ten, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_eleven, product.price);
    return puzzle_arcade_ticket_v001.aleo/spend(ticket_twelve, product.price);
  }

  transition thirteen_part_purchase(
    id: u128,
    ticket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_two: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_three: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_four: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_five: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_six: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_seven: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_eight: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_nine: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_ten: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_eleven: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_twelve: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_thirteen: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    puzzle_arcade_ticket_v001.aleo/spend(ticket, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_two, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_three, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_four, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_five, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_six, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_seven, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_eight, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_nine, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_ten, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_eleven, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_twelve, product.price);
    return puzzle_arcade_ticket_v001.aleo/spend(ticket_thirteen, product.price);
  }

  // max num of inputs to a transition is 16
  // see console/network/src/lib.rs in snarkVM
  transition fourteen_part_purchase(
    id: u128,
    ticket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_two: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_three: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_four: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_five: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_six: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_seven: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_eight: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_nine: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_ten: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_eleven: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_twelve: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_thirteen: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket_fourteen: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    puzzle_arcade_ticket_v001.aleo/spend(ticket, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_two, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_three, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_four, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_five, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_six, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_seven, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_eight, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_nine, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_ten, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_eleven, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_twelve, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket_thirteen, product.price);
    return puzzle_arcade_ticket_v001.aleo/spend(ticket_fourteen, product.price);
  }

}
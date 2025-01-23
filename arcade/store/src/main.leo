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
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, product.price);

    return puzzle_arcade_ticket_v001.aleo/spend(ticket2, product.price);
  }

  transition three_part_purchase(
    id: u128,
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket3: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket2, product.price);
    return puzzle_arcade_ticket_v001.aleo/spend(ticket3, product.price);
  }

  transition four_part_purchase(
    id: u128,
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket3: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket4: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket2, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket3, product.price);
    return puzzle_arcade_ticket_v001.aleo/spend(ticket4, product.price);
  }

  transition five_part_purchase(
    id: u128,
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket3: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket4: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket5: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket2, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket3, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket4, product.price);
    return puzzle_arcade_ticket_v001.aleo/spend(ticket5, product.price);
  }

  transition six_part_purchase(
    id: u128,
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket3: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket4: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket5: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket6: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket2, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket3, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket4, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket5, product.price);
    return puzzle_arcade_ticket_v001.aleo/spend(ticket6, product.price);
  }

  transition seven_part_purchase(
    id: u128,
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket3: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket4: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket5: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket6: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket7: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket2, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket3, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket4, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket5, product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket6, product.price);
    return puzzle_arcade_ticket_v001.aleo/spend(ticket7, product.price);
  }
}
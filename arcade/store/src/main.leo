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
    amount1: u64,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amount2: u64,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    assert(amount1 + amount2 >= product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, amount1);

    return puzzle_arcade_ticket_v001.aleo/spend(ticket2, amount2);
  }

  transition three_part_purchase(
    id: u128,
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amount1: u64,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amount2: u64,
    ticket3: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amount3: u64,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    assert(amount1 + amount2 + amount3 >= product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, amount1);
    puzzle_arcade_ticket_v001.aleo/spend(ticket2, amount2);
    return puzzle_arcade_ticket_v001.aleo/spend(ticket3, amount3);
  }

  transition four_part_purchase(
    id: u128,
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amount1: u64,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amount2: u64,
    ticket3: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amount3: u64,
    ticket4: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amount4: u64,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    assert(amount1 + amount2 + amount3 + amount4 >= product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, amount1);
    puzzle_arcade_ticket_v001.aleo/spend(ticket2, amount2);
    puzzle_arcade_ticket_v001.aleo/spend(ticket3, amount3);
    return puzzle_arcade_ticket_v001.aleo/spend(ticket4, amount4);
  }

  transition five_part_purchase(
    id: u128,
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amount1: u64,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amount2: u64,
    ticket3: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amount3: u64,
    ticket4: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amount4: u64,
    ticket5: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amount5: u64,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    assert(amount1 + amount2 + amount3 + amount4 + amount5 >= product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, amount1);
    puzzle_arcade_ticket_v001.aleo/spend(ticket2, amount2);
    puzzle_arcade_ticket_v001.aleo/spend(ticket3, amount3);
    puzzle_arcade_ticket_v001.aleo/spend(ticket4, amount4);
    return puzzle_arcade_ticket_v001.aleo/spend(ticket5, amount5);
  }

  transition six_part_purchase(
    id: u128,
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amount1: u64,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amount2: u64,
    ticket3: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amount3: u64,
    ticket4: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amount4: u64,
    ticket5: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amount5: u64,
    ticket6: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amount6: u64,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    assert(amount1 + amount2 + amount3 + amount4 + amount5 + amount6 >= product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, amount1);
    puzzle_arcade_ticket_v001.aleo/spend(ticket2, amount2);
    puzzle_arcade_ticket_v001.aleo/spend(ticket3, amount3);
    puzzle_arcade_ticket_v001.aleo/spend(ticket4, amount4);
    puzzle_arcade_ticket_v001.aleo/spend(ticket5, amount5);
    return puzzle_arcade_ticket_v001.aleo/spend(ticket6, amount6);
  }

  transition seven_part_purchase(
    id: u128,
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amount1: u64,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amount2: u64,
    ticket3: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amount3: u64,
    ticket4: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amount4: u64,
    ticket5: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amount5: u64,
    ticket6: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amount6: u64,
    ticket7: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amount7: u64,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    assert(amount1 + amount2 + amount3 + amount4 + amount5 + amount6 + amount7 >= product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, amount1);
    puzzle_arcade_ticket_v001.aleo/spend(ticket2, amount2);
    puzzle_arcade_ticket_v001.aleo/spend(ticket3, amount3);
    puzzle_arcade_ticket_v001.aleo/spend(ticket4, amount4);
    puzzle_arcade_ticket_v001.aleo/spend(ticket5, amount5);
    puzzle_arcade_ticket_v001.aleo/spend(ticket6, amount6);
    return puzzle_arcade_ticket_v001.aleo/spend(ticket7, amount7);
  }
}
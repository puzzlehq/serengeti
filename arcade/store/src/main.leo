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
    amt1: u64,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amt2: u64,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    assert(amt1 + amt2 >= product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, amt1);

    return puzzle_arcade_ticket_v001.aleo/spend(ticket2, amt2);
  }

  transition three_part_purchase(
    id: u128,
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amt1: u64,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amt2: u64,
    ticket3: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amt3: u64,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    assert(amt1 + amt2 + amt3 >= product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, amt1);
    puzzle_arcade_ticket_v001.aleo/spend(ticket2, amt2);
    return puzzle_arcade_ticket_v001.aleo/spend(ticket3, amt3);
  }

  transition four_part_purchase(
    id: u128,
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amt1: u64,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amt2: u64,
    ticket3: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amt3: u64,
    ticket4: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amt4: u64,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    assert(amt1 + amt2 + amt3 + amt4 >= product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, amt1);
    puzzle_arcade_ticket_v001.aleo/spend(ticket2, amt2);
    puzzle_arcade_ticket_v001.aleo/spend(ticket3, amt3);
    return puzzle_arcade_ticket_v001.aleo/spend(ticket4, amt4);
  }

  transition five_part_purchase(
    id: u128,
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amt1: u64,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amt2: u64,
    ticket3: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amt3: u64,
    ticket4: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amt4: u64,
    ticket5: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amt5: u64,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    assert(amt1 + amt2 + amt3 + amt4 + amt5 >= product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, amt1);
    puzzle_arcade_ticket_v001.aleo/spend(ticket2, amt2);
    puzzle_arcade_ticket_v001.aleo/spend(ticket3, amt3);
    puzzle_arcade_ticket_v001.aleo/spend(ticket4, amt4);
    return puzzle_arcade_ticket_v001.aleo/spend(ticket5, amt5);
  }

  transition six_part_purchase(
    id: u128,
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amt1: u64,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amt2: u64,
    ticket3: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amt3: u64,
    ticket4: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amt4: u64,
    ticket5: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amt5: u64,
    ticket6: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amt6: u64,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    assert(amt1 + amt2 + amt3 + amt4 + amt5 + amt6 >= product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, amt1);
    puzzle_arcade_ticket_v001.aleo/spend(ticket2, amt2);
    puzzle_arcade_ticket_v001.aleo/spend(ticket3, amt3);
    puzzle_arcade_ticket_v001.aleo/spend(ticket4, amt4);
    puzzle_arcade_ticket_v001.aleo/spend(ticket5, amt5);
    return puzzle_arcade_ticket_v001.aleo/spend(ticket6, amt6);
  }

  transition seven_part_purchase(
    id: u128,
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amt1: u64,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amt2: u64,
    ticket3: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amt3: u64,
    ticket4: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amt4: u64,
    ticket5: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amt5: u64,
    ticket6: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amt6: u64,
    ticket7: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    amt7: u64,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    assert(amt1 + amt2 + amt3 + amt4 + amt5 + amt6 + amt7 >= product.price);
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, amt1);
    puzzle_arcade_ticket_v001.aleo/spend(ticket2, amt2);
    puzzle_arcade_ticket_v001.aleo/spend(ticket3, amt3);
    puzzle_arcade_ticket_v001.aleo/spend(ticket4, amt4);
    puzzle_arcade_ticket_v001.aleo/spend(ticket5, amt5);
    puzzle_arcade_ticket_v001.aleo/spend(ticket6, amt6);
    return puzzle_arcade_ticket_v001.aleo/spend(ticket7, amt7);
  }
}
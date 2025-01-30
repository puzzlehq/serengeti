import puzzle_arcade_ticket_v001.aleo;
import par_store_inventory_v3.aleo;

program par_store_v5.aleo {
  transition purchase(
    id: u128,
    ticket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    return puzzle_arcade_ticket_v001.aleo/spend(ticket, product.price);
  }

  transition purchase2(
    id: u128,
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    partialTicket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    let change: u64 = ticket1.amount
      + partialTicket.amount
      - product.price;
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, ticket1.amount);
    return puzzle_arcade_ticket_v001.aleo/spend(partialTicket, partialTicket.amount - change);
  }

  transition purchase3(
    id: u128,
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    partialTicket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    let change: u64 = ticket1.amount
      + ticket2.amount
      + partialTicket.amount
      - product.price;
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, ticket1.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket2, ticket2.amount);
    return puzzle_arcade_ticket_v001.aleo/spend(partialTicket, change);
  }

  transition purchase4(
    id: u128,
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket3: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    partialTicket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    let change: u64 = ticket1.amount
      + ticket2.amount
      + ticket3.amount
      + partialTicket.amount
      - product.price;
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, ticket1.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket2, ticket2.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket3, ticket3.amount);
    return puzzle_arcade_ticket_v001.aleo/spend(partialTicket, change);
  }

  transition purchase5(
    id: u128,
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket3: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket4: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    partialTicket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    let change: u64 = ticket1.amount
      + ticket2.amount
      + ticket3.amount
      + ticket4.amount
      + partialTicket.amount
      - product.price;
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, ticket1.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket2, ticket2.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket3, ticket3.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket4, ticket4.amount);
    return puzzle_arcade_ticket_v001.aleo/spend(partialTicket, change);
  }

  transition purchase6(
    id: u128,
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket3: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket4: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket5: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    partialTicket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    let change: u64 = ticket1.amount
      + ticket2.amount
      + ticket3.amount
      + ticket4.amount
      + ticket5.amount
      + partialTicket.amount
      - product.price;
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, ticket1.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket2, ticket2.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket3, ticket3.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket4, ticket4.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket5, ticket5.amount);
    return puzzle_arcade_ticket_v001.aleo/spend(partialTicket, change);
  }

  transition purchase7(
    id: u128,
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket3: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket4: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket5: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket6: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    partialTicket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    let change: u64 = ticket1.amount
      + ticket2.amount
      + ticket3.amount
      + ticket4.amount
      + ticket5.amount
      + ticket6.amount
      + partialTicket.amount
      - product.price;
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, ticket1.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket2, ticket2.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket3, ticket3.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket4, ticket4.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket5, ticket5.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket6, ticket6.amount);
    return puzzle_arcade_ticket_v001.aleo/spend(partialTicket, change);
  }

  transition purchase8(
    id: u128,
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket3: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket4: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket5: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket6: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket7: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    partialTicket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    let change: u64 = ticket1.amount
      + ticket2.amount
      + ticket3.amount
      + ticket4.amount
      + ticket5.amount
      + ticket6.amount
      + ticket7.amount
      + partialTicket.amount
      - product.price;
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, ticket1.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket2, ticket2.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket3, ticket3.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket4, ticket4.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket5, ticket5.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket6, ticket6.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket7, ticket7.amount);
    return puzzle_arcade_ticket_v001.aleo/spend(partialTicket, change);
  }

  transition purchase9(
    id: u128,
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket3: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket4: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket5: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket6: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket7: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket8: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    partialTicket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    product: par_store_inventory_v3.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    let change: u64 = ticket1.amount
      + ticket2.amount
      + ticket3.amount
      + ticket4.amount
      + ticket5.amount
      + ticket6.amount
      + ticket7.amount
      + ticket8.amount
      + partialTicket.amount
      - product.price;
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, ticket1.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket2, ticket2.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket3, ticket3.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket4, ticket4.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket5, ticket5.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket6, ticket6.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket7, ticket7.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket8, ticket8.amount);
    return puzzle_arcade_ticket_v001.aleo/spend(partialTicket, change);
  }

  // transition purchase10(
  //   id: u128,
  //   ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
  //   ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
  //   ticket3: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
  //   ticket4: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
  //   ticket5: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
  //   ticket6: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
  //   ticket7: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
  //   ticket8: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
  //   ticket9: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
  //   partialTicket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
  //   product: par_store_inventory_v3.aleo/Product,
  // ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  // {
  //   let change: u64 = ticket1.amount
  //     + ticket2.amount
  //     + ticket3.amount
  //     + ticket4.amount
  //     + ticket5.amount
  //     + ticket6.amount
  //     + ticket7.amount
  //     + ticket8.amount
  //     + ticket9.amount
  //     + partialTicket.amount
  //     - product.price;
  //   puzzle_arcade_ticket_v001.aleo/spend(ticket1, ticket1.amount);
  //   puzzle_arcade_ticket_v001.aleo/spend(ticket2, ticket2.amount);
  //   puzzle_arcade_ticket_v001.aleo/spend(ticket3, ticket3.amount);
  //   puzzle_arcade_ticket_v001.aleo/spend(ticket4, ticket4.amount);
  //   puzzle_arcade_ticket_v001.aleo/spend(ticket5, ticket5.amount);
  //   puzzle_arcade_ticket_v001.aleo/spend(ticket6, ticket6.amount);
  //   puzzle_arcade_ticket_v001.aleo/spend(ticket7, ticket7.amount);
  //   puzzle_arcade_ticket_v001.aleo/spend(ticket8, ticket8.amount);
  //   puzzle_arcade_ticket_v001.aleo/spend(ticket9, ticket9.amount);
  //   return puzzle_arcade_ticket_v001.aleo/spend(partialTicket, change);
  // }
}
import puzzle_arcade_ticket_v001.aleo;
import par_store_inventory_v6.aleo;

program par_store_10_13_v2.aleo {
  async transition purchase10(
    sku_id: u16,
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket3: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket4: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket5: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket6: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket7: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket8: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket9: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    partialTicket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    price: u64
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket, Future)
  {
    let change: u64 = ticket1.amount
      + ticket2.amount
      + ticket3.amount
      + ticket4.amount
      + ticket5.amount
      + ticket6.amount
      + ticket7.amount
      + ticket8.amount
      + ticket9.amount
      + partialTicket.amount
      - price;
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, ticket1.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket2, ticket2.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket3, ticket3.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket4, ticket4.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket5, ticket5.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket6, ticket6.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket7, ticket7.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket8, ticket8.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket9, ticket9.amount);
    return (
      puzzle_arcade_ticket_v001.aleo/spend(partialTicket, partialTicket.amount - change),
      finalize_purchase10(par_store_inventory_v6.aleo/validate_purchase(sku_id, price))
    );
  }
  async function finalize_purchase10(future: Future) {
    future.await();
  }

  async transition purchase11(
    sku_id: u16,
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket3: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket4: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket5: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket6: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket7: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket8: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket9: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket10: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    partialTicket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    price: u64
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket, Future)
  {
    let change: u64 = ticket1.amount
      + ticket2.amount
      + ticket3.amount
      + ticket4.amount
      + ticket5.amount
      + ticket6.amount
      + ticket7.amount
      + ticket8.amount
      + ticket9.amount
      + ticket10.amount
      + partialTicket.amount
      - price;
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, ticket1.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket2, ticket2.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket3, ticket3.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket4, ticket4.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket5, ticket5.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket6, ticket6.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket7, ticket7.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket8, ticket8.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket9, ticket9.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket10, ticket10.amount);
    return (
      puzzle_arcade_ticket_v001.aleo/spend(partialTicket, partialTicket.amount - change),
      finalize_purchase11(par_store_inventory_v6.aleo/validate_purchase(sku_id, price))
    );
  }
  async function finalize_purchase11(future: Future) {
    future.await();
  }

  async transition purchase12(
    sku_id: u16,
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket3: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket4: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket5: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket6: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket7: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket8: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket9: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket10: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket11: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    partialTicket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    price: u64
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket, Future)
  {
    let change: u64 = ticket1.amount
      + ticket2.amount
      + ticket3.amount
      + ticket4.amount
      + ticket5.amount
      + ticket6.amount
      + ticket7.amount
      + ticket8.amount
      + ticket9.amount
      + ticket10.amount
      + ticket11.amount
      + partialTicket.amount
      - price;
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, ticket1.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket2, ticket2.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket3, ticket3.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket4, ticket4.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket5, ticket5.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket6, ticket6.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket7, ticket7.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket8, ticket8.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket9, ticket9.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket10, ticket10.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket11, ticket11.amount);
    return (
      puzzle_arcade_ticket_v001.aleo/spend(partialTicket, partialTicket.amount - change),
      finalize_purchase12(par_store_inventory_v6.aleo/validate_purchase(sku_id, price))
    );
  }
  async function finalize_purchase12(future: Future) {
    future.await();
  }

  async transition purchase13(
    sku_id: u16,
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket3: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket4: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket5: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket6: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket7: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket8: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket9: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket10: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket11: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket12: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    partialTicket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    price: u64
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket, Future)
  {
    let change: u64 = ticket1.amount
      + ticket2.amount
      + ticket3.amount
      + ticket4.amount
      + ticket5.amount
      + ticket6.amount
      + ticket7.amount
      + ticket8.amount
      + ticket9.amount
      + ticket10.amount
      + ticket11.amount
      + ticket12.amount
      + partialTicket.amount
      - price;
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, ticket1.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket2, ticket2.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket3, ticket3.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket4, ticket4.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket5, ticket5.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket6, ticket6.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket7, ticket7.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket8, ticket8.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket9, ticket9.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket10, ticket10.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket11, ticket11.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket12, ticket12.amount);
    return (
      puzzle_arcade_ticket_v001.aleo/spend(partialTicket, partialTicket.amount - change),
      finalize_purchase13(par_store_inventory_v6.aleo/validate_purchase(sku_id, price))
    );
  }
  async function finalize_purchase13(future: Future) {
    future.await();
  }
}

import puzzle_arcade_ticket_v001.aleo;
import par_store_inventory_v1.aleo;

program par_store_v9.aleo {
  async transition purchase(
    sku_id: u16,
    ticket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    price: u64,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket, Future)
  {
    return (
      puzzle_arcade_ticket_v001.aleo/spend(ticket, price),
      finalize_purchase(par_store_inventory_v1.aleo/validate_purchase(sku_id, price))
    );
  }
  async function finalize_purchase(future: Future) {
    future.await();
  }

  async transition purchase2(
    sku_id: u16,
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    partialTicket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    price: u64
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket, Future)
  {
    let change: u64 = ticket1.amount
      + partialTicket.amount
      - price;
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, ticket1.amount);
    return (
      puzzle_arcade_ticket_v001.aleo/spend(partialTicket, partialTicket.amount - change),
      finalize_purchase2(par_store_inventory_v1.aleo/validate_purchase(sku_id, price))
    );
  }
  async function finalize_purchase2(future: Future) {
    future.await();
  }

  async transition purchase3(
    sku_id: u16,
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    partialTicket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    price: u64
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket, Future)
  {
    let change: u64 = ticket1.amount
      + ticket2.amount
      + partialTicket.amount
      - price;
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, ticket1.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket2, ticket2.amount);
    return (
      puzzle_arcade_ticket_v001.aleo/spend(partialTicket, partialTicket.amount - change),
      finalize_purchase3(par_store_inventory_v1.aleo/validate_purchase(sku_id, price))
    );
  }
  async function finalize_purchase3(future: Future) {
    future.await();
  }

  async transition purchase4(
    sku_id: u16,
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket3: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    partialTicket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    price: u64
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket, Future)
  {
    let change: u64 = ticket1.amount
      + ticket2.amount
      + ticket3.amount
      + partialTicket.amount
      - price;
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, ticket1.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket2, ticket2.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket3, ticket3.amount);
    return (
      puzzle_arcade_ticket_v001.aleo/spend(partialTicket, partialTicket.amount - change),
      finalize_purchase4(par_store_inventory_v1.aleo/validate_purchase(sku_id, price))
    );
  }
  async function finalize_purchase4(future: Future) {
    future.await();
  }

  async transition purchase5(
    sku_id: u16,
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket3: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket4: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    partialTicket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    price: u64
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket, Future)
  {
    let change: u64 = ticket1.amount
      + ticket2.amount
      + ticket3.amount
      + ticket4.amount
      + partialTicket.amount
      - price;
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, ticket1.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket2, ticket2.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket3, ticket3.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket4, ticket4.amount);
    return (
      puzzle_arcade_ticket_v001.aleo/spend(partialTicket, partialTicket.amount - change),
      finalize_purchase5(par_store_inventory_v1.aleo/validate_purchase(sku_id, price))
    );
  }
  async function finalize_purchase5(future: Future) {
    future.await();
  }

  async transition purchase6(
    sku_id: u16,
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket3: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket4: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket5: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    partialTicket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    price: u64
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket, Future)
  {
    let change: u64 = ticket1.amount
      + ticket2.amount
      + ticket3.amount
      + ticket4.amount
      + ticket5.amount
      + partialTicket.amount
      - price;
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, ticket1.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket2, ticket2.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket3, ticket3.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket4, ticket4.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket5, ticket5.amount);
    return (
      puzzle_arcade_ticket_v001.aleo/spend(partialTicket, partialTicket.amount - change),
      finalize_purchase6(par_store_inventory_v1.aleo/validate_purchase(sku_id, price))
    );
  }
  async function finalize_purchase6(future: Future) {
    future.await();
  }

  async transition purchase7(
    sku_id: u16,
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket3: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket4: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket5: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket6: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
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
      + partialTicket.amount
      - price;
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, ticket1.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket2, ticket2.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket3, ticket3.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket4, ticket4.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket5, ticket5.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket6, ticket6.amount);
    return (
      puzzle_arcade_ticket_v001.aleo/spend(partialTicket, partialTicket.amount - change),
      finalize_purchase7(par_store_inventory_v1.aleo/validate_purchase(sku_id, price))
    );
  }
  async function finalize_purchase7(future: Future) {
    future.await();
  }

  async transition purchase8(
    sku_id: u16,
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket3: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket4: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket5: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket6: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket7: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
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
      + partialTicket.amount
      - price;
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, ticket1.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket2, ticket2.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket3, ticket3.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket4, ticket4.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket5, ticket5.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket6, ticket6.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket7, ticket7.amount);
    return (
      puzzle_arcade_ticket_v001.aleo/spend(partialTicket, partialTicket.amount - change),
      finalize_purchase8(par_store_inventory_v1.aleo/validate_purchase(sku_id, price))
    );
  }
  async function finalize_purchase8(future: Future) {
    future.await();
  }

  async transition purchase9(
    sku_id: u16,
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket3: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket4: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket5: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket6: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket7: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket8: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
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
    return (
      puzzle_arcade_ticket_v001.aleo/spend(partialTicket, partialTicket.amount - change),
      finalize_purchase9(par_store_inventory_v1.aleo/validate_purchase(sku_id, price))
    );
  }
  async function finalize_purchase9(future: Future) {
    future.await();
  }
}
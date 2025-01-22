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
}
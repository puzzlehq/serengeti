import puzzle_arcade_ticket_v001.aleo;
import par_store_inventory_v1.aleo;

program par_store_v1.aleo {
  transition purchase(
    id: u64,
    ticket: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    product: par_store_inventory_v1.aleo/Product,
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket)
  {
    return puzzle_arcade_ticket_v001.aleo/spend(ticket, product.price);
  }
}
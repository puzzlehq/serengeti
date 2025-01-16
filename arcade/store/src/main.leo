import puzzle_arcade_ticket_v002.aleo;
import puzzle_arcade_store_inventory.aleo;

program puzzle_arcade_store.aleo {
  const STORE_OPERATOR: address = aleo14y7ahmrzka0wphss6p5wtvs0s08u4e00azr8ua6wxr3h60vlgyyqw7mxtd;
  transition purchase(
    id: u64,
    ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket,
    product: puzzle_arcade_store_inventory.aleo/Product,
  ) -> (puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket)
  {
    // burn purchaser's part
    let spent_ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_v002.aleo/spend(ticket, product.price);
    return (spent_ticket);
  }

  transition fulfill(buyer: address, product: puzzle_arcade_store_inventory.aleo/Product) -> puzzle_arcade_store_inventory.aleo/Product {
    // assert the product is owned by the store operator to prevent a secondary market
    assert_eq(product.owner, STORE_OPERATOR);
    // transfer the product to the purchaser
    let product_transfer: puzzle_arcade_store_inventory.aleo/Product = puzzle_arcade_store_inventory.aleo/fulfill(buyer, product);
    return (product_transfer);
  }
}
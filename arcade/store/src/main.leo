import puzzle_arcade_ticket_v002.aleo;

program puzzle_arcade_store.aleo {
  const STORE_OPERATOR: address = aleo14y7ahmrzka0wphss6p5wtvs0s08u4e00azr8ua6wxr3h60vlgyyqw7mxtd;

  // mapping of product ids to prices ex: {1u64: 2u64}
  mapping prices: u64 => u64;

  struct Code {
    pt1: u128,
    pt2: u128,
    pt3: u128,
    pt4: u128,
    pt5: u128
  }

  record Product {
    owner: address,
    id: u64,
    code: Code
  }

  async transition add_product_to_price_mapping (id: u64, price: u64) -> Future {
    assert_eq(self.caller, STORE_OPERATOR);
    return finalize_add_product(id, price);
  }

  async function finalize_add_product(id: u64, price: u64) {
    Mapping::set(prices, id, price);
  }

  transition mint(id: u64, code: Code) -> Product {
    return Product { owner: STORE_OPERATOR, id, code };
  }

  async transition purchase(
    id: u64,
    ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket,
    amt: u64, // amount of PART to burn
  ) -> (puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket, Future)
  {
    // todo: how do we validate that the user is paying the correct amount? gated by frontend?
    // burn purchaser's part
    let spent_ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket = puzzle_arcade_ticket_v002.aleo/spend(ticket, amt);
    return (spent_ticket, finalize_purchase(id, amt));
  }

  async function finalize_purchase
  (
    id: u64,
    amt: u64,
  ) {
    let price: u64 = Mapping::get(prices, id);
    assert_eq(amt, price);
  }

  transition fulfill(buyer: address, product: Product) -> Product {
    // assert the product is owned by the store operator to prevent a secondary market
    assert_eq(product.owner, STORE_OPERATOR);
    // transfer the product to the purchaser
    return Product {
      owner: buyer,
      id: product.id,
      code: product.code
    };
  }
}
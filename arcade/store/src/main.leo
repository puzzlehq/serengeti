import puzzle_arcade_ticket_v002.aleo;

program puzzle_arcade_store.aleo {
  const STORE_OPERATOR: address = aleo14y7ahmrzka0wphss6p5wtvs0s08u4e00azr8ua6wxr3h60vlgyyqw7mxtd;
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

  transition mint(id: u64, code: Code) -> Product {
    return Product { owner: STORE_OPERATOR, id, code };
  }

  transition purchase(
    id: u64,
    ticket: puzzle_arcade_ticket_v002.aleo/PuzzleArcadeTicket,
    buyer: address,
    product: Product
  ) -> (Product)
  {
    return Product {
      owner: buyer,
      id: product.id,
      code: product.code
    };
  }

  transition fulfill(buyer: address, product: Product) -> Product {
    return Product {
      owner: buyer,
      id: product.id,
      code: product.code
    };
  }
}
program puzzle_arcade_store_inventory.aleo {
  const STORE_OPERATOR: address = aleo14y7ahmrzka0wphss6p5wtvs0s08u4e00azr8ua6wxr3h60vlgyyqw7mxtd;

  record Product {
    owner: address,
    id: u64,
    code: Code,
    price: u64
  }

  struct Code {
    pt1: u128,
    pt2: u128,
    pt3: u128,
    pt4: u128,
    pt5: u128
  }

  transition mint(id: u64, code: Code, price: u64) -> Product {
    return Product { owner: STORE_OPERATOR, id, code, price };
  }

  transition fulfill(buyer: address, product: Product) -> Product {
    // assert the product is owned by the store operator to prevent a secondary market
    assert_eq(product.owner, STORE_OPERATOR);
    // transfer the product to the purchaser
    return Product {
      owner: buyer,
      id: product.id,
      code: product.code,
      price: product.price
    };
  }
}

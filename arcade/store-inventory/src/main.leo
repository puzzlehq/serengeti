program par_store_inventory_v1.aleo {
  const OPERATOR: address = aleo1raehunvfm6jvgnycefevwlhdau0577mucqg3c68vwpld2dmyyv9qhl59p4;

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
    assert_eq(self.caller, OPERATOR);
    return Product { owner: OPERATOR, id, code, price };
  }

  transition fulfill(buyer: address, product: Product) -> Product {
    // assert the product is owned by the store operator to prevent a secondary market
    assert_eq(product.owner, OPERATOR);
    // transfer the product to the purchaser
    return Product {
      owner: buyer,
      id: product.id,
      code: product.code,
      price: product.price
    };
  }
}

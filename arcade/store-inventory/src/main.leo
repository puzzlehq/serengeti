program par_store_inventory_v5.aleo {
  const OPERATOR: address = aleo1raehunvfm6jvgnycefevwlhdau0577mucqg3c68vwpld2dmyyv9qhl59p4;

  // sku_id => price
  mapping sku_prices: u16 => u64;
  // sku_id => number in stock
  mapping sku_stock: u16 => u32;

  record Product {
    owner: address,
    sku_id: u16,
    code: Code,
  }

  struct Code {
    pt1: u128,
    pt2: u128,
    pt3: u128,
    pt4: u128,
    pt5: u128
  }

  async transition set_sku_price(sku_id: u16, price: u64) -> Future {
    assert_eq(self.caller, OPERATOR);
    return finalize_set_sku_price(sku_id, price);
  }
  async function finalize_set_sku_price(sku_id: u16, price: u64) {
    Mapping::set(sku_prices, sku_id, price);
  }

  async transition mint(sku_id: u16, code: Code) -> (Product, Future) {
    assert_eq(self.caller, OPERATOR);
    let product: Product = Product { owner: OPERATOR, sku_id, code };
    return (product, finalize_mint(sku_id));
  }
  async function finalize_mint(sku_id: u16) {
    // set its availability to true
    let stock: u32 = Mapping::get_or_use(sku_stock, sku_id, 0u32);
    Mapping::set(sku_stock, sku_id, stock + 1u32);
  }

  async transition validate_purchase(sku_id: u16, price: u64) -> Future {
    return finalize_validate_purchase(sku_id, price);
  }
  async function finalize_validate_purchase(sku_id: u16, price: u64) {
    // assert sku_id has stock
    let stock: u32 = Mapping::get_or_use(sku_stock, sku_id, 0u32);
    assert(stock > 0u32);

    // assert the price is correct
    assert_eq(price, Mapping::get(sku_prices, sku_id));

    // reduce the sku stock
    Mapping::set(sku_stock, sku_id, stock - 1u32);
  }

  transition fulfill(buyer: address, product: Product) -> Product {
    // assert the product is owned by the store operator to prevent a secondary market
    assert_eq(product.owner, OPERATOR);
    // transfer the product to the purchaser
    return Product {
      owner: buyer,
      sku_id: product.sku_id,
      code: product.code
    };
  }

  // fn used only in case of contract upgrades
  async transition shutdown(sku_ids: [u16; 8]) -> Future {
    assert_eq(self.caller, OPERATOR);
    return finalize_shutdown(sku_ids);
  }

  async function finalize_shutdown(sku_ids: [u16; 8]) {
    for i: u8 in 0u8..7u8 {
      let sku_id: u16 = sku_ids[i];
        // can pass in 0u16 to skip if skus left is less than 8
      if sku_id != 0u16 {
          Mapping::remove(sku_stock, sku_id);
          Mapping::remove(sku_prices, sku_id);
      }
    }
  }
}

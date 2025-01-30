program par_store_inventory_v4.aleo {
  const OPERATOR: address = aleo1raehunvfm6jvgnycefevwlhdau0577mucqg3c68vwpld2dmyyv9qhl59p4;

  // sku_id => price
  mapping sku_prices: u128 => u64;
  // Product id => sku_id
  mapping product_ids_to_skus: u128 => u128;
  // Product.id => availability
  mapping availability: u128 => bool;

  record Product {
    owner: address,
    id: u128,
    code: Code,
  }

  struct Code {
    pt1: u128,
    pt2: u128,
    pt3: u128,
    pt4: u128,
    pt5: u128
  }

  async transition set_sku_price(sku_id: u128, price: u64) -> Future {
    assert_eq(self.caller, OPERATOR);
    return finalize_set_sku_price(sku_id, price);
  }
  async function finalize_set_sku_price(sku_id: u128, price: u64) {
    Mapping::set(sku_prices, sku_id, price);
  }

  async transition mint(id: u128, sku_id: u128, code: Code, price: u64) -> (Product, Future) {
    assert_eq(self.caller, OPERATOR);
    let product: Product = Product { owner: OPERATOR, id, code };
    return (product, finalize_mint(id, sku_id));
  }
  async function finalize_mint(id: u128, sku_id: u128) {
    // link the product to a sku so we can validate its purchase price later
    Mapping::set(product_ids_to_skus, id, sku_id);
    // set its availability to true
    Mapping::set(availability, id, true);
  }

  async transition validate_purchase(id: u128, price: u64) -> Future {
    return finalize_validate_purchase(id, price);
  }
  async function finalize_validate_purchase(id: u128, price: u64) {
    // assert the product still is available
    assert(Mapping::get_or_use(availability, id, false));
    let sku_id: u128 = Mapping::get(product_ids_to_skus, id);
    // assert the price is correct
    assert_eq(price, Mapping::get(sku_prices, sku_id));
    // set the product's availability
    Mapping::set(availability, id, false);
  }

  transition fulfill(buyer: address, product: Product) -> Product {
    // assert the product is owned by the store operator to prevent a secondary market
    assert_eq(product.owner, OPERATOR);
    // transfer the product to the purchaser
    return Product {
      owner: buyer,
      id: product.id,
      code: product.code
    };
  }
}

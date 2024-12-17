program puzzle_arcade_store.aleo {
  struct Code {
    pt1: u128,
    pt2: u128,
    pt3: u128,
    pt4: u128,
    pt5: u128
  }
 
  record Product {
    owner: address,
    id: u64, // unique! ObjectId ?
    code: Code
  }

  transition mint(id: u64, code: Code) -> Product {
    return Product { owner: STORE_OPERATOR, id, code };
  }

  transition purchase(id: u64) {
    // somehow set self.signer as the purchaser of Product with id
  }

  transition fulfill(buyer: address, product: Product) -> Product {
    return Prodcut {
      owner: buyer,
      id: product.id,
      code: product.code
    };
  }
}

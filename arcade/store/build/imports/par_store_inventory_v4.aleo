program par_store_inventory_v4.aleo;

struct Code:
    pt1 as u128;
    pt2 as u128;
    pt3 as u128;
    pt4 as u128;
    pt5 as u128;

record Product:
    owner as address.private;
    id as u128.private;
    code as Code.private;

mapping sku_prices:
    key as u128.public;
    value as u64.public;

mapping product_ids_to_skus:
    key as u128.public;
    value as u128.public;

mapping availability:
    key as u128.public;
    value as boolean.public;

function set_sku_price:
    input r0 as u128.private;
    input r1 as u64.private;
    assert.eq self.caller aleo1raehunvfm6jvgnycefevwlhdau0577mucqg3c68vwpld2dmyyv9qhl59p4;
    async set_sku_price r0 r1 into r2;
    output r2 as par_store_inventory_v4.aleo/set_sku_price.future;

finalize set_sku_price:
    input r0 as u128.public;
    input r1 as u64.public;
    set r1 into sku_prices[r0];

function mint:
    input r0 as u128.private;
    input r1 as u128.private;
    input r2 as Code.private;
    input r3 as u64.private;
    assert.eq self.caller aleo1raehunvfm6jvgnycefevwlhdau0577mucqg3c68vwpld2dmyyv9qhl59p4;
    cast aleo1raehunvfm6jvgnycefevwlhdau0577mucqg3c68vwpld2dmyyv9qhl59p4 r0 r2 into r4 as Product.record;
    async mint r0 r1 into r5;
    output r4 as Product.record;
    output r5 as par_store_inventory_v4.aleo/mint.future;

finalize mint:
    input r0 as u128.public;
    input r1 as u128.public;
    set r1 into product_ids_to_skus[r0];
    set true into availability[r0];

function validate_purchase:
    input r0 as u128.private;
    input r1 as u64.private;
    async validate_purchase r0 r1 into r2;
    output r2 as par_store_inventory_v4.aleo/validate_purchase.future;

finalize validate_purchase:
    input r0 as u128.public;
    input r1 as u64.public;
    get.or_use availability[r0] false into r2;
    assert.eq r2 true;
    get product_ids_to_skus[r0] into r3;
    get sku_prices[r3] into r4;
    assert.eq r1 r4;
    set false into availability[r0];

function fulfill:
    input r0 as address.private;
    input r1 as Product.record;
    assert.eq r1.owner aleo1raehunvfm6jvgnycefevwlhdau0577mucqg3c68vwpld2dmyyv9qhl59p4;
    cast r0 r1.id r1.code into r2 as Product.record;
    output r2 as Product.record;

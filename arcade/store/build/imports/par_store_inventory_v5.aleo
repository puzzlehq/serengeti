program par_store_inventory_v5.aleo;

struct Code:
    pt1 as u128;
    pt2 as u128;
    pt3 as u128;
    pt4 as u128;
    pt5 as u128;

record Product:
    owner as address.private;
    sku_id as u16.private;
    code as Code.private;

mapping sku_prices:
    key as u16.public;
    value as u64.public;

mapping sku_stock:
    key as u16.public;
    value as u32.public;

function set_sku_price:
    input r0 as u16.private;
    input r1 as u64.private;
    assert.eq self.caller aleo1raehunvfm6jvgnycefevwlhdau0577mucqg3c68vwpld2dmyyv9qhl59p4;
    async set_sku_price r0 r1 into r2;
    output r2 as par_store_inventory_v5.aleo/set_sku_price.future;

finalize set_sku_price:
    input r0 as u16.public;
    input r1 as u64.public;
    set r1 into sku_prices[r0];

function mint:
    input r0 as u16.private;
    input r1 as Code.private;
    input r2 as u64.private;
    assert.eq self.caller aleo1raehunvfm6jvgnycefevwlhdau0577mucqg3c68vwpld2dmyyv9qhl59p4;
    cast aleo1raehunvfm6jvgnycefevwlhdau0577mucqg3c68vwpld2dmyyv9qhl59p4 r0 r1 into r3 as Product.record;
    async mint r0 into r4;
    output r3 as Product.record;
    output r4 as par_store_inventory_v5.aleo/mint.future;

finalize mint:
    input r0 as u16.public;
    get.or_use sku_stock[r0] 0u32 into r1;
    add r1 1u32 into r2;
    set r2 into sku_stock[r0];

function validate_purchase:
    input r0 as u16.private;
    input r1 as u64.private;
    async validate_purchase r0 r1 into r2;
    output r2 as par_store_inventory_v5.aleo/validate_purchase.future;

finalize validate_purchase:
    input r0 as u16.public;
    input r1 as u64.public;
    get.or_use sku_stock[r0] 0u32 into r2;
    gt r2 0u32 into r3;
    assert.eq r3 true;
    get sku_prices[r0] into r4;
    assert.eq r1 r4;
    sub r2 1u32 into r5;
    set r5 into sku_stock[r0];

function fulfill:
    input r0 as address.private;
    input r1 as Product.record;
    assert.eq r1.owner aleo1raehunvfm6jvgnycefevwlhdau0577mucqg3c68vwpld2dmyyv9qhl59p4;
    cast r0 r1.sku_id r1.code into r2 as Product.record;
    output r2 as Product.record;

function shutdown:
    assert.eq self.caller aleo1raehunvfm6jvgnycefevwlhdau0577mucqg3c68vwpld2dmyyv9qhl59p4;
    async shutdown into r0;
    output r0 as par_store_inventory_v5.aleo/shutdown.future;

finalize shutdown:
    remove sku_stock[0u16];
    remove sku_stock[1u16];
    remove sku_stock[2u16];
    remove sku_stock[3u16];
    remove sku_stock[4u16];
    remove sku_stock[5u16];
    remove sku_stock[6u16];
    remove sku_stock[7u16];
    remove sku_stock[8u16];
    remove sku_stock[9u16];
    remove sku_stock[10u16];
    remove sku_stock[11u16];
    remove sku_stock[12u16];
    remove sku_stock[13u16];
    remove sku_stock[14u16];
    remove sku_stock[15u16];

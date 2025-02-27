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
    assert.eq self.caller aleo1raehunvfm6jvgnycefevwlhdau0577mucqg3c68vwpld2dmyyv9qhl59p4;
    cast aleo1raehunvfm6jvgnycefevwlhdau0577mucqg3c68vwpld2dmyyv9qhl59p4 r0 r1 into r2 as Product.record;
    async mint r0 into r3;
    output r2 as Product.record;
    output r3 as par_store_inventory_v5.aleo/mint.future;

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
    input r0 as [u16; 8u32].private;
    assert.eq self.caller aleo1raehunvfm6jvgnycefevwlhdau0577mucqg3c68vwpld2dmyyv9qhl59p4;
    async shutdown r0 into r1;
    output r1 as par_store_inventory_v5.aleo/shutdown.future;

finalize shutdown:
    input r0 as [u16; 8u32].public;
    is.neq r0[0u32] 0u16 into r1;
    branch.eq r1 false to end_then_0_0;
    remove sku_stock[r0[0u32]];
    remove sku_prices[r0[0u32]];
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    position end_otherwise_0_1;
    is.neq r0[1u32] 0u16 into r2;
    branch.eq r2 false to end_then_0_2;
    remove sku_stock[r0[1u32]];
    remove sku_prices[r0[1u32]];
    branch.eq true true to end_otherwise_0_3;
    position end_then_0_2;
    position end_otherwise_0_3;
    is.neq r0[2u32] 0u16 into r3;
    branch.eq r3 false to end_then_0_4;
    remove sku_stock[r0[2u32]];
    remove sku_prices[r0[2u32]];
    branch.eq true true to end_otherwise_0_5;
    position end_then_0_4;
    position end_otherwise_0_5;
    is.neq r0[3u32] 0u16 into r4;
    branch.eq r4 false to end_then_0_6;
    remove sku_stock[r0[3u32]];
    remove sku_prices[r0[3u32]];
    branch.eq true true to end_otherwise_0_7;
    position end_then_0_6;
    position end_otherwise_0_7;
    is.neq r0[4u32] 0u16 into r5;
    branch.eq r5 false to end_then_0_8;
    remove sku_stock[r0[4u32]];
    remove sku_prices[r0[4u32]];
    branch.eq true true to end_otherwise_0_9;
    position end_then_0_8;
    position end_otherwise_0_9;
    is.neq r0[5u32] 0u16 into r6;
    branch.eq r6 false to end_then_0_10;
    remove sku_stock[r0[5u32]];
    remove sku_prices[r0[5u32]];
    branch.eq true true to end_otherwise_0_11;
    position end_then_0_10;
    position end_otherwise_0_11;
    is.neq r0[6u32] 0u16 into r7;
    branch.eq r7 false to end_then_0_12;
    remove sku_stock[r0[6u32]];
    remove sku_prices[r0[6u32]];
    branch.eq true true to end_otherwise_0_13;
    position end_then_0_12;
    position end_otherwise_0_13;

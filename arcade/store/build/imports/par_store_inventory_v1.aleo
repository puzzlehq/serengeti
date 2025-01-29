program par_store_inventory_v1.aleo;

struct Code:
    pt1 as u128;
    pt2 as u128;
    pt3 as u128;
    pt4 as u128;
    pt5 as u128;

record Product:
    owner as address.private;
    id as u64.private;
    code as Code.private;
    price as u64.private;

function mint:
    input r0 as u64.private;
    input r1 as Code.private;
    input r2 as u64.private;
    assert.eq self.caller aleo1raehunvfm6jvgnycefevwlhdau0577mucqg3c68vwpld2dmyyv9qhl59p4 ;
    cast aleo1raehunvfm6jvgnycefevwlhdau0577mucqg3c68vwpld2dmyyv9qhl59p4 r0 r1 r2 into r3 as Product.record;
    output r3 as Product.record;

function fulfill:
    input r0 as address.private;
    input r1 as Product.record;
    assert.eq r1.owner aleo1raehunvfm6jvgnycefevwlhdau0577mucqg3c68vwpld2dmyyv9qhl59p4 ;
    cast r0 r1.id r1.code r1.price into r2 as Product.record;
    output r2 as Product.record;

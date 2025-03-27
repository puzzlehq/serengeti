program squash_timestamp.aleo;

record Timestamp:
    owner as address.private;
    time as u64.private;

function mint:
    input r0 as u64.public;
    assert.eq self.caller aleo12e0yyyqw0lfff8nufdss94k5hml9d9jl45rlfwu5l3e73wpu9s8sdznsev ;
    cast aleo12e0yyyqw0lfff8nufdss94k5hml9d9jl45rlfwu5l3e73wpu9s8sdznsev r0 into r1 as Timestamp.record;
    output r1 as Timestamp.record;

function update:
    input r0 as Timestamp.record;
    input r1 as u64.public;
    cast aleo12e0yyyqw0lfff8nufdss94k5hml9d9jl45rlfwu5l3e73wpu9s8sdznsev r1 into r2 as Timestamp.record;
    output r2 as Timestamp.record;

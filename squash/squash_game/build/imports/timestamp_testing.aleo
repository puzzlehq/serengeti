program timestamp_testing.aleo;

record Timestamp:
    owner as address.private;
    time as u64.private;

function mint:
    input r0 as u64.public;
    cast aleo18xacl585anaqc06320r3yw8yjx9u3278l7vlrjj7nkpznz667gxq3kr2ev r0 into r1 as Timestamp.record;
    output r1 as Timestamp.record;

function update:
    input r0 as Timestamp.record;
    input r1 as u64.public;
    cast aleo18xacl585anaqc06320r3yw8yjx9u3278l7vlrjj7nkpznz667gxq3kr2ev r1 into r2 as Timestamp.record;
    output r2 as Timestamp.record;

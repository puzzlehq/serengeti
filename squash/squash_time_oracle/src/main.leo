program squash_time_oracle.aleo {
  const OPERATOR: address = aleo18xacl585anaqc06320r3yw8yjx9u3278l7vlrjj7nkpznz667gxq3kr2ev;

  record Timestamp {
    owner: address,
    time: u64
  }

  transition mint (public time: u64) -> Timestamp {
    assert_eq(self.caller, OPERATOR);
    return Timestamp {
      owner: OPERATOR,
      time
    };
  }

  transition update(timestamp: Timestamp, public new_time: u64) -> Timestamp {
    return Timestamp {
      owner: OPERATOR,
      time: new_time
    };
  }
}

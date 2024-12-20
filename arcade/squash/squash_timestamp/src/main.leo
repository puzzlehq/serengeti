program squash_timestamp.aleo {
  const OPERATOR: address = aleo12e0yyyqw0lfff8nufdss94k5hml9d9jl45rlfwu5l3e73wpu9s8sdznsev;

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

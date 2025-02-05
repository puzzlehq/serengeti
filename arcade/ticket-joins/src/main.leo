import puzzle_arcade_ticket_v001.aleo;

program par_ticket_joins_v1.aleo {
  async transition join6(
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket3: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket4: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket5: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket6: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket, Future) {
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, ticket1.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket2, ticket2.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket3, ticket3.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket4, ticket4.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket5, ticket5.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket6, ticket6.amount);

    let (joined, future): (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket, Future) = puzzle_arcade_ticket_v001.aleo/mint(
      self.signer,
      ticket1.amount
      + ticket2.amount
      + ticket3.amount
      + ticket4.amount
      + ticket5.amount
      + ticket6.amount
    );

    return (joined, finalize_join6(future));
  }
  async function finalize_join6(future: Future) {
    future.await();
  }

  async transition join7(
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket3: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket4: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket5: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket6: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket7: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket, Future) {
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, ticket1.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket2, ticket2.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket3, ticket3.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket4, ticket4.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket5, ticket5.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket6, ticket6.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket7, ticket7.amount);

    let (joined, future): (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket, Future) = puzzle_arcade_ticket_v001.aleo/mint(
      self.signer,
      ticket1.amount
      + ticket2.amount
      + ticket3.amount
      + ticket4.amount
      + ticket5.amount
      + ticket6.amount
      + ticket7.amount
    );

    return (joined, finalize_join7(future));
  }
  async function finalize_join7(future: Future) {
    future.await();
  }

  async transition join8(
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket3: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket4: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket5: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket6: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket7: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket8: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket, Future) {
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, ticket1.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket2, ticket2.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket3, ticket3.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket4, ticket4.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket5, ticket5.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket6, ticket6.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket7, ticket7.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket8, ticket8.amount);

    let (joined, future): (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket, Future) = puzzle_arcade_ticket_v001.aleo/mint(
      self.signer,
      ticket1.amount
      + ticket2.amount
      + ticket3.amount
      + ticket4.amount
      + ticket5.amount
      + ticket6.amount
      + ticket7.amount
      + ticket8.amount
    );

    return (joined, finalize_join8(future));
  }
  async function finalize_join8(future: Future) {
    future.await();
  }

  async transition join9(
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket3: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket4: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket5: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket6: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket7: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket8: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket9: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket, Future) {
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, ticket1.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket2, ticket2.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket3, ticket3.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket4, ticket4.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket5, ticket5.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket6, ticket6.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket7, ticket7.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket8, ticket8.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket9, ticket9.amount);

    let (joined, future): (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket, Future) = puzzle_arcade_ticket_v001.aleo/mint(
      self.signer,
      ticket1.amount
      + ticket2.amount
      + ticket3.amount
      + ticket4.amount
      + ticket5.amount
      + ticket6.amount
      + ticket7.amount
      + ticket8.amount
      + ticket9.amount
    );

    return (joined, finalize_join9(future));
  }
  async function finalize_join9(future: Future) {
    future.await();
  }

  async transition join10(
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket3: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket4: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket5: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket6: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket7: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket8: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket9: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket10: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket, Future) {
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, ticket1.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket2, ticket2.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket3, ticket3.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket4, ticket4.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket5, ticket5.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket6, ticket6.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket7, ticket7.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket8, ticket8.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket9, ticket9.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket10, ticket10.amount);

    let (joined, future): (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket, Future) = puzzle_arcade_ticket_v001.aleo/mint(
      self.signer,
      ticket1.amount
      + ticket2.amount
      + ticket3.amount
      + ticket4.amount
      + ticket5.amount
      + ticket6.amount
      + ticket7.amount
      + ticket8.amount
      + ticket9.amount
      + ticket10.amount
    );

    return (joined, finalize_join10(future));
  }
  async function finalize_join10(future: Future) {
    future.await();
  }

  async transition join11(
    ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket3: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket4: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket5: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket6: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket7: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket8: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket9: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket10: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
    ticket11: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket
  ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket, Future) {
    puzzle_arcade_ticket_v001.aleo/spend(ticket1, ticket1.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket2, ticket2.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket3, ticket3.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket4, ticket4.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket5, ticket5.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket6, ticket6.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket7, ticket7.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket8, ticket8.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket9, ticket9.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket10, ticket10.amount);
    puzzle_arcade_ticket_v001.aleo/spend(ticket11, ticket11.amount);

    let (joined, future): (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket, Future) = puzzle_arcade_ticket_v001.aleo/mint(
      self.signer,
      ticket1.amount
      + ticket2.amount
      + ticket3.amount
      + ticket4.amount
      + ticket5.amount
      + ticket6.amount
      + ticket7.amount
      + ticket8.amount
      + ticket9.amount
      + ticket10.amount
      + ticket11.amount
    );

    return (joined, finalize_join11(future));
  }
  async function finalize_join11(future: Future) {
    future.await();
  }

  // async transition join12(
  //   ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
  //   ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
  //   ticket3: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
  //   ticket4: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
  //   ticket5: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
  //   ticket6: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
  //   ticket7: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
  //   ticket8: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
  //   ticket9: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
  //   ticket10: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
  //   ticket11: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
  //   ticket12: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket
  // ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket, Future) {
  //   puzzle_arcade_ticket_v001.aleo/spend(ticket1, ticket1.amount);
  //   puzzle_arcade_ticket_v001.aleo/spend(ticket2, ticket2.amount);
  //   puzzle_arcade_ticket_v001.aleo/spend(ticket3, ticket3.amount);
  //   puzzle_arcade_ticket_v001.aleo/spend(ticket4, ticket4.amount);
  //   puzzle_arcade_ticket_v001.aleo/spend(ticket5, ticket5.amount);
  //   puzzle_arcade_ticket_v001.aleo/spend(ticket6, ticket6.amount);
  //   puzzle_arcade_ticket_v001.aleo/spend(ticket7, ticket7.amount);
  //   puzzle_arcade_ticket_v001.aleo/spend(ticket8, ticket8.amount);
  //   puzzle_arcade_ticket_v001.aleo/spend(ticket9, ticket9.amount);
  //   puzzle_arcade_ticket_v001.aleo/spend(ticket10, ticket10.amount);
  //   puzzle_arcade_ticket_v001.aleo/spend(ticket11, ticket11.amount);
  //   puzzle_arcade_ticket_v001.aleo/spend(ticket12, ticket12.amount);

  //   let (joined, future): (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket, Future) = puzzle_arcade_ticket_v001.aleo/mint(
  //     self.signer,
  //     ticket1.amount
  //     + ticket2.amount
  //     + ticket3.amount
  //     + ticket4.amount
  //     + ticket5.amount
  //     + ticket6.amount
  //     + ticket7.amount
  //     + ticket8.amount
  //     + ticket9.amount
  //     + ticket10.amount
  //     + ticket11.amount
  //     + ticket12.amount
  //   );

  //   return (joined, finalize_join12(future));
  // }
  // async function finalize_join12(future: Future) {
  //   future.await();
  // }

  // async transition join13(
  //   ticket1: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
  //   ticket2: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
  //   ticket3: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
  //   ticket4: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
  //   ticket5: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
  //   ticket6: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
  //   ticket7: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
  //   ticket8: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
  //   ticket9: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
  //   ticket10: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
  //   ticket11: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
  //   ticket12: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket,
  //   ticket13: puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket
  // ) -> (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket, Future) {
  //   puzzle_arcade_ticket_v001.aleo/spend(ticket1, ticket1.amount);
  //   puzzle_arcade_ticket_v001.aleo/spend(ticket2, ticket2.amount);
  //   puzzle_arcade_ticket_v001.aleo/spend(ticket3, ticket3.amount);
  //   puzzle_arcade_ticket_v001.aleo/spend(ticket4, ticket4.amount);
  //   puzzle_arcade_ticket_v001.aleo/spend(ticket5, ticket5.amount);
  //   puzzle_arcade_ticket_v001.aleo/spend(ticket6, ticket6.amount);
  //   puzzle_arcade_ticket_v001.aleo/spend(ticket7, ticket7.amount);
  //   puzzle_arcade_ticket_v001.aleo/spend(ticket8, ticket8.amount);
  //   puzzle_arcade_ticket_v001.aleo/spend(ticket9, ticket9.amount);
  //   puzzle_arcade_ticket_v001.aleo/spend(ticket10, ticket10.amount);
  //   puzzle_arcade_ticket_v001.aleo/spend(ticket11, ticket11.amount);
  //   puzzle_arcade_ticket_v001.aleo/spend(ticket12, ticket12.amount);
  //   puzzle_arcade_ticket_v001.aleo/spend(ticket13, ticket13.amount);

  //   let (joined, future): (puzzle_arcade_ticket_v001.aleo/PuzzleArcadeTicket, Future) = puzzle_arcade_ticket_v001.aleo/mint(
  //     self.signer,
  //     ticket1.amount
  //     + ticket2.amount
  //     + ticket3.amount
  //     + ticket4.amount
  //     + ticket5.amount
  //     + ticket6.amount
  //     + ticket7.amount
  //     + ticket8.amount
  //     + ticket9.amount
  //     + ticket10.amount
  //     + ticket11.amount
  //     + ticket12.amount
  //     + ticket13.amount
  //   );

  //   return (joined, finalize_join13(future));
  // }
  // async function finalize_join13(future: Future) {
  //   future.await();
  // }
}

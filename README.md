# wheres_alex_v001.aleo

The first 1v1 game on Aleo where the entire game is private to the world!

Challenge another address on Aleo to guess where you hid Alex and if they guess wrong, then you win!

<img width="1473" alt="image" src="https://github.com/puzzlehq/serengeti/assets/39972641/558600ef-7bec-4112-a081-c8b69ad9e64f">

# Where's Alex & showcases how to solve issues in multiparty privacy

## Defining Multiparty Privacy
Multiparty privacy is a broad category

One category of multiparty privacy is n:1 is like a company's bank account
You want to keep the account balance and action private to everyone outside of the _n_ people in the bank account.
A company's bank account is multiparty and private -- _n_ people have ability to view/share an account and it requires _t_ approvals to do an action on one account.


Another category of multiparty privacy is 1:1 is like a game like Guess Who?
The game is multiparty and may/may not be private to others outside of the two players, but each player wants to keep certain information private from everyone else. 
![image](https://github.com/puzzlehq/serengeti/assets/39972641/cf60c961-a96f-4814-8a6c-d1d9573c1f16)

## The main issues with multiparty privacy
Multiparty privacy suffers from 3 problems
1. Guarantees on privacy of data
2. Guarantees on routing of information between parties
3. Multiparty computation attacks: timeout and denial of service

We can understand these problems specifically by looking at a game of online poker in web2.
![image](https://github.com/puzzlehq/serengeti/assets/39972641/01ceabd7-abb1-41bb-ba2f-773e3b6be0d5)

1. Guarantees on privacy of data
The terms of service, the auditing by government, and the enforcement of law on that online poker business by the company's operating jurisdiction is the only guarantee you get that your hand is private to other players and the dealer to make sure the game is fair.

The most common complaint of online poker is that the game is rigged because other players can see your cards somehow to know to increase wager or fold.

2. Guarantees on routing of information between parties
The terms of service, the auditing by government, and the enforcement of law on that online poker business by the company's operating jurisdiction is the only guarantee you get that your actions to up a bet, match wager, or fold is actually carried out.

Another common complaint of online poker is that the game lags or fails to record your action and folds your hand or matches your wager when you didn't want it to.

3. Multiparty computation attacks: timeout and denial of service
These attacks currently have no mitigation
- if the online poker site shuts down, then you have no mitigation
- if the opponent rage quits, then you have no mitigation

These are the last most common complaints of an online poker game -- opponents will rage quit or the online poker service may fail/shut down mid game.


## How Where's Alex solves the issues with multiparty privacy
1. Guarantees on privacy of data
In private/public ZKP blockchains like Aleo, your data is guaranteed to be private to other players in the game as long as they don't have your private keys and that the smart contract/program functions don't reveal your data to others.

This alleviates the concern that the game is rigged because you have guarantees your information is hidden and can verify yourself.

2. Guarantees on routing of information between parties
Puzzle's SDK has operations to CreateSharedState and ImportSharedState that work with Puzzle Wallet to create multisig keys and import multisig keys for generating a place to send information to parties in a game.
In private/public ZKP blockchains like Aleo, your information is recorded onchain and guaranteed to be available to anyone that runs or communicates with a node.
Additionally, Puzzle wallet makes it easy for you to find your game state that's recorded on chain.

This alleviates the concern that your actions will be carried out and reach the other parties -- you can verify that it has been processed on chain.

3. Multiparty computation attacks: timeout and denial of service
The secret sauce of Where's Alex is solving the rage-quit or denial of service problem with incentive engineering.

This is done by forcing a challenger to commit a wager to a 2/2 multisig between the challenger & opponent when proposing a game.
Once the opponent accepts the game and submits their guess -- the challenger's wager is locked and will be lost if the challenger rage quits or never reveals the answer.
Importantly -- thanks to programmability of the multisig -- there are exit routes the challenger can take to retrieve their funds from the multisig if the opponent rejects or never responds so it's not stuck at the beginning as well.


# Walking through the where's alex program step-by-step

## High level overview of where's alex program
<img width="792" alt="image" src="https://github.com/puzzlehq/serengeti/assets/39972641/b5c0f35c-a91f-4b9d-a233-3191ddbc8265">


NOTE: Different function executions require different keys (player 1, player 2, multisig keys). For testing purposes, you can run the below to switch execution keys.

We also have a `test.sh` script [here](./wheres_alex_vXXX/test.sh) that runs through all the flows.

```
echo "
NETWORK=testnet3
PRIVATE_KEY={MS_PK || P1_PK | P2_PK}
" > .env
```

## Steps

### Step 1: challenger calls propose_game
<img width="917" alt="image" src="https://github.com/puzzlehq/serengeti/assets/39972641/70ebabdf-eab9-4c5e-ad69-e5eb0fa4f462">


`propose_game` to create a game with a friend.

This will involve creating a 2/2 multisig and staking funds to the private 2/2 multisig between the challenger and their opponent for the game (solving problem #3 mentioned above).

Function:
```rust
propose_game(
  wager_record: puzzle_token.leo/Puzz.record,
  amount: u64,
  sender: address, // Challenger address proposing game
  challenger: address,
  opponent: address,
  game_multisig: address,
  message_1: field, //from output of useSignature
  message_2: field,
  message_3: field,
  message_4: field,
  message_5: field,
  sig: signature, //from output of useSignature
  //multiparty_pvp_utils data
  nonce: field,
  answer: field,
  seed: field,
)
```

Example Command:
```
leo run propose_game "{
        owner: aleo16hf8hfpwasnn9cf7k2c0dllc56nn7qt547qxgvgwu6pznw4trvqsx68kls.private,
        amount: 500u64.private,
        ix: 0u32.private,
        _nonce: 5117772722354704202838157764917930913180509833961648133377098024993045952079group.public
    }" 100u64 aleo16hf8hfpwasnn9cf7k2c0dllc56nn7qt547qxgvgwu6pznw4trvqsx68kls aleo16hf8hfpwasnn9cf7k2c0dllc56nn7qt547qxgvgwu6pznw4trvqsx68kls aleo1r4pc6ufjvw050jhzrew3vqm2lvacdxfd4a5ckulau0vjc72qvc8sr0jg2a aleo1asu88azw3uqud282sll23wh3tvmvwjdz5vhvu2jwyrdwtgqn5qgqetuvr6 8062328565641143710315198539395259864274213782537700083868207132716559019626field 646976134778083579747150617209623060175268802563807996500102649727939562470field 7738966642647861988443742254957166327730088714215632067055062293849087980027field 501202936879316583063216806269060512965140130553350448375465909870676136661field 478560413032field sign1h04lnsl0t4aau8lzp06rzcm5eqrzr9ew63ljnw43v2nr7nkmsqqcx8cksna2ajwgk80rv0s7prrndw5k56sey3nrl487552lvaukuq8xe0cgu6x809qetnn35ufm3gl6ecyvtpgaavu9y5754j27utrwq8amruqyq2x6dvqs790yqsrctwmjnh3k7thslm0r9c3hpdvjrywpzts24xr 12345field 0field 98765field
```
<!-- ### player_one_renege_proposal

`propose_game` to create a game with a friend.

Function:
```rust
player_one_renege_proposal(
    private game_record: Game,
    private ms_rules: puzzle_account.leo/OwnerRules.record,
    private token_owner_rules: puzzle_token.leo/TokenOwnerRules.record,
    private player_one_claim_record: puzzle_token.leo/PuzzClaim.record,
    private puzz_record: puzzle_token.leo/Puzz.record,
    private amount: u64,
    private sig: signature, // player 1 sig
    private msg: field, // msg generated on propose_game with nonce
)
``` -->

### Step 2: opponent starts to accept game by calling submit_wager()

<img width="1001" alt="image" src="https://github.com/puzzlehq/serengeti/assets/39972641/6d2b5126-7c3d-4dd4-837b-629809d428a2">


`submit_wager` to create a game with a friend.

Function:
```rust
submit_wager(
  game_address: address,
  opponent: address,
  wager: puzzle_token.leo/Puzz.record,
  wager_amount: u64,
  nonce: field,
  msg: field,
  sig: signature,
)
```

```
leo run submit_wager "{
  owner: aleo1r4pc6ufjvw050jhzrew3vqm2lvacdxfd4a5ckulau0vjc72qvc8sr0jg2a.private,
  amount: 500u64.private,
  ix: 0u32.private,
  _nonce: 3004940205258698961047675300612628178407977124226246568871909567528102781306group.public
}" "{
  owner: aleo1r4pc6ufjvw050jhzrew3vqm2lvacdxfd4a5ckulau0vjc72qvc8sr0jg2a.private,
  seed: 98765field.private,
  amount: 100u64.private,
  challenger: aleo16hf8hfpwasnn9cf7k2c0dllc56nn7qt547qxgvgwu6pznw4trvqsx68kls.private,
  opponent: aleo1r4pc6ufjvw050jhzrew3vqm2lvacdxfd4a5ckulau0vjc72qvc8sr0jg2a.private,
  game_multisig: aleo1asu88azw3uqud282sll23wh3tvmvwjdz5vhvu2jwyrdwtgqn5qgqetuvr6.private,
  _nonce: 614304942627494924156540954346562345174322008762458420667361217491279792987group.public
}" "{
  owner: aleo1r4pc6ufjvw050jhzrew3vqm2lvacdxfd4a5ckulau0vjc72qvc8sr0jg2a.private,
  game_multisig: aleo1asu88azw3uqud282sll23wh3tvmvwjdz5vhvu2jwyrdwtgqn5qgqetuvr6.private,
  game_state: 1field.private,
  your_turn: true.private,
  total_pot: 200u64.private,
  challenger_address: aleo16hf8hfpwasnn9cf7k2c0dllc56nn7qt547qxgvgwu6pznw4trvqsx68kls.private,
  opponent_address: aleo1r4pc6ufjvw050jhzrew3vqm2lvacdxfd4a5ckulau0vjc72qvc8sr0jg2a.private,
  _nonce: 5007203806498158254911228558413488930295100188486359169745660062379448997833group.public
}" 4299148155668445410404796665478412871867472362428312345599969289162437917169field 251561861986387641133995513088278466362266230978294643355666629668300490271field 1152742118437172617676919179607096353215168002720611159713055309066048881777field 6965356107999508170054292104522311809055538516545196583411503498743541220125field 478560413032field sign1j0hhruukxrlddx4tzzpe8gccgy3l430el69e0jpclrzk2x3kecpq7zteu9z5qqqttk4xltyplgwzt4famkfxar5wjncz5ttssdur2qslse2uz49ljzhxz82y28gy0un45z8w2jgwk7jhdgxqh58qgcvwqpcuf9estpjsv9n9jln3x08mzl2rc8z25j6s6r4uf8rq9r7ddkxqyaahcxh
```

<!-- ### player_two_renege_proposal

Function:
```rust
player_two_renege_proposal (
    private game_record: Game,
    private puzz_record: puzzle_token.leo/Puzz.record,
    private amount: u64,
)
```

```
leo run player_two_renege_proposal "{
  owner: aleo1eqkje8cvr0twm07w4m5n356pju7njtfx75xp5zzvpg8yhgrnr58snq9kyu.private,
  player_one_comm: 5722488078224404519904990561561967723774900188856745391253581068668871700882field.private,
  player_two_answer: 1field.private,
  total_pot: 1u64.private,
  player_one_address: aleo1ml2xr6fawppd6uaf8gn95uy2fpqqg8gk74k0lu8na7uvayk64v8qu8hw5u.private,
  player_two_address: aleo1muq22xpnzgaeqez0mgkdcau6kcjpk6ztey0u8yv34zcupk3hpczsmxeaww.private,
  game_state: 0field.private,
  _nonce: 1296315430263074257232864498293672966286835343348148902391724199988062350962group.public
}" "{
  owner: aleo1eqkje8cvr0twm07w4m5n356pju7njtfx75xp5zzvpg8yhgrnr58snq9kyu.private,
  amount: 1u64.private,
  _nonce: 4523450399236952519907142286677160238720523714834464784249135179526188829220group.public
}" 1u64
``` -->

### Step 3: multisig key used to lock wagers in accept_game()
```rust
accept_game (
  game_record: Game,
  opponent_answer: field,
  piece_stake_challenger: puzzle_pieces_v007.leo/PieceStake.record,
  piece_claim_challenger: puzzle_pieces_v007.leo/PieceClaim.record,
  piece_stake_opponent: puzzle_pieces_v007.leo/PieceStake.record,
  piece_claim_opponent: puzzle_pieces_v007.leo/PieceClaim.record,
  block_ht: u32,
)
```

<!-- ```
leo run accept_game "{
  owner: aleo1eqkje8cvr0twm07w4m5n356pju7njtfx75xp5zzvpg8yhgrnr58snq9kyu.private,
  player_one_comm: 5722488078224404519904990561561967723774900188856745391253581068668871700882field.private,
  player_two_answer: 1field.private,
  total_pot: 1u64.private,
  player_one_address: aleo1ml2xr6fawppd6uaf8gn95uy2fpqqg8gk74k0lu8na7uvayk64v8qu8hw5u.private,
  player_two_address: aleo1muq22xpnzgaeqez0mgkdcau6kcjpk6ztey0u8yv34zcupk3hpczsmxeaww.private,
  game_state: 0field.private,
  _nonce: 1296315430263074257232864498293672966286835343348148902391724199988062350962group.public
}" 1field
``` -->

### reveal_answer

`reveal_answer` to reveal answer record to prove player 1 won or lost.

Function:
```rust
reveal_answer(
  reveal_answer_notification_record: RevealAnswerNotification,
  answer_record: multiparty_pvp_utils_v001.leo/Answer.record,
  joint_piece_state: puzzle_pieces_v007.leo/JointPieceState.record,
  claim_signature: puzzle_pieces_v007.leo/ClaimSignature.record,
  sig: signature
)
```

<!-- Example Command:
(current version immediately below):
```
leo run reveal_answer "{                                                                         system
  owner: aleo1ml2xr6fawppd6uaf8gn95uy2fpqqg8gk74k0lu8na7uvayk64v8qu8hw5u.private,
  game_address: aleo1eqkje8cvr0twm07w4m5n356pju7njtfx75xp5zzvpg8yhgrnr58snq9kyu.private,
  nonce: 1field.private,
  answer: 1field.private,
  _nonce: 7009801456707050578336701579084302465418736038255959066582797292369873303448group.public
}" aleo1eqkje8cvr0twm07w4m5n356pju7njtfx75xp5zzvpg8yhgrnr58snq9kyu aleo1muq22xpnzgaeqez0mgkdcau6kcjpk6ztey0u8yv34zcupk3hpczsmxeaww
```

(later version):
```
leo run reveal_answer "{
  owner: aleo1ml2xr6fawppd6uaf8gn95uy2fpqqg8gk74k0lu8na7uvayk64v8qu8hw5u.private,
  game_address: aleo1eqkje8cvr0twm07w4m5n356pju7njtfx75xp5zzvpg8yhgrnr58snq9kyu.private,
  nonce: 1field.private,
  answer: 1field.private,
  _nonce: 3758214225201963159322315890422876208404622381900552146703962096804019801163group.public
}" aleo1eqkje8cvr0twm07w4m5n356pju7njtfx75xp5zzvpg8yhgrnr58snq9kyu aleo1muq22xpnzgaeqez0mgkdcau6kcjpk6ztey0u8yv34zcupk3hpczsmxeaww
``` -->

### finish_game

`finish_game` to finish game

Function:
```rust
finish_game (
  game_record: Game,
  joint_piece_winner: puzzle_pieces_v007.leo/JointPieceWinner.record,
  piece_joint_stake: puzzle_pieces_v007.leo/PieceJointStake.record,
  joint_piece_time_claim: puzzle_pieces_v007.leo/JointPieceTimeClaim.record,
)
```

<!-- ```
leo run finish_game "{                                                                           system
  owner: aleo1eqkje8cvr0twm07w4m5n356pju7njtfx75xp5zzvpg8yhgrnr58snq9kyu.private,
  player_one_comm: 5722488078224404519904990561561967723774900188856745391253581068668871700882field.private,
  player_two_answer: 1field.private,
  total_pot: 1u64.private,
  player_one_address: aleo1ml2xr6fawppd6uaf8gn95uy2fpqqg8gk74k0lu8na7uvayk64v8qu8hw5u.private,
  player_two_address: aleo1muq22xpnzgaeqez0mgkdcau6kcjpk6ztey0u8yv34zcupk3hpczsmxeaww.private,
  game_state: 1field.private,
  _nonce: 3553610906097706365741456401130919249613155723801620547652734147524726606202group.public
}" "{
  owner: aleo1eqkje8cvr0twm07w4m5n356pju7njtfx75xp5zzvpg8yhgrnr58snq9kyu.private,
  answer: 1field.private,
  nonce: 1field.private,
  _nonce: 4664029747950624586742729197884948830947232283053549771820864082582580731401group.public
}" "{
  owner: aleo1eqkje8cvr0twm07w4m5n356pju7njtfx75xp5zzvpg8yhgrnr58snq9kyu.private,
  amount: 2u64.private,
  _nonce: 4523450399236952519907142286677160238720523714834464784249135179526188829220group.public
}"
``` -->

<!-- ### claim_total_pot

`claim_total_pot` to claim total pot (if p1 does not reveal answer)

Function:
```rust
claim_total_pot (
    private game_record: Game,
    private revealed_answer_record: RevealedAnswer,
    private puzz_record: puzzle_token.leo/Puzz.record,
)
```


```
leo run claim_total_pot "{                                                                       system
  owner: aleo1eqkje8cvr0twm07w4m5n356pju7njtfx75xp5zzvpg8yhgrnr58snq9kyu.private,
  player_one_comm: 5722488078224404519904990561561967723774900188856745391253581068668871700882field.private,
  player_two_answer: 1field.private,
  total_pot: 1u64.private,
  player_one_address: aleo1ml2xr6fawppd6uaf8gn95uy2fpqqg8gk74k0lu8na7uvayk64v8qu8hw5u.private,
  player_two_address: aleo1muq22xpnzgaeqez0mgkdcau6kcjpk6ztey0u8yv34zcupk3hpczsmxeaww.private,
  game_state: 1field.private,
  _nonce: 3553610906097706365741456401130919249613155723801620547652734147524726606202group.public
}" "{
  owner: aleo1eqkje8cvr0twm07w4m5n356pju7njtfx75xp5zzvpg8yhgrnr58snq9kyu.private,
  answer: 1field.private,
  nonce: 1field.private,
  _nonce: 4664029747950624586742729197884948830947232283053549771820864082582580731401group.public
}" "{
  owner: aleo1eqkje8cvr0twm07w4m5n356pju7njtfx75xp5zzvpg8yhgrnr58snq9kyu.private,
  amount: 2u64.private,
  _nonce: 4523450399236952519907142286677160238720523714834464784249135179526188829220group.public
}"
``` -->

# puzzle_pieces_v001.aleo

## Functions

### stake_transfer_in

`stake_transfer_in` to stake piece token into a game multisig/shared account.

Function:
```rust
stake_transfer_in(
  piece_token: Piece,
  sender: address,
  challenger: address,
  opponent: address,
  game_multisig: address,
  amount: u64,
  message_1: field,
  message_2: field,
  message_3: field,
  message_4: field,
  message_5: field,
  sig: signature,
)
```

### stake_transfer_out

`stake_transfer_out` to stake piece token out of a game multisig/shared account.

Function:
```rust
stake_transfer_out(
  piece_stake: PieceStake,
  piece_claim: PieceClaim,
  sig: signature,
)
```

## transfer_stakes_to_joint

`transfer_stakes_to_joint` to jointly stake piece token into the game multisig/shared account.

Function:
```rust
transfer_stakes_to_joint (
  piece_stake_challenger: PieceStake,
  piece_claim_challenger: PieceClaim,
  piece_stake_opponent: PieceStake,
  piece_claim_opponent: PieceClaim,
  block_ht: u32,
)
```

### joint_stake_state_update

`joint_stake_state_update` called by challenger to reveal answer in where's alex game

Function:
```rust
joint_stake_state_update(
  reveal_answer_notification_record: RevealAnswerNotification,
  answer_record: multiparty_pvp_utils_v001.leo/Answer.record,
  joint_piece_state: puzzle_pieces_v007.leo/JointPieceState.record,
  claim_signature: puzzle_pieces_v007.leo/ClaimSignature.record,
  sig: signature,
)
```


### joint_stake_transfer_to_winner

`joint_stake_transfer_to_winner` called by anyone with multisig key to end the game and transfer the pieces to the winner

Function:
```rust
joint_stake_transfer_to_winner (
  joint_piece_winner: JointPieceWinner,
  piece_joint_stake: PieceJointStake,
  joint_piece_time_claim: JointPieceTimeClaim,
)
```


# multiparty_pvp_utils_v001.aleo

## Functions

### stake_transfer_in

`mint_answer` mints answer record on propose_game, verifies a signature by the challenger

Function:
```rust
mint_answer(
  piece_token: Piece,
  sender: address,
  challenger: address,
  opponent: address,
  game_multisig: address,
  amount: u64,
  message_1: field,
  message_2: field,
  message_3: field,
  message_4: field,
  message_5: field,
  sig: signature,
)
```

### mint_multisig_key

`mint_multisig_key` to mint the multisig key record with a seed

Function:
```rust
mint_multisig_key(
  seed: field,
  amount: u64,
  challenger: address,
  opponent: address,
  game_multisig: address,
)
```

## reveal_answer

`reveal_answer` called by challenger to reveal the original answer to verify there was no cheating involved

Function:
```rust
reveal_answer (
  answer: Answer,
  sig: signature,
)
```


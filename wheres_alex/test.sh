challenger_pk="APrivateKey1zkp9p8bttYsy3EuwiGrb4PXmrtjzZkpGvBCGVCgvpcwVjUV"
challenger_address="aleo16hf8hfpwasnn9cf7k2c0dllc56nn7qt547qxgvgwu6pznw4trvqsx68kls"
challenger_answer="0u8"
challenger_wager_record="{owner:aleo16hf8hfpwasnn9cf7k2c0dllc56nn7qt547qxgvgwu6pznw4trvqsx68kls.private,amount:1000000u64.private,_nonce:5117772722354704202838157764917930913180509833961648133377098024993045952079group.public}"
wager="1000000u64"

opponent_pk="APrivateKey1zkpALDDK4zAigs387emvnuxWXvGjFw2AmmYcQH7TBt8nhof"
opponent_address="aleo1r4pc6ufjvw050jhzrew3vqm2lvacdxfd4a5ckulau0vjc72qvc8sr0jg2a"
opponent_wager_record="{owner:aleo1r4pc6ufjvw050jhzrew3vqm2lvacdxfd4a5ckulau0vjc72qvc8sr0jg2a.private,amount:1000000u64.private,_nonce:3004940205258698961047675300612628178407977124226246568871909567528102781306group.public}"
opponent_guess="0u8"

multisig_pk="APrivateKey1zkp8pmTMT4FxG5qXZ9McEYDdY1G6YokY1BYzwoxTYJEKubF"
multisig_address="aleo1asu88azw3uqud282sll23wh3tvmvwjdz5vhvu2jwyrdwtgqn5qgqetuvr6"
multisig_seed="1087553608931403204786147037030246934976831393046204745890089459296069094887field"

block_height="100000u32"

extract_outputs() {
  local output="$1"
  
  # extract the bullet points under "Outputs"
  local bullets=$(echo "$output" | awk '/➡️  Outputs/{flag=1; next} /Leo ✅ Finished/{flag=0} flag')

  # remove newlines from the entire bullets string
  bullets=$(echo "$bullets" | tr -d '\n')

  # convert the bullets string to an array, splitting by '•'
  IFS='•' read -r -d '' -a bullets_array <<< "$bullets"

  # trim leading and trailing whitespace and remove all spaces from each array element
  for i in "${!bullets_array[@]}"; do
    bullets_array[$i]=$(echo "${bullets_array[$i]}" | xargs | tr -d ' ')
  done

  # remove empty elements
  bullets_array=("${bullets_array[@]:1}")

  # return the array
  echo "${bullets_array[@]}"
}

echo "
NETWORK=testnet
ENDPOINT=https://testnet.puzzle.online
PRIVATE_KEY=$challenger_pk
" > .env
echo "
        :::::::::  :::::::::   ::::::::  :::::::::   ::::::::   ::::::::  ::::::::::
       :+:    :+: :+:    :+: :+:    :+: :+:    :+: :+:    :+: :+:    :+: :+:
      +:+    +:+ +:+    +:+ +:+    +:+ +:+    +:+ +:+    +:+ +:+        +:+
     +#++:++#+  +#++:++#:  +#+    +:+ +#++:++#+  +#+    +:+ +#++:++#++ +#++:++#
    +#+        +#+    +#+ +#+    +#+ +#+        +#+    +#+        +#+ +#+
   #+#        #+#    #+# #+#    #+# #+#        #+#    #+# #+#    #+# #+#
  ###        ###    ###  ########  ###         ########   ########  ##########
        ::::::::      :::       :::   :::   ::::::::::
      :+:    :+:   :+: :+:    :+:+: :+:+:  :+:
     +:+         +:+   +:+  +:+ +:+:+ +:+ +:+
    :#:        +#++:++#++: +#+  +:+  +#+ +#++:++#
   +#+   +#+# +#+     +#+ +#+       +#+ +#+
  #+#    #+# #+#     #+# #+#       #+# #+#
  ########  ###     ### ###       ### ##########
"

run_output=$(leo run propose_game \
  $challenger_wager_record \
  $wager \
  $challenger_address \
  $opponent_address \
  $multisig_address \
  $challenger_answer \
  $multisig_seed
)
echo "$run_output"

propose_outputs=($(extract_outputs "$run_output"))
stake_claim_challenger="${propose_outputs[0]}"
stake_challenger="${propose_outputs[1]}"
change_challenger="${propose_outputs[2]}"
answer="${propose_outputs[3]}"
key="${propose_outputs[4]}"
game="${propose_outputs[5]}"
proposal="${propose_outputs[6]}"

echo "
NETWORK=testnet
ENDPOINT=https://testnet.puzzle.online
PRIVATE_KEY=$opponent_pk
" > .env
echo "
        ::::::::  :::    ::: :::::::::    :::   :::   ::::::::::: :::::::::::
      :+:    :+: :+:    :+: :+:    :+:  :+:+: :+:+:      :+:         :+:
     +:+        +:+    +:+ +:+    +:+ +:+ +:+:+ +:+     +:+         +:+
    +#++:++#++ +#+    +:+ +#++:++#+  +#+  +:+  +#+     +#+         +#+
          +#+ +#+    +#+ +#+    +#+ +#+       +#+     +#+         +#+
  #+#    #+# #+#    #+# #+#    #+# #+#       #+#     #+#         #+#
  ########   ########  #########  ###       ### ###########     ###
      :::       :::     :::      ::::::::  :::::::::: :::::::::
     :+:       :+:   :+: :+:   :+:    :+: :+:        :+:    :+:
    +:+       +:+  +:+   +:+  +:+        +:+        +:+    +:+
   +#+  +:+  +#+ +#++:++#++: :#:        +#++:++#   +#++:++#:
  +#+ +#+#+ +#+ +#+     +#+ +#+   +#+# +#+        +#+    +#+
  #+#+# #+#+#  #+#     #+# #+#    #+# #+#        #+#    #+#
  ###   ###   ###     ###  ########  ########## ###    ###
"

run_output=$(leo run submit_wager \
  "$opponent_wager_record" \
  "$key" \
  "$proposal"
)
echo "$run_output"

submit_wager_outputs=($(extract_outputs "$run_output"))
stake_claim_opponent="${submit_wager_outputs[0]}"
stake_opponent="${submit_wager_outputs[1]}"
change_opponent="${submit_wager_outputs[2]}"

echo "
NETWORK=testnet
ENDPOINT=https://testnet.puzzle.online
PRIVATE_KEY=$multisig_pk
" > .env

echo "
            :::      ::::::::   ::::::::  :::::::::: ::::::::: :::::::::::
         :+: :+:   :+:    :+: :+:    :+: :+:        :+:    :+:    :+:
       +:+   +:+  +:+        +:+        +:+        +:+    +:+    +:+
     +#++:++#++: +#+        +#+        +#++:++#   +#++:++#+     +#+
    +#+     +#+ +#+        +#+        +#+        +#+           +#+
   #+#     #+# #+#    #+# #+#    #+# #+#        #+#           #+#
  ###     ###  ########   ########  ########## ###           ###
        ::::::::      :::       :::   :::   ::::::::::
      :+:    :+:   :+: :+:    :+:+: :+:+:  :+:
     +:+         +:+   +:+  +:+ +:+:+ +:+ +:+
    :#:        +#++:++#++: +#+  +:+  +#+ +#++:++#
   +#+   +#+# +#+     +#+ +#+       +#+ +#+
  #+#    #+# #+#     #+# #+#       #+# #+#
  ########  ###     ### ###       ### ##########
"

run_output=$(leo run accept_game \
  "$game" \
  "$opponent_guess" \
  "$stake_challenger" \
  "$stake_claim_challenger" \
  "$stake_opponent" \
  "$stake_claim_opponent" \
  "$block_height"
)
echo "$run_output"

accept_game_outputs=($(extract_outputs "$run_output"))
joint_stake="${accept_game_outputs[0]}"
joint_timeout_claim="${accept_game_outputs[1]}"
joint_state="${accept_game_outputs[2]}"
guess="${accept_game_outputs[3]}"
game="${accept_game_outputs[4]}"

echo "
NETWORK=testnet
ENDPOINT=https://testnet.puzzle.online
PRIVATE_KEY=$challenger_pk
" > .env
echo "
        :::::::::  :::::::::: :::     ::: ::::::::::     :::     :::
       :+:    :+: :+:        :+:     :+: :+:          :+: :+:   :+:
      +:+    +:+ +:+        +:+     +:+ +:+         +:+   +:+  +:+
     +#++:++#:  +#++:++#   +#+     +:+ +#++:++#   +#++:++#++: +#+
    +#+    +#+ +#+         +#+   +#+  +#+        +#+     +#+ +#+
   #+#    #+# #+#          #+#+#+#   #+#        #+#     #+# #+#
  ###    ### ##########     ###     ########## ###     ### ##########
            :::     ::::    :::  ::::::::  :::       ::: :::::::::: :::::::::
         :+: :+:   :+:+:   :+: :+:    :+: :+:       :+: :+:        :+:    :+:
       +:+   +:+  :+:+:+  +:+ +:+        +:+       +:+ +:+        +:+    +:+
     +#++:++#++: +#+ +:+ +#+ +#++:++#++ +#+  +:+  +#+ +#++:++#   +#++:++#:
    +#+     +#+ +#+  +#+#+#        +#+ +#+ +#+#+ +#+ +#+        +#+    +#+
   #+#     #+# #+#   #+#+# #+#    #+#  #+#+# #+#+#  #+#        #+#    #+#
  ###     ### ###    ####  ########    ###   ###   ########## ###    ###
"

run_output=$(leo run reveal_answer_game "$guess" "$answer" "$joint_state")
echo "$run_output"

reveal_answer_outputs=($(extract_outputs "$run_output"))
answer="${reveal_answer_outputs[0]}"
joint_winner="${reveal_answer_outputs[1]}"

echo "
NETWORK=testnet
ENDPOINT=https://testnet.puzzle.online
PRIVATE_KEY=$multisig_pk
" > .env
echo "
      :::::::::: ::::::::::: ::::    ::: ::::::::::: ::::::::  :::    :::
     :+:            :+:     :+:+:   :+:     :+:    :+:    :+: :+:    :+:
    +:+            +:+     :+:+:+  +:+     +:+    +:+        +:+    +:+
   :#::+::#       +#+     +#+ +:+ +#+     +#+    +#++:++#++ +#++:++#++
  +#+            +#+     +#+  +#+#+#     +#+           +#+ +#+    +#+
 #+#            #+#     #+#   #+#+#     #+#    #+#    #+# #+#    #+#
###        ########### ###    #### ########### ########  ###    ###
      ::::::::      :::       :::   :::   ::::::::::
    :+:    :+:   :+: :+:    :+:+: :+:+:  :+:
   +:+         +:+   +:+  +:+ +:+:+ +:+ +:+
  :#:        +#++:++#++: +#+  +:+  +#+ +#++:++#
 +#+   +#+# +#+     +#+ +#+       +#+ +#+
#+#    #+# #+#     #+# #+#       #+# #+#
########  ###     ### ###       ### ##########
"

run_output=$(leo run finish_game \
  "$game" \
  "$joint_winner" \
  "$joint_stake" \
  "$joint_timeout_claim"
)
echo "$run_output"


# #   # transition finish_game_by_timeout(
# #   #       game_record: Game,
# #   #       piece_joint_stake: JointPieceStake,
# #   #       joint_piece_time_claim: JointPieceTimeClaim,
# #   #       opponent_sig: signature, // use from ClaimSignature record on FE, can't consume in this fxn bc claim is owned by multisig
# #   #   )

# # # leo run finish_game_by_timeout "{
# # #     owner: aleo1asu88azw3uqud282sll23wh3tvmvwjdz5vhvu2jwyrdwtgqn5qgqetuvr6.private,
# # #     challenger_commit: 1632338669887332693450432112819554759682427161589172463360656597380489639523field.private,
# # #     opponent_answer: 0u8.private,
# # #     total_pot: 200u64.private,
# # #     challenger_address: aleo16hf8hfpwasnn9cf7k2c0dllc56nn7qt547qxgvgwu6pznw4trvqsx68kls.private,
# # #     opponent_address: aleo1r4pc6ufjvw050jhzrew3vqm2lvacdxfd4a5ckulau0vjc72qvc8sr0jg2a.private,
# # #     game_multisig: aleo1asu88azw3uqud282sll23wh3tvmvwjdz5vhvu2jwyrdwtgqn5qgqetuvr6.private,
# # #     game_state: 2u8.private,
# # #     _nonce: 6948608249986613510548613368363016201727215274114585598126958153407391794356group.public
# # #   }" \
# # #   "{
# # #     owner: aleo1asu88azw3uqud282sll23wh3tvmvwjdz5vhvu2jwyrdwtgqn5qgqetuvr6.private,
# # #     amount: 200u64.private,
# # #     time_claimer_address: aleo1r4pc6ufjvw050jhzrew3vqm2lvacdxfd4a5ckulau0vjc72qvc8sr0jg2a.private,
# # #     state_updater_address: aleo16hf8hfpwasnn9cf7k2c0dllc56nn7qt547qxgvgwu6pznw4trvqsx68kls.private,
# # #     block_ht: 100000u32.private,
# # #     _nonce: 2240713899390860994917694134343841722032477963540160502162988371192957651151group.public
# # #   }" \
# # #   "{
# # #     owner: aleo1asu88azw3uqud282sll23wh3tvmvwjdz5vhvu2jwyrdwtgqn5qgqetuvr6.private,
# # #     amount: 200u64.private,
# # #     time_claimer_address: aleo1r4pc6ufjvw050jhzrew3vqm2lvacdxfd4a5ckulau0vjc72qvc8sr0jg2a.private,
# # #     state_updater_address: aleo16hf8hfpwasnn9cf7k2c0dllc56nn7qt547qxgvgwu6pznw4trvqsx68kls.private,
# # #     message_1: 4299148155668445410404796665478412871867472362428312345599969289162437917169field.private,
# # #     message_2: 251561861986387641133995513088278466362266230978294643355666629668300490271field.private,
# # #     message_3: 1152742118437172617676919179607096353215168002720611159713055309066048881777field.private,
# # #     message_4: 6965356107999508170054292104522311809055538516545196583411503498743541220125field.private,
# # #     message_5: 478560413032field.private,
# # #     game_multisig: aleo1asu88azw3uqud282sll23wh3tvmvwjdz5vhvu2jwyrdwtgqn5qgqetuvr6.private,
# # #     challenger: aleo16hf8hfpwasnn9cf7k2c0dllc56nn7qt547qxgvgwu6pznw4trvqsx68kls.private,
# # #     opponent: aleo1r4pc6ufjvw050jhzrew3vqm2lvacdxfd4a5ckulau0vjc72qvc8sr0jg2a.private,
# # #     block_ht: 100000u32.private,
# # #     _nonce: 274384839497127952384736973185974643077364641215250178954909534832130043014group.public
# # #   }" \
# # #   sign1j0hhruukxrlddx4tzzpe8gccgy3l430el69e0jpclrzk2x3kecpq7zteu9z5qqqttk4xltyplgwzt4famkfxar5wjncz5ttssdur2qslse2uz49ljzhxz82y28gy0un45z8w2jgwk7jhdgxqh58qgcvwqpcuf9estpjsv9n9jln3x08mzl2rc8z25j6s6r4uf8rq9r7ddkxqyaahcxh

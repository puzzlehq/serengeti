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
joint_timeout_claim="${accept_game_outputs[0]}"
joint_state="${accept_game_outputs[1]}"
guess="${accept_game_outputs[2]}"
game="${accept_game_outputs[3]}"

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
  "$joint_timeout_claim"
)
echo "$run_output"

run_output=$(leo run finish_game_by_timeout "$game" "$joint_timeout_claim")
echo "$run_output"

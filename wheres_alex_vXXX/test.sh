# The private key and address of the challenger - Alice.
# Swap these in when running transactions as the challenger.
# "private_key": "APrivateKey1zkp9p8bttYsy3EuwiGrb4PXmrtjzZkpGvBCGVCgvpcwVjUV",
# "address": "aleo16hf8hfpwasnn9cf7k2c0dllc56nn7qt547qxgvgwu6pznw4trvqsx68kls"

# The private key and address of the opponent - Bob.
# Swap these in when running transactions as the opponent.
# "private_key": "APrivateKey1zkpALDDK4zAigs387emvnuxWXvGjFw2AmmYcQH7TBt8nhof"
# "address": "aleo1r4pc6ufjvw050jhzrew3vqm2lvacdxfd4a5ckulau0vjc72qvc8sr0jg2a"

# The private key and address of the game multisig.
# Swap these when running transactions from the game multisig.
# "private_key": "APrivateKey1zkp8pmTMT4FxG5qXZ9McEYDdY1G6YokY1BYzwoxTYJEKubF"
# "address": "aleo1asu88azw3uqud282sll23wh3tvmvwjdz5vhvu2jwyrdwtgqn5qgqetuvr6"


# Swap in the private key of the challenger -- Alice.
echo "
NETWORK=testnet3
PRIVATE_KEY=APrivateKey1zkp9p8bttYsy3EuwiGrb4PXmrtjzZkpGvBCGVCgvpcwVjUV
" > .env

echo "
#       :::::::::  :::::::::   ::::::::  :::::::::   ::::::::   ::::::::  ::::::::::
#      :+:    :+: :+:    :+: :+:    :+: :+:    :+: :+:    :+: :+:    :+: :+:
#     +:+    +:+ +:+    +:+ +:+    +:+ +:+    +:+ +:+    +:+ +:+        +:+
#    +#++:++#+  +#++:++#:  +#+    +:+ +#++:++#+  +#+    +:+ +#++:++#++ +#++:++#
#   +#+        +#+    +#+ +#+    +#+ +#+        +#+    +#+        +#+ +#+
#  #+#        #+#    #+# #+#    #+# #+#        #+#    #+# #+#    #+# #+#
# ###        ###    ###  ########  ###         ########   ########  ##########
#       ::::::::      :::       :::   :::   ::::::::::
#     :+:    :+:   :+: :+:    :+:+: :+:+:  :+:
#    +:+         +:+   +:+  +:+ +:+:+ +:+ +:+
#   :#:        +#++:++#++: +#+  +:+  +#+ +#++:++#
#  +#+   +#+# +#+     +#+ +#+       +#+ +#+
# #+#    #+# #+#     #+# #+#       #+# #+#
# ########  ###     ### ###       ### ##########
"

leo run propose_game "{
        owner: aleo16hf8hfpwasnn9cf7k2c0dllc56nn7qt547qxgvgwu6pznw4trvqsx68kls.private,
        amount: 500u64.private,
        ix: 0u32.private,
        _nonce: 5117772722354704202838157764917930913180509833961648133377098024993045952079group.public
    }" 100u64 aleo16hf8hfpwasnn9cf7k2c0dllc56nn7qt547qxgvgwu6pznw4trvqsx68kls aleo16hf8hfpwasnn9cf7k2c0dllc56nn7qt547qxgvgwu6pznw4trvqsx68kls aleo1r4pc6ufjvw050jhzrew3vqm2lvacdxfd4a5ckulau0vjc72qvc8sr0jg2a aleo1asu88azw3uqud282sll23wh3tvmvwjdz5vhvu2jwyrdwtgqn5qgqetuvr6 8062328565641143710315198539395259864274213782537700083868207132716559019626field 646976134778083579747150617209623060175268802563807996500102649727939562470field 7738966642647861988443742254957166327730088714215632067055062293849087980027field 501202936879316583063216806269060512965140130553350448375465909870676136661field 478560413032field sign1h04lnsl0t4aau8lzp06rzcm5eqrzr9ew63ljnw43v2nr7nkmsqqcx8cksna2ajwgk80rv0s7prrndw5k56sey3nrl487552lvaukuq8xe0cgu6x809qetnn35ufm3gl6ecyvtpgaavu9y5754j27utrwq8amruqyq2x6dvqs790yqsrctwmjnh3k7thslm0r9c3hpdvjrywpzts24xr 12345field 0field 98765field

# Swap in the private key of the opponent - Bob.
echo "
NETWORK=testnet3
PRIVATE_KEY=APrivateKey1zkpALDDK4zAigs387emvnuxWXvGjFw2AmmYcQH7TBt8nhof
" > .env

echo "
#       ::::::::  :::    ::: :::::::::    :::   :::   ::::::::::: :::::::::::
#     :+:    :+: :+:    :+: :+:    :+:  :+:+: :+:+:      :+:         :+:
#    +:+        +:+    +:+ +:+    +:+ +:+ +:+:+ +:+     +:+         +:+
#   +#++:++#++ +#+    +:+ +#++:++#+  +#+  +:+  +#+     +#+         +#+
#         +#+ +#+    +#+ +#+    +#+ +#+       +#+     +#+         +#+
# #+#    #+# #+#    #+# #+#    #+# #+#       #+#     #+#         #+#
# ########   ########  #########  ###       ### ###########     ###
#     :::       :::     :::      ::::::::  :::::::::: :::::::::
#    :+:       :+:   :+: :+:   :+:    :+: :+:        :+:    :+:
#   +:+       +:+  +:+   +:+  +:+        +:+        +:+    +:+
#  +#+  +:+  +#+ +#++:++#++: :#:        +#++:++#   +#++:++#:
# +#+ +#+#+ +#+ +#+     +#+ +#+   +#+# +#+        +#+    +#+
# #+#+# #+#+#  #+#     #+# #+#    #+# #+#        #+#    #+#
# ###   ###   ###     ###  ########  ########## ###    ###
"

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

# Swap in the private key of the multisig.

echo "
NETWORK=testnet3
PRIVATE_KEY=APrivateKey1zkp8pmTMT4FxG5qXZ9McEYDdY1G6YokY1BYzwoxTYJEKubF
" > .env

echo "
#           :::      ::::::::   ::::::::  :::::::::: ::::::::: :::::::::::
#        :+: :+:   :+:    :+: :+:    :+: :+:        :+:    :+:    :+:
#      +:+   +:+  +:+        +:+        +:+        +:+    +:+    +:+
#    +#++:++#++: +#+        +#+        +#++:++#   +#++:++#+     +#+
#   +#+     +#+ +#+        +#+        +#+        +#+           +#+
#  #+#     #+# #+#    #+# #+#    #+# #+#        #+#           #+#
# ###     ###  ########   ########  ########## ###           ###
#       ::::::::      :::       :::   :::   ::::::::::
#     :+:    :+:   :+: :+:    :+:+: :+:+:  :+:
#    +:+         +:+   +:+  +:+ +:+:+ +:+ +:+
#   :#:        +#++:++#++: +#+  +:+  +#+ +#++:++#
#  +#+   +#+# +#+     +#+ +#+       +#+ +#+
# #+#    #+# #+#     #+# #+#       #+# #+#
# ########  ###     ### ###       ### ##########
"

# leo run accept_game "{
#   owner: aleo1asu88azw3uqud282sll23wh3tvmvwjdz5vhvu2jwyrdwtgqn5qgqetuvr6.private,
#   challenger_commit: 1632338669887332693450432112819554759682427161589172463360656597380489639523field.private,
#   opponent_answer: 0field.private,
#   total_pot: 200u64.private,
#   challenger_address: aleo16hf8hfpwasnn9cf7k2c0dllc56nn7qt547qxgvgwu6pznw4trvqsx68kls.private,
#   opponent_address: aleo1r4pc6ufjvw050jhzrew3vqm2lvacdxfd4a5ckulau0vjc72qvc8sr0jg2a.private,
#   game_multisig: aleo1asu88azw3uqud282sll23wh3tvmvwjdz5vhvu2jwyrdwtgqn5qgqetuvr6.private,
#   game_state: 1field.private,
#   _nonce: 1334964628097769506346609254612928141201659101623645895663814974083190759961group.public
# }" 0field "{
#   owner: aleo1asu88azw3uqud282sll23wh3tvmvwjdz5vhvu2jwyrdwtgqn5qgqetuvr6.private,
#   amount: 100u64.private,
#   challenger: aleo16hf8hfpwasnn9cf7k2c0dllc56nn7qt547qxgvgwu6pznw4trvqsx68kls.private,
#   opponent: aleo1r4pc6ufjvw050jhzrew3vqm2lvacdxfd4a5ckulau0vjc72qvc8sr0jg2a.private,
#   ix: 3u32.private,
#   _nonce: 4284598271155980028049768842401005159567204128606052241931518995011812618429group.public
# }" "{
#   owner: aleo1asu88azw3uqud282sll23wh3tvmvwjdz5vhvu2jwyrdwtgqn5qgqetuvr6.private,
#   amount: 100u64.private,
#   claimer: aleo1r4pc6ufjvw050jhzrew3vqm2lvacdxfd4a5ckulau0vjc72qvc8sr0jg2a.private,
#   message_1: 4299148155668445410404796665478412871867472362428312345599969289162437917169field.private,
#   message_2: 251561861986387641133995513088278466362266230978294643355666629668300490271field.private,
#   message_3: 1152742118437172617676919179607096353215168002720611159713055309066048881777field.private,
#   message_4: 6965356107999508170054292104522311809055538516545196583411503498743541220125field.private,
#   message_5: 478560413032field.private,
#   challenger: aleo16hf8hfpwasnn9cf7k2c0dllc56nn7qt547qxgvgwu6pznw4trvqsx68kls.private,
#   opponent: aleo1r4pc6ufjvw050jhzrew3vqm2lvacdxfd4a5ckulau0vjc72qvc8sr0jg2a.private,
#   ix: 6u32.private,
#   _nonce: 3569726119866764549964441851090282924398824450345405697637548871911049598842group.public
# }" "{
#   owner: aleo1asu88azw3uqud282sll23wh3tvmvwjdz5vhvu2jwyrdwtgqn5qgqetuvr6.private,
#   amount: 100u64.private,
#   challenger: aleo16hf8hfpwasnn9cf7k2c0dllc56nn7qt547qxgvgwu6pznw4trvqsx68kls.private,
#   opponent: aleo1r4pc6ufjvw050jhzrew3vqm2lvacdxfd4a5ckulau0vjc72qvc8sr0jg2a.private,
#   ix: 3u32.private,
#   _nonce: 1971872521381063346261049000143077388486554460249572615590773197484105792568group.public
# }" "{
#   owner: aleo1asu88azw3uqud282sll23wh3tvmvwjdz5vhvu2jwyrdwtgqn5qgqetuvr6.private,
#   amount: 100u64.private,
#   claimer: aleo16hf8hfpwasnn9cf7k2c0dllc56nn7qt547qxgvgwu6pznw4trvqsx68kls.private,
#   message_1: 8062328565641143710315198539395259864274213782537700083868207132716559019626field.private,
#   message_2: 646976134778083579747150617209623060175268802563807996500102649727939562470field.private,
#   message_3: 7738966642647861988443742254957166327730088714215632067055062293849087980027field.private,
#   message_4: 501202936879316583063216806269060512965140130553350448375465909870676136661field.private,
#   message_5: 478560413032field.private,
#   challenger: aleo16hf8hfpwasnn9cf7k2c0dllc56nn7qt547qxgvgwu6pznw4trvqsx68kls.private,
#   opponent: aleo1r4pc6ufjvw050jhzrew3vqm2lvacdxfd4a5ckulau0vjc72qvc8sr0jg2a.private,
#   ix: 6u32.private,
#   _nonce: 3366954178518918621707747175319544829507693042206066118513504319768518783949group.public
# }" 10u32

# Swap in the private key of the challenger -- Alice.
echo "
NETWORK=testnet3
PRIVATE_KEY=APrivateKey1zkp9p8bttYsy3EuwiGrb4PXmrtjzZkpGvBCGVCgvpcwVjUV
" > .env

echo "
#       :::::::::  :::::::::: :::     ::: ::::::::::     :::     :::
#      :+:    :+: :+:        :+:     :+: :+:          :+: :+:   :+:
#     +:+    +:+ +:+        +:+     +:+ +:+         +:+   +:+  +:+
#    +#++:++#:  +#++:++#   +#+     +:+ +#++:++#   +#++:++#++: +#+
#   +#+    +#+ +#+         +#+   +#+  +#+        +#+     +#+ +#+
#  #+#    #+# #+#          #+#+#+#   #+#        #+#     #+# #+#
# ###    ### ##########     ###     ########## ###     ### ##########
#           :::     ::::    :::  ::::::::  :::       ::: :::::::::: :::::::::
#        :+: :+:   :+:+:   :+: :+:    :+: :+:       :+: :+:        :+:    :+:
#      +:+   +:+  :+:+:+  +:+ +:+        +:+       +:+ +:+        +:+    +:+
#    +#++:++#++: +#+ +:+ +#+ +#++:++#++ +#+  +:+  +#+ +#++:++#   +#++:++#:
#   +#+     +#+ +#+  +#+#+#        +#+ +#+ +#+#+ +#+ +#+        +#+    +#+
#  #+#     #+# #+#   #+#+# #+#    #+#  #+#+# #+#+#  #+#        #+#    #+#
# ###     ### ###    ####  ########    ###   ###   ########## ###    ###
"

#leo run reveal_answer


# Swap in the private key of the multisig.

echo "
NETWORK=testnet3
PRIVATE_KEY=APrivateKey1zkp8pmTMT4FxG5qXZ9McEYDdY1G6YokY1BYzwoxTYJEKubF
" > .env

echo "
#       :::::::::: ::::::::::: ::::    ::: ::::::::::: ::::::::  :::    :::
#      :+:            :+:     :+:+:   :+:     :+:    :+:    :+: :+:    :+:
#     +:+            +:+     :+:+:+  +:+     +:+    +:+        +:+    +:+
#    :#::+::#       +#+     +#+ +:+ +#+     +#+    +#++:++#++ +#++:++#++
#   +#+            +#+     +#+  +#+#+#     +#+           +#+ +#+    +#+
#  #+#            #+#     #+#   #+#+#     #+#    #+#    #+# #+#    #+#
# ###        ########### ###    #### ########### ########  ###    ###
#       ::::::::      :::       :::   :::   ::::::::::
#     :+:    :+:   :+: :+:    :+:+: :+:+:  :+:
#    +:+         +:+   +:+  +:+ +:+:+ +:+ +:+
#   :#:        +#++:++#++: +#+  +:+  +#+ +#++:++#
#  +#+   +#+# +#+     +#+ +#+       +#+ +#+
# #+#    #+# #+#     #+# #+#       #+# #+#
# ########  ###     ### ###       ### ##########
"

#leo run finish_game


# Swap in the private key of the challenger -- Alice.
echo "
NETWORK=testnet3
PRIVATE_KEY=APrivateKey1zkp9p8bttYsy3EuwiGrb4PXmrtjzZkpGvBCGVCgvpcwVjUV
" > .env

echo "
#         :::   :::   ::::::::::: ::::    ::: :::::::::::
#       :+:+: :+:+:      :+:     :+:+:   :+:     :+:
#     +:+ +:+:+ +:+     +:+     :+:+:+  +:+     +:+
#    +#+  +:+  +#+     +#+     +#+ +:+ +#+     +#+
#   +#+       +#+     +#+     +#+  +#+#+#     +#+
#  #+#       #+#     #+#     #+#   #+#+#     #+#
# ###       ### ########### ###    ####     ###
#           :::     ::::    :::  ::::::::  :::       ::: :::::::::: :::::::::
#        :+: :+:   :+:+:   :+: :+:    :+: :+:       :+: :+:        :+:    :+:
#      +:+   +:+  :+:+:+  +:+ +:+        +:+       +:+ +:+        +:+    +:+
#    +#++:++#++: +#+ +:+ +#+ +#++:++#++ +#+  +:+  +#+ +#++:++#   +#++:++#:
#   +#+     +#+ +#+  +#+#+#        +#+ +#+ +#+#+ +#+ +#+        +#+    +#+
#  #+#     #+# #+#   #+#+# #+#    #+#  #+#+# #+#+#  #+#        #+#    #+#
# ###     ### ###    ####  ########    ###   ###   ########## ###    ###
"

leo run mint_answer aleo16hf8hfpwasnn9cf7k2c0dllc56nn7qt547qxgvgwu6pznw4trvqsx68kls aleo1r4pc6ufjvw050jhzrew3vqm2lvacdxfd4a5ckulau0vjc72qvc8sr0jg2a aleo1asu88azw3uqud282sll23wh3tvmvwjdz5vhvu2jwyrdwtgqn5qgqetuvr6 100u64 12345field 98765field 8062328565641143710315198539395259864274213782537700083868207132716559019626field 646976134778083579747150617209623060175268802563807996500102649727939562470field 7738966642647861988443742254957166327730088714215632067055062293849087980027field 501202936879316583063216806269060512965140130553350448375465909870676136661field 478560413032field sign1h04lnsl0t4aau8lzp06rzcm5eqrzr9ew63ljnw43v2nr7nkmsqqcx8cksna2ajwgk80rv0s7prrndw5k56sey3nrl487552lvaukuq8xe0cgu6x809qetnn35ufm3gl6ecyvtpgaavu9y5754j27utrwq8amruqyq2x6dvqs790yqsrctwmjnh3k7thslm0r9c3hpdvjrywpzts24xr

echo "
#         :::   :::   ::::::::::: ::::    ::: :::::::::::
#       :+:+: :+:+:      :+:     :+:+:   :+:     :+:
#     +:+ +:+:+ +:+     +:+     :+:+:+  +:+     +:+
#    +#+  +:+  +#+     +#+     +#+ +:+ +#+     +#+
#   +#+       +#+     +#+     +#+  +#+#+#     +#+
#  #+#       #+#     #+#     #+#   #+#+#     #+#
# ###       ### ########### ###    ####     ###
#         :::   :::   :::    ::: :::    ::::::::::: :::::::::::
#       :+:+: :+:+:  :+:    :+: :+:        :+:         :+:
#     +:+ +:+:+ +:+ +:+    +:+ +:+        +:+         +:+
#    +#+  +:+  +#+ +#+    +:+ +#+        +#+         +#+     +#++:++#++:++
#   +#+       +#+ +#+    +#+ +#+        +#+         +#+
#  #+#       #+# #+#    #+# #+#        #+#         #+#
# ###       ###  ########  ########## ###     ###########
#       :::::::: ::::::::::: ::::::::           :::    ::: :::::::::: :::   :::
#     :+:    :+:    :+:    :+:    :+:          :+:   :+:  :+:        :+:   :+:
#    +:+           +:+    +:+                 +:+  +:+   +:+         +:+ +:+
#   +#++:++#++    +#+    :#:                 +#++:++    +#++:++#     +#++:
#         +#+    +#+    +#+   +#+#          +#+  +#+   +#+           +#+
# #+#    #+#    #+#    #+#    #+#          #+#   #+#  #+#           #+#
# ######## ########### ########           ###    ### ##########    ###
"

leo run mint_multisig_key 12345field 100u64 aleo1asu88azw3uqud282sll23wh3tvmvwjdz5vhvu2jwyrdwtgqn5qgqetuvr6 aleo16hf8hfpwasnn9cf7k2c0dllc56nn7qt547qxgvgwu6pznw4trvqsx68kls aleo1r4pc6ufjvw050jhzrew3vqm2lvacdxfd4a5ckulau0vjc72qvc8sr0jg2a

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

leo run reveal_answer "{
    owner: aleo16hf8hfpwasnn9cf7k2c0dllc56nn7qt547qxgvgwu6pznw4trvqsx68kls.private,
    challenger_address: aleo16hf8hfpwasnn9cf7k2c0dllc56nn7qt547qxgvgwu6pznw4trvqsx68kls.private,
    opponent_address: aleo1r4pc6ufjvw050jhzrew3vqm2lvacdxfd4a5ckulau0vjc72qvc8sr0jg2a.private,
    game_multisig: aleo1asu88azw3uqud282sll23wh3tvmvwjdz5vhvu2jwyrdwtgqn5qgqetuvr6.private,
    amount: 100u64.private,
    nonce: 12345field.private,
    answer: 98765field.private,
    message_1: 8062328565641143710315198539395259864274213782537700083868207132716559019626field.private,
    message_2: 646976134778083579747150617209623060175268802563807996500102649727939562470field.private,
    message_3: 7738966642647861988443742254957166327730088714215632067055062293849087980027field.private,
    message_4: 501202936879316583063216806269060512965140130553350448375465909870676136661field.private,
    message_5: 478560413032field.private,
    _nonce: 3086461441036924895581482603324967423059802832652857085654924791650328692109group.public
    }" sign1h04lnsl0t4aau8lzp06rzcm5eqrzr9ew63ljnw43v2nr7nkmsqqcx8cksna2ajwgk80rv0s7prrndw5k56sey3nrl487552lvaukuq8xe0cgu6x809qetnn35ufm3gl6ecyvtpgaavu9y5754j27utrwq8amruqyq2x6dvqs790yqsrctwmjnh3k7thslm0r9c3hpdvjrywpzts24xr

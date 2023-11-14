echo "
NETWORK=testnet3
PRIVATE_KEY=APrivateKey1zkp9p8bttYsy3EuwiGrb4PXmrtjzZkpGvBCGVCgvpcwVjUV
" > .env

echo "
#    :::     ::: :::::::::: :::::::::  ::::::::::: :::::::::: :::   :::
#   :+:     :+: :+:        :+:    :+:     :+:     :+:        :+:   :+: 
#  +:+     +:+ +:+        +:+    +:+     +:+     +:+         +:+ +:+   
# +#+     +:+ +#++:++#   +#++:++#:      +#+     :#::+::#     +#++:     
# +#+   +#+  +#+        +#+    +#+     +#+     +#+           +#+       
# #+#+#+#   #+#        #+#    #+#     #+#     #+#           #+#        
#  ###     ########## ###    ### ########### ###           ###         
#       :::::::: ::::::::::: ::::::::                                  
#     :+:    :+:    :+:    :+:    :+:                                  
#    +:+           +:+    +:+                                          
#   +#++:++#++    +#+    :#:                                           
#         +#+    +#+    +#+   +#+#                                     
# #+#    #+#    #+#    #+#    #+#                                      
# ######## ########### ########                                        
"

leo run sig_verify "{
        owner: aleo16hf8hfpwasnn9cf7k2c0dllc56nn7qt547qxgvgwu6pznw4trvqsx68kls.private,
        message_1: 8062328565641143710315198539395259864274213782537700083868207132716559019626field.private,
        message_2: 646976134778083579747150617209623060175268802563807996500102649727939562470field.private,
        message_3: 7738966642647861988443742254957166327730088714215632067055062293849087980027field.private,
        message_4: 501202936879316583063216806269060512965140130553350448375465909870676136661field.private,
        message_5: 478560413032field.private,
        _nonce: 5117772722354704202838157764917930913180509833961648133377098024993045952079group.public
    }" sign1h04lnsl0t4aau8lzp06rzcm5eqrzr9ew63ljnw43v2nr7nkmsqqcx8cksna2ajwgk80rv0s7prrndw5k56sey3nrl487552lvaukuq8xe0cgu6x809qetnn35ufm3gl6ecyvtpgaavu9y5754j27utrwq8amruqyq2x6dvqs790yqsrctwmjnh3k7thslm0r9c3hpdvjrywpzts24xr
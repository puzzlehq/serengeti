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
##   ##    ####   ###  ##  #### ##  #### ### ##   ### ##     ####   ### ##   ### ###
 ## ##      ##      ## ##  # ## ##  ####  ##  ##   ##  ##     ##    ##  ##    ##  ##
# ### #     ##     # ## #    ##     ####  ##  ##   ##  ##     ##       ##     ##
## # ##     ##     ## ##     ##     ####  ##  ##   ## ##      ##      ##      ## ##
##   ##     ##     ##  ##    ##     ####  ## ##    ## ##      ##     ##       ##
##   ##     ##     ##  ##    ##     ####  ##       ##  ##     ##    ##  ##    ##  ##
##   ##    ####   ###  ##   ####    #### ####     #### ##    ####   # ####   ### ###
                                    ####
"
leo run mint_prize 252496349687615411424866113487376041671u128 286475219118120941632852794305998134102u128

echo "
  ##     ### ##   ### ##             ## ##   ###  ##  ### ###
   ##     ##  ##   ##  ##           ##   ##    ## ##   ##  ##
 ## ##    ##  ##   ##  ##           ##   ##   # ## #   ##
 ##  ##   ##  ##   ##  ##           ##   ##   ## ##    ## ##
 ## ###   ##  ##   ##  ##           ##   ##   ##  ##   ##
 ##  ##   ##  ##   ##  ##           ##   ##   ##  ##   ##  ##
###  ##  ### ##   ### ##             ## ##   ###  ##  ### ###
"

leo run add_one_raffle_entry aleo1xz7vdq0tnww7s9kpp7ahnkq4ydn9gffchwjrx27fuvylvnr29cqqj0zhac

echo "
  ##     ### ##   ### ##            #### ##  ##   ##   ## ##
   ##     ##  ##   ##  ##           # ## ##  ##   ##  ##   ##
 ## ##    ##  ##   ##  ##             ##     ##   ##  ##   ##
 ##  ##   ##  ##   ##  ##             ##     ## # ##  ##   ##
 ## ###   ##  ##   ##  ##             ##     # ### #  ##   ##
 ##  ##   ##  ##   ##  ##             ##      ## ##   ##   ##
###  ##  ### ##   ### ##             ####    ##   ##   ## ##
"
leo run add_two_raffle_entries aleo1xz7vdq0tnww7s9kpp7ahnkq4ydn9gffchwjrx27fuvylvnr29cqqj0zhac

echo "
  ##     ### ##   ### ##            #### ##  ###  ##  ### ##   ### ###  ### ###
   ##     ##  ##   ##  ##           # ## ##   ##  ##   ##  ##   ##  ##   ##  ##
 ## ##    ##  ##   ##  ##             ##      ##  ##   ##  ##   ##       ##
 ##  ##   ##  ##   ##  ##             ##      ## ###   ## ##    ## ##    ## ##
 ## ###   ##  ##   ##  ##             ##      ##  ##   ## ##    ##       ##
 ##  ##   ##  ##   ##  ##             ##      ##  ##   ##  ##   ##  ##   ##  ##
###  ##  ### ##   ### ##             ####    ###  ##  #### ##  ### ###  ### ###
"

leo run add_three_raffle_entries aleo1xz7vdq0tnww7s9kpp7ahnkq4ydn9gffchwjrx27fuvylvnr29cqqj0zhac

echo "
  ##     ### ##   ### ##            ### ###   ## ##   ##  ###  ### ##
   ##     ##  ##   ##  ##            ##  ##  ##   ##  ##   ##   ##  ##
 ## ##    ##  ##   ##  ##            ##      ##   ##  ##   ##   ##  ##
 ##  ##   ##  ##   ##  ##            ## ##   ##   ##  ##   ##   ## ##
 ## ###   ##  ##   ##  ##            ##      ##   ##  ##   ##   ## ##
 ##  ##   ##  ##   ##  ##            ##      ##   ##  ##   ##   ##  ##
###  ##  ### ##   ### ##            ####      ## ##    ## ##   #### ##
"

leo run add_four_raffle_entries aleo1xz7vdq0tnww7s9kpp7ahnkq4ydn9gffchwjrx27fuvylvnr29cqqj0zhac

echo "
  ##     ### ##   ### ##            ### ###    ####   ### ###  ### ###
   ##     ##  ##   ##  ##            ##  ##     ##     ##  ##   ##  ##
 ## ##    ##  ##   ##  ##            ##         ##     ##  ##   ##
 ##  ##   ##  ##   ##  ##            ## ##      ##     ##  ##   ## ##
 ## ###   ##  ##   ##  ##            ##         ##     ### ##   ##
 ##  ##   ##  ##   ##  ##            ##         ##      ###     ##  ##
###  ##  ### ##   ### ##            ####       ####      ##    ### ###

"


leo run add_five_raffle_entries aleo1xz7vdq0tnww7s9kpp7ahnkq4ydn9gffchwjrx27fuvylvnr29cqqj0zhac

echo "
  ##     ### ##   ### ##             ## ##     ####   ##  ##
   ##     ##  ##   ##  ##           ##   ##     ##    ### ##
 ## ##    ##  ##   ##  ##           ####        ##     ###
 ##  ##   ##  ##   ##  ##            #####      ##      ###
 ## ###   ##  ##   ##  ##               ###     ##       ###
 ##  ##   ##  ##   ##  ##           ##   ##     ##    ##  ###
###  ##  ### ##   ### ##             ## ##     ####   ##   ##
"

leo run add_six_raffle_entries aleo1xz7vdq0tnww7s9kpp7ahnkq4ydn9gffchwjrx27fuvylvnr29cqqj0zhac

echo "
  ##     ### ##   ### ##             ## ##   ### ###  ### ###  ### ###  ###  ##
   ##     ##  ##   ##  ##           ##   ##   ##  ##   ##  ##   ##  ##    ## ##
 ## ##    ##  ##   ##  ##           ####      ##       ##  ##   ##       # ## #
 ##  ##   ##  ##   ##  ##            #####    ## ##    ##  ##   ## ##    ## ##
 ## ###   ##  ##   ##  ##               ###   ##       ### ##   ##       ##  ##
 ##  ##   ##  ##   ##  ##           ##   ##   ##  ##    ###     ##  ##   ##  ##
###  ##  ### ##   ### ##             ## ##   ### ###     ##    ### ###  ###  ##

"
leo run add_seven_raffle_entries aleo1xz7vdq0tnww7s9kpp7ahnkq4ydn9gffchwjrx27fuvylvnr29cqqj0zhac



echo "
  ##     ### ##   ### ##            ### ###    ####    ## ##   ###  ##  #### ##
   ##     ##  ##   ##  ##            ##  ##     ##    ##   ##   ##  ##  # ## ##
 ## ##    ##  ##   ##  ##            ##         ##    ##        ##  ##    ##
 ##  ##   ##  ##   ##  ##            ## ##      ##    ##  ###   ## ###    ##
 ## ###   ##  ##   ##  ##            ##         ##    ##   ##   ##  ##    ##
 ##  ##   ##  ##   ##  ##            ##  ##     ##    ##   ##   ##  ##    ##
###  ##  ### ##   ### ##            ### ###    ####    ## ##   ###  ##   ####

"


leo run add_eight_raffle_entries aleo1xz7vdq0tnww7s9kpp7ahnkq4ydn9gffchwjrx27fuvylvnr29cqqj0zhac


echo "
  ##     ### ##   ### ##            ###  ##    ####   ###  ##  ### ###
   ##     ##  ##   ##  ##             ## ##     ##      ## ##   ##  ##
 ## ##    ##  ##   ##  ##            # ## #     ##     # ## #   ##
 ##  ##   ##  ##   ##  ##            ## ##      ##     ## ##    ## ##
 ## ###   ##  ##   ##  ##            ##  ##     ##     ##  ##   ##
 ##  ##   ##  ##   ##  ##            ##  ##     ##     ##  ##   ##  ##
###  ##  ### ##   ### ##            ###  ##    ####   ###  ##  ### ###

"

leo run add_nine_raffle_entries aleo1xz7vdq0tnww7s9kpp7ahnkq4ydn9gffchwjrx27fuvylvnr29cqqj0zhac

echo "
  ##     ### ##   ### ##            #### ##  ### ###  ###  ##
   ##     ##  ##   ##  ##           # ## ##   ##  ##    ## ##
 ## ##    ##  ##   ##  ##             ##      ##       # ## #
 ##  ##   ##  ##   ##  ##             ##      ## ##    ## ##
 ## ###   ##  ##   ##  ##             ##      ##       ##  ##
 ##  ##   ##  ##   ##  ##             ##      ##  ##   ##  ##
###  ##  ### ##   ### ##             ####    ### ###  ###  ##


"

leo run add_ten_raffle_entries aleo1xz7vdq0tnww7s9kpp7ahnkq4ydn9gffchwjrx27fuvylvnr29cqqj0zhac

echo "
  ##     ### ##   ### ##            ### ###  ####     ### ###  ### ###  ### ###  ###  ##
   ##     ##  ##   ##  ##            ##  ##   ##       ##  ##   ##  ##   ##  ##    ## ##
 ## ##    ##  ##   ##  ##            ##       ##       ##       ##  ##   ##       # ## #
 ##  ##   ##  ##   ##  ##            ## ##    ##       ## ##    ##  ##   ## ##    ## ##
 ## ###   ##  ##   ##  ##            ##       ##       ##       ### ##   ##       ##  ##
 ##  ##   ##  ##   ##  ##            ##  ##   ##  ##   ##  ##    ###     ##  ##   ##  ##
###  ##  ### ##   ### ##            ### ###  ### ###  ### ###     ##    ### ###  ###  ##

"

leo run add_eleven_raffle_entries aleo1xz7vdq0tnww7s9kpp7ahnkq4ydn9gffchwjrx27fuvylvnr29cqqj0zhac

echo "
  ##     ### ##   ### ##            #### ##  ##   ##  ### ###  ####     ### ###  ### ###
   ##     ##  ##   ##  ##           # ## ##  ##   ##   ##  ##   ##       ##  ##   ##  ##
 ## ##    ##  ##   ##  ##             ##     ##   ##   ##       ##       ##  ##   ##
 ##  ##   ##  ##   ##  ##             ##     ## # ##   ## ##    ##       ##  ##   ## ##
 ## ###   ##  ##   ##  ##             ##     # ### #   ##       ##       ### ##   ##
 ##  ##   ##  ##   ##  ##             ##      ## ##    ##  ##   ##  ##    ###     ##  ##
###  ##  ### ##   ### ##             ####    ##   ##  ### ###  ### ###     ##    ### ###

"

leo run add_twelve_raffle_entries aleo1xz7vdq0tnww7s9kpp7ahnkq4ydn9gffchwjrx27fuvylvnr29cqqj0zhac

echo "
  ##     ### ##   ### ##            #### ##  ###  ##    ####   ### ##   #### ##  ### ###  ### ###  ###  ##
   ##     ##  ##   ##  ##           # ## ##   ##  ##     ##     ##  ##  # ## ##   ##  ##   ##  ##    ## ##
 ## ##    ##  ##   ##  ##             ##      ##  ##     ##     ##  ##    ##      ##       ##       # ## #
 ##  ##   ##  ##   ##  ##             ##      ## ###     ##     ## ##     ##      ## ##    ## ##    ## ##
 ## ###   ##  ##   ##  ##             ##      ##  ##     ##     ## ##     ##      ##       ##       ##  ##
 ##  ##   ##  ##   ##  ##             ##      ##  ##     ##     ##  ##    ##      ##  ##   ##  ##   ##  ##
###  ##  ### ##   ### ##             ####    ###  ##    ####   #### ##   ####    ### ###  ### ###  ###  ##

"

leo run add_thirteen_raffle_entries aleo1xz7vdq0tnww7s9kpp7ahnkq4ydn9gffchwjrx27fuvylvnr29cqqj0zhac

echo "
  ##     ### ##   ### ##            ### ###   ## ##   ##  ###  ### ##   #### ##  ### ###  ### ###  ###  ##
   ##     ##  ##   ##  ##            ##  ##  ##   ##  ##   ##   ##  ##  # ## ##   ##  ##   ##  ##    ## ##
 ## ##    ##  ##   ##  ##            ##      ##   ##  ##   ##   ##  ##    ##      ##       ##       # ## #
 ##  ##   ##  ##   ##  ##            ## ##   ##   ##  ##   ##   ## ##     ##      ## ##    ## ##    ## ##
 ## ###   ##  ##   ##  ##            ##      ##   ##  ##   ##   ## ##     ##      ##       ##       ##  ##
 ##  ##   ##  ##   ##  ##            ##      ##   ##  ##   ##   ##  ##    ##      ##  ##   ##  ##   ##  ##
###  ##  ### ##   ### ##            ####      ## ##    ## ##   #### ##   ####    ### ###  ### ###  ###  ##

"

leo run add_fourteen_raffle_entries aleo1xz7vdq0tnww7s9kpp7ahnkq4ydn9gffchwjrx27fuvylvnr29cqqj0zhac

echo "
  ##     ### ##   ### ##            ### ###    ####   ### ###  #### ##  ### ###  ### ###  ###  ##
   ##     ##  ##   ##  ##            ##  ##     ##     ##  ##  # ## ##   ##  ##   ##  ##    ## ##
 ## ##    ##  ##   ##  ##            ##         ##     ##        ##      ##       ##       # ## #
 ##  ##   ##  ##   ##  ##            ## ##      ##     ## ##     ##      ## ##    ## ##    ## ##
 ## ###   ##  ##   ##  ##            ##         ##     ##        ##      ##       ##       ##  ##
 ##  ##   ##  ##   ##  ##            ##         ##     ##        ##      ##  ##   ##  ##   ##  ##
###  ##  ### ##   ### ##            ####       ####   ####      ####    ### ###  ### ###  ###  ##


"

leo run add_fifteen_raffle_entries aleo1xz7vdq0tnww7s9kpp7ahnkq4ydn9gffchwjrx27fuvylvnr29cqqj0zhac

echo "
### ##   ### ##     ##     ##   ##           ##   ##    ####   ###  ##  ###  ##  ### ###  ### ##
 ##  ##   ##  ##     ##    ##   ##           ##   ##     ##      ## ##    ## ##   ##  ##   ##  ##
 ##  ##   ##  ##   ## ##   ##   ##           ##   ##     ##     # ## #   # ## #   ##       ##  ##
 ##  ##   ## ##    ##  ##  ## # ##           ## # ##     ##     ## ##    ## ##    ## ##    ## ##
 ##  ##   ## ##    ## ###  # ### #           # ### #     ##     ##  ##   ##  ##   ##       ## ##
 ##  ##   ##  ##   ##  ##   ## ##             ## ##      ##     ##  ##   ##  ##   ##  ##   ##  ##
### ##   #### ##  ###  ##  ##   ##           ##   ##    ####   ###  ##  ###  ##  ### ###  #### ##


"

leo run draw_winner

echo "
 ## ##   ### ###  ###  ##  ### ##            ### ##   ### ##     ####   ### ##   ### ###
##   ##   ##  ##    ## ##   ##  ##            ##  ##   ##  ##     ##    ##  ##    ##  ##
####      ##       # ## #   ##  ##            ##  ##   ##  ##     ##       ##     ##
 #####    ## ##    ## ##    ##  ##            ##  ##   ## ##      ##      ##      ## ##
    ###   ##       ##  ##   ##  ##            ## ##    ## ##      ##     ##       ##
##   ##   ##  ##   ##  ##   ##  ##            ##       ##  ##     ##    ##  ##    ##  ##
 ## ##   ### ###  ###  ##  ### ##            ####     #### ##    ####   # ####   ### ###
"

# need to change pk to pk of operator for this function to pass

leo run send_prize_to_winner aleo1xz7vdq0tnww7s9kpp7ahnkq4ydn9gffchwjrx27fuvylvnr29cqqj0zhac "{
  owner: aleo1pedhtu6akw9z68wedu8t3fgxfdh3ye2rypeqkx9cxjpr99chqvyqkjg7rw.private,
  private_key: {
    pk_pt1: 252496349687615411424866113487376041671u128.private,
    pk_pt2: 286475219118120941632852794305998134102u128.private
  },
  _nonce: 899390276711048807475330890752563664469849018498297260305236813602187184926group.public
}"
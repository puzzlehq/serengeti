# The private key and address of the admin.
# Swap these in when running transactions as the deployer.
# "private_key": "APrivateKey1zkp9Qk6oZspRY6jgScdrmJsUi9PmdES5pmtzEakCMeVYnLs",
# "address": "aleo1as9067txqeya80e720ge68pt9faj6ymy20drfr5a7stfntyk95rqmv9afs"

# The private key and address of the initial depositor.
# Swap these in when running transactions as the depositor.
# "private_key": "APrivateKey1zkpALDDK4zAigs387emvnuxWXvGjFw2AmmYcQH7TBt8nhof"
# "address": "aleo1r4pc6ufjvw050jhzrew3vqm2lvacdxfd4a5ckulau0vjc72qvc8sr0jg2a"

# The private key and address of the staker.
# Swap these when running transactions from the staker.
# "private_key": "APrivateKey1zkp8pmTMT4FxG5qXZ9McEYDdY1G6YokY1BYzwoxTYJEKubF"
# "address": "aleo1asu88azw3uqud282sll23wh3tvmvwjdz5vhvu2jwyrdwtgqn5qgqetuvr6"


# Swap in the private key of the admin
echo "
NETWORK=testnet
PRIVATE_KEY=APrivateKey1zkp9Qk6oZspRY6jgScdrmJsUi9PmdES5pmtzEakCMeVYnLs
ENDPOINT="https://testnet.puzzle.online"
" > .env

echo "
initialize
"

leo run initialize 100u128 aleo1psjn2tup7xq6vejpfchpu0tf34m3y5h4h5235cft7a5vtsgetqqszur2ke

# Swap in the private key of the admin
echo "
NETWORK=testnet
PRIVATE_KEY=APrivateKey1zkp9Qk6oZspRY6jgScdrmJsUi9PmdES5pmtzEakCMeVYnLs
ENDPOINT="https://testnet.puzzle.online"
" > .env

echo "
initial_deposit
"

leo run initial_deposit 10_000_000_000u64 aleo1psjn2tup7xq6vejpfchpu0tf34m3y5h4h5235cft7a5vtsgetqqszur2ke


# Swap in the private key of the staker.
echo "
NETWORK=testnet
PRIVATE_KEY=APrivateKey1zkp8pmTMT4FxG5qXZ9McEYDdY1G6YokY1BYzwoxTYJEKubF
ENDPOINT="https://testnet.puzzle.online"
" > .env

echo "
deposit_public
"

leo run deposit_public 1_000_000u64

# Swap in the private key of the admin.
echo "
NETWORK=testnet
PRIVATE_KEY=APrivateKey1zkp9Qk6oZspRY6jgScdrmJsUi9PmdES5pmtzEakCMeVYnLs
ENDPOINT="https://testnet.puzzle.online"
" > .env

echo "
set next validator
"

leo run set_next_validator aleo1psjn2tup7xq6vejpfchpu0tf34m3y5h4h5235cft7a5vtsgetqqszur2ke

# Swap in the private key of the admin.
echo "
NETWORK=testnet
PRIVATE_KEY=APrivateKey1zkp9Qk6oZspRY6jgScdrmJsUi9PmdES5pmtzEakCMeVYnLs
ENDPOINT="https://testnet.puzzle.online"
" > .env

echo "
bond_all
"

# Swap in the private key of the staker.
echo "
NETWORK=testnet
PRIVATE_KEY=APrivateKey1zkp8pmTMT4FxG5qXZ9McEYDdY1G6YokY1BYzwoxTYJEKubF
ENDPOINT="https://testnet.puzzle.online"
" > .env


echo "
withdraw_public
"

leo run withdraw_public aleo1asu88azw3uqud282sll23wh3tvmvwjdz5vhvu2jwyrdwtgqn5qgqetuvr6 1u64 1u64

# Swap in the private key of the admin.
echo "
NETWORK=testnet
PRIVATE_KEY=APrivateKey1zkp9Qk6oZspRY6jgScdrmJsUi9PmdES5pmtzEakCMeVYnLs
ENDPOINT="https://testnet.puzzle.online"
" > .env


echo "
claim_unbond
"


leo run claim_unbond aleo1asu88azw3uqud282sll23wh3tvmvwjdz5vhvu2jwyrdwtgqn5qgqetuvr6

# Swap in the private key of the staker
echo "
NETWORK=testnet
PRIVATE_KEY=APrivateKey1zkp8pmTMT4FxG5qXZ9McEYDdY1G6YokY1BYzwoxTYJEKubF
ENDPOINT="https://testnet.puzzle.online"
" > .env


echo "
claim_withdrawal_public
"


leo run claim_withdrawal_public aleo1asu88azw3uqud282sll23wh3tvmvwjdz5vhvu2jwyrdwtgqn5qgqetuvr6 1u64
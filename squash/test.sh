# to swap out private keys:
# sed -i '' "s/PRIVATE_KEY=.*/PRIVATE_KEY=$ORACLE_KEY/" .env

PLAYER_KEY=APrivateKey1zkp4sc5nWLq2yLiPS8TDLYQayQXAn6VfCC3f8Ft66P6sSkg
PLAYER_ADDRESS=aleo1r8vz4dk0ku7fkwernv665e05zt5t4xv6mprrhxq3wwa9dpzjkvpsvxv99h
ORACLE_KEY=APrivateKey1zkp4sc5nWLq2yLiPS8TDLYQayQXAn6VfCC3f8Ft66P6asdf
DELTA=600u64

echo "
NETWORK=testnet
PRIVATE_KEY=$PLAYER_KEY
ENDPOINT=https://node.puzzle.online
" > .env

extract_outputs() {
  local output="$1"

  # extract the bullet points under "Outputs"
  local bullets=$(echo "$output" | awk '/Output[s]?/{flag=1; next} /Leo ✅ Finished/{flag=0} flag')

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

# 1 - mint the first timestamp
cd squash_time_oracle
echo "minting initial timestamp..."
run_output=$(leo run mint 600u64)
outputs=$(extract_outputs "$run_output")
timestamp=${outputs[0]}
echo "initial timestamp: $timestamp"

# 2 - mint the first squash
cd ../squash_game
echo "minting initial squash..."
echo "leo run mint $PLAYER_ADDRESS \"$timestamp\""
run_output=$(leo run mint $PLAYER_ADDRESS "$timestamp")
echo $run_output
outputs=$(extract_outputs "$run_output")
squash=${outputs[0]}
echo "initial squash: $squash"

# 3 - update timestamp
# 4 - water squash -- kg should be 1
# 5 - update timestamp
# 6 - update timestamp
# 7 - water squash -- kg should be 0.5
# 8 - 
# 9 - 
# 19 - 
# 11 - 
# 12 - 
# 13 - 
# 14 - 
# 15 - attempt double-water (fails)

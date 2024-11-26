# to swap out private keys:
# sed -i '' "s/PRIVATE_KEY=.*/PRIVATE_KEY=$ORACLE_KEY/" .env

PLAYER_ADDRESS=aleo1x4qm9ycjnm4uht6a7jvvl8v6vu20hhx864zagdtp34lscx6rhs9s8m3834
DELTA=600u64

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

function update_timestamp() {
  # echo "leo run update \"$TIMESTAMP\" $1\n"
  cd ../squash_time_oracle
  run_output=$(leo run update "$TIMESTAMP" $1)
  outputs=$(extract_outputs "$run_output")
  TIMESTAMP=${outputs[0]}
}

function extract_time() {
  local input="$1"
  local time=$(echo "$input" | awk -F'time:|u64' '{print $2}' | tr -d '[:space:]')
  echo "$time"
}

function water_squash() {
  # echo -e "leo run water \"$SQUASH\" \"$TIMESTAMP\" $1 10u64\n"
  cd ../squash_game
  run_output=$(leo run water "$SQUASH" "$TIMESTAMP" $1 10u64)
  outputs=$(extract_outputs "$run_output")
  SQUASH=${outputs[0]}
}

function extract_kg() {
  local input="$1"
  local kg=$(echo "$input" | awk -F'kg:|u64' '{print $2}' | tr -d '[:space:]')
  # echo "scale=6; $kg / 1000" | bc
  echo "$kg"
}

# 1 - mint the first timestamp
echo "minting initial timestamp..."
cd ./squash_time_oracle
run_output=$(leo run mint 0u64)
outputs=$(extract_outputs "$run_output")
TIMESTAMP=${outputs[0]}
echo "\ninitial timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 2 - mint the first squash
echo "\nminting initial squash..."
cd ../squash_game
run_output=$(leo run mint $PLAYER_ADDRESS "$TIMESTAMP")
outputs=$(extract_outputs "$run_output")
SQUASH=${outputs[0]}
echo "\ninitial squash: $SQUASH"
echo "initial kg: $(extract_kg $SQUASH)"

# 3 - update timestamp
echo "\nupdating timestamp to 10s..."
update_timestamp 10u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 4 - water squash -- kg should be 2
echo "\nwatering squash at 15s..."
water_squash 15u64
echo "updated squash: $SQUASH"
echo "updated kg: $(extract_kg $SQUASH)"

# 5 - update timestamp
echo "\nupdating timestamp to 20s..."
update_timestamp 20u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 6 - update timestamp AGAIN
echo "\nupdating timestamp to 30s..."
update_timestamp 30u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 7 - water squash -- kg should be 0.5
echo "\nwatering squash at 35s..."
water_squash 35u64
echo "updated squash: $SQUASH"
echo "updated kg: $(extract_kg $SQUASH)"

# 8 - 
# 9 - 
# 19 - 
# 11 - 
# 12 - 
# 13 - 
# 14 - 
# 15 - attempt double-water (fails)

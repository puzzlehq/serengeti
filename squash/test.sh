# to swap out private keys:
# sed -i '' "s/PRIVATE_KEY=.*/PRIVATE_KEY=$ORACLE_KEY/" .env

PLAYER_ADDRESS=aleo189pjvf988j58x2a3nxcexm8e8e4afxdfgymejnf2hhek4r8lcq9snjtdxz
DELTA=10u64

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
  echo -e "leo run water \"$SQUASH\" \"$TIMESTAMP\" $1 $DELTA\n"
  cd ../squash_game
  run_output=$(leo run water "$SQUASH" "$TIMESTAMP" $1 $DELTA)
  outputs=$(extract_outputs "$run_output")
  SQUASH=${outputs[0]}
}

function water_squash_and_level_up() {
  echo -e "leo run water_and_level_up \"$SQUASH\" \"$TIMESTAMP\" $1 $DELTA\n"
  cd ../squash_game
  run_output=$(leo run water_and_level_up "$SQUASH" "$TIMESTAMP" $1 $DELTA)
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

# 3 - update timestamp - 0 days missed
echo "\nupdating timestamp to 10s..."
update_timestamp 10u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 4 - water squash -- kg should be 2
echo "\nwatering squash at 15s..."
water_squash 15u64
echo "updated squash: $SQUASH"
echo "updated kg: $(extract_kg $SQUASH), expected kg: 2000000"

# 5 - update timestamp - 0 days missed
echo "\nupdating timestamp to 20s..."
update_timestamp 20u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 6 - update timestamp AGAIN - 1 day missed
echo "\nupdating timestamp to 30s..."
update_timestamp 30u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 7 - water squash -- kg should be 2.5
echo "\nwatering squash at 35s..."
water_squash 35u64
echo "updated squash: $SQUASH"
echo "updated kg: $(extract_kg $SQUASH), expected kg: 2500000"

# 8 - update timestamp - 0 days missed
echo "\nupdating timestamp to 40s..."
update_timestamp 40u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 9 - water squash -- kg should be 3.5
echo "\nwatering squash at 45s..."
water_squash 45u64
echo "updated squash: $SQUASH"
echo "updated kg: $(extract_kg $SQUASH), expected kg: 3500000"

# 10 - update timestamp - 0 days missed
echo "\nupdating timestamp to 50s..."
update_timestamp 50u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 11 - water squash -- kg should be 4.5
echo "\nwatering squash at 55s..."
water_squash 55u64
echo "updated squash: $SQUASH"
echo "updated kg: $(extract_kg $SQUASH), expected kg: 4500000"

# 12 - update timestamp - 0 days missed
echo "\nupdating timestamp to 60s..."
update_timestamp 60u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 13 - update timestamp AGAIN - 1 day missed, 0.5 kg loss
echo "\nupdating timestamp to 70s..."
update_timestamp 70u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 14 - update timestamp AGAIN - 2 days missed, 1.0 kg loss
echo "\nupdating timestamp to 80s..."
update_timestamp 80u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 15 - update timestamp AGAIN - 3 days missed, 1.5 kg loss
 echo "\nupdating timestamp to 90s..."
update_timestamp 90u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 16 - water squash -- kg should be 4
echo "\nwatering squash at 95s..."
water_squash 95u64
echo "updated squash: $SQUASH"
echo "updated kg: $(extract_kg $SQUASH) , expected kg: 4000000"

# 17 - update timestamp - 0 days missed
echo "\nupdating timestamp to 100s..."
update_timestamp 100u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 18 - update timestamp AGAIN - 1 days missed, 0.5 kg loss
echo "\nupdating timestamp to 110s..."
update_timestamp 110u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 19 - update timestamp AGAIN - 2 days missed, 1.0 kg loss
echo "\nupdating timestamp to 120s..."
update_timestamp 110u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 20 - update timestamp AGAIN - 3 days missed, 1.5 kg loss
echo "\nupdating timestamp to 130s..."
update_timestamp 130u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 21 - update timestamp AGAIN - 4 days missed, 2.0 kg loss
echo "\nupdating timestamp to 140s..."
update_timestamp 140u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 22 - update timestamp AGAIN - 5 days missed, 2.5 kg loss
echo "\nupdating timestamp to 150s..."
update_timestamp 150u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 23 - update timestamp AGAIN - 6 days missed, 3.0 kg loss
echo "\nupdating timestamp to 160s..."
update_timestamp 160u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 24 - update timestamp AGAIN - 7 days missed, 3.5 kg loss
echo "\nupdating timestamp to 170s..."
update_timestamp 170u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 25 - update timestamp AGAIN - 8 days missed, 4.0 kg loss
echo "\nupdating timestamp to 180s..."
update_timestamp 180u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 26 - update timestamp AGAIN - 9 days missed, 4.5 kg loss
echo "\nupdating timestamp to 190s..."
update_timestamp 190u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 27 - water squash -- kg should be 1.0
echo "\nwatering squash at 195s..."
water_squash 195u64
echo "updated squash: $SQUASH"
echo "updated kg: $(extract_kg $SQUASH) , expected kg: 1000000"

# 15 - attempt double-water (fails)

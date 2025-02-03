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

function get_first_text_section() {
    local input_string="$1"
    local first_word

    # Use awk to extract the first word before any whitespace
    first_word=$(echo "$input_string" | awk '{print $1}')

    # Print the first word
    echo "$first_word"
}

function update_timestamp() {
  # echo "leo run update \"$TIMESTAMP\" $1\n"
  cd ../timestamp
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
  cd ../game
  run_output=$(leo run water "$SQUASH" "$TIMESTAMP" $1 $DELTA)
  outputs=$(extract_outputs "$run_output")
  SQUASH=${outputs[0]}
}

function water_squash_and_level_up() {
  echo -e "leo run water_and_level_up \"$SQUASH\" \"$TIMESTAMP\" $1 $DELTA\n"
  cd ../game
  run_output=$(leo run water_and_level_up "$SQUASH" "$TIMESTAMP" $1 $DELTA)
  outputs=$(extract_outputs "$run_output")
  output=${outputs[0]};
  split_output=$(get_first_text_section "$output")
  SQUASH=${split_output}
}

function extract_kg() {
  local input="$1"
  local kg=$(echo "$input" | awk -F'kg:|u64' '{print $2}' | tr -d '[:space:]')
  # echo "scale=6; $kg / 1000" | bc
  echo "$kg"
}

function extract_level() {
  local input="$1"
  local level=$(echo "$input" | awk -F'level:|u8' '{print $2}' | tr -d '[:space:]')
  echo "$level"
}

# 1 - mint the first timestamp
echo "minting initial timestamp..."
cd ./timestamp
run_output=$(leo run mint 0u64)
outputs=$(extract_outputs "$run_output")
TIMESTAMP=${outputs[0]}
echo "\ninitial timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 2 - mint the first squash
echo "\nminting initial squash..."
cd ../game
run_output=$(leo run mint $PLAYER_ADDRESS 123456u128 123456u32 "$TIMESTAMP")
outputs=$(extract_outputs "$run_output")
SQUASH=${outputs[0]}
echo "\ninitial squash: $SQUASH"
echo "initial kg: $(extract_kg $SQUASH)"

# 3 - update timestamp - 0 days missed
echo "\nupdating timestamp to 10s..."
update_timestamp 10u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 4 - water squash -- kg should be 2.0
echo "\nwatering squash at 15s..."
water_squash 15u64
echo "updated squash: $SQUASH"
echo "updated kg: $(extract_kg $SQUASH), expected kg: 2000000"

# 5 - update timestamp - 0 days missed
echo "\nupdating timestamp to 20s..."
update_timestamp 20u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 6 - water squash -- kg should be 3.0
echo "\nwatering squash at 25s..."
water_squash 25u64
echo "updated squash: $SQUASH"
echo "updated kg: $(extract_kg $SQUASH), expected kg: 3000000"

# 7 - update timestamp - 0 days missed
echo "\nupdating timestamp to 30s..."
update_timestamp 30u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 8 - water squash -- kg should be 4.0
echo "\nwatering squash at 35s..."
water_squash 35u64
echo "updated squash: $SQUASH"
echo "updated kg: $(extract_kg $SQUASH), expected kg: 4000000"

# 9 - update timestamp - 0 days missed
echo "\nupdating timestamp to 40s..."
update_timestamp 40u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 10 - water squash -- kg should be 5.0
echo "\nwatering squash at 45s..."
water_squash 45u64
echo "updated squash: $SQUASH"
echo "updated kg: $(extract_kg $SQUASH), expected kg: 5000000"

# 11 - update timestamp - 0 days missed
echo "\nupdating timestamp to 50s..."
update_timestamp 50u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 12 - water squash -- kg should be 6.0
echo "\nwatering squash at 55s..."
water_squash 55u64
echo "updated squash: $SQUASH"
echo "updated kg: $(extract_kg $SQUASH), expected kg: 6000000"

# 13 - update timestamp - 0 days missed
echo "\nupdating timestamp to 60s..."
update_timestamp 60u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 14 - water squash -- kg should be 7.0
echo "\nwatering squash at 65s..."
water_squash 65u64
echo "updated squash: $SQUASH"
echo "updated kg: $(extract_kg $SQUASH), expected kg: 7000000"

# 13 - update timestamp - 0 days missed
echo "\nupdating timestamp to 70s..."
update_timestamp 70u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 14 - water squash -- kg should be 8.0
echo "\nwatering squash at 75s..."
water_squash 75u64
echo "updated squash: $SQUASH"
echo "updated kg: $(extract_kg $SQUASH), expected kg: 8000000"

# 15 - update timestamp - 0 days missed
echo "\nupdating timestamp to 80s..."
update_timestamp 80u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 16 - update timestamp - 1 days missed
echo "\nupdating timestamp to 90s..."
update_timestamp 90u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 17 - water squash -- kg should be 8.5
echo "\nwatering squash at 95s..."
water_squash 95u64
echo "updated squash: $SQUASH"
echo "updated kg: $(extract_kg $SQUASH), expected kg: 8500000"

# 18 - update timestamp - 0 days missed
echo "\nupdating timestamp to 100s..."
update_timestamp 100u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 19 - update timestamp - 1 days missed
echo "\nupdating timestamp to 110s..."
update_timestamp 110u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 20 - water squash -- kg should be 8.5
echo "\nwatering squash at 115s..."
water_squash 115u64
echo "updated squash: $SQUASH"
echo "updated kg: $(extract_kg $SQUASH), expected kg: 9000000"

# 21 - update timestamp - 0 days missed
echo "\nupdating timestamp to 120s..."
update_timestamp 120u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 22 - update timestamp - 1 days missed
echo "\nupdating timestamp to 130s..."
update_timestamp 130u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 23 - water squash -- kg should be 9.5
echo "\nwatering squash at 135s..."
water_squash 135u64
echo "updated squash: $SQUASH"
echo "updated kg: $(extract_kg $SQUASH), expected kg: 9500000"

# 24 - update timestamp - 0 days missed
echo "\nupdating timestamp to 140s..."
update_timestamp 140u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 25 - update timestamp - 1 days missed
echo "\nupdating timestamp to 150s..."
update_timestamp 150u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 26 water squash and level up -- kg should be 10.0, level should be 1
echo "\nwatering and leveling up squash at 155s..."
water_squash_and_level_up 155u64
echo "updated squash: $SQUASH"
echo "updated kg: $(extract_kg $SQUASH) , expected kg: 1050000"
echo "updated level: $(extract_level $SQUASH) , expected level: 1"

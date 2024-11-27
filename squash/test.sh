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
update_timestamp 120u64
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

# 26 - update timestamp AGAIN - 10 days missed, 5.0 kg loss
echo "\nupdating timestamp to 200s..."
update_timestamp 200u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 27 - water squash -- kg should be 1.0
echo "\nwatering squash at 205s..."
water_squash 205u64
echo "updated squash: $SQUASH"
echo "updated kg: $(extract_kg $SQUASH) , expected kg: 1000000"

# 28 - update timestamp - 0 days missed
echo "\nupdating timestamp to 210s..."
update_timestamp 210u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 29 - water squash -- kg should be 2.0
echo "\nwatering squash at 215s..."
water_squash 215u64
echo "updated squash: $SQUASH"
echo "updated kg: $(extract_kg $SQUASH) , expected kg: 2000000"

# 30 - update timestamp - 0 days missed
echo "\nupdating timestamp to 220s..."
update_timestamp 220u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 31 - water squash -- kg should be 3.0
echo "\nwatering squash at 225s..."
water_squash 225u64
echo "updated squash: $SQUASH"
echo "updated kg: $(extract_kg $SQUASH) , expected kg: 3000000"

# 32 - update timestamp - 0 days missed
echo "\nupdating timestamp to 230s..."
update_timestamp 230u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 33 - water squash -- kg should be 4.0
echo "\nwatering squash at 235s..."
water_squash 235u64
echo "updated squash: $SQUASH"
echo "updated kg: $(extract_kg $SQUASH) , expected kg: 4000000"

# 34 - update timestamp - 0 days missed
echo "\nupdating timestamp to 240s..."
update_timestamp 240u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 35 - water squash -- kg should be 5.0
echo "\nwatering squash at 245s..."
water_squash 245u64
echo "updated squash: $SQUASH"
echo "updated kg: $(extract_kg $SQUASH) , expected kg: 5000000"

# 36 - update timestamp - 0 days missed
echo "\nupdating timestamp to 250s..."
update_timestamp 250u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 37 - water squash -- kg should be 6.0
echo "\nwatering squash at 255s..."
water_squash 255u64
echo "updated squash: $SQUASH"
echo "updated kg: $(extract_kg $SQUASH) , expected kg: 6000000"

# 38 - update timestamp - 0 days missed
echo "\nupdating timestamp to 260s..."
update_timestamp 260u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 39 - water squash -- kg should be 7.0
echo "\nwatering squash at 265s..."
water_squash 265u64
echo "updated squash: $SQUASH"
echo "updated kg: $(extract_kg $SQUASH) , expected kg: 7000000"

# 40 - update timestamp - 0 days missed
echo "\nupdating timestamp to 270s..."
update_timestamp 270u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 41 - water squash -- kg should be 8.0
echo "\nwatering squash at 275s..."
water_squash 275u64
echo "updated squash: $SQUASH"
echo "updated kg: $(extract_kg $SQUASH) , expected kg: 8000000"

# 42 - update timestamp - 0 days missed
echo "\nupdating timestamp to 280s..."
update_timestamp 280u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 43 - water squash -- kg should be 9.0
echo "\nwatering squash at 285s..."
water_squash 285u64
echo "updated squash: $SQUASH"
echo "updated kg: $(extract_kg $SQUASH) , expected kg: 9000000"
echo "level: $(extract_level $SQUASH) , expected level: 0"

# 44 - update timestamp - 0 days missed
echo "\nupdating timestamp to 290s..."
update_timestamp 290u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 45 - water squash and level up -- kg should be 10.0, level should be 1
echo "\nwatering and leveling up squash at 295s..."
water_squash_and_level_up 295u64
echo "updated squash: $SQUASH"
echo "updated kg: $(extract_kg $SQUASH) , expected kg: 10000000"
echo "updated level: $(extract_level $SQUASH) , expected level: 1"

# 46 - update timestamp - 0 days missed
echo "\nupdating timestamp to 300s..."
update_timestamp 300u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 47 - water squash -- kg should be 11.0
echo "\nwatering squash at 305s..."
water_squash 305u64
echo "updated squash: $SQUASH"
echo "updated kg: $(extract_kg $SQUASH) , expected kg: 11000000"
echo "level: $(extract_level $SQUASH) , expected level: 1"

# 48 - update timestamp - 0 days missed
echo "\nupdating timestamp to 310s..."
update_timestamp 310u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 49 - update timestamp - 1 days missed,  0.5 kg loss
echo "\nupdating timestamp to 320s..."
update_timestamp 320u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 50 - update timestamp - 2 days missed,  1.0 kg loss
echo "\nupdating timestamp to 330s..."
update_timestamp 330u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# 51 - update timestamp - 3 days missed,  1.5 kg loss
echo "\nupdating timestamp to 340s..."
update_timestamp 340u64
echo "updated timestamp: $TIMESTAMP"
echo "time: $(extract_time $TIMESTAMP)"

# # 52 - water squash and level up -- this should fail bc we already leveled up
# echo "\nwatering and leveling up squash at 335s..."
# water_squash_and_level_up 335u64
# echo "updated squash: $SQUASH"
# echo "updated kg: $(extract_kg $SQUASH) , expected kg: 9500000"
# echo "updated level: $(extract_level $SQUASH) , expected level: 1"

# 53 - water squash -- kg should be 10.5, level should be 1
echo "\nwatering and leveling up squash at 345s..."
water_squash 345u64
echo "updated squash: $SQUASH"
echo "updated kg: $(extract_kg $SQUASH) , expected kg: 10500000"
echo "updated level: $(extract_level $SQUASH) , expected level: 1"
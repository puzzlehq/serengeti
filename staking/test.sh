#!/bin/bash

# Array of transaction IDs with their timestamps and functions
declare -a txs=(
    "au1rlkmt4g0venp0wy2l8c8n7yc7uyp7vqr75lz4axnw3amea5jhy9smx80jx:2024-11-12 11:20:36:claim_withdrawal"
    "au176j32u78mp7xuyxkxuuenqd6epkw3amrj2wah4j09vrr8x9kv59qega70a:2024-11-12 11:18:04:claim_unbond"
    "au1ve5z8dc6ym32laazvcv5msrzf9h8wgsk9y5l6gdupzs2rj70auqqlze656:2024-11-08 16:34:11:withdraw_public"
    "au1yrvx38aefkn94nhzf2ctrhprn8xzvy0wvzc0mqwgh7qxsptplqxsecpmuc:2024-11-08 16:32:46:bond_deposits"
    "au1vajjk0g3rxlqkaujpk4fsa0dxye4xjxtr73087078335cdsmxczq5rz6xe:2024-11-08 16:28:34:withdraw_public"
    "au185um39c8h24gt0xyysptczlepl6lhrahf7379mckceels5tst5yqd45peg:2024-11-08 16:25:13:withdraw_public"
    "au166wpxas22q4jl8yc4ryrm2ckuq39x9m0fwacg5d95tz2ms7zuyzstsea3h:2024-11-08 16:21:19:withdraw_public"
    "au1r8r4n8njz8m7lml2086xzlyefmut8ltappcpmytp866aemlqr5zqlvsgzy:2024-11-08 16:19:58:bond_deposits"
    "au1dynrhxrplqsnj3nwl5t96c05ya69w3sk2a59f4l62h52nck6gvqsxdrm95:2024-11-08 16:18:24:deposit_public"
    "au1uh75uv22t0lehtmpcfs8cyka7p5m97j2ah4v2ravfh46fs3v0ugqage5vx:2024-11-08 16:16:31:deposit_public"
)

echo "Analyzing Puzzle Staking Protocol Transactions..."
echo "----------------------------------------------"

for tx in "${txs[@]}"; do
    # Split the transaction info
    IFS=':' read -r txid timestamp function <<< "$tx"
    
    echo -e "\nTransaction: $txid"
    echo "Timestamp: $timestamp"
    echo "Function: $function"
    
    # Fetch transaction data
    response=$(curl -s "https://node.puzzle.online/testnet/transaction/confirmed/$txid")
    
    # Extract relevant information based on function type
    case $function in
        "deposit_public")
            # Extract deposit amount from inputs
            amount=$(echo "$response" | grep -o '"value": "[0-9]*u64"' | head -1 | grep -o '[0-9]*')
            echo "Deposit Amount: $amount microcredits"
            ;;
        "bond_deposits")
            # Extract bond amount
            amount=$(echo "$response" | grep -o '"value": "[0-9]*u64"' | head -1 | grep -o '[0-9]*')
            echo "Bond Amount: $amount microcredits"
            ;;
        "withdraw_public")
            # Extract withdrawal shares and total withdrawal
            shares=$(echo "$response" | grep -o '"value": "[0-9]*u64"' | head -1 | grep -o '[0-9]*')
            total=$(echo "$response" | grep -o '"value": "[0-9]*u64"' | head -2 | tail -1 | grep -o '[0-9]*')
            echo "Withdrawal Shares: $shares"
            echo "Total Withdrawal: $total microcredits"
            ;;
        "claim_unbond")
            echo "Claiming unbonded tokens"
            ;;
        "claim_withdrawal")
            amount=$(echo "$response" | grep -o '"value": "[0-9]*u64"' | head -1 | grep -o '[0-9]*')
            echo "Claimed Amount: $amount microcredits"
            ;;
    esac
    
    echo "----------------------------------------"
done

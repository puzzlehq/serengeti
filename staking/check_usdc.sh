#!/bin/bash

# Replace with your Etherscan API key
API_KEY="9WEH4MU4UMP2MFGPABJV9FX8S2NFS12UD7"

# USDC contract address on Ethereum mainnet
USDC_CONTRACT="0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48"

# Create a temp file for counts
temp_file=$(mktemp)
echo "0 0" > $temp_file  # Initialize counts: total_checked significant_balance

# Function to check USDC balance
check_usdc_balance() {
    address=$1
    echo "Checking USDC balance for: $address"
    
    # Call Etherscan API for token balance
    response=$(curl -s "https://api.etherscan.io/api?module=account&action=tokenbalance&contractaddress=$USDC_CONTRACT&address=$address&tag=latest&apikey=$API_KEY")
    
    # Extract balance and convert from 6 decimals (USDC has 6 decimals)
    balance=$(echo $response | jq -r '.result')
    if [ ! -z "$balance" ] && [ "$balance" != "null" ]; then
        usdc=$(echo "scale=6; $balance / 1000000" | bc)
        echo "Balance: $usdc USDC"
        
        # Read current counts
        read total sig < $temp_file
        
        # Increment total
        total=$((total + 1))
        
        # Check if balance meets threshold ($5)
        if (( $(echo "$usdc >= 5" | bc -l) )); then
            sig=$((sig + 1))
        fi
        
        # Save updated counts
        echo "$total $sig" > $temp_file
        
    else
        echo "Failed to get balance"
    fi
    echo "------------------------"
    
    # Sleep to respect rate limits
    sleep 0.25
}

echo "Starting USDC balance check for first 20 addresses..."
echo "------------------------"

# Process first 20 addresses
cat mainnet.raffles_v2.json | grep -o '"url": "[^"]*"' | cut -d'"' -f4 | cut -d'/' -f5 | head -n 20 | while read address; do
    check_usdc_balance "$address"
done

# Read final counts
read total_checked significant_balance < $temp_file

# Print summary
echo ""
echo "=== SUMMARY ==="
echo "Total addresses checked: $total_checked"
echo "Addresses with ≥ 5 USDC: $significant_balance"
echo "==================="

# Cleanup
rm $temp_file

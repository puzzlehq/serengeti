#!/bin/bash

# Replace with your Etherscan API key
API_KEY="9WEH4MU4UMP2MFGPABJV9FX8S2NFS12UD7"

# Create a temporary file to store results
temp_file=$(mktemp)
echo "0 0" > $temp_file  # Initialize counts: total_checked significant_balance

# Function to check balance of an address
check_balance() {
    address=$1
    echo "Checking balance for: $address"
    
    # Call Etherscan API
    response=$(curl -s "https://api.etherscan.io/api?module=account&action=balance&address=$address&tag=latest&apikey=$API_KEY")
    
    # Extract balance and convert from wei to ETH
    balance=$(echo $response | jq -r '.result')
    if [ ! -z "$balance" ] && [ "$balance" != "null" ]; then
        ether=$(echo "scale=18; $balance / 1000000000000000000" | bc)
        echo "Balance: $ether ETH"
        
        # Read current counts
        read total sig < $temp_file
        
        # Increment total
        total=$((total + 1))
        
        # Check if balance meets threshold
        if (( $(echo "$ether >= 0.004" | bc -l) )); then
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

echo "Starting balance check for all addresses..."
echo "------------------------"

# Process each address
cat mainnet.raffles_v2.json | grep -o '"url": "[^"]*"' | cut -d'"' -f4 | cut -d'/' -f5 | while read address; do
    check_balance "$address"
done

# Read final counts
read total_checked significant_balance < $temp_file

# Print summary
echo ""
echo "=== SUMMARY ==="
echo "Total addresses checked: $total_checked"
echo "Addresses with ≥ 0.004 ETH: $significant_balance"
echo "==================="

# Cleanup
rm $temp_file

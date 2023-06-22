#!/usr/bin/env bash

# Validation constraints
re='^[-0-9\.?0-9 ]+ [-+*/^] [-0-9\.?0-9]+$'
OPERATION_HISTORY_FILE="operation_history.txt"

# Function that validates the input, calculates the operation and prints the result
calculate() {
    if [[ "$REPLY" =~ $re ]]; then
        arithmetic_result=$(echo "scale=2; $REPLY" | bc -l)
        printf "%s\n" "$arithmetic_result" | tee -a "$OPERATION_HISTORY_FILE"
    else
        echo "Operation check failed!" | tee -a "$OPERATION_HISTORY_FILE"
    fi
}

# Let's start the Simple Calculator - Bash Shell Application
touch $OPERATION_HISTORY_FILE >| $OPERATION_HISTORY_FILE

# Let's start with the welcome message
echo "Welcome to the basic calculator!" | tee -a "$OPERATION_HISTORY_FILE"

while true; do 
    echo "Enter an arithmetic operation or type 'quit' to quit:" | tee -a "$OPERATION_HISTORY_FILE"
    read -r REPLY
    echo "$REPLY" >> "$OPERATION_HISTORY_FILE"

    case $REPLY in
        0 | 'quit')
            # Prints the goodbye message and exit
            echo "Goodbye!" | tee -a "$OPERATION_HISTORY_FILE"
            break;
            ;;
        *)
            calculate "$REPLY"
            ;;
    esac
done
#!/usr/bin/env bash

OPERATION_HISTORY_FILE="operation_history.txt"

# Function to read an input
read_input() {
    # Start with a message
    message="Enter an arithmetic operation or type 'quit' to quit:"
    echo "$message"
    append_to_file "$message"

    # Read two numbers and one operator on one line from the standard input
    read input
    append_to_file "$input"
}

# Function to validate the input
validate_input() {
    # Validation constraints
    match_number='^[-]?[0-9]*[.]?[0-9]+$'
    match_operator='^[-\/*+^]$'

    # Extract the numbers and operator from the input
    number1=$(echo "$input" | awk '{print $1}')
    number2=$(echo "$input" | awk '{print $3}')
    operator=$(echo "$input" | awk '{print $2}')

    # Count the number of words in the input string
    word_count=$(echo "$input" | wc -w)

    # Check whether the numbers are integers. Numbers could be 
    # positive, negative, or zeros
    # Check whether an operator is correct. Operators can be 
    # multiplication, division, addition, and subtraction
    if [[ "$number1" =~ $match_number ]] && \
        [[ "$number2" =~ $match_number ]] && \
        [[ "$operator" =~ $match_operator ]] && \
        [[ ${#operator} -eq 1 ]] && \
        [[ "$word_count" -eq 3 ]]; then
        return 0 # true
    fi

    return 1 # false
}

# Function to calculate
calculate_and_print() {
    if [[ "$1" -eq 0 ]]; then
        arithmetic_result=$( echo "scale=2; $number1 $operator $number2" | bc -l)
        printf "%s\n" "$arithmetic_result"
        append_to_file "$arithmetic_result"
    else
        fail_message="Operation check failed!"
        printf "%s\n" "$fail_message"
        append_to_file "$fail_message"
    fi
}

append_to_file() {
    echo "$1" >> "$OPERATION_HISTORY_FILE"
}

overwrite_the_file() {
    echo "$1" > "$OPERATION_HISTORY_FILE"
}

# Let's start the Simple Calculator Bash Shell Application
overwrite_the_file -n ""

# Start with the welcoming message.
welcome_message="Welcome to the basic calculator!"
echo "$welcome_message"
append_to_file "$welcome_message"

while true; do
    # Call the read_input function
    read_input

    if [[ "$input" == "quit" ]]; then
        break
    fi

    # Call the validate_input function
    validate_input

    if [[ $? -eq 0 ]]; then
        calculate_and_print 0
    else
        calculate_and_print 1
    fi
done

# Print the goodbye message and exit
goodbye_message="Goodbye!"
echo $goodbye_message
append_to_file "$goodbye_message"
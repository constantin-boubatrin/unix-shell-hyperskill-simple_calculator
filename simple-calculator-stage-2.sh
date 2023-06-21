#!/usr/bin/env bash

# Start with a message
echo "Enter an arithmetic operation:"

# Read two numbers and one operator on one line from the standard input
read input

# Extract the numbers and operator from the input
number1=$(echo "$input" | awk '{print $1}')
number2=$(echo "$input" | awk '{print $3}')
operator=$(echo "$input" | awk '{print $2}')

# Count the number of words in the input string
word_count=$(echo "$input" | wc -w)

result="Operation check "
match_number='^-?[0-9]+$'
match_operator='[-+*/]'

# Check whether the numbers are integers. Numbers could be 
# positive, negative, or zeros
if [[ "$number1" =~ $match_number ]] && \
        [[ "$number2" =~ $match_number ]] && \
        (( "$word_count" == 3 )); then

    # Check whether an operator is correct. Operators can be 
    # multiplication, division, addition, and subtraction
    if [[ "$operator" == $match_operator ]]; then
        arithmetic_result=$(( "$number1" "$operator" "$number2" ))
        printf "%s\n" "$arithmetic_result"
    else
        result+="failed!"
        printf "%s\n" "$result"
    fi
else
    result+="failed!"
    printf "%s\n" "$result"
fi
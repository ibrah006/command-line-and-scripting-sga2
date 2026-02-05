#!/bin/bash

# Check if input.txt exists and is readable
if [ ! -r "input.txt" ]; then
    echo "Error: input.txt does not exist or is not readable."
    exit 1
fi

# Extract all words (split by spaces and punctuation), one per line
words=$(tr -cs '[:alnum:]' '\n' < input.txt)

# Longest word
longest=$(echo "$words" | awk '{ if(length > max) { max=length; word=$0 } } END { print word }')

# Shortest word
shortest=$(echo "$words" | awk 'length>0 { if(min==0 || length<min) { min=length; word=$0 } } END { print word }')

# Average word length
total_length=$(echo "$words" | awk '{sum += length} END {print sum}')
total_words=$(echo "$words" | wc -l)
if [ "$total_words" -ne 0 ]; then
    avg_length=$(echo "scale=2; $total_length / $total_words" | bc)
else
    avg_length=0
fi

# Total number of unique words (case-insensitive)
unique_count=$(echo "$words" | tr '[:upper:]' '[:lower:]' | sort | uniq | wc -l)

# Display results
echo "Longest word: $longest"
echo "Shortest word: $shortest"
echo "Average word length: $avg_length"
echo "Total number of unique words: $unique_count"

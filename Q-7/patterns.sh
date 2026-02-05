#!/bin/bash

# Check if a file is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <input_file>"
    exit 1
fi

input="$1"

# Check if the file exists and is readable
if [ ! -r "$input" ]; then
    echo "Error: $input does not exist or is not readable."
    exit 1
fi

# Clear output files
> vowels.txt
> consonants.txt
> mixed.txt

# Extract words (split by non-alphanumeric characters), one per line
tr -cs '[:alpha:]' '\n' < "$input" | tr '[:upper:]' '[:lower:]' | while read -r word; do
    # Skip empty lines
    [ -z "$word" ] && continue

    # Check if word contains only vowels
    if [[ "$word" =~ ^[aeiou]+$ ]]; then
        echo "$word" >> vowels.txt
    # Check if word contains only consonants
    elif [[ "$word" =~ ^[bcdfghjklmnpqrstvwxyz]+$ ]]; then
        echo "$word" >> consonants.txt
    # Word contains both vowels and consonants, starts with consonant
    elif [[ "$word" =~ ^[bcdfghjklmnpqrstvwxyz] ]] && [[ "$word" =~ [aeiou] ]] && [[ "$word" =~ [bcdfghjklmnpqrstvwxyz] ]]; then
        echo "$word" >> mixed.txt
    fi
done

echo "Pattern extraction completed."
echo "Vowel-only words: vowels.txt"
echo "Consonant-only words: consonants.txt"
echo "Mixed words starting with consonant: mixed.txt"

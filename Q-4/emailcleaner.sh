#!/bin/bash

# Check if emails.txt exists and is readable
if [ ! -r "emails.txt" ]; then
    echo "Error: emails.txt does not exist or is not readable."
    exit 1
fi

# Regex for valid email: letters_and_digits@letters.com
valid_regex='^[a-zA-Z0-9_]+@[a-zA-Z]+\.com$'

# Extract valid email addresses
grep -E "$valid_regex" emails.txt > valid.txt

# Remove duplicates from valid.txt
sort valid.txt | uniq > temp.txt
mv temp.txt valid.txt

# Extract invalid email addresses
grep -Ev "$valid_regex" emails.txt > invalid.txt

echo "Email processing completed."
echo "Valid emails saved in valid.txt"
echo "Invalid emails saved in invalid.txt"

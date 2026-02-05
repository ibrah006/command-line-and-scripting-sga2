#!/bin/bash

# Check for exactly two arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <dirA> <dirB>"
    exit 1
fi

dirA="$1"
dirB="$2"

# Check if directories exist
if [ ! -d "$dirA" ]; then
    echo "Error: $dirA is not a valid directory."
    exit 1
fi

if [ ! -d "$dirB" ]; then
    echo "Error: $dirB is not a valid directory."
    exit 1
fi

echo "Files only in $dirA:"
echo "-------------------"
for file in "$dirA"/*; do
    filename=$(basename "$file")
    if [ ! -e "$dirB/$filename" ]; then
        echo "$filename"
    fi
done

echo
echo "Files only in $dirB:"
echo "-------------------"
for file in "$dirB"/*; do
    filename=$(basename "$file")
    if [ ! -e "$dirA/$filename" ]; then
        echo "$filename"
    fi
done

echo
echo "Files present in BOTH directories but with different contents:"
echo "-------------------------------------------------------------"
for file in "$dirA"/*; do
    filename=$(basename "$file")
    if [ -e "$dirB/$filename" ]; then
        # Compare contents using cmp
        if ! cmp -s "$dirA/$filename" "$dirB/$filename"; then
            echo "$filename"
        fi
    fi
done

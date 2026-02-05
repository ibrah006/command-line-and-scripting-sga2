#!/bin/bash

# Check for a single argument
if [ "$#" -ne 1 ]; then
        echo "Error: Exactly one argument is required."
        exit 1
fi 

path="$1"

# Check if path exists 
if [ ! -e "$path" ]; then
        echo "Erorr: path does not exist."
        exit 1
fi

# if argument is a file
if [ -f "$path" ]; then
        echo "File analysis for: $path"
        wc "$path"
# if argument is directory
elif [ -d "$path" ]; then
        echo "Directory analysis for: $path"

        total_files=$(find "$path" -type f | wc -l)
        txt_files=$(find "$path" -type f -name "*.txt" | wc -l)

        echo "Total number of files found: $total_files"
        echo "Number of .txt files found: $txt_files"
else 
        echo "Error: Unsupported file type"
        exit 
fi

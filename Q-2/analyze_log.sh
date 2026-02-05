#!/bin/bash

# Check argument count
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <log_file>"
    exit 1
fi

logfile="$1"

# Check file existence
if [ ! -e "$logfile" ]; then
    echo "Error: File does not exist."
    exit 1
fi

# Check readability
if [ ! -r "$logfile" ]; then
    echo "Error: File is not readable."
    exit 1
fi

# Regex for log format
# YYYY-MM-DD HH:MM:SS LEVEL MESSAGE
regex='^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2} (INFO|ERROR|WARNING) .+'

# Validate each line
line_number=0
while IFS= read -r line; do
    line_number=$((line_number + 1))
    if [[ ! $line =~ $regex ]]; then
        echo "Error: Invalid log format at line $line_number"
        echo ">> $line"
        exit 1
    fi
done < "$logfile"

echo "Log file format is valid."

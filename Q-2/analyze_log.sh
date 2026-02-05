#!/bin/bash

# Check if exactly one argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <log_file>"
    exit 1
fi

logfile="$1"

# Check if file exists
if [ ! -e "$logfile" ]; then
    echo "Error: File does not exist."
    exit 1
fi

# Check if file is readable
if [ ! -r "$logfile" ]; then
    echo "Error: File is not readable."
    exit 1
fi

echo "Log file '$logfile' exists and is readable."

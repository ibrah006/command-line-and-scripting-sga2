#!/bin/bash

# Check if exactly one argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory_path>"
    exit 1
fi

dir="$1"

# Check if directory exists
if [ ! -d "$dir" ]; then
    echo "Error: $dir is not a valid directory."
    exit 1
fi

# Create backup subdirectory if it doesn't exist
backup_dir="$dir/backup"
mkdir -p "$backup_dir"

echo "Starting file moves in background (Parent PID: $$)"

# Loop through regular files only
for file in "$dir"/*; do
    [ ! -f "$file" ] && continue  # Skip directories

    # Move file in the background
    mv "$file" "$backup_dir/" &
    pid=$!
    echo "Moving $(basename "$file") in background with PID $pid"
done

# Wait for all background processes to finish
wait
echo "All background move operations completed."

#!/bin/bash

# 1. Check argument count
if [ "$#" -ne 1 ]; then
    echo "Error: Exactly one log file must be provided."
    exit 1
fi

logfile="$1"

# 2. Validate file existence
if [ ! -e "$logfile" ]; then
    echo "Error: File does not exist."
    exit 1
fi

# Validate readability
if [ ! -r "$logfile" ]; then
    echo "Error: File is not readable."
    exit 1
fi

# Validate non-empty file
if [ ! -s "$logfile" ]; then
    echo "Error: Log file is empty."
    exit 1
fi

# Log format regex
# YYYY-MM-DD HH:MM:SS LEVEL MESSAGE
regex='^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2} (INFO|WARNING|ERROR) .+'

# Validate log format line by line
line_no=0
while IFS= read -r line; do
    line_no=$((line_no + 1))
    if [[ ! $line =~ $regex ]]; then
        echo "Error: Invalid log format at line $line_no"
        echo ">> $line"
        exit 1
    fi
done < "$logfile"

# Date for report file
today=$(date +%Y-%m-%d)
report="logsummary_${today}.txt"

# 3. Count log entries
total_entries=$(wc -l < "$logfile")
info_count=$(grep -c " INFO " "$logfile")
warning_count=$(grep -c " WARNING " "$logfile")
error_count=$(grep -c " ERROR " "$logfile")

# 4. Most recent ERROR message
recent_error=$(grep " ERROR " "$logfile" | tail -n 1)

if [ -z "$recent_error" ]; then
    recent_error="No ERROR messages found."
fi

# 5. Generate report
{
    echo "Log Summary Report"
    echo "Date: $today"
    echo "---------------------------"
    echo "Total log entries: $total_entries"
    echo "INFO messages: $info_count"
    echo "WARNING messages: $warning_count"
    echo "ERROR messages: $error_count"
    echo
    echo "Most Recent ERROR:"
    echo "$recent_error"
} > "$report"

echo "Log analysis completed successfully."
echo "Report generated: $report"

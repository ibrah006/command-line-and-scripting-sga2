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

# Date for report file
date_today=$(date +%Y-%m-%d)
report="logsummary_${date_today}.txt"

# 3. Count total log entries
total_entries=$(wc -l < "$logfile")

# Count log levels
info_count=$(grep -c " INFO " "$logfile")
warning_count=$(grep -c " WARNING " "$logfile")
error_count=$(grep -c " ERROR " "$logfile")

# 4. Get most recent ERROR message
recent_error=$(grep " ERROR " "$logfile" | tail -n 1)

# Handle case where no ERROR exists
if [ -z "$recent_error" ]; then
    recent_error="No ERROR messages found."
fi

# 5. Generate report file
{
    echo "Log Summary Report"
    echo "Date: $date_today"
    echo "-------------------------"
    echo "Total log entries: $total_entries"
    echo "INFO messages: $info_count"
    echo "WARNING messages: $warning_count"
    echo "ERROR messages: $error_count"
    echo
    echo "Most Recent ERROR:"
    echo "$recent_error"
} > "$report"

# Display summary to user
echo "Log analysis completed successfully."
echo "Report generated: $report"

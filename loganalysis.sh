#!/bin/bash
# log_analysis.sh - A script to parse and analyze log files using a configuration file

# Load configuration
CONFIG_FILE="log_analysis.conf"
if [ ! -f "$CONFIG_FILE" ]; then
  echo "Configuration file not found!"
  exit 1
fi
source $CONFIG_FILE

# Check if the log file exists
if [ ! -f "$LOG_FILE" ]; then
  echo "Log file not found!"
  exit 1
fi

# Clear the output file if it exists
> $OUTPUT_FILE

# Extract specific information: Errors and Warnings
echo "Extracting Errors and Warnings..." | tee -a $OUTPUT_FILE
grep -i -E "$ERROR_PATTERNS" $LOG_FILE | tee -a $OUTPUT_FILE

# Generate statistics: Number of Errors per hour
echo -e "\nGenerating Error Statistics..." | tee -a $OUTPUT_FILE
grep -i "$ERROR_PATTERNS" $LOG_FILE | awk '{print $1,$2}' | cut -d: -f1,2 | uniq -c | sort -nr | tee -a $OUTPUT_FILE

# Identify log patterns: Repeated failed login attempts
echo -e "\nIdentifying Failed Login Attempts..." | tee -a $OUTPUT_FILE
grep "$FAILED_LOGIN_PATTERN" $LOG_FILE | awk '{print $(NF-3)}' | sort | uniq -c | sort -nr | tee -a $OUTPUT_FILE

echo -e "\nLog analysis completed. Results saved to $OUTPUT_FILE."

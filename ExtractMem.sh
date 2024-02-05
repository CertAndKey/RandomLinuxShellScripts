#!/bin/sh
 
pid=<pid>  # Replace with your process ID
 
# Loop over each line in the maps file
grep -E '^[0-9a-f]*-[0-9a-f]*' /proc/$pid/maps | while read -r line
do
    # Extract start and end addresses from line
    START_ADDR=$(echo $line | awk '{print $1}' | cut -d '-' -f 1) 
    END_ADDR=$(echo $line | awk '{print $1}' | cut -d '-' -f 2) 
    # Calculate how many bytes to read using shell arithmetic
    BYTES_TO_READ=$((0x$END_ADDR - 0x$START_ADDR))
 
    echo "Range ${START_ADDR}-${END_ADDR} (Bytes to read: $BYTES_TO_READ):"
 
    # Read from /proc/<pid>/mem using dd and output to terminal with hexdump
    sudo dd if=/proc/$pid/mem bs=1 skip=$((0x$START_ADDR)) count=$BYTES_TO_READ 2>/dev/null | hexdump -C
done

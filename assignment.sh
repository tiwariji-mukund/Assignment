# Path to the Logs folder
logs_folder="Path to the Logs folder"

# Find and list all log files in the Logs folder, then sort by size in descending order
log_files=$(find "$logs_folder" -name "name of the log file" -type f -exec du -h {} + | sort -rh)

# Loop through the sorted log files and truncate them to 100 lines
echo "$log_files" | while IFS= read -r line; do
    size=$(echo "$line" | awk '{print $1}')
    file=$(echo "$line" | awk '{print $2}')
    
    echo "Truncating $file to 100 lines..."
    tail -n 100 "$file" > "$file.tmp"
    mv "$file.tmp" "$file"
    
    echo "Truncated $file to 100 lines. Size before: $size"
done

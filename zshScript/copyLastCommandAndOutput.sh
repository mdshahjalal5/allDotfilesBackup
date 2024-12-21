
# Fetch the last command
last_command=$(fc -ln -1)

# Execute the command and capture the output
output=$($last_command 2>&1)  # Captures stdout and stderr

# Combine the command and its output
combined="$last_command\n$output"

# Use xclip or xsel directly to copy to clipboard
if command -v xclip &> /dev/null; then
  echo -e "$combined" | xclip -selection clipboard  # Linux with xclip
elif command -v xsel &> /dev/null; then
  echo -e "$combined" | xsel --clipboard --input  # Linux with xsel
else
  echo "No clipboard utility found! Install xclip or xsel."
fi





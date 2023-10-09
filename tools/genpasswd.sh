#!/bin/bash

# A naive script for generating an authentication file with 
# username:{sha256-encoded-passwd} lines. 

# Check if filename is provided
if [[ $# -eq 0 ]]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

filename="$1"
rm -f $filename

# Function to handle exit signals
exit_cleanly() {
    echo -e "\Done."
    exit 0
}

# Trap exit signals: SIGINT and SIGTERM
trap exit_cleanly SIGINT SIGTERM

# Loop until Ctrl-D is pressed
while true; do
    read -p "Username: " username
    if [[ -z "$username" ]]; then
        echo "Exiting."
        break
    fi    
    read -sp "Password: " password
    echo # Add a newline character after hiding input

    if [[ -z "$password" ]]; then
        echo "Exiting."
        break
    fi

    hashed_password=$(echo -n "$password" | sha256sum | awk '{print $1}')
    echo "$username:$hashed_password" >> "$filename"
    echo "Credentials saved."
done

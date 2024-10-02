#!/bin/bash

echo -e "Checking for updates...\n"

# Function to compare version numbers
version_gt() { 
    test "$(printf '%s\n' "$@" | sort -V | head -n 1)" != "$1"; 
}

# Check if dpkg-query is available (Debian-based systems)
if command -v dpkg-query > /dev/null 2>&1; then
    # Get current installed version of Discord
    current_version=$(dpkg-query -W -f='${Version}' discord 2>/dev/null)
else
    echo "dpkg-query not found. This script is designed for Debian-based systems."
    exit 1
fi

# Get latest available version of Discord
redirect_url=$(curl -sIL https://discord.com/api/download/stable?platform=linux | grep -i '^location' | awk '{print $2}' | tr -d '\r\n')
latest_version=$(echo "$redirect_url" | grep -oP '[0-9]+\.[0-9]+\.[0-9]+' | head -n1)

# Check if update is necessary
if [ -z "$current_version" ]; then
    echo "Discord is not installed."
    exit 1
fi

if version_gt "$latest_version" "$current_version"; then
    # Print version information
    echo "You are currently running Discord version $current_version."
    echo -e "The latest version of Discord available is $latest_version.\n"

    # Update Discord
    if command -v wget > /dev/null 2>&1; then
        sudo wget --show-progress -O discord.deb "$redirect_url"
    else
        echo "wget not found. Please install wget to proceed."
        exit 1
    fi

    if [ -f discord.deb ]; then
        sudo dpkg --install discord.deb && sudo rm -f discord.deb
    else
        echo "Failed to download Discord."
        exit 1
    fi
else 
    echo -e "Discord is up to date, no need for updates.\n"
fi

echo -e "\nLaunching Discord..."
discord

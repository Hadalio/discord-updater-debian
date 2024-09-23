# Discord Auto Updater

A Bash script for checking and updating Discord on Debian-based systems. This script automatically checks if there's a newer version of Discord available, downloads the `.deb` package, installs it, and launches Discord.

## Features
- Compares installed version of Discord with the latest available version.
- Downloads and installs the latest version if an update is needed.
- Compatible with Debian-based systems (e.g., Ubuntu, Linux Mint).
  
## Requirements
- **dpkg-query** (for checking installed Discord version)
- **curl** (for fetching the latest version)
- **wget** (for downloading the `.deb` package)
  
Ensure these dependencies are installed by running:

```bash
sudo apt update
sudo apt install curl wget

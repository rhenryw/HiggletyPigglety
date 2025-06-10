#!/bin/bash

set -e

# Function to detect if a command exists
has() {
  command -v "$1" >/dev/null 2>&1
}

echo "[*] Checking environment..."

# Try to install sudo if missing (only works if user has root access)
if ! has sudo; then
  echo "[!] 'sudo' not found. Trying to install it..."
  if has apt; then
    su -c "apt update && apt install -y sudo"
  else
    echo "[ERROR] 'sudo' is required and could not be installed automatically."
    exit 1
  fi
fi

# Ensure basic tools are installed
echo "[*] Installing git, python3, and pip3 if needed..."
sudo apt update
sudo apt install -y git python3 python3-pip

# Clone the repo if not already cloned
REPO_NAME="HiggletyPigglety"
if [ ! -d "$REPO_NAME" ]; then
  git clone https://github.com/rhenryw/HiggletyPigglety.git
fi

cd "$REPO_NAME" || {
  echo "[ERROR] Could not enter repo directory."
  exit 1
}

# Upgrade pip and install required Python packages
echo "[*] Installing required Python packages..."
pip3 install --upgrade pip
pip3 install colorama tabulate animation art requests

# Run the script
echo "[*] Running D_DosAttack.py..."
python3 D_DosAttack.py

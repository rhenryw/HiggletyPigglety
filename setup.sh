#!/bin/bash

set -e

has() { command -v "$1" >/dev/null 2>&1; }

echo "[*] Checking environment..."

# Ensure sudo is installed
if ! has sudo; then
  echo "[!] 'sudo' not found. Attempting to install..."
  if has apt; then
    su -c "apt update && apt install -y sudo"
  else
    echo "[ERROR] Could not install sudo."
    exit 1
  fi
fi

# Install base dependencies
echo "[*] Installing git, Python3, and pip..."
sudo apt update
sudo apt install -y git python3 python3-pip

# Upgrade pip and install Python packages system-wide with override
echo "[*] Installing Python packages with --break-system-packages..."
pip3 install --upgrade pip --break-system-packages
pip3 install --break-system-packages \
  colorama \
  tabulate \
  animation \
  art \
  requests

# Clone repo if not already present
REPO_NAME="HiggletyPigglety"
if [ ! -d "$REPO_NAME" ]; then
  git clone https://github.com/rhenryw/HiggletyPigglety.git
fi

cd "$REPO_NAME" || { echo "[ERROR] Could not cd into repo"; exit 1; }

# Run the script
echo "[*] Running D_DosAttack.py..."
python3 D_DosAttack.py

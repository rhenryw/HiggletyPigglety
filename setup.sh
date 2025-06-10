#!/bin/bash

set -e

has() { command -v "$1" >/dev/null 2>&1; }

echo "[*] Checking environment..."

# Install sudo if missing
if ! has sudo; then
  echo "[!] 'sudo' not found. Attempting to install..."
  if has apt; then
    su -c "apt update && apt install -y sudo"
  else
    echo "[ERROR] Could not install sudo."
    exit 1
  fi
fi

# Install Python and required packages using apt
echo "[*] Installing git, python3, and required python3 modules..."
sudo apt update
sudo apt install -y git python3 \
  python3-colorama \
  python3-tabulate \
  python3-requests \
  python3-art \
  python3-pyfiglet

# Clone the repo
REPO_NAME="HiggletyPigglety"
if [ ! -d "$REPO_NAME" ]; then
  git clone https://github.com/rhenryw/HiggletyPigglety.git
fi

cd "$REPO_NAME" || {
  echo "[ERROR] Could not enter repo directory."
  exit 1
}

# Run the script
echo "[*] Running D_DosAttack.py..."
python3 D_DosAttack.py

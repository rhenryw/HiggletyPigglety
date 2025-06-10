#!/bin/bash

set -e

# Check for sudo
if ! command -v sudo &> /dev/null; then
  echo "'sudo' not found. Please install 'sudo' manually."
  exit 1
fi

# Update package lists
sudo apt update

# Install git and python3/pip if missing
sudo apt install -y git python3 python3-pip

# Clone the repo
git clone https://github.com/rhenryw/HiggletyPigglety.git

cd HiggletyPigglety || { echo "Failed to enter repo directory."; exit 1; }

# Ensure pip is available
if ! command -v pip3 &> /dev/null; then
  echo "pip3 not found. Attempting to install."
  sudo apt install -y python3-pip
fi

# Install required Python packages
pip3 install --upgrade pip
pip3 install colorama tabulate animation art requests

# Run the script
python3 D_DosAttack.py

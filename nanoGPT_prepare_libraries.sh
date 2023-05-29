#!/bin/bash
set -e

# Make sure only root can run this script
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

# Change to the script directory
cd /root/nanoGPT

# Create a virtual environment
python3 -m venv gpt2_env

# Activate the virtual environment
source gpt2_env/bin/activate

# Update pip, setuptools, and wheel
pip install --upgrade pip setuptools wheel

# Install the Python packages required by the nanoGPT project
pip install torch numpy transformers datasets tiktoken wandb tqdm

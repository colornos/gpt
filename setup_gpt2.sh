#!/bin/bash
set -e

# Make sure only root can run this script
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

# Update the system and install necessary system packages
apt update
apt upgrade -y
apt install -y vim net-tools python3-dev libpq-dev curl build-essential libffi-dev libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

# Install pyenv for Python version management
curl https://pyenv.run | bash

# Add necessary lines to .bashrc for pyenv
echo 'export PYENV_ROOT="/root/.pyenv"' >> /root/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> /root/.bashrc
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init --path)"\nfi' >> /root/.bashrc

# Reload .bashrc to apply changes
source /root/.bashrc

# Sometimes necessary for pyenv to be recognized immediately
export PYENV_ROOT="/root/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# Install Python 3.10.0 with pyenv and set it as the default
$PYENV_ROOT/bin/pyenv install 3.10.0
$PYENV_ROOT/bin/pyenv global 3.10.0

# Update pip, setuptools, and wheel
$PYENV_ROOT/shims/python3 -m pip install --upgrade pip setuptools wheel

# Install necessary Python packages
$PYENV_ROOT/shims/python3 -m pip install torch numpy transformers datasets tiktoken wandb tqdm

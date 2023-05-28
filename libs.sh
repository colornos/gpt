#!/bin/bash

# Upgrade system and install necessary system packages
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y vim python3-dev libpq-dev

# Install pyenv for Python version management
curl https://pyenv.run | bash

# Add necessary lines to .bashrc for pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init --path)"\nfi' >> ~/.bashrc
source ~/.bashrc

# Install Python 3.10.0 with pyenv and set it as the default
pyenv install 3.10.0
pyenv global 3.10.0

# Update pip, setuptools, and wheel
python3 -m pip install --upgrade pip setuptools wheel

# Install necessary Python packages
python3 -m pip install torch numpy transformers datasets tiktoken wandb tqdm

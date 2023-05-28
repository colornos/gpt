#!/bin/bash

# Update the system and install necessary system packages
sudo apt update
sudo apt upgrade -y
sudo apt install -y vim python3-dev libpq-dev curl

# Install pyenv for Python version management
curl https://pyenv.run | bash

# Add necessary lines to .bashrc for pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init --path)"\nfi' >> ~/.bashrc

# Reload .bashrc to apply changes
source ~/.bashrc

# Sometimes necessary for pyenv to be recognized immediately
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# Install Python 3.10.0 with pyenv and set it as the default
pyenv install 3.10.0
pyenv global 3.10.0

# Update pip, setuptools, and wheel
python3 -m pip install --upgrade pip setuptools wheel

# Install necessary Python packages
python3 -m pip install torch numpy transformers datasets tiktoken wandb tqdm

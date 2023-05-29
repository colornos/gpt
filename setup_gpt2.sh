#!/bin/bash
set -e

# Update the system and install necessary system packages
sudo apt update
sudo apt upgrade -y
sudo apt install -y vim python3-dev libpq-dev curl build-essential libffi-dev libssl-dev zlib1g-dev libreadline-dev libsqlite3-dev wget llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev python3-pip python3-venv

# Install pyenv for Python version management if it does not already exist
if [ ! -d "$HOME/.pyenv" ] ; then
    curl https://pyenv.run | bash
fi

# Add necessary lines to .bashrc for pyenv
if ! grep -q 'export PYENV_ROOT="$HOME/.pyenv"' ~/.bashrc ; then
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
    echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init --path)"\nfi' >> ~/.bashrc
fi

# Reload .bashrc to apply changes
source ~/.bashrc

# Sometimes necessary for pyenv to be recognized immediately
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# Install Python 3.10.0 with pyenv and set it as the default
if ! pyenv versions | grep -q '3.10.0' ; then
    pyenv install 3.10.0
    pyenv global 3.10.0
fi

# Create a Python virtual environment
python3 -m venv gpt2_env

# Activate the virtual environment
source gpt2_env/bin/activate

# Update pip, setuptools, and wheel in the virtual environment
pip install --upgrade pip setuptools wheel

# Install necessary Python packages into the virtual environment
pip install torch numpy transformers datasets tiktoken wandb tqdm

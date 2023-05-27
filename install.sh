#!/bin/bash

# Update the system
sudo apt-get update
sudo apt-get upgrade -y

# Install dependencies
sudo apt-get install -y python3-pip libjpeg-dev libopenblas-dev libopenmpi-dev libomp-dev

# Install Python packages
sudo -H pip3 install setuptools==58.3.0
sudo -H pip3 install Cython
sudo -H pip3 install gdown

# Install PyTorch
sudo -H pip3 install torch

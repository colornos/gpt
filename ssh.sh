#!/bin/bash

# Update System
sudo apt-get update
sudo apt-get upgrade -y

# Install openssh-server
sudo apt-get install openssh-server -y

# Enable SSH service to start on boot
sudo systemctl enable ssh

# Allow SSH through the firewall
sudo ufw allow 22/tcp

# Enable the firewall
sudo ufw enable

# Display IP address
echo "Here is your IP address for SSH connection:"
hostname -I | awk '{print $1}'

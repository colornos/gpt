#!/bin/bash

# Update System
sudo apt-get update
sudo apt-get upgrade -y

# Install XRDP
sudo apt-get install xrdp -y

# Install XFCE4
sudo apt-get install xfce4 -y

# Configure XRDP to use XFCE4
echo xfce4-session >~/.xsession

# Restart XRDP service
sudo service xrdp restart

# Afterwards run this command to add a rule to your firewall to allow this connection
#sudo ufw allow 3389/tcp

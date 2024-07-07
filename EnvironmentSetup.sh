#!/bin/bash

echo "Starting environment setup..."

# Update and upgrade system packages
sudo apt-get update -y && sudo apt-get upgrade -y

# Install necessary packages
sudo apt-get install -y git curl vim

# Clone a repository
git clone https://github.com/example/repo.git

# Navigate to the project directory
cd repo

# Setup environment variables
export ENV_VAR="value"

# Run initial setup script
./setup.sh

echo "Environment setup completed."

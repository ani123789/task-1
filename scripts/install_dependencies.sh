#!/bin/bash
set -e

# Update package info
sudo dnf update -y

# Install Apache (httpd)
sudo dnf install -y httpd

# Enable and start Apache
sudo systemctl enable httpd
sudo systemctl start httpd

#!/bin/bash

# Use dnf instead of apt on Amazon Linux 2023
sudo dnf update -y
sudo dnf install -y nginx

# Start and enable nginx
sudo systemctl start nginx
sudo systemctl enable nginx

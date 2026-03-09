#!/bin/bash
sudo apt update -y
sudo apt install -y nginx
echo "Hello from $(hostname)" > /var/www/html/index.html
systemctl enable nginx
systemctl start nginx
sudo snap install amazon-ssm-agent --classic
sudo snap start amazon-ssm-agent

#!/bin/bash
timedatectl
sudo apt update
sudo apt install -y dkms git
sudo apt install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
wget -O - https://get.docker.com | sudo sh - 
sudo apt update
sudo apt install -y docker-ce docker-ce-cli \
  containerd.io docker-buildx-plugin docker-compose-plugin
sudo apt update
docker --version
docker compose version
mkdir ~/git
cp -r ./data ~/git/epg-plex-data
sudo usermod -aG docker $USER

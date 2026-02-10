#!/bin/bash
timedatectl
sudo apt update
sudo apt install -y dkms git
sudo apt install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc]  https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli \
  containerd.io docker-buildx-plugin docker-compose-plugin
sudo apt install -y jq
sudo apt update
docker --version
docker compose version
mkdir ~/git
cp -r ./data ~/git/epg-plex-data
sudo usermod -aG docker $USER

#!/bin/bash
cd ~/git

# Install and set up docker-mirakc-epgstation
git clone --recursive https://github.com/beatkz/docker-mirakc-epgstation.git
cd docker-mirakc-epgstation
bash setup.sh
rm -rf mirakurun

cd ~/git/epg-plex-data

# mirakc part
cp -r ./mirakc ~/git/docker-mirakc-epgstation/mirakc
cp ./mirakc-config-mlt8.yml ~/git/docker-mirakc-epgstation/mirakc/config.yml
cat channels.yml >> ~/git/docker-mirakc-epgstation/mirakc/config.yml

# epgstation part
cp ./epgstation-config.yml ~/git/docker-mirakc-epgstation/epgstation/config/config.yml

# Dockerfile and docker-compose part
cp ./new-epgstation.Dockerfile ~/git/docker-mirakc-epgstation/epgstation/debian.Dockerfile
cp ./new-docker-compose-mlt8.yml ~/git/docker-mirakc-epgstation/docker-compose.yml

cd ~/git/docker-mirakc-epgstation

docker compose pull
docker compose build --no-cache
docker compose up -d

#!/bin/bash
cd ~/git

git clone --recursive https://github.com/beatkz/docker-mirakc-epgstation.git
cd docker-mirakc-epgstation
bash setup.sh
rm -rf mirakurun

cd ~/git/epg-plex-data
cp -r ./mirakc ~/git/docker-mirakc-epgstation/mirakc
cp ./new-epgstationDockerfile ~/git/docker-mirakc-epgstation/epgstation/debian.Dockerfile
cp ./epgstation-config.yml ~/git/docker-mirakc-epgstation/epgstation/config/config.yml
cp ./mirakc-config-w.yml ~/git/docker-mirakc-epgstation/mirakc/config.yml
cat channels.yml >> ~/git/docker-mirakc-epgstation/mirakc/config.yml
cp ./new-docker-compose-w.yml ~/git/docker-mirakc-epgstation/docker-compose.yml
cd ~/git/docker-mirakc-epgstation

docker compose pull
docker compose build --no-cache
docker compose up -d

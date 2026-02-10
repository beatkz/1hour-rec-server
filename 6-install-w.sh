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

# Add channels to mirakc config
#wget https://gist.githubusercontent.com/uru2/7f738d864c2789b35c35e6bb7be9d0cb/raw/a113304cd4d30eacc154f88aa61704e5078521eb/scan_ch_mirakc_docker.sh
#bash scan_ch_mirakc_docker.sh
#cat mirakc_channels.yml >> mirakc/config.yml

docker compose pull
docker compose build --no-cache
docker compose up -d

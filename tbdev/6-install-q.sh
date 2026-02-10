#!/bin/bash
cd ~/git
git clone https://github.com/l3tnun/docker-mirakurun-epgstation.git
cd docker-mirakurun-epgstation
cp docker-compose-sample.yml docker-compose.yml
cp epgstation/config/config.yml.template epgstation/config/config.yml
cp epgstation/config/enc.js.template epgstation/config/enc.js
cp epgstation/config/operatorLogConfig.sample.yml epgstation/config/operatorLogConfig.yml
cp epgstation/config/epgUpdaterLogConfig.sample.yml epgstation/config/epgUpdaterLogConfig.yml
cp epgstation/config/serviceLogConfig.sample.yml epgstation/config/serviceLogConfig.yml
git clone -b 3.9.0-rc.4 https://github.com/Chinachu/Mirakurun
cd ~/git/epg-plex-data
cp ./new-MirakurunDockerfile ~/git/docker-mirakurun-epgstation/Mirakurun/docker/Dockerfile
cp ./tuners.yml ~/git/docker-mirakurun-epgstation/Mirakurun/config/tuners.yml
cp ./channels.yml ~/git/docker-mirakurun-epgstation/Mirakurun/config/channels.yml
cp ./new-docker-compose.yml ~/git/docker-mirakurun-epgstation/docker-compose.yml
cd ~/git/docker-mirakurun-epgstation
docker compose pull
docker compose build --no-cache
docker compose up -d

#!/bin/bash
sudo apt update
sudo apt install -y wget
wget -O data/webmin-setup-repo.sh https://raw.githubusercontent.com/webmin/webmin/master/webmin-setup-repo.sh
sudo sh data/webmin-setup-repo.sh -f --stable
sudo apt update
sudo apt install -y webmin --install-recommends
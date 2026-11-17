#!/bin/bash
sudo apt update
sudo apt install -y wget
wget https://raw.githubusercontent.com/webmin/webmin/master/webmin-setup-repo.sh
sudo sh webmin-setup-repo.sh --stable
sudo apt update
sudo apt install -y webmin --install-recommends
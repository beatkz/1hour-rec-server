#!/bin/bash
cd ~/git
sudo apt -y install gdebi
wget https://github.com/tsukumijima/px4_drv/releases/download/v0.7.1/px4-drv-dkms_0.7.1_all.deb
sudo gdebi -n ./px4-drv-dkms_0.7.1_all.deb
read -p "ドライバがインストールされました。enterキーを押すとリブートします。"
sudo reboot

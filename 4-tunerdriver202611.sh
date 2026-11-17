#!/bin/bash
cd ~/git
sudo apt -y install gdebi
<<<<<<<< HEAD:4-tunerdriver202602.sh
wget https://github.com/tsukumijima/px4_drv/releases/download/v0.5.5/px4-drv-dkms_0.5.5_all.deb
sudo gdebi -n ./px4-drv-dkms_0.5.5_all.deb
========
wget https://github.com/tsukumijima/px4_drv/releases/download/v0.7.1/px4-drv-dkms_0.7.1_all.deb
sudo gdebi -n ./px4-drv-dkms_0.7.1_all.deb
>>>>>>>> main:4-tunerdriver202611.sh
read -p "ドライバがインストールされました。enterキーを押すとリブートします。"
sudo reboot

#!/bin/bash

# For root control
if [ "$(id -u)" != 0 ]; then
  echo "You are not root! This script must be run as root"
  exit 1
fi

apt-get install -y firmware-atheros
apt-get install -y firmware-realtek
apt install -y nvidia-detect
apt install -y nvidia-driver
apt install -y nvidia-settings
hiconfig hci0 noscan
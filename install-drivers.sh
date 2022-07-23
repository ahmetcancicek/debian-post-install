#!/bin/bash

# Set Color
RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
ENDCOLOR="\e[0m"

# For root control
if [ "$(id -u)" != 0 ]; then
  printf "${RED}"
  cat <<EOL
========================================================================
You are not root! This script must be run as root!
========================================================================
EOL
  printf "${ENDCOLOR}"
  exit 1
fi


# Get USER name
USER=$(logname)

# Get HOME folder path
HOME=/home/$USER

# Go TEMP folder
cd /tmp

# Add Repository
apt-add-repository non-free
apt-add-repository main
apt-add-repository contrib

# Update
printf "\n${BLUE}========================Installing Updating========================${ENDCOLOR}\n"
apt-get -y update
printf "${GREEN}========================Updated successfully!========================${ENDCOLOR}\n"

# Upgrade
printf "\n${BLUE}===========================Upgrading===========================${ENDCOLOR}\n"
apt-get -y upgrade
printf "${GREEN}==========================Upgared successfully!===========================${ENDCOLOR}\n"

printf "${BLUE}"
cat <<EOL
========================================================================
Drivers is installing!
========================================================================
EOL
printf "${ENDCOLOR}"

#
apt-get install -y firmware-atheros

#
apt-get install -y firmware-realtek

#
apt install -y nvidia-detect

#
apt install -y nvidia-driver

#
apt install -y nvidia-settings

#
hiconfig hci0 noscan


printf "${GREEN}"
cat <<EOL
========================================================================
Congratulations, everything you wanted to install is installed!
========================================================================
EOL
printf "${ENDCOLOR}"

cat <<EOL

EOL

printf "${BLUE}"
read -p "Are you going to reboot this machine for stability? (y/n): " -n 1 answer
printf "${ENDCOLOR}"
if [[ $answer =~ ^[Yy]$ ]]; then
  reboot
fi

cat <<EOL

EOL
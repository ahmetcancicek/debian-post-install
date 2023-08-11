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


# Update
printf "\n${BLUE}========================Installing Updating========================${ENDCOLOR}\n"
apt-get -y update
printf "${GREEN}========================Updated successfully!========================${ENDCOLOR}\n"

# Upgrade
printf "\n${BLUE}===========================Upgrading===========================${ENDCOLOR}\n"
apt-get -y upgrade
printf "${GREEN}==========================Upgraded successfully!===========================${ENDCOLOR}\n"


# Install driver
declare -A driver
drivers=(
  firmware-atheros
  firmware-realtek
  nvidia-detect
  nvidia-driver
  nvidia-settings
)

printf "\n${BLUE}========================Installing drivers $1========================${ENDCOLOR}\n"
for key in "${drivers[@]}"; do
  apt install -y $key
done
printf "\n${BLUE}===============Drivers are installed successfully=============== ${ENDCOLOR}\n"


# Bluetooth visible off
hciconfig hci0 noscan


printf "\n${GREEN}"
cat <<EOL
===========================================================================
Congratulations, everything you wanted to install is installed!
===========================================================================
EOL
printf "${ENDCOLOR}\n"

cat <<EOL

EOL

printf ${RED}
read -p "Are you going to reboot this machine for stability? (y/n): " -n 1 answer
if [[ $answer =~ ^[Yy]$ ]]; then
  reboot
fi
printf ${ENDCOLOR}

cat <<EOL

EOL

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

printf "${BLUE}"
cat <<EOL
========================================================================
Fonts is installing!
========================================================================
EOL
printf "${ENDCOLOR}"

#
apt install -y fonts-powerline

# Hack v3
rm -rf /usr/share/fonts/hack hack-v3 hack
wget -O hack-v3.zip https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip
unzip hack-v3.zip -d hack-v3
mkdir hack
mv hack-v3/ttf/* hack
mv hack /usr/share/fonts/truetype/hack
fc-cache -f .
cd -


# Ubuntu Font Family
rm -rf /usr/share/fonts/ubuntu-font-family /usr/share/fonts/ubuntu-font-family-0.83
wget -O ubuntu-font-family.zip https://assets.ubuntu.com/v1/0cef8205-ubuntu-font-family-0.83.zip
unzip ubuntu-font-family.zip
mv ubuntu-font-family-0.83 ubuntu-font-family
mv ubuntu-font-family /usr/share/fonts/truetype/ubuntu-font-family
fc-cache -f .
cd -


# JetBrains Mono Font Family
rm -rf /usr/share/fonts/truetype/jetbrains-mono JetBrainsMono-2.242 jetbrains-mono
wget https://download.jetbrains.com/fonts/JetBrainsMono-2.242.zip
unzip JetBrainsMono-2.242 -d JetBrainsMono-2.242
mkdir jetbrains-mono
mv JetBrainsMono-2.242/fonts/ttf/** jetbrains-mono
mv jetbrains-mono /usr/share/fonts/truetype/jetbrains-mono
fc-cache -f .
cd -

# Install Monaco
rm -rf /usr/share/fonts/truetype/monaco
mkdir /usr/share/fonts/truetype/monaco
cd /usr/share/fonts/truetype/monaco
wget http://www.gringod.com/wp-upload/software/Fonts/Monaco_Linux.ttf
fc-cache -f .
cd -


# Install MesloLGS
rm -rf /usr/share/fonts/truetype/MesloLGS
mkdir /usr/share/fonts/truetype/MesloLGS
cd /usr/share/fonts/truetype/MesloLGS
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
fc-cache -f .
cd -


printf "${GREEN}"
cat <<EOL
========================================================================
Congratulations, everything you wanted to install is installed!
========================================================================
EOL
printf "${ENDCOLOR}"

cat <<EOL

EOL

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

cd /tmp


# Open Sans
curl -o open-sans.zip https://fonts.google.com/download?family=Open%20Sans
unzip open-sans.zip -d open-sans
rm -rf /usr/share/fonts/open-sans
mv open-sans /usr/share/fonts/truetype/open-sans


# Roboto
curl -o roboto.zip https://fonts.google.com/download?family=Roboto
unzip roboto.zip -d roboto
rm -rf /usr/share/fonts/roboto
mv roboto /usr/share/fonts/truetype/roboto


# Noto Sans
curl -o noto-sans.zip https://fonts.google.com/download?family=Noto%20Sans
unzip noto-sans.zip -d noto-sans
rm -rf /usr/share/fonts/noto-sans
mv noto-sans /usr/share/fonts/truetype/noto-sans


# Fira Mono
curl -o fira-mono.zip https://fonts.google.com/download?family=Fira%20Mono
unzip fira-mono.zip -d fira-mono
rm -rf /usr/share/fonts/fira-mono
mv fira-mono /usr/share/fonts/truetype/fira-mono


# Clear Sans
curl -o clear-sans.zip https://www.fontsquirrel.com/fonts/download/clear-sans
unzip clear-sans.zip -d clear-sans
rm -rf /usr/share/fonts/clear-sans
mv clear-sans /usr/share/fonts/truetype/clear-sans


# Fira Sans
curl -o fira-sans.zip https://fonts.google.com/download?family=Fira%20Sans
unzip fira-sans.zip -d fira-sans
rm -rf /usr/share/fonts/fira_sans
mv fira-sans /usr/share/fonts/truetype/fira-sans


# Roboto Slab
curl -o roboto-slab.zip https://fonts.google.com/download?family=Roboto%20Slab
unzip roboto-slab.zip -d roboto-slab
rm -rf /usr/share/fonts/roboto-slab
mv roboto-slab /usr/share/fonts/truetype/roboto-slab


# Overpass
curl -o overpass.zip https://fonts.google.com/download?family=Overpass
unzip overpass.zip -d overpass
rm -rf /usr/share/fonts/overpass
mv overpass /usr/share/fonts/truetype/overpass


# Overpass Mono
curl -o overpass-mono.zip https://fonts.google.com/download?family=Overpass%20Mono
unzip overpass-mono.zip -d overpass-mono
rm -rf /usr/share/fonts/overpass-mono
mv overpass-mono /usr/share/fonts/truetype/overpass-mono


# Inter
rm -rf /usr/share/fonts/Inter-3.19
wget https://github.com/rsms/inter/releases/download/v3.19/Inter-3.19.zip
unzip Inter-3.19.zip -d Inter-3.19
rm -rf /usr/share/fonts/inter-3.19
mv Inter-3.19 /usr/share/fonts/truetype/Inter-3.19


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
curl -o ubuntu-font-family.zip https://assets.ubuntu.com/v1/0cef8205-ubuntu-font-family-0.83.zip
unzip ubuntu-font-family.zip -d ./
mv ubuntu-font-family-0.83 /usr/share/fonts/truetype/ubuntu-font-family
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

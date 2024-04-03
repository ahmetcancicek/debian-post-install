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

# Go TEMP folder
cd /tmp

# Go /tmp
go_temp() {
  cd /tmp
}

# Installation Message
print_installation_message() {
  printf "\n${BLUE}===============================Installing $1==============================${ENDCOLOR}\n"
}

# Installation Success Message
print_installation_message_success() {
  printf "${GREEN}========================$1 is installed successfully!========================${ENDCOLOR}\n"
  go_temp
}


# Roboto
print_installation_message Roboto
rm -rf roboto.zip
curl -o roboto.zip https://www.fontsquirrel.com/fonts/download/roboto
unzip roboto.zip -d roboto
rm -rf /usr/local/share/fonts/roboto
mv roboto /usr/local/share/fonts/
cd /usr/local/share/fonts/
fc-cache -f
print_installation_message_success Roboto

# Noto Sans
print_installation_message Noto-Sans
rm -rf noto-sans.zip
curl -o noto-sans.zip https://www.fontsquirrel.com/fonts/download/noto-sans
unzip noto-sans.zip -d noto-sans
rm -rf /usr/local/share/fonts/noto-sans
mv noto-sans /usr/local/share/fonts/
cd /usr/local/share/fonts/
fc-cache -f
print_installation_message_success Noto-Sans

# Fira Mono
print_installation_message Fira-Mono
rm -rf fira-mono.zip
curl -o fira-mono.zip https://www.fontsquirrel.com/fonts/download/fira-mono
unzip fira-mono.zip -d fira-mono
rm -rf /usr/local/share/fonts/fira-mono
mv fira-mono /usr/local/share/fonts/
cd /usr/local/share/fonts/
fc-cache -f
print_installation_message_success Fira-Mono

# Clear Sans
print_installation_message Clear-Sans
rm -rf clear-sans.zip
curl -o clear-sans.zip https://www.fontsquirrel.com/fonts/download/clear-sans
unzip clear-sans.zip -d clear-sans
rm -rf /usr/local/share/fonts/clear-sans
mv clear-sans /usr/local/share/fonts/
cd /usr/local/share/fonts/
fc-cache -f
print_installation_message_success Clear-Sans

# Fira Sans Fira-Sans
print_installation_message Fira-Sans
rm -rf fira-sans.zip
curl -o fira-sans.zip https://www.fontsquirrel.com/fonts/download/fira-sans
unzip fira-sans.zip -d fira-sans
rm -rf /usr/local/share/fonts/fira-sans
mv fira-sans /usr/local/share/fonts/
cd /usr/local/share/fonts/
fc-cache -f
print_installation_message_success Fira-Sans

# Roboto Slab
print_installation_message Roboto-Slab
rm -rf roboto-slap.zip
curl -o roboto-slab.zip https://www.fontsquirrel.com/fonts/download/roboto-slab
unzip roboto-slab.zip -d roboto-slab
rm -rf /usr/local/share/fonts/roboto-slab
mv roboto-slab /usr/local/share/fonts/
cd /usr/local/share/fonts/
fc-cache -f
print_installation_message_success Roboto-Slab

# Overpass
print_installation_message Overpass
rm -rf overpass.zip
curl -o overpass.zip https://www.fontsquirrel.com/fonts/download/overpass
unzip overpass.zip -d overpass
rm -rf /usr/local/share/fonts/overpass
mv overpass /usr/local/share/fonts/
cd /usr/local/share/fonts/
fc-cache -f
print_installation_message_success Overpass

# Ubuntu
print_installation_message Ubuntu
rm -rf ubuntu.zip
curl -o ubuntu.zip https://www.fontsquirrel.com/fonts/download/ubuntu
unzip ubuntu.zip -d ubuntu
rm -rf /usr/local/share/fonts/ubuntu
mv ubuntu /usr/local/share/fonts/
cd /usr/local/share/fonts/
fc-cache -f
print_installation_message_success Ubuntu

# Ubuntu Mono
print_installation_message Ubuntu-Mono
rm -rf ubuntu-mono.zip
curl -o ubuntu-mono.zip https://www.fontsquirrel.com/fonts/download/ubuntu-mono
unzip ubuntu-mono.zip -d ubuntu-mono
rm -rf /usr/local/share/fonts/ubuntu-mono
mv ubuntu-mono /usr/local/share/fonts/
cd /usr/local/share/fonts/
fc-cache -f
print_installation_message_success Ubuntu-Mono

# Overpass Mono
print_installation_message Overpass-Mono
rm -rf overpass-mono.zip
curl -o overpass-mono.zip https://www.fontsquirrel.com/fonts/download/overpass-mono
unzip overpass-mono.zip -d overpass-mono
rm -rf /usr/local/share/fonts/overpass-mono
mv overpass-mono /usr/local/share/fonts/
cd /usr/local/share/fonts/
fc-cache -f
print_installation_message_success Overpass-Mono

# JetBrains Mono Font Family
print_installation_message JetBrains-Mono
rm -rf JetBrainsMono-2.242.zip
rm -rf /usr/local/share/fonts/jetbrains-mono
wget https://download.jetbrains.com/fonts/JetBrainsMono-2.242.zip
unzip JetBrainsMono-2.242.zip -d JetBrainsMono-2.242
mkdir jetbrains-mono
mv JetBrainsMono-2.242/fonts/ttf/** jetbrains-mono
rm -rf JetBrainsMono-2.242
mv jetbrains-mono /usr/local/share/fonts
cd /usr/local/share/fonts/
fc-cache -f
print_installation_message_success JetBrains-Mono

# Inter
print_installation_message Inter
rm -rf Inter-3.19.zip
rm -rf /usr/local/share/fonts/Inter-3.19
wget https://github.com/rsms/inter/releases/download/v3.19/Inter-3.19.zip
unzip Inter-3.19.zip -d Inter-3.19
rm -rf /usr/local/share/fonts/inter-3.19
mv Inter-3.19 /usr/local/share/fonts/
cd /usr/local/share/fonts/
fc-cache -f
print_installation_message_success Inter

# Hack v3
print_installation_message Hack
rm -rf hack-v3.zip
rm -rf /usr/local/share/fonts/hack
wget -O hack-v3.zip https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip
unzip hack-v3.zip -d hack-v3
mkdir hack
mv hack-v3/ttf/* hack
mv hack /usr/local/share/fonts/hack
cd /usr/local/share/fonts/
fc-cache -f
print_installation_message_success Hack

# Install Monaco
print_installation_message Monaco
rm -rf /usr/local/share/fonts/monaco
mkdir /usr/local/share/fonts/monaco
cd /usr/local/share/fonts/monaco
wget http://www.gringod.com/wp-upload/software/Fonts/Monaco_Linux.ttf
cd /usr/local/share/fonts/
fc-cache -f
print_installation_message_success Monaco

# Install MesloLGS
print_installation_message MesloLGS
rm -rf /usr/local/share/fonts/MesloLGS
mkdir /usr/local/share/fonts/MesloLGS
cd /usr/local/share/fonts/MesloLGS
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
cd /usr/local/share/fonts/
fc-cache -f
print_installation_message_success MesloLGS


printf "${GREEN}"
cat <<EOL


===============================================================
Congratulations, everything you wanted to install is installed!
===============================================================
EOL
printf "${ENDCOLOR}"

cat <<EOL

EOL

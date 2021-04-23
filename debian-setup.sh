#!/bin/bash

# For root control
if [ "$(id -u)" != 0 ]; then
  echo "You are not root! This script must be run as root"
  exit 1
fi

#
function print_line() {
  echo "----------------------------------------------------------------------------------------"
}

# Create temporary folder
mkdir setup
cd setup || exit

# Repository
apt-add-repository non-free


# Update
echo "Update"
apt-get -y update

# Install
echo "Installing Standard Package"
apt-get install \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg \
  lsb-release \
  wget \
  dialog


cmd=(dialog --title "Debian 10 Installer" --separate-output --checklist 'Please choose: ' 22 76 16)
options=(
  # A: Software Repositories
  A1 "Install Snap Repository" on
  A2 "Install Flatpak Repository" on
  # B: Internet
  B1 "Google Chrome" off
  B2 "Chromium" off
  B3 "Spotify (Snap)" off
  # C: Chat Application
  C1 "Zoom Meeting Client" off
  C2 "Discord" off
  C3 "Thunderbird Mail" off
  C4 "Skype (Snap)" off
  # D: Gnome Tweaks
  D1 "Gnome Tweak Tool" off
  D2 "Gnome Shell Extensions" off
  # E: Development
  E1 "GIT" off
  E2 "JAVA" off
  E3 "GO" off
  E4 "Microsoft Visual Studio Code (Snap)" off
  E5 "IntelliJ IDEA Ultimate (Snap)" off
  E6 "GoLand (Snap)" off
  E7 "Postman (Snap)" off
  E8 "Docker" off
  E10 "Maven" off
  E11 "Putty" off
  E12 "Vim" off
  # F: Utility
  F1: "Dropbox" off
  F2: "KeePassXC" off
  F3: "Virtualbox" off
  F4: "Terminator" off
  # G: Image, Video and Audio
  G1 "GIMP" off
  G2 "Droidcam" off
)

choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices; do
  # Print line after each installation
  print_line
  case $choice in
  # A: Software Repositories
  A1)
    # Install Snap Repository
    echo "Installing Snap Repository"
    apt -y install snapd
    ;;
  A2)
    # Install Flatpak repository
    echo "Installing Flatpak Repository"
    apt -y install flatpak
    apt -y install gnome-software-plugin-flatpak
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    ;;

  # B: Internet
  B1)
    # Install Google Chrome
    echo "Installing Google Chrome"
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    apt -y install ./google-chrome-stable_current_amd64.deb
    ;;
  B2)
    # Install Chromium
    echo "Installing Chromium"
    apt -y chromium
    ;;
  B3)
    # Install Spotify (Snap)
    echo "Installing Spotify (Snap)"
    snap install spotify
    ;;

    # C: Chat Application
  C1)
    # Install Zoom Meeting Client
    echo "Installing Zoom Meeting Client"
    wget https://zoom.us/client/latest/zoom_amd64.deb
    apt -y install ./zoom_amd64.deb
    apt policy zoom
    ;;
  C2)
    # Install Discord
    echo "Installing Discord"
    wget -O discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
    dpkg -i discord.deb
    ;;
  C3)
    # Install Thunderbird
    echo "Installing Thunderbird"
    apt -y thunderbird
    ;;
  C4)
    # Install Skype (Snap)
    echo "Installing Skype (Snap)"
    sudo snap install skype
    ;;

    # D: Gnome Tweaks
  D1)
    # Install Gnome Tweak Tool
    echo "Installing Gnome Tweak Tool"
    apt -y install gnome-tweak-tool
    ;;
  D2)
    # Install Gnome Shell Extensions
    echo "Installing Gnome Shell Extensions"
    apt -y install gnome-shell-extensions
    ;;

    # E: Development
  E1)
    # Install GIT
    echo "Installing GIT"
    apt -y install git
    ;;
  E2)
    # Install JAVA
    echo "Installing JAVA"
    apt -y install default-jdk
    ;;
  E3)
    # Install GO
    # TODO: Install GO
    ;;
  E4)
    # Install Microsoft Visual Studio Code
    echo "Installing Microsoft Visual Studio Code (Snap)"
    snap install --classic code
    ;;
  E5)
    # Install IntelliJ IDEA Ultimate
    echo "Installing IntelliJ IDEA Ultimate (Snap)"
    snap install intellij-idea-ultimate --classic
    ;;
  E6)
    # Install GoLand
    # TODO: Install GoLand
    ;;
  E7)
    # Install Postman
    echo "Installing Postman (Snap)"
    snap install postman
    ;;
  E8)
    # Install Docker
    echo "Installing Docker"
    apt-get remove docker docker-engine docker.io containerd runc
    apt-get update
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo \
      "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt-get update
    apt-get install docker-ce docker-ce-cli containerd.io
    groupadd docker
    usermod -aG docker $USER
    newgrp docker
    ;;
  E10)
    # Install Maven
    echo "Installing Maven"
    # TODO: Install Maven
    ;;
  E11)
    # Install Putty
    echo "Installing Putty"
    # TODO: Install Putty
    ;;
  E12)
    # Install Vim
    echo "Installing Vim"
    apt install vim
    ;;

    # F: Utility
  F1)
    # Install Dropbox
    wget -O dropbox.deb https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2020.03.04_amd64.deb
    dpkg -i dropbox.deb
    ;;
  F2)
    # Install KeePassXC
    echo "Installing KeePassXC (Snap)"
    snap install keepassxc
    ;;
  F3)
    # Install Virtualbox
    echo "Installing Virtualbox"
    deb http://download.virtualbox.org/virtualbox/debian buster contrib
    wget https://www.virtualbox.org/download/oracle_vbox_2016.asc
    apt-key add oracle_vbox_2016.asc
    apt update
    apt install virtualbox-6.1
    ;;
  F5)
    # Install Terminator
    echo "Installing Terminator"
    apt install terminator
    ;;

    # G: Image, Video and Audio
  G1)
    # Install GIMP
    echo "Installing GIMP"
    apt -y install gimp
    ;;
  G2)
    # Install Droidcam
    wget -O droidcam_latest.zip https://files.dev47apps.net/linux/droidcam_1.7.2.zip
    unzip droidcam_latest.zip -d droidcam
    cd droidcam && sudo ./install-client
    # shellcheck disable=SC2046
    apt install linux-headers-`uname -r` gcc make
    sudo ./install-video
  ;;
  *) ;;
  esac
done

# End
cat <<EOL

---------------------------------------------------------------
Congratulations, everything you wanted to install is installed!
---------------------------------------------------------------

EOL

# Reboot
read -p "Are you going to reboot this machine for stability? (y/n) " -n 1 answer
echo
if [[ $answer =~ ^[Yy]$ ]]; then
  reboot
fi

#!/bin/bash

# For root control
if [ "$(id -u)" != 0 ]; then
  echo "You are not root! This script must be run as root"
  exit 1
fi

cd ~

# Update
echo "Update"
apt-get -y update

# Install wget
echo "Installing Wget"
apt-get install wget

# Install Dialog
echo "Installing Dialog"
apt-get install dialog

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
  C2 "Discord (Snap)" off
  C3 "Thunderbird Mail" off
  C4 "Skype" off
  # D: Gnome Tweaks
  D1 "Gnome Tweak Tool" off
  D2 "Gnome Shell Extensions" off
  # E: Development
  E1 "GIT" off
  E2 "JAVA" off
  E3 "Microsoft Visual Studio Code (Snap)" off
  E4 "IntelliJ IDEA Ultimate (Snap)" off
  E5 "Postman (Snap)" off
  E6 "GO (Snap)" off
  E7 "GoLand (Snap)" off
  E8 "Docker (Snap)" off
  E9 "Maven" off
  E10 "Putty" off
  E11 "Vim" off
  # F: Utility
  F1: "Dropbox" off
  F2: "Powerline" off
  F3: "KeePassXC" off
  F4: "Virtualbox" off
  F5: "Terminator" off
  # G: Image, Video and Audio
  G1 "GIMP" off
  G2: "OBS Studio" off
  # H: For Notebook
  H1: "LIBINPUT-GESTURES" off
  # I: Gnome Tweak Extensions
  I1: "" off
  I2: "" off
  I3: "" off
  I4: "" off
  I5: "" off
  I6: "" off
  I7: "" off
  I8: "" off
  I9: "" off
)

choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices; do
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
    # Install Discord (Snap)
    echo "Installing Discord (Snap)"
    snap install discord
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
    # Install Microsoft Visual Studio Code
    echo "Installing Microsoft Visual Studio Code (Snap)"
    snap install --classic code
    ;;
  E4)
    # Install IntelliJ IDEA Ultimate
    echo "Installing IntelliJ IDEA Ultimate (Snap)"
    snap install intellij-idea-ultimate --classic
    ;;
  E5)
    # Install Postman
    echo "Installing Postman (Snap)"
    snap install postman
    ;;
  E6)
    # Install GO
    echo "Installing GO (Snap)"
    snap install go --classic
    ;;
  E7)
    # Install GoLand
    echo "Installing GoLand (Snap)"
    snap install goland --classic
    ;;
  E8)
    # Install Docker
    echo "Installing Docker (Snap)"
    snap install docker
    snap start docker
    snap stop docker
    ;;
  E9)
    # Install Maven
    echo "Installing Maven"
    apt -y install maven
    ;;
  E10)
    echo "Installing Putty"
    # Install Putty
    ;;
  E11)
    echo "Installing Vim"
    # Install Vim
    ;;

    # F: Utility
  F1) ;;

  F2)
    # Install Powerline
    echo "Installing Powerline"
    apt -y install powerline && apt -y install fonts-powerline
    # TODO: Powerline Settings
    ;;
  F3)
    # Install KeePassXC
    echo "Installing KeePassXC (Snap)"
    snap install keepassxc
    ;;
  F4)
    # Install Virtualbox
    echo "Installling Virtualbox"
    # TODO:
    ;;
  F5)
    # Install Terminator
    echo "Installing Terminator"
    # TODO:
    ;;

    # G: Image, Video and Audio
  G1)
    # Install GIMP
    echo "Installing GIMP"
    apt-get -y install gimp
    ;;
  G2)
    # Install OBS Studio
    echo "Installing OBS Studio"
    # TODO:
    ;;

    # H: For Notebook
  H1)
    # Install LIBINPUT-GESTURES
    echo "Installing LIBINPUT-GESTURES"
    apt-get -y install libinput-tools
    git clone https://github.com/bulletmark/libinput-gestures.git
    cd libinput-gestures
    ./libinput-gestures-setup install
    libinput-gestures-setup autostart
    libinput-gestures-setup start
    cd ..
    ;;

    # I: Gnome Tweak Extensions
  I1)
    # TODO:
    ;;
  I2)
    # TODO:
    ;;
  I3)
    # TODO:
    ;;
  I4)
    # TODO:
    ;;
  I5)
    # TODO:
    ;;
  I6)
    # TODO:
    ;;
  I7)
    # TODO:
    ;;
  I8)
    # TODO:
    ;;
  I9)
    # TODO:
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

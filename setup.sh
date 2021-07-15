#!/bin/bash

# For root control
if [ "$(id -u)" != 0 ]; then
  echo "You are not root! This script must be run as root"
  exit 1
fi

# HOME 
USER=$(logname) 
eval cd ~$USER

# Create temporary folder
rm -rf setup
mkdir setup
cd setup || exit


# TODO:
HOME=/home/$USER

RED="\e[31m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"


TITLE=""
#
function print_line() {
  echo -e "=============================${RED}${TITLE}${ENDCOLOR}============================="
}

# Repository
TITLE="START: ADD REPOSITORY"
print_line
apt-add-repository non-free
apt-add-repository main
apt-add-repository contrib
TITLE="END: ADD REPOSITORY"
print_line

# Update
TITLE="START: UPDATE"
print_line
echo "Update"
apt-get -y update
TITLE="END: UPDATE"
print_line

# Upgrade
TITLE="START: UPGRADE"
print_line
echo "Upgrade"
apt-get -y upgrade
TITLE="END: UPGRADE"
print_line

# Install
TITLE="START: INSTALLING STANDARD PACKAGE"
print_line
echo "Installing Standard Package"
apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg \
  lsb-release \
  wget \
  dialog
TITLE="END: INSTALLING STANDARD PACKAGE"
print_line

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
  E4 "Microsoft Visual Studio Code" off
  E5 "IntelliJ IDEA Ultimate (Snap)" off
  E6 "GoLand (Snap)" off
  E7 "Postman (Snap)" off
  E8 "Docker" off
  E9 "Maven" off
  E10 "Putty" off
  E11 "Vim" off
  # F: Utility
  F1 "Dropbox" off
  F2 "KeePassXC" off
  F3 "Virtualbox" off
  F4 "Terminator" off
  F5 "Powerline" off
  # G: Image, Video and Audio
  G1 "GIMP" off
  G2 "Droidcam" off
  # H: Hardware
  H1 "Atheros" off
  H2 "Realtek" off
  H3 "Nvidia" off
  # I: Settings
  I1 "Bluetooth Visible (Off)" off
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
    apt -y install snapd
    snap install snap-store
    ;;
  A2)
    # Install Flatpak repository
    apt -y install flatpak
    apt -y install gnome-software-plugin-flatpak
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    ;;

  # B: Internet
  B1)
    # Install Google Chrome
    TITLE="START: INSTALLING GOOGLE CHROME"
    print_line
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    apt -y install ./google-chrome-stable_current_amd64.deb
    TITLE="END: INSTALLING GOOGLE CHROME"
    print_line
    ;;
  B2)
    # Install Chromium
    TITLE="START: INSTALLING CHROMIUM"
    print_line
    apt -y chromium
    TITLE="END: INSTALLING CHROMIUM"
    print_line
    ;;
  B3)
    # Install Spotify (Snap)
    TITLE="START: INSTALLING SPOTIFY"
    print_line
    snap install spotify
    TITLE="END: INSTALLING SPOTIFY"
    print_line
    ;;

    # C: Chat Application
  C1)
    # Install Zoom Meeting Client
    TITLE="START: INSTALLING ZOOM MEETING CLIENT"
    print_line
    wget https://zoom.us/client/latest/zoom_amd64.deb
    apt -y install ./zoom_amd64.deb
    apt policy zoom
    TITLE="END: INSTALLING ZOOM MEETING CLIENT"
    print_line
    ;;
  C2)
    # Install Discord
    TITLE="START: INSTALLING DISCORD"
    print_line
    wget -O discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
    dpkg -i discord.deb
    TITLE="END: INSTALLING DISCORD"
    print_line
    ;;
  C3)
    # Install Thunderbird
    TITLE="START: INSTALLING THUNDERBIRD"
    print_line
    apt -y install thunderbird
    TITLE="END: INSTALLING THUNDERBIRD"
    print_line
    ;;
  C4)
    # Install Skype (Snap)
    TITLE="START: INSTALLING SKYPE"
    print_line
    sudo snap install skype
    TITLE="END: INSTALLING SKYPE"
    print_line
    ;;

    # D: Gnome Tweaks
  D1)
    # Install Gnome Tweak Tool
    TITLE="START: INSTALLING GNOME TWEAK TOOL"
    print_line
    apt -y install gnome-tweak-tool
    TITLE="END: INSTALLING GNOME TWEAK TOOL"
    print_line
    ;;
  D2)
    # Install Gnome Shell Extensions
    TITLE="START: INSTALLING GNOME SHELL EXTENSIONS"
    print_linecle
    apt -y install gnome-shell-extensions
    TITLE="END: INSTALLING GNOME SHELL EXTENSIONS"
    print_line
    ;;

    # E: Development
  E1)
    # Install GIT
    TITLE="START: INSTALLING GIT"
    print_line
    apt -y install git
    TITLE="END: INSTALLING GIT"
    print_line
    ;;
  E2)
    # Install JAVA
    TITLE="START: INSTALLING JAVA"
    print_line
    apt -y install default-jdk
    TITLE="END: INSTALLING JAVA"
    print_line
    ;;
  E3)
    # Install GO
    TITLE="START: INSTALLING GO"
    print_line
    wget https://golang.org/dl/go1.16.3.linux-amd64.tar.gz
    rm -rf /usr/local/go && tar -C /usr/local -xzf go1.16.3.linux-amd64.tar.gz
    echo "export PATH=$PATH:/usr/local/go/bin" >>  $HOME/.bashrc
    echo 'export GOPATH=$HOME/go' >> $HOME/.bashrc
    # echo 'export GOPATH=$HOME/code/go' >> $HOME/.profile
    # echo 'export PATH=$PATH:/usr/local/go/bin' >> $HOME/.profile
    source $HOME/.bashrc
    TITLE="END: INSTALLING GO"
    print_line
    ;;
  E4)
    # Install Microsoft Visual Studio Code
    TITLE="START: INSTALLING MS CODE"
    print_line
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
    sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    rm -f packages.microsoft.gpg
    apt install apt-transport-https
    apt update
    apt install code # or code-insiders
    TITLE="END: INSTALLING MS CODE"
    print_line
    ;;
  E5)
    # Install IntelliJ IDEA Ultimate
    TITLE="START: INSTALLING IntelliJ IDEA Ultimate"
    print_line
    snap install intellij-idea-ultimate --classic
    TITLE="END: INSTALLING IntelliJ IDEA Ultimate"
    print_line
    ;;
  E6)
    # Install GoLand
    TITLE="START: INSTALLING GoLand"
    print_line
    sudo snap install goland --classic
    TITLE="END: INSTALLING GoLand"
    print_line
    ;;
  E7)
    # Install Postman
    TITLE="START: INSTALLING POSTMAN"
    print_line
    snap install postman
    TITLE="END: INSTALLING POSTMAN"
    print_line
    ;;
  E8)
    # Install Docker
    TITLE="START: INSTALLING DOCKER"
    print_line
    apt-get remove docker docker-engine docker.io containerd runc
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo \
      "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt-get update
    apt-get install -y docker-ce docker-ce-cli containerd.io
    groupadd docker
    usermod -aG docker $USER
    TITLE="END: INSTALLING DOCKER"
    print_line
    ;;
  E9)
    # Install Maven
    TITLE="START: INSTALLING MAVEN"
    print_line
    wget https://downloads.apache.org/maven/maven-3/3.8.1/binaries/apache-maven-3.8.1-bin.tar.gz -P /tmp
    rm -rf /opt/apache-maven-3.8.1 /opt/maven
    tar xf /tmp/apache-maven-*.tar.gz -C /opt
    ln -s /opt/apache-maven-3.8.1 /opt/maven
    echo 'export JAVA_HOME=/usr/lib/jvm/default-java' >> $HOME/.bashrc
    echo 'export M2_HOME=/opt/maven' >> $HOME/.bashrc
    echo 'export MAVEN_HOME=/opt/maven' >>  $HOME/.bashrc
    echo "export PATH=$PATH:/opt/maven/bin" >>  $HOME/.bashrc
    source $HOME/.bashrc
    TITLE="END: INSTALLING MAVEN"
    print_line
    ;;
  E10)
    # Install Putty
    TITLE="START: INSTALLING PUTTY"
    print_line
    apt -y install putty
    TITLE="END: INSTALLING PUTTY"
    print_line
    ;;
  E11)
    # Install Vim
    TITLE="START: INSTALLING VIM"
    print_line
    apt -y install vim
    TITLE="END: INSTALLING VIM"
    print_line
    ;;

    # F: Utility
  F1)
    # Install Dropbox
    TITLE="START: INSTALLING DROPBOX"
    print_line
    wget -O dropbox.deb https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2020.03.04_amd64.deb
    dpkg -i dropbox.deb
    END="START: INSTALLING DROPBOX"
    print_line
    ;;
  F2)
    # Install KeePassXC
    TITLE="START: INSTALLING KeePassXC"
    print_line
    snap install keepassxc
    TITLE="END: INSTALLING KeePassXC"
    print_line
    ;;
  F3)
    # Install Virtualbox
    TITLE="START: INSTALLING VIRTUALBOX"
    print_line
    add-apt-repository "deb http://download.virtualbox.org/virtualbox/debian buster contrib"
    # deb http://download.virtualbox.org/virtualbox/debian buster contrib
    wget https://www.virtualbox.org/download/oracle_vbox_2016.asc
    apt-key add oracle_vbox_2016.asc
    apt update
    apt install -y virtualbox-6.1
    TITLE="END: INSTALLING VIRTUALBOX"
    print_line
    ;;
  F4)
    # Install Terminator
    TITLE="START: INSTALLING TERMINATOR"
    print_line
    apt install terminator
    TITLE="END: INSTALLING TERMINATOR"
    print_line
    ;;
  F5)
    # Install Powerline
    TITLE="START: INSTALLING POWERLINE"
    print_line
    apt build-dep powerline
    apt -y install powerline fonts-powerline
    echo " " >> $HOME/.bashrc
    echo "# Powerline configuration" >> $HOME/.bashrc
    echo "if [ -f /usr/share/powerline/bindings/bash/powerline.sh ]; then" >> $HOME/.bashrc
    echo "powerline-daemon -q" >> $HOME/.bashrc
    echo "POWERLINE_BASH_CONTINUATION=1" >> $HOME/.bashrc
    echo "POWERLINE_BASH_SELECT=1" >> $HOME/.bashrc
    echo "source /usr/share/powerline/bindings/bash/powerline.sh" >> $HOME/.bashrc
    echo "fi" >> $HOME/.bashrc
    source $HOME/.bashrc
    TITLE="END: INSTALLING POWERLINE"
    print_line
    ;;

    # G: Image, Video and Audio
  G1)
    # Install GIMP
    TITLE="START: INSTALLING GIMP"
    print_line
    apt -y install gimp
    TITLE="END: INSTALLING GIMP"
    print_line
    ;;
  G2)
    # Install Droidcam
    TITLE="START: INSTALLING DROIDCAM"
    print_line
    wget -O droidcam_latest.zip https://files.dev47apps.net/linux/droidcam_1.7.2.zip
    unzip droidcam_latest.zip -d droidcam
    cd droidcam && sudo ./install-client
    # shellcheck disable=SC2046
    apt install linux-headers-`uname -r` gcc make
    sudo ./install-video
    TITLE="END: INSTALLING DROIDCAM"
    print_line
  ;;

  # H: Hardware
  H1)
    # Install Atheros
    TITLE="START: INSTALLING ATHEROS DRIVER"
    print_line
    apt-get install -y firmware-atheros
    TITLE="END: INSTALLING ATHEROS DRIVER"
    print_line
   ;;
  H2)
    # Install Realtek
    TITLE="START: INSTALLING REALTEK DRIVER"
    print_line
    apt-get install -y firmware-realtek
    TITLE="END: INSTALLING REALTEK DRIVER"
    print_line
   ;;
  H3)
    # Install Nvidia
    TITLE="START: INSTALLING NVIDIA DRIVER"
    print_line
    apt install -y nvidia-detect
    apt install -y nvidia-driver
    apt install -y nvidia-settings
    TITLE="END: INSTALLING NVIDIA DRIVER"
    print_line
  ;;

  # I: Settings
  I1)
    TITLE="START: BLUETOOTH VISIBLE OFF"
    print_line
    echo "Bluetooth Visible: Off"
    hciconfig hci0 noscan
    TITLE="END: INSTALLING VISIBLE OFF"
    print_line
    ;;

  *) 
  esac
done

cd ..
rm -rf setup


# Dependencies
TITLE="START: DEPENDENCIES"
print_line
apt-get install -y -f
TITLE="END: DEPENDENCIES"
print_line

# Successful
cat <<EOL


EOL
TITLE="SUCCESSFUL"
print_line
printf "${GREEN}"
# End
cat <<EOL
---------------------------------------------------------------
Congratulations, everything you wanted to install is installed!
---------------------------------------------------------------

EOL
printf "${ENDCOLOR}"



# Restart
cat <<EOL


EOL
TITLE="RESTART"
print_line
printf "${RED}"
# Reboot
read -p "Are you going to reboot this machine for stability? (y/n) " -n 1 answer
if [[ $answer =~ ^[Yy]$ ]]; then
  reboot
fi

echo " "
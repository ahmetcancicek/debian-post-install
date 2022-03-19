#!/bin/bash

# For root control
if [ "$(id -u)" != 0 ]; then
  echo "You are not root! This script must be run as root"
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
apt-get -y update

# Upgrade
apt-get -y upgrade

# Install standard package
apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg \
  lsb-release \
  wget \
  dialog

cmd=(dialog --title "Debian 11 Installer" --separate-output --checklist 'Please choose: ' 27 76 16)
options=(
  # A: Software Repositories
  A1 "Install Snap Repository" on
  A2 "Install Flatpak Repository" on
  # B: Internet
  B1 "Google Chrome" off
  B2 "Chromium" off
  B3 "Spotify (Snap)" off
  B4 "Opera" off
  # C: Chat Application
  C1 "Zoom Meeting Client" off
  C2 "Discord" off
  C3 "Thunderbird Mail" off
  C4 "Skype (Snap)" off
  C5 "Slack" off
  C6 "Microsoft Teams (Snap)" off
  # D: Development
  D1 "GIT" off
  D2 "JAVA" off
  D3 "GO" off
  D4 "Microsoft Visual Studio Code" off
  D5 "IntelliJ IDEA Ultimate (Snap)" off
  D6 "GoLand (Snap)" off
  D7 "Postman (Snap)" off
  D8 "Docker" off
  D9 "Maven" off
  D10 "Putty" off
  D11 "Vim" off
  D12 "PyCharm" off
  D13 "Robo 3T" off
  D14 "DataGrid" off
  D15 "Mongo Shell & MongoDB Database Tools" off
  # E: Gnome Tweaks
  E1 "Gnome Tweak Tool" off
  E2 "Gnome Shell Extensions" off
  # F: Utility
  F1 "Dropbox" off
  F2 "KeePassXC" off
  F3 "Virtualbox" off
  F4 "Terminator" off
  F5 "Powerline" off
  F6 "Htop" off
  F7 "vimrc" off
  # G: Image, Video and Audio
  G1 "GIMP" off
  G2 "Droidcam" off
  # H: Hardware
  H1 "Atheros" off
  H2 "Realtek" off
  H3 "Nvidia" off
  # I: Settings
  I1  "Bluetooth Visible (off)" off
)

choices=$("${cmd[@]}" "${options[@]}" 2>&1 > /dev/tty)
clear
for choice in $choices; do
  case $choice in
  A1)
    apt -y install snapd
    snap install snap-store
    ;;
  A2)
    apt -y install flatpak
    apt -y install gnome-software-plugin-flatpak
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    ;;

  B1)
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    apt -y install ./google-chrome-stable_current_amd64.deb
    ;;
  B2)
    apt -y install chromium
    ;;
  B3)
    snap install spotify
    ;;
  B4)
    snap install opera
    ;;

  C1)
    wget https://zoom.us/client/latest/zoom_amd64.deb
    apt -y install ./zoom_amd64.deb
    ;;
  C2)
    wget -O discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
    dpkg -i discord.deb
    ;;
  C3)
     apt -y install thunderbird
     ;;
  C4)
    snap install skype
    ;;
  C5)
    snap install slack --classic
    ;;
  C6)
    snap install teams
    ;;

  D1)
    apt -y install git
    ;;
  D2)
    apt -y install default-jdk
    ;;
  D3)
    wget https://go.dev/dl/go1.18.linux-amd64.tar.gz
    rm -rf /usr/local/go && tar -C /usr/local -xzf go1.18.linux-amd64.tar.gz
    echo ' ' >> $HOME/.profile
    echo '# GoLang configuration ' >> $HOME/.profile
    echo 'export PATH="$PATH:/usr/local/go/bin"' >> $HOME/.profile
    echo 'export GOPATH="$HOME/go"' >> $HOME/.profile
    source $HOME/.profile
    ;;
  D4)
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
    sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    rm -f packages.microsoft.gpg
    apt install apt-transport-https
    apt update
    apt install code # or code-insiders
    ;;
  D5)
    snap install intellij-idea-ultimate --classic
    ;;
  D6)
    sudo snap install goland --classic
    ;;
  D7)
    snap install postman
    ;;
  D8)
    apt-get install \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg \
        lsb-release
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo \
      "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
      $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt-get update
    apt-get -y install docker-ce docker-ce-cli containerd.io
    docker run hello-world

    groupadd docker
    usermod -aG docker $USER
    curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
    docker-compose --version
    ;;
  D9)
    wget https://dlcdn.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
    tar -zxvf apache-maven-3.6.3-bin.tar.gz
    mkdir /opt/maven
    mv ./apache-maven-3.6.3 /opt/maven/
    echo ' ' >> $HOME/.profile
    echo '# Maven Configuration' >> $HOME/.profile
    echo 'JAVA_HOME=/usr/lib/jvm/default-java' >> $HOME/.profile
    echo 'export M2_HOME=/opt/maven/apache-maven-3.6.3' >> $HOME/.profile
    echo 'export PATH=${M2_HOME}/bin:${PATH}' >> $HOME/.profile
    source $HOME/.profile
    ;;
  D10)
    apt -y install putty
    ;;
  D11)
    apt -y install vim
    ;;
  D12)
    snap install pycharm-community --classic
    ;;
  D13)
    snap install robo3t-snap
    ;;
  D14)
    snap install datagrip --classic
    ;;
  D15)
    wget -O mongosh.deb https://downloads.mongodb.com/compass/mongodb-mongosh_1.2.2_amd64.deb
    dpkg -i ./mongosh.deb

    wget -O mongodb-database-tools.deb https://fastdl.mongodb.org/tools/db/mongodb-database-tools-debian92-x86_64-100.5.2.deb
    dpkg -i ./mongodb-database-tools.deb
    ;;

  E1)
    apt -y install gnome-tweak-tool
    ;;
  E2)
    apt -y install gnome-shell-extensions
    ;;

  F1)
    wget -O dropbox.deb https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2020.03.04_amd64.deb
    apt -y install ./dropbox.deb
    ;;
  F2)
    snap install keepassxc
    ;;
  F3)
    add-apt-repository "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian bullseye contrib"
    wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | apt-key add -
    wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | apt-key add -
    apt-get update
    apt-get -y install virtualbox-6.1
    ;;
  F4)
    apt -y install terminator
    ;;
  F5)
    apt -y instal powerline fonts-powerline
    # TODO: Fix configuration
    ;;
  F6)
    apt -y install htop
    ;;
  F7)
    git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
    sh ~/.vim_runtime/install_awesome_vimrc.sh
    ;;

  G1)
    apt -y install gimp
    ;;
  G2)
    cd /tmp/
    wget -O droidcam_latest.zip https://files.dev47apps.net/linux/droidcam_1.8.1.zip
    unzip droidcam_latest.zip -d droidcam
    cd droidcam && sudo ./install-client
    apt -y install linux-headers-`uname -r` gcc make
    ./install-video

    wget https://files.dev47apps.net/linux/libindicator3-7_0.5.0-4_amd64.deb
    sudo dpkg -i libindicator3-7_0.5.0-4_amd64.deb

    wget https://files.dev47apps.net/linux/libappindicator3-1_0.4.92-7_amd64.deb
    sudo dpkg -i libappindicator3-1_0.4.92-7_amd64.deb
    ;;

  H1)
    apt-get install -y firmware-atheros
    ;;
  H2)
    apt-get install -y firmware-realtek
    ;;
  H3)
    apt install -y nvidia-detect
    apt install -y nvidia-driver
    apt install -y nvidia-settings
    ;;

  I1)
    hiconfig hci0 noscan
    ;;
  *)
  esac
done

# Install dependencies
apt-get -f install

cat <<EOL
---------------------------------------------------------------
Congratulations, everything you wanted to install is installed!
---------------------------------------------------------------
EOL

cat <<EOL

EOL

read -p "Are you going to reboot this machine for stability? (y/n): " -n 1 answer
if [[ $answer =~ ^[Yy]$ ]];then
  reboot
fi


cat <<EOL

EOL

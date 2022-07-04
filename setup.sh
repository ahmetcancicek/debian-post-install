#!/bin/bash

# For root control
if [ "$(id -u)" != 0 ]; then
  echo "You are not root! This script must be run as root"
  exit 1
fi

# Set Version
JETBRAINS_VERSION=2022.1.3
GO_VERSION=1.18.3
POSTMAN_VERSION=9.20.3
MAVEN=3
MAVEN_VERSION=3.8.6
DROIDCAM_VERSION=1.8.1
DROPBOX_VERSION=2020.03.04

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

# Install fonts
apt-get install -y \
  fonts-powerline \
  fonts-ubuntu

# Install standard package
apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg \
  lsb-release \
  wget \
  dialog \
  tree

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
  D5 "IntelliJ IDEA Ultimate" off
  D6 "GoLand" off
  D7 "Postman" off
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
  F6 "Htop" off
  F7 "vimrc" off
  F8 "ZSH" off
  # G: Image, Video and Audio
  G1 "GIMP" off
  G2 "Droidcam" off
  G3 "TLP" off
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
    curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add -
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    apt-get update && sudo apt-get install spotify-client
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
    wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz
    rm -rf /usr/local/go && tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
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
    wget https://download.jetbrains.com/idea/ideaIU-${JETBRAINS_VERSION}.tar.gz -O ideaIU.tar.gz
    tar -xzf ideaIU.tar.gz -C /opt
    mv /opt/idea-IU-* /opt/idea-IU-${JETBRAINS_VERSION}
    ln -s /opt/idea-IU-${JETBRAINS_VERSION}/bin/idea.sh /usr/local/bin/idea
    echo "[Desktop Entry]
          Version=1.0
          Type=Application
          Name=IntelliJ IDEA Ultimate Edition
          Icon=/opt/idea-IU-${JETBRAINS_VERSION}/bin/idea.svg
          Exec=/opt/idea-IU-${JETBRAINS_VERSION}/bin/idea.sh %f
          Comment=Capable and Ergonomic IDE for JVM
          Categories=Development;IDE;
          Terminal=false
          StartupWMClass=jetbrains-idea
          StartupNotify=true" >> /usr/share/applications/jetbrains-idea.desktop
    ;;
  D6)
    wget https://download.jetbrains.com/go/goland-${JETBRAINS_VERSION}.tar.gz -O goland.tar.gz
    tar -xzf goland.tar.gz -C /opt
    ln -s /opt/GoLand-${JETBRAINS_VERSION}/bin/goland.sh /usr/local/bin/goland
    echo "[Desktop Entry]
          Version=1.0
          Type=Application
          Name=GoLand
          Icon=/opt/GoLand-${JETBRAINS_VERSION}/bin/goland.png
          Exec=/opt/GoLand-${JETBRAINS_VERSION}/bin/goland.sh
          Terminal=false
          Categories=Development;IDE;" >> /usr/share/applications/jetbrains-goland.desktop
    ;;
  D7)
    curl https://dl.pstmn.io/download/latest/linux64 --output postman-${POSTMAN_VERSION}-linux-x64.tar.gz
    tar -xzf postman-{POSTMAN_VERSION}-linux-x64.tar.gz -C /opt
    echo "[Desktop Entry]
          Encoding=UTF-8
          Name=Postman
          Exec=/opt/Postman/app/Postman %U
          Icon=/opt/Postman/app/resources/app/assets/icon.png
          Terminal=false
          Type=Application
          Categories=Development;" >> /usr/share/applications/Postman.desktop
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
    wget https://dlcdn.apache.org/maven/maven-${MAVEN}/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz
    tar -zxvf apache-maven-${MAVEN_VERSION}-bin.tar.gz
    mkdir /opt/maven
    mv ./apache-maven-${MAVEN_VERSION} /opt/maven/
    echo "
          # Maven Configuration
          JAVA_HOME=/usr/lib/jvm/default-java
          export M2_HOME=/opt/maven/apache-maven-${MAVEN_VERSION}
          export PATH=${M2_HOME}/bin:${PATH};" >> $HOME/.profile
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
    wget https://download.jetbrains.com/datagrip/datagrip-${JETBRAINS_VERSION}.tar.gz
    tar -xzf datagrip-${JETBRAINS_VERSION}.tar.gz -C /opt
    ln -s /opt/DataGrip-${JETBRAINS_VERSION}/bin/datagrip.sh /usr/local/bin/datagrip
    echo "[Desktop Entry]
          Version=1.0
          Type=Application
          Name=DataGrip
          Icon=/opt/DataGrip-${JETBRAINS_VERSION}/bin/datagrip.png
          Exec=/opt/DataGrip-${JETBRAINS_VERSION}/bin/datagrip.sh
          Terminal=false
          Categories=Development;IDE;" >> /usr/share/applications/jetbrains-datagrip.desktop
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
    wget -O dropbox.deb https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_${DROPBOX_VERSION}_amd64.deb
    apt -y install ./dropbox.deb
    ;;
  F2)
    apt-get -y install keepassxc
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
  F6)
    apt -y install htop
    ;;
  F7)
    git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
    sh ~/.vim_runtime/install_awesome_vimrc.sh
    ;;
  F8)
    apt-get install zsh -y
    chsh -s $(which zsh)
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    source .zshrc
    ;;

  G1)
    apt -y install gimp
    ;;
  G2)
    cd /tmp/
    wget -O droidcam_latest.zip https://files.dev47apps.net/linux/droidcam_${DROIDCAM_VERSION}.zip
    unzip droidcam_latest.zip -d droidcam
    cd droidcam && sudo ./install-client
    apt -y install linux-headers-`uname -r` gcc make
    ./install-video

    wget https://files.dev47apps.net/linux/libindicator3-7_0.5.0-4_amd64.deb
    sudo dpkg -i libindicator3-7_0.5.0-4_amd64.deb

    wget https://files.dev47apps.net/linux/libappindicator3-1_0.4.92-7_amd64.deb
    sudo dpkg -i libappindicator3-1_0.4.92-7_amd64.deb
    ;;
  G3)
  apt -y install tlp
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

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

writeInstallationMessage() {
  printf "\n${BLUE}===============================Installing $1==============================${ENDCOLOR}\n"
}

writeInstallationSuccessfulMessage() {
  printf "${GREEN}========================$1 is installed successfully!========================${ENDCOLOR}\n"
}

# Set Version
JETBRAINS_VERSION=2022.3.2
GO_VERSION=1.18.3
POSTMAN_VERSION=10.0.8
MAVEN=3
MAVEN_VERSION=3.8.7
GRADLE_VERSION=7.6
SPRING_VERSION=3.0.0
DROIDCAM_VERSION=1.8.2
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
printf "\n${BLUE}========================Installing Updating========================${ENDCOLOR}\n"
apt-get -y update
printf "${GREEN}========================Updated successfully!========================${ENDCOLOR}\n"

# Upgrade
printf "\n${BLUE}===========================Upgrading===========================${ENDCOLOR}\n"
apt-get -y upgrade
printf "${GREEN}==========================Upgared successfully!===========================${ENDCOLOR}\n"

## Bluetooth visibility
hiconfig hci0 noscan

# Install fonts
printf "\n${BLUE}========================Installing fonts========================${ENDCOLOR}\n"
apt-get install -y \
  fonts-powerline \
  fonts-ubuntu \
  fonts-manager
printf "\n${BLUE}========================Fonts are installed successfully========================${ENDCOLOR}\n"

# Install standard package
printf "\n${BLUE}========================Installing standard package $1========================${ENDCOLOR}\n"
apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg \
  lsb-release \
  wget \
  dialog \
  tree \
  zsh \
  htop

printf "\n${BLUE}===============Standard packages are installed successfully=============== ${ENDCOLOR}\n"

cmd=(dialog --title "Debian 11 Installer" --separate-output --checklist 'Please choose: ' 27 76 16)
options=(
  # A: Software Repositories
  A1 "Install Snap Repository" off
  A2 "Install Flatpak Repository" off
  # B: Internet
  B1 "Google Chrome" off
  B2 "Chromium" off
  B3 "Spotify" off
  B4 "Opera" off
  B5 "Microsoft Edge" off
  # C: Chat Application
  C1 "Zoom Meeting Client" off
  C2 "Discord" off
  C3 "Thunderbird Mail" off
  C4 "Skype (Snap)" off
  C5 "Slack (Snap)" off
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
  D10 "Gradle" off
  D11 "Node.js & NPM" off
  D12 "Putty" off
  D13 "Vim" off
  D14 "DataGrip" off
  D15 "Mongo Shell & MongoDB Database Tools" off
  # E: Gnome Tweaks
  E1 "Gnome Tweak Tool" off
  E2 "Gnome Shell Extensions" off
  # F: Utility
  F1 "Dropbox" off
  F2 "KeePassXC" off
  F3 "Virtualbox" off
  F4 "Gnome Boxes" off
  F5 "Terminator" off
  F6 "Web Apps" off
  F7 "OpenVPN" off
  # G: Image, Video and Audio
  G1 "GIMP" off
  G2 "Droidcam" off
  G3 "TLP" off
)

choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices; do
  case $choice in
  A1)
    writeInstallationMessage Snap-Repository
    apt -y install snapd
    snap install snap-store
    writeInstallationSuccessfulMessage Snap-Repository
    ;;
  A2)
    writeInstallationMessage Flatpak-Repository
    apt -y install flatpak
    apt -y install gnome-software-plugin-flatpak
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    writeInstallationSuccessfulMessage Flatpak-Repository
    ;;

  B1)
    writeInstallationMessage Google-Chrome
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    apt -y install ./google-chrome-stable_current_amd64.deb
    writeInstallationSuccessfulMessage Google-Chrome
    ;;
  B2)
    writeInstallationMessage Chromium
    apt -y install chromium
    writeInstallationSuccessfulMessage Chromium
    ;;
  B3)
    writeInstallationMessage Spotify
    curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    apt -y update && apt -y install spotify-client
    writeInstallationSuccessfulMessage Spotify
    ;;
  B4)
    writeInstallationMessage Opera
    wget -qO- https://deb.opera.com/archive.key | sudo apt-key add –
    add-apt-repository "deb [arch=i386,amd64] https://deb.opera.com/opera-stable/ stable non-free"
    apt -y update
    apt install -y opera-stable
    writeInstallationSuccessfulMessage Opera
    ;;
  B5)
    writeInstallationMessage Microsoft-Edge
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
    sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'
    rm microsoft.gpg
    apt -y update && apt -y install microsoft-edge-stable
    writeInstallationSuccessfulMessage Microsoft-Edge
  ;;

  C1)
    writeInstallationMessage Zoom
    wget https://zoom.us/client/latest/zoom_amd64.deb
    apt -y install ./zoom_amd64.deb
    writeInstallationSuccessfulMessage Zoom
    ;;
  C2)
    writeInstallationMessage Discord
    wget -O discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
    dpkg -i discord.deb
    writeInstallationSuccessfulMessage Discord
    ;;
  C3)
    writeInstallationMessage Thunderbird
    apt -y install thunderbird
    writeInstallationSuccessfulMessage Thunderbird
    ;;
  C4)
    writeInstallationMessage Skype
    snap install skype
    writeInstallationSuccessfulMessage Skype
    ;;
  C5)
    writeInstallationMessage Slack
    snap install slack --classic
    writeInstallationSuccessfulMessage Slack
    ;;
  C6)
    writeInstallationMessage Teams
    snap install teams
    writeInstallationSuccessfulMessage Teams
    ;;

  D1)
    writeInstallationMessage GIT
    apt -y install git
    writeInstallationSuccessfulMessage GIT
    ;;
  D2)
    writeInstallationMessage OpenJDK
    apt -y install default-jdk
    writeInstallationMessage OpenJDK


    writeInstallationMessage JAVA-JDK-18
    wget https://download.oracle.com/java/18/latest/jdk-18.0.2_linux-x64_bin.tar.gz
    mkdir /usr/local/java/
    tar xf jdk-18.0.2_linux-x64_bin.tar.gz -C /usr/local/java/
    update-alternatives --install "/usr/bin/java" "java" "/usr/local/java/jdk-18.0.2/bin/java" 1
    update-alternatives --install "/usr/bin/javac" "javac" "/usr/local/java/jdk-18.0.2/bin/javac" 1
    update-alternatives --set java /usr/local/java/jdk-18.0.2/bin/java
    update-alternatives --set javac /usr/local/java/jdk-18.0.2/bin/javac
    echo -e '\n# JAVA Configuration' >>$HOME/.profile
    echo 'JAVA_HOME=/usr/local/java/jdk-18.0.2/bin/java' >>$HOME/.profile
    source $HOME/.profile
    writeInstallationSuccessfulMessage JAVA-JDK-18

    writeInstallationMessage JAVA-JDK-17
    wget https://download.oracle.com/java/17/archive/jdk-17_linux-x64_bin.tar.gz
    tar xf jdk-17_linux-x64_bin.tar.gz -C /usr/local/java
    update-alternatives --install "/usr/bin/java" "java" "/usr/local/java/jdk-17/bin/java" 2
    update-alternatives --install "/usr/bin/javac" "javac" "/usr/local/java/jdk-17/bin/javac" 2
    writeInstallationSuccessfulMessage JAVA-JDK-17


    writeInstallationMessage Spring-Boot-CLI
    wget https://repo.spring.io/release/org/springframework/boot/spring-boot-cli/3.0.0/spring-boot-cli-${SPRING_VERSION}-bin.tar.gz
    tar xf spring-boot-cli-${SPRING_VERSION}-bin.tar.gz -C /opt
    echo -e "\n# Spring Boot CLI" >>  $HOME/.profile
    echo -ne 'export SPRING_HOME=/opt/spring-' >>  $HOME/.profile
    echo "${SPRING_VERSION}" >> $HOME/.profile
    echo 'export PATH=$PATH:$HOME/bin:$SPRING_HOME/bin' >>  $HOME/.profile
    source $HOME/.profile
    writeInstallationSuccessfulMessage Spring-Boot-CLI
    ;;

  D3)
    writeInstallationMessage Go
    wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz
    rm -rf /usr/local/go && tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
    echo -e '\n# GoLang configuration ' >>$HOME/.profile
    echo 'export PATH="$PATH:/usr/local/go/bin"' >>$HOME/.profile
    echo 'export GOPATH="$HOME/go"' >>$HOME/.profile
    source $HOME/.profile
    writeInstallationSuccessfulMessage Go
    ;;
  D4)
    writeInstallationMessage vscode
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
    install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
    sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    rm -f packages.microsoft.gpg
    apt -y update
    apt -y install code # or code-insiders
    writeInstallationSuccessfulMessage vscode
    ;;
  D5)
    writeInstallationMessage IntelliJ-IDEA
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
          StartupNotify=true;" >>/usr/share/applications/jetbrains-idea.desktop
    writeInstallationSuccessfulMessage IntelliJ-IDEA
    ;;
  D6)
    writeInstallationMessage GoLand
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
          Categories=Development;IDE;" >>/usr/share/applications/jetbrains-goland.desktop
    writeInstallationSuccessfulMessage GoLand
    ;;
  D7)
    writeInstallationMessage Postman
    curl https://dl.pstmn.io/download/latest/linux64 --output postman-${POSTMAN_VERSION}-linux-x64.tar.gz
    tar -xzf postman-${POSTMAN_VERSION}-linux-x64.tar.gz -C /opt
    echo "[Desktop Entry]
          Encoding=UTF-8
          Name=Postman
          Exec=/opt/Postman/app/Postman %U
          Icon=/opt/Postman/app/resources/app/assets/icon.png
          Terminal=false
          Type=Application
          Categories=Development;" >>/usr/share/applications/Postman.desktop
    writeInstallationSuccessfulMessage Postman
    ;;
  D8)
    writeInstallationMessage Docker
    apt-get install \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg \
      lsb-release
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo \
      "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
      $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list >/dev/null
    apt-get update
    apt-get -y install docker-ce docker-ce-cli containerd.io
    docker run hello-world
    groupadd docker
    usermod -aG docker $USER
    writeInstallationSuccessfulMessage Docker

    writeInstallationMessage docker-compose
    curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
    docker-compose --version
    writeInstallationSuccessfulMessage docker-compose
    ;;
  D9)
    writeInstallationMessage Maven
    rm -rf /tmp/apache-maven-${MAVEN_VERSION}-bin.tar.gz
    wget https://dlcdn.apache.org/maven/maven-${MAVEN}/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz
    tar -zxvf apache-maven-${MAVEN_VERSION}-bin.tar.gz -C /opt
    ln -s /opt/apache-maven-${MAVEN_VERSION} /opt/maven
    echo -e '\n# Maven Configuration' >>$HOME/.profile
    echo "export M2_HOME=/opt/maven" >>$HOME/.profile
    echo 'export PATH=${M2_HOME}/bin:${PATH}' >>$HOME/.profile
    source $HOME/.profile
    writeInstallationSuccessfulMessage Maven
    ;;
  D10)
    writeInstallationMessage Gradle
    rm -rf gradle-${GRADLE_VERSION}-bin.zip
    wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip
    mkdir /opt/gradle
    unzip -d /opt/ gradle-${GRADLE_VERSION}-bin.zip
    ln -s /opt/gradle-${GRADLE_VERSION} /opt/gradle
    echo -e '\n# Gradle Configuration'  >>$HOME/.profile
    echo -ne 'export PATH=$PATH:/opt/gradle' >> $HOME/.profile
    echo "/gradle-${GRADLE_VERSION}/bin" >> $HOME/.profile
    source $HOME/.profile
    writeInstallationSuccessfulMessage Gradle
    ;;
  D11)
    writeInstallationMessage NPM
    apt install nodejs npm -y
    node -v
    writeInstallationSuccessfulMessage NPM
  ;;
  D12)
    writeInstallationMessage PuTTY
    apt -y install putty
    writeInstallationSuccessfulMessage PuTTY
    ;;
  D13)
    writeInstallationMessage Vim
    apt -y install vim
    writeInstallationSuccessfulMessage Vim
    ;;
  D14)
    writeInstallationMessage DataGrip
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
          Categories=Development;IDE;" >>/usr/share/applications/jetbrains-datagrip.desktop
    writeInstallationSuccessfulMessage DataGrip
    ;;
  D15)
    writeInstallationMessage Mongo-Shell
    wget -O mongosh.deb https://downloads.mongodb.com/compass/mongodb-mongosh_1.2.2_amd64.deb
    dpkg -i ./mongosh.deb
    writeInstallationSuccessfulMessage Mongo-Shell

    writeInstallationMessage MongoDB-Database-Tools
    wget -O mongodb-database-tools.deb https://fastdl.mongodb.org/tools/db/mongodb-database-tools-debian92-x86_64-100.5.2.deb
    dpkg -i ./mongodb-database-tools.deb
    writeInstallationSuccessfulMessage MongoDB-Database-Tools
    ;;

  E1)
    writeInstallationMessage Gnome-Tweak-Tool
    apt -y install gnome-tweak-tool
    writeInstallationSuccessfulMessage Gnome-Tweak-Tool
    ;;
  E2)
    writeInstallationMessage Gnome-Shell-Extensions
    apt -y install gnome-shell-extensions
    writeInstallationSuccessfulMessage Gnome-Shell-Extensions
    ;;

  F1)
    writeInstallationMessage Dropbox
    wget -O dropbox.deb https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_${DROPBOX_VERSION}_amd64.deb
    apt -y install ./dropbox.deb
    writeInstallationSuccessfulMessage Dropbox
    ;;
  F2)
    writeInstallationMessage KeePassXC
    apt-get -y install keepassxc
    writeInstallationSuccessfulMessage KeePassXC
    ;;
  F3)
    writeInstallationMessage Virtualbox
    add-apt-repository "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian bullseye contrib"
    wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | apt-key add -
    wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | apt-key add -
    apt-get -y update
    apt-get -y install virtualbox-6.1
    writeInstallationSuccessfulMessage Virtualbox
    ;;
  F4)
    writeInstallationMessage Boxes
    apt -y install gnome-boxes
    writeInstallationSuccessfulMessage Boxes
    ;;
  F5)
    writeInstallationMessage Terminator
    apt -y install terminator
    writeInstallationSuccessfulMessage Terminator
    ;;
  F6)
    writeInstallationMessage Web-Apps
    wget http://packages.linuxmint.com/pool/main/w/webapp-manager/webapp-manager_1.2.8_all.deb
    sudo dpkg -i webapp-manager_1.2.8_all.deb
    writeInstallationSuccessfulMessage Web-Apps
    ;;
  F7)
    writeInstallationMessage OpenVPN
    apt-get install -y openvpn
    apt-get install -y network-manager-openvpn-gnome
    writeInstallationSuccessfulMessage OpenVPN
    ;;

  G1)
    writeInstallationMessage Gimp
    apt -y install gimp
    writeInstallationSuccessfulMessage Gimp
    ;;
  G2)
    writeInstallationMessage Droidcam
    wget -O droidcam_latest.zip https://files.dev47apps.net/linux/droidcam_${DROIDCAM_VERSION}.zip
    unzip droidcam_latest.zip -d droidcam
    cd droidcam && sudo ./install-client
    apt -y install linux-headers-$(uname -r) gcc make
    ./install-video
    cd ..

    wget https://files.dev47apps.net/linux/libindicator3-7_0.5.0-4_amd64.deb
    sudo dpkg -i libindicator3-7_0.5.0-4_amd64.deb

    wget https://files.dev47apps.net/linux/libappindicator3-1_0.4.92-7_amd64.deb
    sudo dpkg -i libappindicator3-1_0.4.92-7_amd64.deb
    writeInstallationSuccessfulMessage Droidcam
    ;;
  G3)
    writeInstallationMessage TLP
    apt -y install tlp
    writeInstallationSuccessfulMessage TLP
    ;;
  *)
  esac
done



printf "\n${BLUE}===============Installing Dependencies========================${ENDCOLOR}\n"
# Install dependencies
apt-get -f install
printf "${GREEN}===============Dependencies are installed successfully!===============${ENDCOLOR}\n"

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

#!/bin/bash

# Set Color
RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
ENDCOLOR="\e[0m"
# Set Version
JETBRAINS_VERSION=2023.3.4
GO_VERSION=1.22
POSTMAN_VERSION=10.23
MAVEN=3
MAVEN_VERSION=3.9.4
GRADLE_VERSION=8.2.1
SPRING_VERSION=3.1.2
DROIDCAM_VERSION=1.8.2
DROPBOX_VERSION=2022.12.05

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

# Install standard package
declare -A essential
essentials=(
  apt-transport-https
  ca-certificates
  curl
  gnupg
  lsb-release
  wget
  dialog
  tree
  zsh
  htop
)
printf "\n${BLUE}========================Installing standard package $1========================${ENDCOLOR}\n"
for key in "${essentials[@]}"; do
  apt install -y $key
done
printf "\n${BLUE}===============Standard packages are installed successfully=============== ${ENDCOLOR}\n"

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


# Snap Repository
install_snap() {
  print_installation_message Snap
  apt -y install snapd
  snap install snap-store
  print_installation_message_success Snap
}

# Flatpak Repository
install_flatpak() {
  print_installation_message Flatpak-Repository
  apt -y install flatpak
  apt -y install gnome-software-plugin-flatpak
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  print_installation_message_success Flatpak-Repository
}

# Google Chrome
install_google_chrome() {
  print_installation_message Google-Chrome
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  apt -y install ./google-chrome-stable_current_amd64.deb
  print_installation_message_success Google-Chrome
}

# Chromium
install_chromium() {
  print_installation_message Chromium
  apt -y install chromium
  print_installation_message_success Chromium
}

# Spotify
install_spotify() {
  print_installation_message Spotify
  curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
  echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
  apt -y update && apt -y install spotify-client
  print_installation_message_success Spotify
}

# Opera
install_opera() {
  print_installation_message Opera
  curl -fSsL https://deb.opera.com/archive.key | gpg --dearmor | sudo tee /usr/share/keyrings/opera.gpg >/dev/null
  echo deb [arch=amd64 signed-by=/usr/share/keyrings/opera.gpg] https://deb.opera.com/opera-stable/ stable non-free | sudo tee /etc/apt/sources.list.d/opera.list
  apt -y update
  apt -y install opera-stable
  print_installation_message_success Opera
}

# Microsoft-Edge
install_microsoft_edge() {
  print_installation_message Microsoft-Edge
  curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >microsoft.gpg
  install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
  sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'
  rm microsoft.gpg
  apt -y update && apt -y install microsoft-edge-stable
  print_installation_message_success Microsoft-Edge
}

# Zoom
install_zoom() {
  print_installation_message Zoom
  wget https://zoom.us/client/latest/zoom_amd64.deb
  apt -y install ./zoom_amd64.deb
  print_installation_message_success Zoom
}

# Discord
install_discord() {
  print_installation_message Discord
  wget -O discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
  dpkg -i discord.deb
  print_installation_message_success Discord
}

# Thunderbird
install_thunderbird() {
  print_installation_message Thunderbird
  apt -y install thunderbird
  print_installation_message_success Thunderbird
}

# GIT
install_git() {
  print_installation_message GIT
  apt -y install git
  print_installation_message_success GIT
}

# OpenJDK
install_openJDK() {
  print_installation_message OpenJDK
  apt -y install default-jdk
  print_installation_message OpenJDK

}

# ORACLE JAVA JDK 18 & ORACLE JAVA JDK 17 && SPRING BOOT CLI
install_javaJDK() {
  print_installation_message JAVA-JDK-18
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
  print_installation_message_success JAVA-JDK-18

  print_installation_message JAVA-JDK-17
  wget https://download.oracle.com/java/17/archive/jdk-17_linux-x64_bin.tar.gz
  tar xf jdk-17_linux-x64_bin.tar.gz -C /usr/local/java
  update-alternatives --install "/usr/bin/java" "java" "/usr/local/java/jdk-17/bin/java" 2
  update-alternatives --install "/usr/bin/javac" "javac" "/usr/local/java/jdk-17/bin/javac" 2
  print_installation_message_success JAVA-JDK-17

  print_installation_message Spring-Boot-CLI
  wget https://repo.maven.apache.org/maven2/org/springframework/boot/spring-boot-cli/${SPRING_VERSION}/spring-boot-cli-${SPRING_VERSION}-bin.tar.gz
  tar xf spring-boot-cli-${SPRING_VERSION}-bin.tar.gz -C /opt
  echo -e "\n# Spring Boot CLI" >>$HOME/.profile
  echo -ne 'export SPRING_HOME=/opt/spring-' >>$HOME/.profile
  echo "${SPRING_VERSION}" >>$HOME/.profile
  echo 'export PATH=$PATH:$HOME/bin:$SPRING_HOME/bin' >>$HOME/.profile
  source $HOME/.profile
  print_installation_message_success Spring-Boot-CLI
}

# GO
install_go() {
  print_installation_message Go
  wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz
  rm -rf /usr/local/go && tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz

  echo -e '\n# GoLang configuration ' >>$HOME/.profile
  echo 'export PATH="$PATH:/usr/local/go/bin"' >>$HOME/.profile
  echo 'export GOPATH="$HOME/go"' >>$HOME/.profile
  source $HOME/.profile
  print_installation_message_success Go
}

# VSCODE
install_vscode() {
  print_installation_message vscode
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
  install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
  sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
  rm -f packages.microsoft.gpg
  apt -y update
  apt -y install code # or code-insiders
  print_installation_message_success vscode
}

# Intellij-IDEA
install_intellij_idea() {
  print_installation_message IntelliJ-IDEA
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
  print_installation_message_success IntelliJ-IDEA
}

# GoLand
install_goland() {
  print_installation_message GoLand
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
  print_installation_message_success GoLand
}

# Postman
install_postman() {
  print_installation_message Postman
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
  print_installation_message_success Postman
}

# Docker
install_docker() {
  print_installation_message Docker
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
  print_installation_message_success Docker

  print_installation_message docker-compose
  curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
  ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
  docker-compose --version
  print_installation_message_success docker-compose
}

# Maven
install_maven() {
  print_installation_message Maven
  rm -rf /tmp/apache-maven-${MAVEN_VERSION}-bin.tar.gz
  wget https://dlcdn.apache.org/maven/maven-${MAVEN}/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz
  tar -zxvf apache-maven-${MAVEN_VERSION}-bin.tar.gz -C /opt
  ln -s /opt/apache-maven-${MAVEN_VERSION} /opt/maven
  echo -e '\n# Maven Configuration' >>$HOME/.profile
  echo "export M2_HOME=/opt/maven" >>$HOME/.profile
  echo 'export PATH=${M2_HOME}/bin:${PATH}' >>$HOME/.profile
  source $HOME/.profile
  print_installation_message_success Maven
}

# Gradle
install_gradle() {
  print_installation_message Gradle
  rm -rf gradle-${GRADLE_VERSION}-bin.zip
  wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip
  unzip -d /opt/ gradle-${GRADLE_VERSION}-bin.zip
  ln -s /opt/gradle-${GRADLE_VERSION} /opt/gradle
  echo -e '\n# Gradle Configuration' >>$HOME/.profile
  echo -ne 'export PATH=$PATH:/opt/gradle/bin' >>$HOME/.profile
  source $HOME/.profile
  print_installation_message_success Gradle
}

# NPM
install_npm() {
  print_installation_message NPM
  apt install nodejs npm -y
  node -v
  print_installation_message_success NPM
}

# PuTTY
install_putty() {
  print_installation_message PuTTY
  apt -y install putty
  print_installation_message_success PuTTY
}

# Vim
install_vim() {
  print_installation_message Vim
  apt -y install vim
  print_installation_message_success Vim
}

# DataGrip
install_datagrip() {
  print_installation_message DataGrip
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
  print_installation_message_success DataGrip
}

# Gnome
install_gnome_tool() {
  print_installation_message Gnome-Tweak-Tool
  apt -y install gnome-tweak-tool
  apt -y install gnome-shell-extensions
  print_installation_message_success Gnome-Tweak-Tool
}

# Dropbox
install_dropbox() {
  print_installation_message Dropbox
  wget -O dropbox.deb https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_${DROPBOX_VERSION}_amd64.deb
  apt -y install ./dropbox.deb
  print_installation_message_success Dropbox
}

# KeePassXC
install_keepassxc() {
  print_installation_message KeePassXC
  apt-get -y install keepassxc
  print_installation_message_success KeePassXC
}

# VirtualBox
install_virtualbox() {
  # TODO:
  print_installation_message VirtualBox

  print_installation_message_success VirtualBox
}

# Gnome Boxes
install_gnome_boxes() {
  print_installation_message Boxes
  apt -y install gnome-boxes
  print_installation_message_success Boxes
}

# Terminator
install_terminator() {
  print_installation_message Terminator
  apt -y install terminator
  print_installation_message_success Terminator
}

# Web-Apps
install_web_apps() {
  print_installation_message Web-Apps
  wget http://packages.linuxmint.com/pool/main/w/webapp-manager/webapp-manager_1.2.8_all.deb
  dpkg -i webapp-manager_1.2.8_all.deb
  print_installation_message_success Web-Apps
}

# OpenVPN
install_openvpn() {
  print_installation_message OpenVPN
  apt install -y openvpn
  apt- install -y network-manager-openvpn-gnome
  print_installation_message_success OpenVPN
}

# VeraCrypt
install_veracrypt() {
  print_installation_message VeraCrypt
  wget -O veracrypt.deb https://launchpad.net/veracrypt/trunk/1.25.9/+download/veracrypt-1.25.9-Debian-11-amd64.deb
  dpkg -i veracrypt.deb
  print_installation_message_success VeraCrypt
}

# Gimp
install_gimp() {
  print_installation_message Gimp
  apt -y install gimp
  print_installation_message_success Gimp
}

# Droidcam
install_droidcam() {
  print_installation_message Droidcam
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
  print_installation_message_success Droidcam
}

# TLP
install_tlp() {
  print_installation_message TLP
  apt -y install tlp
  print_installation_message_success TLP
}

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
  # E: Environment
  E1 "Gnome Tweak Tool & Extensions" off
  # F: Utility
  F1 "Dropbox" off
  F2 "KeePassXC" off
  F3 "Virtualbox" off
  F4 "Gnome Boxes" off
  F5 "Terminator" off
  F6 "Web Apps" off
  F7 "OpenVPN" off
  F8 "VeraCrypt" off
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
    install_snap
    ;;
  A2)
    install_flatpak
    ;;

  B1)
    install_google_chrome
    ;;
  B2)
    install_chromium
    ;;
  B3)
    install_spotify
    ;;
  B4)
    install_opera
    ;;
  B5)
    install_microsoft_edge
    ;;

  C1)
    install_zoom
    ;;
  C2)
    install_discord
    ;;
  C3)
    install_thunderbird
    ;;

  D1)
    install_git
    ;;
  D2)
    install_openJDK
    install_javaJDK
    ;;
  D3)
    install_go
    ;;
  D4)
    install_vscode
    ;;
  D5)
    install_intellij_idea
    ;;
  D6)
    install_goland
    ;;
  D7)
    install_postman
    ;;
  D8)
    install_docker
    ;;
  D9)
    install_maven
    ;;
  D10)
    install_gradle
    ;;
  D11)
    install_npm
    ;;
  D12)
    install_putty
    ;;
  D13)
    install_vim
    ;;
  D14)
    install_datagrip
    ;;

  E1)
    install_gnome_tool
    ;;

  F1)
    install_dropbox
    ;;
  F2)
    install_keepassxc
    ;;
  F3)
    install_virtualbox
    ;;
  F4)
    install_gnome_boxes
    ;;
  F5)
    install_terminator
    ;;
  F6)
    install_web_apps
    ;;
  F7)
    install_openvpn

    ;;
  F8)
    install_veracrypt
    ;;

  G1)
    install_gimp
    ;;
  G2)
    install_droidcam
    ;;
  G3)
    install_tlp
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

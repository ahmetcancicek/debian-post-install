#!/bin/bash

# ==========================================
# 1. Constants & Configuration
# ==========================================

# Colors
RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
ENDCOLOR="\e[0m"

# Versions
IntelliJIDEA_VERSION="2024.2.1"
DataGrip_VERSION="2024.2.2"
GoLand_VERSION="2024.2.1.1"
GO_VERSION="1.23.1"
POSTMAN_VERSION="11.12"
MAVEN="3"
MAVEN_VERSION="3.9.9"
GRADLE_VERSION="8.10.1"
SPRING_VERSION="3.3.3"
ANKI_VERSION="24.06.3"
DROIDCAM_VERSION="2.1.3"
DROPBOX_VERSION="2024.04.17"
WEBAPPMANAGER_VERSION="1.3.7"

# URLs
CHROME_URL="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
ZOOM_URL="https://zoom.us/client/latest/zoom_amd64.deb"
DISCORD_URL="https://discordapp.com/api/download?platform=linux&format=deb"
VSCODE_KEY_URL="https://packages.microsoft.com/keys/microsoft.asc"
VSCODE_REPO_URL="https://packages.microsoft.com/repos/code"
INTELLIJ_URL="https://download.jetbrains.com/idea/ideaIU-${IntelliJIDEA_VERSION}.tar.gz"
GOLAND_URL="https://download.jetbrains.com/go/goland-${GoLand_VERSION}.tar.gz"
DATAGRIP_URL="https://download.jetbrains.com/datagrip/datagrip-${DataGrip_VERSION}.tar.gz"
POSTMAN_URL="https://dl.pstmn.io/download/latest/linux64"
DOCKER_GPG_URL="https://download.docker.com/linux/debian/gpg"
DOCKER_REPO_URL="https://download.docker.com/linux/debian"
DOCKER_COMPOSE_URL="https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)"
MAVEN_URL="https://dlcdn.apache.org/maven/maven-${MAVEN}/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz"
GRADLE_URL="https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip"
DROPBOX_URL="https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_${DROPBOX_VERSION}_amd64.deb"
WEBAPPMANAGER_URL="http://packages.linuxmint.com/pool/main/w/webapp-manager/webapp-manager_${WEBAPPMANAGER_VERSION}_all.deb"
DROIDCAM_URL="https://files.dev47apps.net/linux/droidcam_${DROIDCAM_VERSION}.zip"
ANKI_URL="https://github.com/ankitects/anki/releases/download/23.12.1/anki-${ANKI_VERSION}-linux-qt6.tar.zst"
BRAVE_KEY_URL="https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg"
BRAVE_REPO_URL="https://brave-browser-apt-release.s3.brave.com/"

# ==========================================
# 2. Helper Functions
# ==========================================

# Check if the user is root
check_root() {
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
}

# Check if the OS is Debian/Ubuntu based
check_os() {
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    if [[ "$ID" != "debian" && "$ID" != "ubuntu" && "$ID_LIKE" != *"debian"* && "$ID_LIKE" != *"ubuntu"* ]]; then
      printf "${RED}Error: This script is designed for Debian/Ubuntu based systems only.${ENDCOLOR}\n"
      exit 1
    fi
  else
    printf "${RED}Error: Cannot determine OS distribution.${ENDCOLOR}\n"
    exit 1
  fi
}

# Go to temporary directory
go_temp() {
  cd /tmp || exit
}

# Print installation start message
print_installation_message() {
  printf "\n${BLUE}===============================Installing %s==============================${ENDCOLOR}\n" "$1"
}

# Print installation success message
print_installation_message_success() {
  printf "${GREEN}========================%s is installed successfully!========================${ENDCOLOR}\n" "$1"
  go_temp
}

# Generic APT package installer
install_apt_package() {
  local app_name=$1
  local package_name=$2
  print_installation_message "$app_name"
  apt-get -y install "$package_name"
  print_installation_message_success "$app_name"
}

# Add configuration to .profile if not exists
add_to_profile() {
  local marker="$1"
  local content="$2"

  if ! grep -qF "$marker" "$HOME/.profile"; then
    echo -e "\n$marker" >> "$HOME/.profile"
    echo -e "$content" >> "$HOME/.profile"
    source "$HOME/.profile"
  fi
}

# Cleanup downloaded files
cleanup() {
  print_installation_message "Cleanup"
  rm -f /tmp/*.deb
  rm -f /tmp/*.tar.gz
  rm -f /tmp/*.zip
  rm -f /tmp/*.gpg
  rm -f /tmp/*.asc
  print_installation_message_success "Cleanup"
}

# ==========================================
# 3. System Setup & Updates
# ==========================================

# Check Root
check_root

# Check OS
check_os

# Get USER name and HOME folder
USER=$(logname)
HOME="/home/$USER"

# Go TEMP folder
go_temp

# Update
printf "\n${BLUE}========================Installing Updating========================${ENDCOLOR}\n"
apt-get -y update
printf "${GREEN}========================Updated successfully!========================${ENDCOLOR}\n"

# Upgrade
printf "\n${BLUE}===========================Upgrading===========================${ENDCOLOR}\n"
apt-get -y upgrade
printf "${GREEN}==========================Upgraded successfully!===========================${ENDCOLOR}\n"

# Install standard packages
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

printf "\n${BLUE}========================Installing standard packages========================${ENDCOLOR}\n"
for key in "${essentials[@]}"; do
  apt-get install -y "$key"
done
printf "\n${BLUE}===============Standard packages are installed successfully=============== ${ENDCOLOR}\n"

# ==========================================
# 4. Installation Functions
# ==========================================

# Snap Repository
install_snap() {
  print_installation_message Snap
  apt-get -y install snapd && \
  snap install snap-store
  print_installation_message_success Snap
}

# Flatpak Repository
install_flatpak() {
  print_installation_message Flatpak-Repository
  apt-get -y install flatpak && \
  apt-get -y install gnome-software-plugin-flatpak && \
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  print_installation_message_success Flatpak-Repository
}

# Google Chrome
install_google_chrome() {
  print_installation_message Google-Chrome
  wget "$CHROME_URL" && \
  apt-get -y install ./google-chrome-stable_current_amd64.deb
  print_installation_message_success Google-Chrome
}

# Spotify
install_spotify() {
  print_installation_message Spotify
  curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg && \
  echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list && \
  apt-get -y update && apt-get -y install spotify-client
  print_installation_message_success Spotify
}

# Opera
install_opera() {
  print_installation_message Opera
  curl -fSsL https://deb.opera.com/archive.key | gpg --dearmor | sudo tee /usr/share/keyrings/opera.gpg >/dev/null && \
  echo deb [arch=amd64 signed-by=/usr/share/keyrings/opera.gpg] https://deb.opera.com/opera-stable/ stable non-free | sudo tee /etc/apt/sources.list.d/opera.list && \
  apt-get -y update && \
  apt-get -y install opera-stable
  print_installation_message_success Opera
}

# Microsoft-Edge
install_microsoft_edge() {
  print_installation_message Microsoft-Edge
  curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >microsoft.gpg && \
  install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/ && \
  sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list' && \
  rm microsoft.gpg && \
  apt-get -y update && apt-get -y install microsoft-edge-stable
  print_installation_message_success Microsoft-Edge
}

# Zoom
install_zoom() {
  print_installation_message Zoom
  wget "$ZOOM_URL" && \
  apt-get -y install ./zoom_amd64.deb
  print_installation_message_success Zoom
}

# Discord
install_discord() {
  print_installation_message Discord
  wget -O discord.deb "$DISCORD_URL" && \
  dpkg -i discord.deb
  print_installation_message_success Discord
}

# OpenJDK
install_openJDK() {
  print_installation_message OpenJDK
  apt-get -y install default-jdk
  print_installation_message OpenJDK
}

# ORACLE JAVA JDK 18 &  ORACLE JAVA JDK 21 & ORACLE JAVA JDK 17 && SPRING BOOT CLI
install_javaJDK() {
  print_installation_message JAVA-JDK-18
  wget https://download.oracle.com/java/18/latest/jdk-18.0.2_linux-x64_bin.tar.gz && \
  mkdir -p /usr/local/java/ && \
  tar xf jdk-18.0.2_linux-x64_bin.tar.gz -C /usr/local/java/ && \
  update-alternatives --install "/usr/bin/java" "java" "/usr/local/java/jdk-18.0.2/bin/java" 1 && \
  update-alternatives --install "/usr/bin/javac" "javac" "/usr/local/java/jdk-18.0.2/bin/javac" 1 && \
  update-alternatives --set java /usr/local/java/jdk-18.0.2/bin/java && \
  update-alternatives --set javac /usr/local/java/jdk-18.0.2/bin/javac && \
  add_to_profile "# JAVA Configuration" "JAVA_HOME=/usr/local/java/jdk-18.0.2/bin/java"
  print_installation_message_success JAVA-JDK-18

  print_installation_message JAVA-JDK-21
  wget https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.tar.gz && \
  tar xf jdk-21_linux-x64_bin.tar.gz -C /usr/local/java/ && \
  update-alternatives --install "/usr/bin/java" "java" "/usr/local/java/jdk-21/bin/java" 2 && \
  update-alternatives --install "/usr/bin/javac" "javac" "/usr/local/java/jdk-21/bin/javac" 2
  print_installation_message_success JAVA-JDK-21

  print_installation_message JAVA-JDK-17
  wget https://download.oracle.com/java/17/archive/jdk-17_linux-x64_bin.tar.gz && \
  tar xf jdk-17_linux-x64_bin.tar.gz -C /usr/local/java && \
  update-alternatives --install "/usr/bin/java" "java" "/usr/local/java/jdk-17/bin/java" 3 && \
  update-alternatives --install "/usr/bin/javac" "javac" "/usr/local/java/jdk-17/bin/javac" 3
  print_installation_message_success JAVA-JDK-17

  print_installation_message Spring-Boot-CLI
  wget https://repo.maven.apache.org/maven2/org/springframework/boot/spring-boot-cli/${SPRING_VERSION}/spring-boot-cli-${SPRING_VERSION}-bin.tar.gz && \
  tar xf spring-boot-cli-${SPRING_VERSION}-bin.tar.gz -C /opt && \
  add_to_profile "# Spring Boot CLI" "export SPRING_HOME=/opt/spring-${SPRING_VERSION}\nexport PATH=\$PATH:\$HOME/bin:\$SPRING_HOME/bin"
  print_installation_message_success Spring-Boot-CLI
}

# GO
install_go() {
  print_installation_message Go
  wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz && \
  rm -rf /usr/local/go && tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz && \
  add_to_profile "# GoLang configuration" "export PATH=\"\$PATH:/usr/local/go/bin\"\nexport GOPATH=\"\$HOME/go\""
  print_installation_message_success Go
}

# VSCODE
install_vscode() {
  print_installation_message vscode
  wget -qO- "$VSCODE_KEY_URL" | gpg --dearmor >packages.microsoft.gpg && \
  install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/ && \
  sh -c "echo \"deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] $VSCODE_REPO_URL stable main\" > /etc/apt/sources.list.d/vscode.list" && \
  rm -f packages.microsoft.gpg && \
  apt-get -y update && \
  apt-get -y install code # or code-insiders
  print_installation_message_success vscode
}

# Intellij-IDEA
install_intellij_idea() {
  print_installation_message IntelliJ-IDEA
  wget "$INTELLIJ_URL" -O ideaIU.tar.gz && \
  tar -xf ideaIU.tar.gz -C /opt && \
  mv /opt/idea-IU-* /opt/idea-IU-${IntelliJIDEA_VERSION} && \
  ln -s /opt/idea-IU-${IntelliJIDEA_VERSION} /opt/idea && \
  ln -s /opt/idea/bin/idea.sh /usr/local/bin/idea && \
  echo "[Desktop Entry]
            Version=1.0
            Type=Application
            Name=IntelliJ IDEA Ultimate Edition
            Icon=/opt/idea/bin/idea.svg
            Exec=/opt/idea/bin/idea.sh %f
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
  wget "$GOLAND_URL" -O goland.tar.gz && \
  tar -xzf goland.tar.gz -C /opt && \
  mv /opt/GoLand-* /opt/GoLand-${GoLand_VERSION} && \
  ln -s /opt/GoLand-${GoLand_VERSION} /opt/goland && \
  ln -s /opt/goland/bin/goland.sh /usr/local/bin/goland && \
  echo "[Desktop Entry]
          Version=1.0
          Type=Application
          Name=GoLand
          Icon=/opt/GoLand-${GoLand_VERSION}/bin/goland.png
          Exec=/opt/GoLand-${GoLand_VERSION}/bin/goland.sh
          Terminal=false
          Categories=Development;IDE;" >>/usr/share/applications/jetbrains-goland.desktop
  print_installation_message_success GoLand
}

# Postman
install_postman() {
  print_installation_message Postman
  curl "$POSTMAN_URL" --output postman-${POSTMAN_VERSION}-linux-x64.tar.gz && \
  tar -xzf postman-${POSTMAN_VERSION}-linux-x64.tar.gz -C /opt && \
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
    lsb-release && \
  curl -fsSL "$DOCKER_GPG_URL" | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
  echo \
    "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] $DOCKER_REPO_URL \
      $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list >/dev/null && \
  apt-get update && \
  apt-get -y install docker-ce docker-ce-cli containerd.io && \
  docker run hello-world && \
  groupadd docker && \
  usermod -aG docker $USER
  print_installation_message_success Docker

  print_installation_message docker-compose
  curl -L "$DOCKER_COMPOSE_URL" -o /usr/local/bin/docker-compose && \
  chmod +x /usr/local/bin/docker-compose && \
  ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose && \
  docker-compose --version
  print_installation_message_success docker-compose
}

# Maven
install_maven() {
  print_installation_message Maven
  rm -rf /tmp/apache-maven-${MAVEN_VERSION}-bin.tar.gz
  wget "$MAVEN_URL" && \
  tar -zxvf apache-maven-${MAVEN_VERSION}-bin.tar.gz -C /opt && \
  ln -s /opt/apache-maven-${MAVEN_VERSION} /opt/maven && \
  add_to_profile "# Maven Configuration" "export M2_HOME=/opt/maven\nexport PATH=\${M2_HOME}/bin:\${PATH}"
  print_installation_message_success Maven
}

# Gradle
install_gradle() {
  print_installation_message Gradle
  rm -rf gradle-${GRADLE_VERSION}-bin.zip
  wget "$GRADLE_URL" && \
  unzip -d /opt/ gradle-${GRADLE_VERSION}-bin.zip && \
  ln -s /opt/gradle-${GRADLE_VERSION} /opt/gradle && \
  add_to_profile "# Gradle Configuration" "export PATH=\$PATH:/opt/gradle/bin"
  print_installation_message_success Gradle
}

# NPM
install_npm() {
  print_installation_message NPM
  apt-get install nodejs npm -y && \
  node -v
  print_installation_message_success NPM
}

# DataGrip
install_datagrip() {
  print_installation_message DataGrip
  wget "$DATAGRIP_URL" && \
  tar -xzf datagrip-${DataGrip_VERSION}.tar.gz -C /opt && \
  # mv /opt/DataGrip-* /opt/DataGrip-${DataGrip_VERSION}
  ln -s /opt/DataGrip-${DataGrip_VERSION} /opt/datagrip && \
  ln -s /opt/datagrip/bin/datagrip.sh /usr/local/bin/datagrip && \
  echo "[Desktop Entry]
          Version=1.0
          Type=Application
          Name=DataGrip
          Icon=/opt/datagrip/bin/datagrip.png
          Exec=/opt/datagrip/bin/datagrip.sh
          Terminal=false
          Categories=Development;IDE;" >>/usr/share/applications/jetbrains-datagrip.desktop
  print_installation_message_success DataGrip
}

# Gnome
install_gnome_tool() {
  print_installation_message Gnome-Tweak-Tool
  apt-get -y install gnome-tweak-tool && \
  apt-get -y install gnome-shell-extensions
  print_installation_message_success Gnome-Tweak-Tool
}

# Dropbox
install_dropbox() {
  print_installation_message Dropbox
  wget -O dropbox.deb "$DROPBOX_URL" && \
  apt-get -y install ./dropbox.deb
  print_installation_message_success Dropbox
}

# VirtualBox
install_virtualbox() {
  print_installation_message VirtualBox
  apt-get -y install gnupg2 lsb-release && \
  curl -fsSL https://www.virtualbox.org/download/oracle_vbox_2016.asc|sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/vbox.gpg && \
  curl -fsSL https://www.virtualbox.org/download/oracle_vbox.asc|sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/oracle_vbox.gpg && \
  echo "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list && \
  apt-get -y update && \
  apt-get install linux-headers-$(uname -r) dkms -y && \
  apt-get install virtualbox-7.0 -y && \
  groupadd vboxusers && \
  usermod -aG vboxusers $USER && \
  wget https://download.virtualbox.org/virtualbox/7.0.10/Oracle_VM_VirtualBox_Extension_Pack-7.0.10.vbox-extpack && \
  vboxmanage extpack install Oracle_VM_VirtualBox_Extension_Pack-7.0.10.vbox-extpack
  print_installation_message_success VirtualBox
}

# Web-Apps
install_web_apps() {
  print_installation_message Web-Apps
  wget "$WEBAPPMANAGER_URL" && \
  dpkg -i webapp-manager_${WEBAPPMANAGER_VERSION}_all.deb && \
  apt-get -f install -y
  print_installation_message_success Web-Apps
}

# Droidcam
install_droidcam() {
  print_installation_message Droidcam
  wget -O droidcam_latest.zip "$DROIDCAM_URL" && \
  unzip droidcam_latest.zip -d droidcam && \
  cd droidcam && sudo ./install-client && \
  apt-get -y install linux-headers-$(uname -r) gcc make && \
  ./install-video
  print_installation_message_success Droidcam
}

# Anki
install_anki() {
  print_installation_message Anki
  apt-get -y install zstd && \
  wget "$ANKI_URL" -O anki.tar.zst && \
  tar xaf anki.tar.zst && \
  cd anki-${ANKI_VERSION}-linux-qt6 && \
  sudo ./install.sh
  print_installation_message_success Anki
}

# Raindrop
install_raindrop() {
  if ! command -v snap &> /dev/null; then
    print_installation_message "Snap (Dependency for Raindrop)"
    install_snap
  fi

  print_installation_message Raindrop
  snap install raindrop
  print_installation_message_success Raindrop
}

# Brave
install_brave() {
  print_installation_message Brave
  apt-get -y install curl && \
  curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg "$BRAVE_KEY_URL" && \
  echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] $BRAVE_REPO_URL stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list && \
  apt-get -y update && \
  apt-get -y install brave-browser
  print_installation_message_success Brave
}

cmd=(dialog --title "Debian 12 Installer" --separate-output --checklist 'Please choose: ' 27 76 16)
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
  B6 "Brave" off
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
  F8 "Timeshift" off
  F9 "Gparted" off
  # G: Image, Video and Audio
  G1 "GIMP" off
  G2 "Droidcam" off
  G3 "Kdenlive" off
  G4 "Krita" off
  G5 "Inkscape" off
  G6 "TLP" off
  # H: Productivity
  H1 "LibreOffice" off
  H2 "Raindrop" off
  H3 "Anki" off
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
    install_apt_package "Chromium" "chromium"
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
  B6)
    install_brave
    ;;

  C1)
    install_zoom
    ;;
  C2)
    install_discord
    ;;
  C3)
    install_apt_package "Thunderbird" "thunderbird"
    ;;

  D1)
    install_apt_package "GIT" "git"
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
    install_apt_package "PuTTY" "putty"
    ;;
  D13)
    install_apt_package "Vim" "vim"
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
    install_apt_package "KeePassXC" "keepassxc"
    ;;
  F3)
    install_virtualbox
    ;;
  F4)
    install_apt_package "Gnome Boxes" "gnome-boxes"
    ;;
  F5)
    install_apt_package "Terminator" "terminator"
    ;;
  F6)
    install_web_apps
    ;;
  F7)
    install_apt_package "OpenVPN" "openvpn"
    install_apt_package "Network Manager OpenVPN" "network-manager-openvpn-gnome"
    ;;
  F8)
    install_apt_package "Timeshift" "timeshift"
    ;;
  F9)
    install_apt_package "Gparted" "gparted"
    ;;

  G1)
    install_apt_package "Gimp" "gimp"
    ;;
  G2)
    install_droidcam
    ;;
  G3)
    install_apt_package "Kdenlive" "kdenlive"
    ;;
  G4)
    install_apt_package "Krita" "krita"
    ;;
  G5)
    install_apt_package "Inkscape" "inkscape"
    ;;
  G6)
    install_apt_package "TLP" "tlp"
    ;;

  H1)
    install_apt_package "LibreOffice" "libreoffice"
    ;;
  H2)
    install_raindrop
    ;;
  H3)
    install_anki
    ;;
  *)
  esac
done

printf "\n${BLUE}===============Installing Dependencies========================${ENDCOLOR}\n"
# Install dependencies
apt-get -f install -y
printf "${GREEN}===============Dependencies are installed successfully!===============${ENDCOLOR}\n"

# Cleanup
cleanup

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

<div align="center">
<h1 align="center">
<br>Debian Post Install
</h1>
<h3>◦ Developed with the software and tools below.</h3>

<p align="center">
<img src="https://img.shields.io/badge/GNU%20Bash-4EAA25.svg?style&logo=GNU-Bash&logoColor=white" alt="GNU%20Bash" />
<img src="https://img.shields.io/badge/Markdown-000000.svg?style&logo=Markdown&logoColor=white" alt="Markdown" />
</p>
<img src="https://img.shields.io/github/languages/top/ahmetcancicek/debian-post-install?style&color=5D6D7E" alt="GitHub top language" />
<img src="https://img.shields.io/github/languages/code-size/ahmetcancicek/debian-post-install?style&color=5D6D7E" alt="GitHub code size in bytes" />
<img src="https://img.shields.io/github/commit-activity/m/ahmetcancicek/debian-post-install?style&color=5D6D7E" alt="GitHub commit activity" />
<img src="https://img.shields.io/github/license/ahmetcancicek/debian-post-install?style&color=5D6D7E" alt="GitHub license" />
</div>

---

## 📍 Overview

Repository contains simple bash script to installing programs effortless after a Debian based installation. If you want
to run the bash script, you can use below code.

---

## 📦 Packages

<details closed><summary>All Packages List</summary>

* Curl
* Wget
* ZSH
* HTOP
* Snap
* Flatpak
* Google Chrome
* Chromium
* Spotify
* Opera
* Microsoft Edge
* Zoom
* Discord
* Thunderbird
* GIT
* OpenJDK
* Oracle Java JDK
* Go
* VSCODE
* IntelliJ IDEA Ultimate
* GoLand
* Postman
* Docker
* Maven
* Gradle
* NPM
* Putty
* VIM
* DataGrip
* Gnome Tweak Tool
* Dropbox
* KeePassXC
* VirtualBox
* Gnome Boxes
* Terminator
* Web Apps
* OpenVPN
* VeraCrypt
* GIMP
* Droidcam
* TLP

</details>

---

## 📂 Repository Structure

```sh
└── debian-post-install/
    ├── .gitignore
    ├── LICENSE
    ├── Makefile
    ├── README.md
    ├── install-drivers.sh
    ├── install-fonts.sh
    ├── install-sudo.sh
    └── main.sh
```

---

## ⚙️ Modules

<details closed><summary>Root</summary>

| File                                                                                                    | Summary                                                                                                                                                                                                        |
|---------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [main.sh](https://github.com/ahmetcancicek/debian-post-install/blob/main/setup.sh)                      | This script runs a script that install the programs you want.                                                                                                                                                  |
| [install-sudo.sh](https://github.com/ahmetcancicek/debian-post-install/blob/main/install-sudo.sh)       | This code installs sudo, checks if the user is root, adds the current user to sudoers file, and displays a success message.                                                                                    |
| [install-fonts.sh](https://github.com/ahmetcancicek/debian-post-install/blob/main/install-fonts.sh)     | This script installs a variety of fonts on a Linux system. It checks for root access, downloads the fonts, extracts them, and moves them to the appropriate font directory. Finally, it updates the font cache. |
| [install-drivers.sh](https://github.com/ahmetcancicek/debian-post-install/blob/main/install-drivers.sh) | This code is a shell script that automates the installation and updating of drivers, provides root access control, and prompts for reboot. It also hides Bluetooth visibility.             |

</details>

---

## 🚀 Getting Started

***Dependencies***

Please ensure you have the following dependencies installed on your system:

```sh
su
apt -y install curl
```

If you want to need installation the sudo, you can use the below code. Otherwise, skip this step.

```sh
su
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ahmetcancicek/debian-post-install/main/install-sudo.sh)" 
```


### 🤖 Running Debian Post Install

```sh
sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/ahmetcancicek/debian-post-install/main/main.sh)" 
```

---

## License

Distributed under the GNU License. See LICENSE.md for more information.

[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](https://opensource.org/licenses/)
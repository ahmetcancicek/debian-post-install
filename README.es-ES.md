

<div align="center">
<h1 align="center">
<br>Debian Post Install
</h1>
<h3>◦ Desarrollado con el siguiente software y herramientas.</h3>

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

## 📍 Descripción General

Este repositorio contiene un script de bash sencillo para instalar programas sin esfuerzo después de una instalación basada en Debian. Si deseas
ejecutar el script de bash, puedes usar el siguiente código.

---

## 📦 Paquetes

<details closed><summary>Lista de Todos los Paquetes</summary>

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
* Brave
* Zoom
* Discord
* Thunderbird
* GIT
* OpenJDK
* Oracle Java JDK
* Spring CLI
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
* Timeshift
* Gparted
* GIMP
* Droidcam
* Kdenlive
* Krita
* Inkscape
* TLP
* LibreOffice

</details>

---

## 📂 Estructura del Repositorio

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

## ⚙️ Módulos

<details closed><summary>Raíz</summary>

| File                                                                                                    | Summary                                                                                                                                                                                                        |
|---------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [main.sh](https://github.com/ahmetcancicek/debian-post-install/blob/main/setup.sh)                      | Este script ejecuta un script que instala los programas que desees.                                                                                                                                                  |
| [install-sudo.sh](https://github.com/ahmetcancicek/debian-post-install/blob/main/install-sudo.sh)       | Este código instala sudo, verifica si el usuario es root, añade al usuario actual al archivo sudoers y muestra un mensaje de éxito.                                                                                    |
| [install-fonts.sh](https://github.com/ahmetcancicek/debian-post-install/blob/main/install-fonts.sh)     | Este script instala una variedad de fuentes en un sistema Linux. Verifica el acceso root, descarga las fuentes, las extrae y las mueve al directorio de fuentes correspondiente. Finalmente, actualiza la caché de fuentes. |
| [install-drivers.sh](https://github.com/ahmetcancicek/debian-post-install/blob/main/install-drivers.sh) | Este código es un script de shell que automatiza la instalación y actualización de controladores, proporciona control de acceso root y solicita un reinicio. También oculta la visibilidad de Bluetooth.             |

</details>

---

## 🚀 Inicio Rápido

***Dependencias***

Asegúrate de tener las siguientes dependencias instaladas en tu sistema:

```sh
su
apt -y install curl
```

Si necesitas instalar sudo, puedes usar el siguiente código. De lo contrario, omite este paso.

```sh
su
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ahmetcancicek/debian-post-install/main/install-sudo.sh)" 
```


### 🤖 Ejecutar Debian Post Install

```sh
sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/ahmetcancicek/debian-post-install/main/main.sh)" 
```

**Para Fuentes**

```sh
sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/ahmetcancicek/debian-post-install/main/install-fonts.sh)" 
```

**Para Controladores**

```sh
sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/ahmetcancicek/debian-post-install/main/install-drivers.sh)" 
```


---

## Licencia

Distribuido bajo la Licencia GNU. Consulta LICENSE.md para más información.

[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](https://opensource.org/licenses/)

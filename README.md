# Debian Post Installation Script

Repository contains simple bash script to installing programs effortless after a Debian based installation. If you want to run the bash script, you can use below code.

[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](https://opensource.org/licenses/)

## Installation

Install dependecies

```bash
su
apt -y install curl
```

## Run

If you want to need installation the sudo, you can use the below code. Otherwise, skip this step.

```bash
su
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ahmetcancicek/debian-post-install/main/install-sudo.sh)" 
```

You can use below code.

```bash
sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/ahmetcancicek/debian-post-install/main/setup.sh)" 
```

## License

[GPLv3.0](https://choosealicense.com/licenses/gpl-3.0/)




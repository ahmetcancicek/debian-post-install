# Debian Post Installation Script

Repository contains simple bash script to installing programs effortless after a Debian based installation. If you want to run the bash script, you can use below code.

[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](https://opensource.org/licenses/)

## Run

If you want to need installation the sudo, you can use the below code. Otherwise, skip this step.

```bash
su
wget https://raw.githubusercontent.com/ahmetcancicek/debian-post-install/main/install-sudo.sh -c -O install-sudo.sh && chmod +x install-sudo.sh
./install-sudo.sh -h
```

You can use below code.

```bash
wget https://raw.githubusercontent.com/ahmetcancicek/debian-post-install/main/setup.sh -c -O setup.sh && chmod +x setup.sh
sudo ./setup.sh -h
```

## Extra

```bash
wget https://raw.githubusercontent.com/ahmetcancicek/debian-post-install/main/install-fonts.sh -c -O install-fonts.sh && chmod +x install-fonts.sh
./install-fonts.sh -h

wget https://raw.githubusercontent.com/ahmetcancicek/debian-post-install/main/install-drivers.sh -c -O install-drivers.sh && chmod +x install-drivers.sh
./install-drivers.sh -h
```

## License

[GPLv3.0](https://choosealicense.com/licenses/gpl-3.0/)




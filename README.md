# Debian Post Installation Script

Repository contains simple bash script to installing programs effortless after a Debian based installation. If you want to run the bash script, you can use below code.

[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](https://opensource.org/licenses/)

## Run

If you want to need installation the sudo, you can use the below code. Otherwise, skip this step.

```bash
su
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ahmetcancicek/debian-post-install/main/install-sudo.sh)" 
```

You can use below code.

```bash
sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/ahmetcancicek/debian-post-install/main/setup.sh)" 
```

## Extra

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ahmetcancicek/debian-post-install/main/install-fonts.sh)" 

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ahmetcancicek/debian-post-install/main/install-drivers.sh)" 
```

## License

[GPLv3.0](https://choosealicense.com/licenses/gpl-3.0/)




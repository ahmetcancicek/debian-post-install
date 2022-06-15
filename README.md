# Debian Post Installation Script

Repository contains simple bash script to installing programs effortless after a Debian based installation. If you want to run the bash script, you can use below code.

[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](https://opensource.org/licenses/)


## Installation

Install dependencies

```bash
su
apt -y install git 
apt -y install make
exit
```

## Run

Clone the project

```bash
  git clone https://github.com/ahmetcancicek/debian-post-install.git
```

Go to the project directory

```bash
  cd debian-post-install
```

If you want to need installation the sudo, you can use the below code. Otherwise, skip this step.

```bash
 su
 make install-sudo
 exit
```

Run

```bash
    sudo make run
```

## License

[GPLv3.0](https://choosealicense.com/licenses/gpl-3.0/)




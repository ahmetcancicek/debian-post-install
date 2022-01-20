# Debian Post Installation Script

Repository contains simple bash script to installing programs effortless after a Debian based installation. If you want to run the bash script, you can use below code.

# Run

```bash
sudo apt -y install git
git clone https://github.com/ahmetcancicek/debian-post-install.git
cd debian-post-install
sudo make run
```

or

```bash
sudo apt -y install git
git clone https://github.com/ahmetcancicek/debian-post-install.git
cd debian-post-install
chmod +x setup.sh
sudo ./setup.sh
```

---

If you want to install Sudo command at the same time, you should run this script.


```bash
su
apt -y install git
git clone https://github.com/ahmetcancicek/debian-post-install.git
cd debian-post-install
chmod +x install-sudo.sh
install-sudo.sh
chmod +x setup.sh
./setup.sh
```

or

```bash
su
apt -y install git
apt -y install make
git clone https://github.com/ahmetcancicek/debian-post-install.git
cd debian-post-install
make install-sudo
make run
```
#!/bin/bash

# For root control
if [ "$(id -u)" != 0 ]; then
  echo "You are not root! This script must be run as root"
  exit 1
fi


# HOME 
USER=$(logname) 
eval cd ~$USER

#Install
apt-get install sudo

# Debian 9 or older
# adduser $USER sudo

# Debian 10
#/sbin/adduser $USER sudo

echo " " >> /etc/sudoers
echo "# User privilege specification" >> /etc/sudoers
echo "$USER  ALL=(ALL:ALL) ALL" >> /etc/sudoers


# Reboot
# End
cat <<EOL

---------------------------------------------------------------
Congratulations, permission you wanted to add for user is created!
---------------------------------------------------------------

EOL

#!/bin/bash

# For root control
if [ "$(id -u)" != 0 ]; then
  echo "You are not root! This script must be run as root"
  exit 1
fi

if [ -z "$1" ]
then
  echo "Hostname must not be null"
  exit 1
fi

hostnamectl set-hostname $1


cat <<EOL
---------------------------------------------------------------
Congratulations, your new hostname is $1
---------------------------------------------------------------
EOL


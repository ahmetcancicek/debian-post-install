#!/bin/bash

# For root control
if [ "$(id -u)" != 0 ]; then
  echo "You are not root! This script must be run as root"
  exit 1
fi

apt -y install sudo

# Get USER name
USER=$(logname)

cat >> /etc/sudoers << EOF

# User privilege specification
$USER ALL=(ALL:ALL) ALL
EOF

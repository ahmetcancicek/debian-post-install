#!/bin/bash

# Set Color
RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
ENDCOLOR="\e[0m"

# For root control
if [ "$(id -u)" != 0 ]; then
  printf "${RED}"
  cat <<EOL
========================================================================
You are not root! This script must be run as root!
========================================================================
EOL
  printf "${ENDCOLOR}"
  exit 1
fi

# Install sudo
apt -y install sudo

# Get USER name
USER=$(logname)

# Print
cat >> /etc/sudoers << EOF

# User privilege specification
$USER ALL=(ALL:ALL) ALL
EOF


printf "${GREEN}"
cat <<EOL
========================================================================
Congratulations, everything you wanted to install is installed!
========================================================================
EOL
printf "${ENDCOLOR}"

cat <<EOL

EOL
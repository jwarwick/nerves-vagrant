#!/usr/bin/env bash

apt-get update
apt-get install -y git g++ libssl-dev libncurses5-dev bc
sudo apt-get install -y libc6:i386 libstdc++6:i386 zlib1g:i386 gcc-multilib

# packages not recommended by nerves-sdk that seem to be required
apt-get install -y zip unzip make

su vagrant <<'EOF'
  mkdir -p /home/vagrant/.nerves-cache
  git clone https://github.com/nerves-project/nerves-sdk.git /home/vagrant/nerves-sdk
  cd /home/vagrant/nerves-sdk
  make nerves_rpi_defconfig
  make
EOF


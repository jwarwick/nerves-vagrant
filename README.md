# Nerves-Vagrant Setup

This project contains a Vagrant/VirtualBox setup to build the Nerves Project (http://nerves-project.org/ https://github.com/nerves-project/nerves-sdk), 
an embedded Erlang environment for the BeagleBone and Raspberry Pi.

## Installation

To install VirtualBox and Vagrant using homebrew (http://brew.sh/) :
```
brew tap caskroom/cask
brew update
brew install brew-cask
brew cask install virtualbox
brew cask install vagrant
```

## Description

The VagrantFile describes the VM setup (important to increase the default memory size and use the specified version
of Ubuntu - newer versions don't appear to have the correct libraries available). The `nerves-bootstrap.sh` file is
run when the vagrant environment is initially started with `vagrant up` or by running `vagrant provision`. It will
download the Nerves project and build an image for the Raspberry Pi.

The default Raspberry Pi setup makes the HDMI output the console. To make the debug console be the default output, 
ssh to the image and modify the file `~/nerves-sdk/board/nerves-common/rootfs-additions/etc/erlinit.config` and run `make` again.

For info on connecting to the Raspberry Pi via the USB console cable, see: https://learn.adafruit.com/downloads/pdf/adafruits-raspberry-pi-lesson-5-using-a-console-cable.pdf
You will need the appropriate USB-serial driver from here: http://sourceforge.net/projects/osx-pl2303/

When finished, run `vagrant ssh` to connect to the VM. Then run:
```
cp nerves-sdk/buildroot/output/images/nerves-rpi-base.img /vagrant/
```
To copy the SD card image back to the host machine (the `/vagrant` directory is mapped back to the directory of the
VagrantFile on the host machine).

On the host machine (MacOS X), insert the SD card and run the following commands:
```
diskutil list
# note the /dev/disk# of the SD card
diskutil unmountDisk /dev/disk#
sudo dd if=nerves-rpi-base.img of=/dev/rdisk# bs=1m
```

Insert the SD card into the Raspberry Pi, then run:
```
# where the values after PL2303- will be machine specific
screen /dev/cu.PL2303-000014FA 115200
```
To connect via screen to the console of the Raspberry Pi. The default nerves-minimal image will provide you with
an Erlang console.

SD card creation instructions from: http://elinux.org/RPi_Easy_SD_Card_Setup#Flashing_the_SD_card_using_Mac_OSX
See the section: _Using command line tools (1)_

## Erlang Build Instructions

What I've done so far:
* Download rebar: `wget https://github.com/rebar/rebar/wiki/rebar`
* Create a new app: `rebar create-app appid=zmq_interface`
* Create a simple GenServer
* Spawn it from the Supervisor
* Create a simple Makefile
* Install relx https://github.com/erlware/relx
* Created simple `relx.config`
* Added rule to Makefile

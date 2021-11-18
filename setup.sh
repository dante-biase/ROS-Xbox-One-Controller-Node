#!/bin/bash


# fix bluetooth connection bug
sudo apt install -y sysfsutils
sudo sh -c "echo '/module/bluetooth/parameters/disable_ertm=1' >> /etc/sysfs.conf"

# setup and enable ssh
sudo apt install -y openssh-server
sudo ufw allow ssh

# install python dependencies
pip3 install evdev pyserial rospkg

# setup maestro controller
sudo apt-get install -y libusb-1.0-0-dev mono-runtime mono-reference-assemblies-2.0 mono-devel
sudo cp ./utils/99-pololu.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules
sudo adduser $USER dialout

# install ROS car
mkdir ~/catkin_ws
mkdir ~/catkin_ws/src
cp -r ./catkin_ws/src/car ~/catkin_ws/src/car

cd ~/catkin_ws
rm -rf ./devel ./build
catkin_make

# reboot for changes to take effect
sudo reboot

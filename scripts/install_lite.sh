#!/bin/bash

# Downloads Raspbian OS Lite and copies
# system image to micro SD card 

# Source:
# https://www.raspberrypi.org/documentation/installation/installing-images/linux.md

# Run lsblk -p to find SD name

# If any partiitions of card have mounted, unmount them
# e.g.
# unmount /dev/sdc1

disk_name=/dev/sdc
wget_dir=downloads

# Download .img file from online source
URL=https://downloads.raspberrypi.org/raspios_lite_armhf/images/raspios_lite_armhf-2021-01-12/2021-01-11-raspios-buster-armhf-lite.zip

# Download latest raspio_light_armhf .zip file to wget_dir
wget ${URL} -P ${wget_dir}

# Unzip downloaded image and pipe contents to dd, which saves to SD
# Status info will be provided to track progress
# If 4M block size does not work, change it 1M
unzip -p 2021-01-11-raspios-buster-armhf.zip | sudo dd of=${disk_name} bs=4M status=progress conv=fsync

# TODO: Add checksum process

# Ensure write cache is flushed so it is safe to remove SD
sync



# Unmount disk
umount ${disk_name}1

printf "\nThe SD card write process is complete and it is now safe"
printf "\nto remove the media from your machine.\n\n"

# Mount SD card boot partition (the smaller one) to add ssh file
sudo mkdir /mnt/SD
sudo mount /dev/sdc1 /mnt/SD
# Add blank ssh file
sudo touch /mnt/SD/ssh
# Unmount media
sudo umount /mnt/SD

# To find raspberry pi on network use:
# ping raspberrypi.local

# If the name of the pi is changed, so will the ping command

# SSH into the pi using
# ssh pi@{IP address}

# Default pi password is "raspberry"
# change this after sign in for security reasons

# If connection fails, you may need to run:
# sudo ufw allow ssh





#!/bin/bash

# Source:
# https://linuxize.com/post/how-to-format-usb-sd-card-linux/

# First, run the following command to identify the SD disk name
#     lsblk -p

disk_name=sdc

# Create the partition table
sudo parted /dev/${disk_name} --script -- mklabel msdos

# Create Fat32 partition that takes whole space:
sudo parted /dev/sdc --script -- mkpart primary fat32 1MiB 100%

# Format boot partition to FAT32:
sudo mkfs.vfat -F32 /dev/sdc1
# It should output this:
# mkfs.fat 4.1 (2017-01-24)

# Print partition table and verify everything is set up correctly:
udo parted /dev/sdc --script print
# It should output this:
# Model: Generic MassStorageClass (scsi)
# Disk /dev/sdc: 31.9GB
# Sector size (logical/physical): 512B/512B
# Partition Table: msdos
# Disk Flags:

# Number  Start   End     Size    Type     File system  Flags
#  1      1049kB  31.9GB  31.9GB  primary  fat32        lba


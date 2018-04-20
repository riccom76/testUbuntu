#!/bin/bash

# Variables
DATA_DISK=$1;
DATA_PART="$DATA_DISK"1;
DATA_PART_MOUNT=$2;

# Partition and format
sudo parted $DATA_DISK mklabel msdos;
sleep 30;
sudo parted -a opt $DATA_DISK mkpart primary ext4 0% 100%;
sleep 30;
sudo mkfs.ext4 -L gitlabdata $DATA_PART;

# Create mount point directory 
sudo mkdir -p $DATA_PART_MOUNT;

sudo mount -t auto -v $DATA_DISK $DATA_PART_MOUNT

sleep 30;

# Make record in /etc/fstab
#DATA_DISK_UUID=$(sudo blkid $DATA_PART -o value | grep "[a-fA-F0-9]\{8\}-[a-fA-F0-9]\{4\}-[a-fA-F0-9]\{4\}-[a-fA-F0-9]\{4\}-[a-fA-F0-9]\{12\}");
#sudo echo "UUID=$DATA_DISK_UUID $DATA_PART_MOUNT auto defaults,nofail,nobootwait 0 2" >> /etc/fstab;

# Mount partitions listed in fstab
#mount -a
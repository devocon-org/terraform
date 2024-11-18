#!/bin/bash

sudo apt update; sudo apt upgrade -y

sudo apt install xfsprogs -y

sudo mkfs -t xfs /dev/xvdbc

sudo mkdir /appdata

sudo mount /dev/xvdbc /appdata

BLK_ID=$(sudo blkid /dev/xvdbc | cut -f2 -d" ")

if [[ -z $BLK_ID ]]; then
  echo "Hmm ... no block ID found ... "
  exit 1
fi

echo "$BLK_ID     /appdata   xfs    defaults   0   2" | sudo tee --append /etc/fstab

sudo mount -a

echo "Bootstrapping Complete!"

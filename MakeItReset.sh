#!/bin/sh
sudo dpkg --clear-selections
sudo dpkg --set-selections < list.txt
sudo apt-get autoremove
sudo apt-get deselect-upgrade
cd ~
rm -fr *
rm -fr .*
cp /etc/skel/.* .


#!/bin/sh
sudo dpkg --clear-selections
sudo dpkg --set-selections < list.txt
sudo apt-get autoremove
sudo apt-get dselect-upgrade
cd ~
rm -fr *
rm -fr .*
cp /etc/skel/.* .
sudo chown $USER:$USER ~/.*


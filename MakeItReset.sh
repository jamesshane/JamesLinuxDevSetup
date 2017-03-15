#!/bin/bash
pat=`echo $SHELL`
if  [[ $pat == *zsh  ]]  ;
	then
		echo "Zsh will be removed, might want to switch to bash: chsh -s /bin/bash" 
		exit 1
fi
echo "Let's Go!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
sudo dpkg --clear-selections
sudo dpkg --set-selections < list.txt
sudo apt-get autoremove
sudo apt-get dselect-upgrade
cd ~
rm -fr *
rm -fr .*
cp /etc/skel/.* .
sudo chown $USER:$USER ~/.*
chsh -s /bin/bash


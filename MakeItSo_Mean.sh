#!/bin/bash
wget https://nodejs.org/dist/v6.9.5/node-v6.9.5.tar.gz
tar xvzf node-v6.9.5.tar.gz
cd node-v6.9.5
./configure
make
sudo make install
sudo npm install -g npm
sudo npm install -g cordova ionic
cd ..
sudo apt-get install mongodb -y
sudo npm install -g gulp
sudo npm install -g bower
sudo npm install -g mean-cli
sudo chown -R $USER ~/.npm
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

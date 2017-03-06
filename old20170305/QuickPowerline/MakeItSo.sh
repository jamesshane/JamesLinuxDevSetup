#!/bin/sh
dpkg --get-selections > list.txt
sudo cp list.txt ../../..
sudo cp ../MakeItReset.sh ../../..
sudo apt-get update
sudo apt-get upgrade -y
#sudo apt-get install -y xinit i3 gnome-terminal firefox
sudo apt-get install -y build-essential vim emacs tmux wget curl zsh htop git-core screen cmatrix vim-gtk
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
#sudo apt-get install vim-gtk -y
#sudo apt-get install python-setuptools -y
#sudo apt-get install python-pip -y
sudo apt-get install git -y
sudo apt-get install fontconfig -y
#sudo -H pip install git+git://github.com/Lokaltog/powerline
#sudo -H pip install --upgrade pip
#wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
#wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
#sudo mv PowerlineSymbols.otf /usr/share/fonts/
#sudo fc-cache -vf /usr/share/fonts/
#sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/
sudo apt-get install powerline
#The author misspelled these. I fixed that, While it does not matter, I fixed it anyway.
mkdir -p ~/.fonts
wget https://github.com/powerline/fonts/raw/master/LiberationMono/Literation%20Mono%20Powerline.ttf -O ~/.fonts/Liberation\ Mono\ Powerline.ttf
wget https://github.com/powerline/fonts/raw/master/LiberationMono/Literation%20Mono%20Powerline%20Bold.ttf -O ~/.fonts/Liberation\ Mono\ Powerline\ Bold.ttf
wget https://github.com/powerline/fonts/raw/master/LiberationMono/Literation%20Mono%20Powerline%20Italic.ttf -O ~/.fonts/Liberation\ Mono\ Powerline\ Italic.ttf
wget https://github.com/powerline/fonts/raw/master/LiberationMono/Literation%20Mono%20Powerline%20Bold%20Italic.ttf -O ~/.fonts/Liberation\ Mono\ Powerline\ Bold\ Italic.ttf
fc-cache -vf ~/.fonts
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
wget https://nodejs.org/dist/v6.9.5/node-v6.9.5.tar.gz
tar xvzf node-v6.9.5.tar.gz
cd node-v6.9.5
./configure
make
sudo make install
sudo npm install -g npm
sudo npm install -g cordova ionic
cd ..
sed -i 's/robbyrussell/rkj-repos/g' ~/.zshrc
cat vimrc1 >> ~/.vimrc
cat vimrc2 >> ~/.vimrc
cat bashrc >> ~/.bashrc
cat tmux.conf >> ~/.tmux.conf
#sudo apt-get install ubuntu-make -y
#sudo apt-get install -y virtualbox-guest-x11

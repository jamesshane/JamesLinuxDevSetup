#!/bin/bash
#get current installs
if [[ $# == 0 ]];
then
	echo "No conditions, using default, no mean, standard powerline"
	#DEFAULT=true
fi
# -e=*|--extension=*)
#EXTENSION="${i#*=}"
#DEFAULT=false
MEAN=false
QUICK=false
for i in "$@"
do
	#echo "doing ${i}"
case $i in
    -h|--help)
    shift # past argument=value
	echo -e "Possible arguments:\n -m,--mean : Installs MEAN, default is no MEAN\n -q, --quick : Quick Powerline install, default is standard\n -h, --help : these instructions\n\n"
	exit 1
    ;;
    -m|--mean)
    MEAN=true
    shift # past argument=value
    ;;
    -q|--quick)
    QUICK=true
    shift # past argument=value
    ;;
    #-d|--default)
    #DEFAULT=true
    #MEAN=false
    #QUICK=false
    #shift # past argument with no value
    #;;
    *)
     # unknown option
     echo -e "Unknown option, try -h, --help\n\n"
     exit 1
    ;;
esac
done
#echo "MEAN = ${MEAN}"
#echo "QUICK = ${QUICK}"
dpkg --get-selections > list.txt
sudo cp list.txt ../..
sudo cp MakeItReset.sh ../..
#end
#update, install i3, and the essentails
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y xinit i3 gnome-terminal firefox
sudo apt-get install -y build-essential vim emacs tmux wget curl zsh htop git-core screen cmatrix vim-gtk
sudo apt-get install fontconfig -y
#end
if ${QUICK};
then
#install powerline quick
sudo apt-get install powerline
#The author misspelled these. I fixed that, While it does not matter, I fixed it anyway.
mkdir -p ~/.fonts
wget https://github.com/powerline/fonts/raw/master/LiberationMono/Literation%20Mono%20Powerline.ttf -O ~/.fonts/Liberation\ Mono\ Powerline.ttf
wget https://github.com/powerline/fonts/raw/master/LiberationMono/Literation%20Mono%20Powerline%20Bold.ttf -O ~/.fonts/Liberation\ Mono\ Powerline\ Bold.ttf
wget https://github.com/powerline/fonts/raw/master/LiberationMono/Literation%20Mono%20Powerline%20Italic.ttf -O ~/.fonts/Liberation\ Mono\ Powerline\ Italic.ttf
wget https://github.com/powerline/fonts/raw/master/LiberationMono/Literation%20Mono%20Powerline%20Bold%20Italic.ttf -O ~/.fonts/Liberation\ Mono\ Powerline\ Bold\ Italic.ttf
fc-cache -vf ~/.fonts
cat vimrcQ >> ~/.vimrc
cat bashrcQ >> ~/.bashrc
cat tmux.confQ >> ~/.tmux.conf
#end
else
#install powerline standard
sudo apt-get install python-setuptools -y
sudo apt-get install python-pip -y
sudo -H pip install git+git://github.com/Lokaltog/powerline
sudo -H pip install --upgrade pip
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
sudo mv PowerlineSymbols.otf /usr/share/fonts/
sudo fc-cache -vf /usr/share/fonts/
sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/
cat vimrc2 >> ~/.vimrc
cat bashrc >> ~/.bashrc
cat tmux.conf >> ~/.tmux.conf
#end
fi
#install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cat vimrc1 >> ~/.vimrc
#end
if ${MEAN};
then
#install MEAN
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
sudo apt-get install elixir -y
sudo npm install -g gulp
sudo npm install -g bower
sudo npm install -g mean-cli
#end
fi
#install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sed -i 's/robbyrussell/rkj-repos/g' ~/.zshrc
#end
#OTHER
#sudo apt-get install ubuntu-make -y
sudo apt-get install -y virtualbox-guest-x11
sudo chown -R $USER ~/.npm
sudo chown $USER:$USER ~/.*
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
#end

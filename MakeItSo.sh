#!/bin/bash

if [[ $# == 0 ]];
then
	echo "No conditions, using default, only standard powerline"
	#DEFAULT=true
fi

# -e=*|--extension=*)
#EXTENSION="${i#*=}"
#DEFAULT=false

BACKUP=false
I3=false
ESS=false
QUICK=false
ZSH=false
VUNDLE=false
MEAN=false
OTHER=false

for i in "$@"
do
	#echo "doing ${i}"
case $i in
    -h|--help)
    shift # past argument=value
    echo -e "Possible arguments:\n"
    echo -e "-b,--backup : Create backup, stored in ../ called MakeItSoReset.sh\n"
    echo -e "-3,--i3 : Installs i3 windows manager and gnome-terminal and firefox\n"
    echo -e "-e,--essentials : Install essential Linux tools\n"
    echo -e "-q,--quick : Quick Powerline install (no ZSH), default is standard (w/ ZSH)\n"
    echo -e "-z,--zsh : Install Oh-My-ZSH\n"
    echo -e "-v,--vundle : Install Vundle VIM plugin manager\n"
    echo -e "-m,--mean : Installs MEAN, default is no MEAN\n"
    echo -e "-o,--other : other things\n"
    echo -e "-h,--help : these instructions\n"
    echo -e "\n\n"
	exit 1
    ;;
    -b|--backup)
    BACKUP=true
    shift # past argument=value
    ;;
    -3|--i3)
    I3=true
    shift # past argument=value
    ;;
    -e|--essentials)
    ESS=true
    shift # past argument=value
    ;;
    -q|--quick)
    QUICK=true
    shift # past argument=value
    ;;
    -z|--zsh)
    ZSH=true
    shift # past argument=value
    ;;
    -v|--vundle)
    VUNDLE=true
    shift # past argument=value
    ;;
    -m|--mean)
    MEAN=true
    shift # past argument=value
    ;;
    -o|--other)
    OTHER=true
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

echo "BACKUP = ${BACKUP}"
echo "I3 = ${I3}"
echo "ESS = ${ESS}"
echo "QUICK = ${QUICK}"
echo "ZSH = ${ZSH}"
echo "VUNDLE = ${VUNDLE}"
echo "MEAN = ${MEAN}"
echo "OTHER = ${OTHER}"

#exit 1

#get current installs, make backup
if ${BASKUP};
then
dpkg --get-selections > list.txt
sudo cp list.txt ../..
sudo cp MakeItReset.sh ../..
fi
#end

#update, upgrade
sudo apt-get update
sudo apt-get upgrade -y
#end

#I3
if ${I3};
then
sudo apt-get install -y xinit i3 gnome-terminal firefox
fi
#end

#the essentails
if ${ESS};
then
sudo apt-get install -y build-essential vim emacs tmux wget curl zsh htop git-core screen cmatrix vim-gtk fontconfig 
fi
#end

#install powerline quick
if ${QUICK};
then
sudo apt-get install powerline -y
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
fi
#end

#install zsh
if ${ZSH};
then
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sed -i 's/robbyrussell/rkj-repos/g' ~/.zshrc
fi
#end

#install Vundle
if ${VUNDLE};
then
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cat vimrc1 >> ~/.vimrc
fi
#end

#install MEAN
if ${MEAN};
then
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
fi
#end

#OTHER
if ${OTHER};
then
#sudo apt-get install ubuntu-make -y
sudo apt-get install -y virtualbox-guest-x11
fi
#end


sudo chown -R $USER ~/.npm
sudo chown $USER:$USER ~/.*
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf
sudo sysctl -p


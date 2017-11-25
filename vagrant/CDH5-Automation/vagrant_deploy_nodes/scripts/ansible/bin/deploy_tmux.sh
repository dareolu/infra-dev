#!/bin/bash
#check for dependencies and install them if not already available
# Todo - add the usage section to the script that describes the arguments that can be passed into it.
# The last argument must always be a directory
tmuxdir="${@:$#}"
for package in "${@:1:$# - 1}"
do
  if [[ $package == *"Dev"* ]]
  then
  if (yum grouplist Dev* | grep -q Available)
  then
    echo $package "will be a group install"
    sudo yum -y groupinstall $package
  else
    echo $package "is already installed"
  fi
else
  if (rpm -q $package | grep -q not)
  then
       echo $package "will be a yum install"
       sudo yum -y install $package
  else
    echo $package "is already installed"
  fi
fi
done

#Set up
if [[ ! -d $tmuxdir ]]
then
  mkdir  -p $tmuxdir
fi

cd $tmuxdir

if [[ ! -e libevent-2.0.22-stable.tar.gz ]]
  then
    echo "********************** Setting up dependencies for TMUX *******************"
    sudo wget https://github.com/libevent/libevent/releases/download/release-2.0.22-stable/libevent-2.0.22-stable.tar.gz
    sudo tar -xvzf libevent-2.0.22-stable.tar.gz
    cd libevent-2.0.22-stable
    sudo ./configure
    sudo make -j 4
    sudo make install
else
  echo "Tmux dependencies has been configured"
fi

cd ..

if [[ ! -f tmux-2.1.tar.gz ]]
  then
    echo "********************* Downloading TMUX ************************************"
    sudo wget https://github.com/tmux/tmux/releases/download/2.1/tmux-2.1.tar.gz
    sudo tar -xvzf tmux-2.1.tar.gz
    cd tmux-2.1
    sudo ./configure LDFLAGS="-Wl,-rpath,/usr/local/lib"
    sudo make -j 4
    sudo make install
else
  echo "Tmux is installed"
fi

# Create a file for IDEMPOTENCE
touch $tmuxdir/tmuxIsInstalled


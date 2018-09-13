#!/bin/bash

SSO=`whoami`
if ! [[ ${SSO} =~ ^([0-9]+)$ ]]
then
	echo "Attempting to read SSO from ~/sso"
	SSO=`cat ~/sso`
fi

if ! [[ ${SSO} =~ ^([0-9]+)$ ]]
then
	echo "No SSO found. Please enter your SSO"
	read SSO
fi
if ! [[ ${SSO} =~ ^([0-9]+)$ ]]
then
	echo "Invalid SSO"
fi
echo "Found SSO: " ${SSO}

sed "s/<sso>/${SSO}/" < scripts/ssh_config > /tmp/.config
if ! [ -d ~/.ssh ]
then
	echo "~/.ssh not found. Generate your private key first"
fi

command -v ruby >/dev/null 2>&1 || { echo >&2 "ruby reuqired, but not found. "; exit 1; }

echo "Installing gem scpt"

# sudo gem install scpt
sudo gem install rb-scpt

if [ -f ~/.ssh/config ]
then
	mv -i ~/.ssh/config ~/.ssh/.config.pts_bk
fi
mv /tmp/.config ~/.ssh/config
chmod 600 ~/.ssh/config

if ! [ -d ~/bin/pts_tools/ ]
then
	mkdir -p ~/bin/pts_tools
fi

cat scripts/bashrc >> ~/.bashrc
source ~/.bashrc

cp scripts/check_all_env_access ~/bin/pts_tools/
cp scripts/newiTermSession.rb ~/bin/pts_tools/
cp scripts/prod_monitor ~/bin/pts_tools/
cp scripts/get_env_offsets.sh ~/bin/pts_tools/
cp scripts/get_offsets.sh ~/bin/pts_tools/
chmod u+x ~/bin/pts_tools/*

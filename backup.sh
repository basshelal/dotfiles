#!/usr/bin/env bash

/usr/bin/cp -fr ~/bin ./
/usr/bin/cp -fr ~/.bashrc ./
/usr/bin/cp -fr ~/.ssh/ ./
rm ./.ssh/known_hosts
/usr/bin/cp -fr ~/.config/alacritty ./
dconf dump / >.dconf-settings.ini
neofetch >neofetch
date >date
ls -AF

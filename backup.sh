#!/usr/bin/env bash

cp -r ~/bin ./
cp ~/.bashrc ./
cp -r ~/.ssh/ ./
rm ./.ssh/known_hosts
cp -r ~/.config/alacritty ./
dconf dump / >.dconf-settings.ini
neofetch >neofetch
date >date
ls -AF

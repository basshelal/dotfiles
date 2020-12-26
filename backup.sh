cp ~/.bashrc ./
cp -r ~/.ssh/ ./
rm ./.ssh/known_hosts
cp -r ~/.config/alacritty ./
dconf dump / >.dconf-settings.ini
date >date
ls -AF

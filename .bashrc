# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=200000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*) ;;

esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

d() {
    pushd "$@" >/dev/null && l
}
s() {
    popd >/dev/null && l
}
mkdr() {
    mkdir -p "$*" && d "$*"
}
mkfl() {
    if [[ ! -e "$*" ]]; then
        dir="$(pwd)/$(dirname "$*")"
        fl="$(pwd)/"$*""
        mkdir -p "$dir" && touch "$fl" && d "$dir"
    else
        echo-error "$* already exists"
        return -1
    fi
}
mkscript() {
    fl="$(pwd)/"$*""
    mkfl "$*" && (
        chmod +x "$fl"
        echo "#!/usr/bin/env bash" >"$fl"
        open "$fl"
    )
}
alias i='install'
alias r='remove'
alias autoremove='sudo apt autoremove'

alias vpn='nordvpn'
vpnc() {
    vpn c
    myip
}
vpnd() {
    vpn d
    myip
}

# terminal
alias c='clear -x'
alias x='exit'

# home dirs
alias ~='d ~'
alias apps='d ~/apps'
alias dls='d ~/dls'
alias docs='d ~/docs'
alias bashrc='open ~/.bashrc'

# dir navigation
alias .1='d ../'
alias ..='d ../'
alias .2='d ../../'
alias ...='d ../../'
alias .3='d ../../../'
alias ....='d ../../../'
alias .4='d ../../../../'
alias .....='d ../../../../'
alias .5='d ../../../../../'
alias ......='d ../../../../../'

# power
alias reboot='sudo reboot'
alias shutdown='sudo shutdown'

alias y='ytdlq'

NOTES_DIR=~/docs/notes/

note() {
    mkdir -p $NOTES_DIR
    touch $NOTES_DIR"$*"
    l $NOTES_DIR
}

notes() {
    l $NOTES_DIR
}

addPath() {
    export PATH="$*:$PATH"
}

addPath "$HOME/bin"
addPath "$HOME/bin/apt.d"
addPath "$HOME/bin/git.d"
addPath "$HOME/bin/ytdl.d"

export TERMINAL="alacritty"
export FILE_MANAGER="nautilus"
export BROWSER="google-chrome-stable"

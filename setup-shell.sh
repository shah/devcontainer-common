#!/usr/bin/env bash
title() {
    local color='\033[1;37m'
    local nc='\033[0m'
    printf "\n${color}$1${nc}\n"
}

# DCC_HOME is the devcontainer-common directory
export DCC_HOME=${DCC_HOME:-/etc/devcontainer-common}

# We use zsh and antigen plus some default utilities so install those
apt-get install -y zsh zsh-antigen tree gawk iproute2

# We use powerlevel10k theme so get the latest version
# TODO: For some reason, when it's loaded through Antigen in devcontainers, 
#       the installation hangs so we're doing it manually here
git clone https://github.com/romkatv/powerlevel10k.git /etc/zsh-theme-powerlevel10k

# We expect this script to be passed in the usernames we're setting up
for user in root "$@"
do
    userHome=`eval echo "~$user"`

    title "Setup command line productivity tools for $user in $userHome"
    cp $DCC_HOME/shell/.zshrc $userHome/.zshrc
    cp $DCC_HOME/shell/.antigenrc $userHome/.antigenrc
    cp $DCC_HOME/shell/.p10k.zsh $userHome/.p10k.zsh
    cp $DCC_HOME/shell/.z $userHome/.z

    title "Switch shell for $user in to /bin/zsh"
    usermod --shell /bin/zsh $user
done

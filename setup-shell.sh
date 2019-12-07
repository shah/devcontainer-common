#!/usr/bin/env bash
title() {
    local color='\033[1;37m'
    local nc='\033[0m'
    printf "\n${color}$1${nc}\n"
}

# DCC_HOME is the devcontainer-common directory
export DCC_HOME=${DCC_HOME:-/etc/devcontainer-common}

title "Setup command line productivity tools for the current user"
apt-get install -y zsh zsh-antigen
cp $DCC_HOME/shell/.zshrc ~/.zshrc
cp $DCC_HOME/shell/.antigenrc ~/.antigenrc
cp $DCC_HOME/shell/.p10k.zsh ~/.p10k.zsh

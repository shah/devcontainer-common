#!/usr/bin/env bash
title() {
    local color='\033[1;37m'
    local nc='\033[0m'
    printf "\n${color}$1${nc}\n"
}

# DCC_HOME is the devcontainer-common directory
export DCC_HOME=${DCC_HOME:-/etc/devcontainer-common}

title "Install core utilities necessary to run setup-*.sh scripts"
apt-get install -y git curl make wget

title "Get the devcontainer-common code so that setup-* scripts have access to files"
git clone --recurse https://github.com/shah/devcontainer-common $DCC_HOME
#!/usr/bin/env bash
title() {
    local color='\033[1;37m'
    local nc='\033[0m'
    printf "\n${color}$1${nc}\n"
}

# DCC_HOME is the devcontainer-common directory
export DCC_HOME=${DCC_HOME:-/etc/devcontainer-common}
export JSONNET_REPO="google/jsonnet"
export JSONNET_VERSION=`curl -s https://api.github.com/repos/${JSONNET_REPO}/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`

title "Install core utilities necessary to run setup-*.sh scripts"
apt-get install -y git curl make wget jq

title "Get the devcontainer-common code so that setup-* scripts have access to files"
git clone --recurse https://github.com/shah/devcontainer-common $DCC_HOME

mkdir -p $DCC_HOME/bin
curl https://github.com/${JSONNET_REPO}/releases/download/${JSONNET_VERSION}/jsonnet-bin-${JSONNET_VERSION}-linux.tar.gz \
     | tar -xz -C $DCC_HOME/bin
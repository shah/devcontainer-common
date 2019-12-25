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
export CUE_REPO="cuelang/cue"
export CUE_VERSION=`curl -s https://api.github.com/repos/${CUE_REPO}/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
export JK_REPO="jkcfg/jk"
export JK_VERSION=`curl -s https://api.github.com/repos/${JK_REPO}/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
export DHALL_REPO="dhall-lang/dhall-haskell"
export DHALL_VERSION=`curl -s https://api.github.com/repos/${DHALL_REPO}/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`

title "Install core utilities necessary to run setup-*.sh scripts"
apt-get install -y git curl make wget jq

title "Get the devcontainer-common code so that setup-* scripts have access to files"
git clone --recurse https://github.com/shah/devcontainer-common $DCC_HOME

title "Install the latest version of jsonnet data templating language into the devcontainer and /usr/bin"
mkdir -p $DCC_HOME/bin
curl -L https://github.com/${JSONNET_REPO}/releases/download/${JSONNET_VERSION}/jsonnet-bin-${JSONNET_VERSION}-linux.tar.gz \
     | tar -xz -C $DCC_HOME/bin
cp $DCC_HOME/bin/jsonnet /usr/bin/jsonnet
cp $DCC_HOME/bin/jsonnetfmt /usr/bin/jsonnetfmt

title "Install the latest version of CUE Data Constraint Language into the devcontainer and /usr/bin"
# we're using ${CUE_VERSION:1} because there's no "v" prefix in the filename but there is in the folder path
curl -L https://github.com/${CUE_REPO}/releases/download/${CUE_VERSION}/cue_${CUE_VERSION:1}_Linux_x86_64.tar.gz \
     | tar -xz -C $DCC_HOME/bin cue
cp $DCC_HOME/bin/cue /usr/bin/cue

title "Install the latest version of jk data templating language into the devcontainer and /usr/bin"
curl -Lo $DCC_HOME/bin/jk https://github.com/${JK_REPO}/releases/download/${JK_VERSION}/jk-linux-amd64
chmod +x $DCC_HOME/bin/jk
cp $DCC_HOME/bin/jk /usr/bin/jk

title "Install the latest version of Dhall configuration language into the devcontainer and /usr/bin"
curl -L https://github.com/${DHALL_REPO}/releases/download/${DHALL_VERSION}/dhall-${DHALL_VERSION}-x86_64-linux.tar.bz2 \
     | tar -x --bzip2 -C $DCC_HOME ./bin/dhall
cp $DCC_HOME/bin/dhall /usr/bin/dhall
# TODO still need to get the dhall-bash, dhall-json, dhall-yaml, etc. utilities?
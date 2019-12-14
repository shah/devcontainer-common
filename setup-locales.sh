#!/usr/bin/env bash

# DCC_HOME is the devcontainer-common directory
export DCC_HOME=${DCC_HOME:-/etc/devcontainer-common}

# In case locales are not installed
apt-get install -y locales

# Configure the default locales (usually US English)
cp $DCC_HOME/default_etc_locale.gen /etc/locale.gen
locale-gen

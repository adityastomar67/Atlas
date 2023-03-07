#!/usr/bin/env bash

# Initialization
ATLAS_DIR=$(pwd)
VIRTUAL_ENV="atlas_virtualenv"
GREEN=`tput setaf 2`
RED=`tput setaf 1`
RESET=`tput sgr0`

# Python version compatibility check
version=$(python3 -V 2>&1 | grep -Po '(?<=Python )(.+)')
if [[ -z "$version" ]]
then
    echo "${RED} No Python 3.x.x in your system${RESET}"
    exit 1
else
    echo "${GREEN} System Python version is: Python ${version} ${RESET}"
fi


# System dependencies installation
sudo apt-get update && /
sudo apt-get install build-essential && /
sudo apt-get install python3-dev && /
sudo apt-get install python3-setuptools && /
sudo apt-get install python3-pip && /
sudo apt-get install python3-venv && /
sudo apt-get install portaudio19-dev python3-pyaudio python3-pyaudio && /
sudo apt-get install libasound2-plugins libsox-fmt-all libsox-dev libxml2-dev libxslt-dev sox ffmpeg && /
sudo apt-get install espeak && /
sudo apt-get install libcairo2-dev libgirepository1.0-dev gir1.2-gtk-3.0  && /
sudo apt-get install gnupg

# Reload local package database
sudo apt-get update
#!/usr/bin/env bash

# Initialization
ATLAS_DIR=$(pwd)
VIRTUAL_ENV="atlas_virtual_env"
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLACK=$(tput setaf 4)
BOLD=$(tput bold)
RESET=$(tput sgr0)


# Python version compatibility check
version=$(python3 -V 2>&1 | grep -Po '(?<=Python )(.+)')
if [[ -z "$version" ]]
then
    echo "${RED} No Python 3.x.x in your system${RESET}"
    exit 1
else
    echo "${GREEN} System Python version is: Python ${version} ${RESET}"
fi

# --TODO--
# System dependencies installation
sudo pacman -Syyu
sudo pacman -S --noconfirm python-pip python-pyaudio
# Reload local package database

RESULT=$?
if  [ $RESULT -eq 0 ]; then
    echo "${GREEN} System dependencies installation succeeded! ${RESET}"
else
    echo "${RED} System dependencies installation failed ${RESET}"
    exit 1
fi

# Create Atlas virtual env
python3 -m venv $ATLAS_DIR/$VIRTUAL_ENV

RESULT=$?
if  [ $RESULT -eq 0 ]; then
    echo "${GREEN} Atlas virtual env creation succeeded! ${RESET}"
else
    echo "${RED} Atlas virtual env creation failed ${RESET}"
    exit 1
fi

# Install Python dependencies
source $ATLAS_DIR/$VIRTUAL_ENV/bin/activate

activated_python_version=$(python -V)
echo "${GREEN} ${activated_python_version} activated!${RESET}"

# Install python requirements
pip3 install --upgrade cython
pip3 install wheel
python setup.py bdist_wheel
pip3 install -r $ATLAS_DIR/requirements.txt
pip3 install -U scikit-learn
pip3 install -U nltk

RESULT=$?
if  [ $RESULT -eq 0 ]; then
    echo "${GREEN} Install Python dependencies succeeded! ${RESET}"
else
    echo "${RED} Install Python dependencies failed ${RESET}"
    exit 1
fi

# Install nltk dependencies
python3 -c "import nltk; nltk.download('punkt'); nltk.download('averaged_perceptron_tagger')"

RESULT=$?
if  [ $RESULT -eq 0 ]; then
    echo "${GREEN} Install nltk dependencies succeeded! ${RESET}"
else
    echo "${RED} Install nltk dependencies failed ${RESET}"
    exit 1
fi

# Create log access
sudo touch /var/log/atlas.log && \
sudo chmod 777 /var/log/atlas.log

RESULT=$?
if  [ $RESULT -eq 0 ]; then
    echo "${GREEN} Create log access succeeded! ${RESET}"
else
    echo "${RED}Create log access failed ${RESET}"
    exit 1
fi

# Deactivate virtualenv
deactivate

# Finished
echo "${GREEN} Atlas setup succeed! ${RESET}"
echo "${BOLD}Start Atlas by ${YELLOW}bash main.sh${RESET}"
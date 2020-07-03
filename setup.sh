#!/bin/bash

function setup_git {
    sudo apt install git -y
    sudo apt install meld -y
    git config --global user.email "bomcrimea@gmail.com"
    git config --global user.name "Furkat Mallabaiev"
    git config --global merge.tool meld
}

SETUP_DIR=~/Desktop/.my_env_setup

function download_my_env_setup {
    git clone https://github.com/fmallaba/my_env_setup.git $SETUP_DIR
}

function run_setup_env {
    cd $SETUP_DIR
    ./setup_env.sh
}

sudo -
setup_git
download_my_env_setup
run_setup_env

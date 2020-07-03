#!/bin/bash

function setup_bash {
    echo "[ -f ~/Desktop/.my_env_setup/bash/.my_bash_addons ] && source ~/Desktop/.my_env_setup/bash/.my_bash_addons" >> ~/.bashrc
}

function setup_vim {
    rm -rf ~/.vim ~/.vimrc
    ln -s ~/Desktop/.my_env_setup/vim/.vim ~/.vim
    ln -s ~/Desktop/.my_env_setup/vim/.vimrc ~/.vimrc
}

function setup_mc {
    sudo apt install mc
    ln -s ~/Desktop/.my_env_setup/mc ~/.config/mc
}

function setup_terminator {
    sudo apt install terminator
    ln -s ~/Desktop/.my_env_setup/terminator ~/.config/terminator
}

function setup_all {
    setup_bash
    setup_vim
    setup_mc
    setup_terminator
}

setup_all

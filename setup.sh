#!/bin/bash

function setup_bash {
    echo "[ -f $PWD/bash/.my_bash_addons ] && source $PWD/bash/.my_bash_addons" >> ~/.bashrc
    sudo echo "set completion-ignore-case on" >> /etc/inputrc
}

function setup_vim {
    sudo apt install vim-gnome -y
    rm -rf ~/.vim ~/.vimrc
    git clone https://github.com/VundleVim/Vundle.vim.git vim/.vim/bundle/Vundle.vim
    ln -s $PWD/vim/.vim ~/.vim
    ln -s $PWD/vim/.vimrc ~/.vimrc
    vim +PluginInstall +qall > /dev/null
}

function setup_mc {
    sudo apt install mc -y
    ln -s $PWD/mc ~/.config/mc
}

function setup_terminator {
    sudo apt install terminator -y
    ln -s $PWD/terminator ~/.config/terminator
}

function setup_bg {
    gsettings set org.gnome.desktop.background picture-uri file://$PWD/bg/jungle_bg.jpg
}

function install_chrome {
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install ./google-chrome-stable_current_amd64.deb -y
}

function setup_git {
    sudo apt install git -y
    sudo apt install meld -y
    git config --global user.email "bomcrimea@gmail.com"
    git config --global user.name "Furkat Mallabaiev"
    git config --global merge.tool meld
}

function setup_all {
    setup_git
    setup_bash
    setup_vim
    setup_mc
    setup_terminator
    setup_bg
    install_chrome
}

sudo -
setup_all

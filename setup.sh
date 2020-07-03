
function setup_bash {
    echo "[ -f $PWD/bash/.my_bash_addons ] && source $PWD/bash/.my_bash_addons" >> ~/.bashrc
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

function setup_all {
    setup_bash
    setup_vim
    setup_mc
    setup_terminator
}

sudo -
setup_all

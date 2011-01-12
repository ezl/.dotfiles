#!/bin/sh

link() {
    src="$1"
    dst="$2"
    if [ ! -e "$src" ]; then
        echo "ERROR: source object '$src' doesn't exist."
        return
    fi
    if [ -e "$dst" ]; then
        if [ ! -L "$dst" ]; then
            echo "WARNING: '$dst' already exists and is NOT a symlink!"
        else
            #echo "Skipping file '$dst'"
            return
        fi
    else
        echo "Linking '$src' to '$dst'"
        ln -s "$src" "$dst"
    fi
}

install_scripts() {
    targetdir="$1"
    [ ! -d "$targetdir" ] && mkdir "$targetdir"
    shift
    for i in $@
    do
        link "$PWD/$i" "$targetdir/$i"
    done
}

echo "Symlinking dotfiles."
for i in dotfiles/*
do
    link "$PWD/$i" "$HOME/.${i##*/}"
done

echo "Installing virtualenv hooks."

#This needs to correspond with your $WORKON_HOME as defined in virtualenvwrapper_bashrc
install_scripts "$HOME/.virtualenvs" postactivate postmkvirtualenv

source git.sh

#First time? Modify bashrc.
if ! grep -q "ezlrc" ~/.bashrc
then
    echo "Editing .bashrc to source .ezlrc."
    echo "source $HOME/.ezlrc" >> $HOME/.bashrc
    source $HOME/.ezlrc
fi

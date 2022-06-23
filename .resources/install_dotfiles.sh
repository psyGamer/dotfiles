#!/usr/bin/bash

SCRIPT_DIR=$(cd `dirname $0`/.. && pwd)

install_files() {
    for file in $SCRIPT_DIR/$1/*; do
        BASENAME=$(basename $file)
        if test -e ~/$1/$BASENAME; then
            echo "~/$1/$BASENAME already exists! Creating backup."
            mv ~/$1/$BASENAME ~/$1/$BASENAME.backup
        fi

        cp -r $SCRIPT_DIR/$1/$BASENAME ~/$1/$BASENAME
        echo "Successfully install ~/$1/$BASENAME!"
    done
}

install_files .resources
install_files .config
install_files .local
install_files .themes
install_files .scripts

cd ~/.resources
chmod +x install_cursors.sh
./install_cursors.sh

echo "Successfully installed dotfiles!"

echo
echo "Installing required packages..."
sudo pacman -S --needed --yes - < ~/.resources/pacman_packages

if ! pacman -Qs paru > /dev/null; then
    echo
    echo "Installing paru..."
    sudo pacman -S --needed --yes base-devel
    git clone https://aur.archlinux.org/paru.git /tmp/paru-git
    pushd /tmp/paru-git
    makepkg -si --noconfirm
    popd
    rm -rd /tmp/paru-git
fi

echo
echo "Installing required AUR packages..."
sudo paru -S --needed --yes - < ~/.resources/aur_packages

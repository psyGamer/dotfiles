#!/usr/bin/bash

SCRIPT_DIR=$(cd `dirname $0` && pwd)

install_files() {
	for file in $(ls -la $SCRIPT_DIR/$1)
	do
		BASENAME=$(basename $file)
		if test -e ~/$1/$BASENAME
			echo "~/.config/$BASENAME already exists! Creating backup."
			mv ~/$1/$BASENAME ~/$1/$BASENAME.backup
		fi
	
		cp -r $SCRIPT_DIR/$1/$BASENAME ~/$1/$BASENAME
		echo "Successfully install ~/.config/$BASENAME!"
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

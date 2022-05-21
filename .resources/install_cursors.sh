#!/usr/bin/bash

SCRIPT_DIR=$(cd `dirname $0` && pwd)
cd $SCRIPT_DIR/simp1e

chmod +x generate_svgs.sh
./generate_svgs.sh
chmod +x build_cursors.sh
./build_cursors.sh

cd $HOME/.local/share/icons

for i in ~/.resources/simp1e/built_themes/*
do
	THEME=$(basename $i)
	ln -s ../../../.resources/simp1e/built_themes/$THEME/ $THEME
done

#!/usr/bin/sh

RED="\033[0;31m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
YELLOW="\033[0;33m"
GREY="\033[0;37m"

for pkg in "$@"
do
	aura -Ap $pkg | less

	#printf "${BLUE}Are you sure you want to install ${YELLOW}${pkg}${BLUE}? ${GREY}[${GREEN}y${GREY}/${RED}N${GREY}]"
	#read -e -p "" -n 1 -r
	#echo
	#if [[ ! $REPLY =~ ^[Yy]$ ]]
	#then
	#	printf "\033[0;33mSkipping $pkg\033[0m\n"
	#	continue
	#fi

	sudo aura -A $pkg
done


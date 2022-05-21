#!/usr/bin/sh

if [ ! -d ".git" ]; then
      printf "\033[31mNot in the root of a git repostitory!\033[0m\n"
      exit 1
fi

#printf "\033[91;1mWARNING: \033[0;91mThis action cannot be undone!\n"
#printf "\033[31mRunning this script will change the author of \033[91;1mALL \033[0;31mcommits in this repository.\n"
printf "\033[91;1mWARNING: \033[0mRunning this script will change the author of \033[1mALL \033[0mcommits in this repository.\n"
#printf "\033[31mAre you sure you want to continue? \033[37m[\033[32my\033[37m/N${GREY}]
printf "\033[1mAre you sure you want to continue? [y/N] "

read -e -p "" -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    printf "\033[0;31mAborting...\033[0m\n"
    exit 1
fi

printf "\033[1mPlease enter the name of the new author: "
read
AUTHOR_NAME=$REPLY
printf "\033[1mPlease enter the email of the new author: "
read
AUTHOR_EMAIL=$REPLY
printf "\033[0mIs this correct: \033[1m$AUTHOR_NAME <$AUTHOR_EMAIL> [Y/n] "
read -e -p "" -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    printf "\033[0;31mAborting...\033[0m\n"
    exit 1
fi

cp -r .git .git.bak

git rebase -r --exec "git commit --amend --author=\"$AUTHOR_NAME <$AUTHOR_EMAIL>\" --no-edit" --committer-date-is-author-date --root
git filter-branch --env-filter 'export GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"'

printf "\033[32;1mDone.\033[0m\n"
printf "\033[32mIf anything went wrong, there is a backup of the \033[1m.git\033[0;32m folder called \033[1m.git.bak\033[0m\n"


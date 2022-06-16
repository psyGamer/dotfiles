if status is-interactive
	# Commands to run in interactive sessions can go here
end

set fish_greeting

set -x EDITOR nvim
set -x GIT_EDITOR $EDITOR

set -x JAVA_8 /usr/lib/jvm/java-8-openjdk

# Blur (See: https://www.reddit.com/r/kde/comments/or87y9/comment/h6ggkdt/?utm_source=share&utm_medium=web2x&context=3)
function blur_terminal
	if test $DISPLAY
		for class in kitty konsole;
	  		for ID in (xdotool search --class $class)
				xprop -f _KDE_NET_WM_BLUR_BEHIND_REGION 32c -set _KDE_NET_WM_BLUR_BEHIND_REGION 0 -id $ID
			end
		end
	end
end
blur_terminal

# A helper for converting SVGs to PNGs
function svg2png
	if test $argv[4] && test $argv[3]
		inkscape --export-filename=$argv[2] -w $argv[3] -h $argv[4] $argv[1]
	else if test $argv[3]
		inkscape --export-filename=$argv[2] -w $argv[3] -h $argv[3] $argv[1]
	else
		inkscape --export-filename=$argv[2] $argv[1]
	end
end

function switch2java8
	set -x JAVA_HOME $JAVA_8
end
function switch2java-default
	set -x JAVA_HOME
end

alias vim="nvim"
alias cat="bat"
alias rm="trash"

alias auri="~/.scripts/aurinstall.sh" # Quickly inspect PKGBUILD and install AUR packages
alias git-change-author="~/.scripts/git-change-author.sh"
alias ansi-colors="~/.scripts/ansi-colors.py"
alias rpatool="~/.scripts/rpatool.sh"

alias sura="sudo aura"

alias git="LANG=en_US /usr/bin/git"
alias dotconfig="LANG=en_US /usr/bin/git --git-dir=$HOME/.dotfiles-git --work-tree=$HOME"

alias code="codium"
alias python="python3"
alias py="python -i /media/Storage/BACKPU/Users/manue/pymod/startup.py" # Python with predefined utils

alias gs="git status"

# Modern versions of common commands
alias ls='lsd'
alias lsa='ls -A'

alias ping="gping"

alias npm="pnpm"

abbr p "sudo pacman"

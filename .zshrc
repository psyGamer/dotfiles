# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
export EDITOR="nvim"
export GIT_EDITOR=$EDITOR

# History
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

bindkey -e
zstyle :compinstall filename '/home/manuel/.zshrc'

autoload -Uz compinit
compinit

# Fix keys
bindkey "^[[H"  beginning-of-line
bindkey "^[[F"  end-of-line
bindkey "^[[3~" delete-char

# oh-my-zsh
ZSH_THEME="psytheme"
plugins=(git zsh-autosuggestions)

# zsh-autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(completion history)

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Blur (see: https://www.reddit.com/r/kde/comments/6jzuwu/konsole_and_yakuake_blur/)
if [[ $(ps --no-header -p $PPID -o comm) =~ '^yakuake|kitty$' ]]; then
        for wid in $(xdotool search --pid $PPID); do
            xprop -f _KDE_NET_WM_BLUR_BEHIND_REGION 32c -set _KDE_NET_WM_BLUR_BEHIND_REGION 0 -id $wid; done
fi

### Aliases ###

alias q!='exit' # VIM-like quit
alias git='LANG=en_US git' # Set git language

# Python with utils predefined
alias python='python3 -i /media/Storage/BACKPU/Users/manue/pymod/startup.py'
alias py='python3 -i /media/Storage/BACKPU/Users/manue/pymod/startup.py'

# Quickly see git repo stats
alias git-commit-stats="git log --pretty=tformat: --numstat | awk '{inserted+=$1; deleted+=$2; delta+=$1-$2; ratio=deleted/inserted} END {printf \"Commit stats:\n- Lines added (total)....  %s\n- Lines deleted (total)..  %s\n- Total lines (delta)....  %s\n- Add./Del. ratio (1:n)..  1 : %s\n\", inserted, deleted, delta, ratio }'"

# Use a more modern version of ls
unalias l
unalias lsa
alias ls='lsd'
alias lsa='ls -A'

alias ping='gping' # Use a better looking ping
alias auri="~/.scripts/aurinstall.sh" # Quickly inspect PKGBUILD and install AUR packages

alias sura="sudo aura"

alias code="codium"

svg2png() { 
	if [[ "$4" != "" && "$3" != "" ]]
	then
		inkscape --export-filename=$2 -w $3 -h $4 $1
	elif  [[ "$3" != "" ]]
	then
		inkscape --export-filename=$2 -w $3 -h $3 $1
	else 
		inkscape --export-filename=$2 $1
	fi
}

#TEMP
alias cdrhb='cd /media/Storage/Minecraft/Curseforge/Minecraft/Instances/rhb'

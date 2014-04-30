# Definition du path
PATH=$HOME/usr/local/bin:$HOME/.brew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/texbin
export PATH

# Gestion de l'historique
HISTFILE=~/.zshrc_history
SAVEHIST=5000
HISTSIZE=5000
setopt inc_append_history
setopt share_history

# Correction de la touche Delete
bindkey "\e[3~"   delete-char

# Autocompletion moins bete
autoload -U compinit && compinit

# Autocompletion de type menu
zstyle ":completion:*" menu select

# Couleur prompt
autoload -U colors && colors

# Definition des couleurs de ls
if [ -f "~/.ls_colors" ]; then
	source ~/.ls_colors
fi

# Definition des variables
USER=`/usr/bin/whoami`
export USER
GROUP=`/usr/bin/id -gn $user`
export GROUP
MAIL="$USER@student.42.fr"
export MAIL

# Definition du prompt
## mdelage
PROMPT="%n@%B%m%b:%~
> "

precmd ()
{
	NORMAL="%{$reset_color%}"
	ISGIT=$(git status 2> /dev/null)
	if [ -n "$ISGIT" ]
	then
		BRANCH=$(git branch | cut -d " " -f 2 | tr -d "\n")
		STATUS=$(echo "$ISGIT" | grep "modified:\|renamed:\|new file:\|deleted:")
		if [ -n "$STATUS" ]
		then
			COLOR="%{$fg[red]%}"
		else
			REMOTE_EXIST=$(git branch -a | grep "remotes/origin/$BRANCH")
			if [ -n "$REMOTE_EXIST" ]
			then
				REMOTE=$(git diff origin/$BRANCH $BRANCH)
				if [ -n "$REMOTE" ]
				then
					COLOR="%{$fg[yellow]%}"
				else
					COLOR="%{$fg[green]%}"
				fi
			else
				COLOR="%{$fg[yellow]%}"
			fi
		fi			
		RPROMPT="%{$COLOR%}($BRANCH)%{$NORMAL%}"
	else
		RPROMPT=""
	fi
}

## dlancar
#PROMPT="[%~] %m%% "
#RPROMPT="[%T]"

# Definition du repertoire contenant la libft
PATH_LIBFT="~/libft"

# Definition des alias de git
alias ga="git add"
alias gb="git branch"
alias gcm="git commit -m"
alias gco="git checkout"
alias gpl="git pull"
alias gps="git push"
alias gm="git merge"
alias gu="git add -u"

# Definition des alias
alias auteur="echo $USER > auteur"
alias c="clear"
alias cc="clang -Wall -Wextra -Werror"
alias em="emacs"
alias files_s="defaults write com.apple.finder AppleShowAllFiles TRUE && killall Finder"
alias files_h="defaults write com.apple.finder AppleShowAllFiles FALSE && killall Finder"
alias gccf="gcc -Wall -Wextra -Werror"
alias gccl="gcc -I $PATH_LIBFT/includes -L $PATH_LIBFT -lft"
alias gcclf="gcc -Wall -Wextra -Werror -I $PATH_LIBFT/includes -L $PATH_LIBFT -lft"
alias ls="ls -G"
alias l="ls -l"
alias la="ls -lA"
alias modsh="emacs ~/.zshrc"
alias p="print"
alias rl="source ~/.zshrc"
alias v="vim"

# Coloration du man
man()
{
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
		man "$@"
}

# Norminette automatique
norme()
{
	CFILES=`find . -iname "*.c"`
	HFILES=`find . -iname "*.h"`
	norminette $CFILES $HFILES
}

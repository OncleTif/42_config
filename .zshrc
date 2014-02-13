# Definition des reglages de zsh
HISTFILE=~/.zshrc_history
SAVEHIST=5000
HISTSIZE=5000
PATH=$HOME/scripts:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/texbin

setopt inc_append_history
# setopt share_history

# Correction de la touche Delete
bindkey "\e[3~"   delete-char

# Autocompletion de type menu
autoload -U compinit && compinit
zstyle ':completion:*' menu select

# Couleur prompt
autoload -U colors && colors

# Definition des variables
USER=`/usr/bin/whoami`
export USER
GROUP=`/usr/bin/id -gn $user`
export GROUP
MAIL="$USER@student.42.fr"
export MAIL

# Definition des repertoires de travail et de correction
MODULE=unix
export MODULE
PROJECT=ftsh3
export PROJECT
WP=/nfs/zfs-student-3/users/2013/mdelage/Rendu/perso/$MODULE/$PROJECT
export WP
MOD_COR=unix
export MOD_COR
PROJ_COR=ftsh3
export PROJ_COR
COR=/nfs/zfs-student-3/users/2013/mdelage/Rendu/correction/$MOD_COR/
export COR
LIB=/nfs/zfs-student-3/users/2013/mdelage/libft/
export LIB

# Definition des couleurs
source ~/.ls_colors

# Definition du prompt
if [[ $(cd $WP && git status | grep "modified" | cut -d ' ' -f 4) > /dev/null ]]
then
	COLOR="%{$fg[red]%}"
else
	COLOR="%{$fg[green]%}"
fi
NORMAL="%{$reset_color%}"
PROMPT="%n@%m:%~
> "
RPROMPT="%{$COLOR%}$MODULE:$PROJECT%{$NORMAL%}"

# Definition des alias raccourcis
alias cdc="cd $WP"
alias cdl="cd $LIB"
alias cds='cd ~/scripts/'
alias cdt='cd ~/test/'
alias cdx='cd $COR'

# Definition des alias
alias auteur="echo 'mdelage' > auteur; git add auteur; git commit -m 'ajout de auteur'; git push origin master"
alias em="emacs"
alias files_s="defaults write com.apple.finder AppleShowAllFiles TRUE && killall Finder"
alias files_h="defaults write com.apple.finder AppleShowAllFiles FALSE && killall Finder"
alias find_text='~/scripts/find_text'
alias gccf='gcc -Wall -Wextra -Werror'
alias gccl="gcc -I ~/libft/includes -L ~/libft -lft"
alias gcclf="gcc -Wall -Wextra -Werror -I ~/libft/includes -L ~/libft -lft"
alias l='ls -l'
alias la='ls -lA'
alias libft='cp -r ~/libft libft; rm -rf libft/.git'
alias ls='ls -G'
alias modsh='emacs ~/.zshrc'
alias norme='~/scripts/norme'
alias norme2='~/scripts/sn.sh'
alias norme3='python ~/scripts/norme.py'
alias norme4='python ~/scripts/norme.py'
alias proto='~/scripts/proto'
alias rl='source ~/.zshrc'
alias sd='emacs'

# Experimental
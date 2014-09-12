# Definition du PATH
PATH=$HOME/.bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/texbin
export PATH

# Configuration de l'historique
HISTFILE=~/.zshrc_history
SAVEHIST=5000
HISTSIZE=5000
setopt inc_append_history
setopt share_history

# Tmux command history
bindkey '^R' history-incremental-search-backward
bindkey -e
export LC_ALL=en_US.UTF-8

# default editor
EDITOR=/usr/bin/vim
export EDITOR

# Reglage du terminal
#TERM=xterm-256color

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

# Definition des couleurs
if [ -f ~/.ls_colors ]; then
    source ~/.ls_colors
fi

NORMAL="%{$reset_color%}"

# Definition du prompt
precmd ()
{
    if [ $? -eq 0 ]
    then
        COLOR3="%{$fg[green]%}"
    else
        COLOR3="%{$fg[red]%}"
    fi
    ISGIT=$(git status 2> /dev/null)
    if [ -n "$ISGIT" ]
    then
        STATUS=$(echo "$ISGIT" | grep "modified:\|renamed:\|new file:\|deleted:")
        BRANCH=$(git branch | cut -d ' ' -f 2 | tr -d '\n')
        if [ -n "$STATUS" ]
        then
            COLOR="%{$fg[red]%}"
        else
            REMOTE_EXIST=$(git branch -a | grep remotes/origin/$BRANCH)
            if [ -n "$REMOTE_EXIST" ]
            then
                REMOTE=$(git diff origin/$BRANCH)
                if [ -n "$REMOTE" ]
                then
                    COLOR="%{$fg[yellow]%}"
                else
                    COLOR="%{$fg[green]%}"
                fi
            else
                COLOR="%{$fg[green]%}"
            fi
        fi
        RPROMPT="%{$COLOR%}($BRANCH)%{$NORMAL%}"
    else
        RPROMPT=""
    fi
    RPROMPT="$RPROMPT"
    PROMPT="%B%{$fg[green]%}%n@%m%{$NORMAL%}%B:%{$fg[blue]%}%~%{$NORMAL%}
%B%{$COLOR3%}> %{$NORMAL%}%b"
}

# Definition des alias raccourcis
alias cdt='cd ~/test/'

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
alias clean='find . -name "*~" -execdir rm {} \;'
alias gccf='gcc -Wall -Wextra -Werror'
alias l='ls'
alias ll='ls -l'
alias la='ls -lA'
alias lah='ls -lAh'
alias lh='ls -lh'
alias ls='ls --color'
alias modsh='vim ~/.dotfiles/.zshrc'
alias purgevim="rf -f ~/.vim/tmp/*.swp ~/.vim/tmp/.*.swp"
alias rl='source ~/.zshrc'
alias tmuxn="TERM=screen_256color-bce tmux"

# Couleurs pour le man
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

ssh_tmux()
{
    ssh -t "$1" tmux a || ssh -t "$1" tmux;
}

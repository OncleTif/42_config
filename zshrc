# Definition du PATH
PATH=$HOME/.brew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/texbin
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

# search in history based on what is type
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward

# previous/next word with ctrl + arrow
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# default editor
EDITOR=/usr/bin/vim
export EDITOR

# Reglage du terminal
if [ "$SHLVL" -eq 1 ]; then
    TERM=xterm-256color
fi

# Correction de la touche Delete
bindkey "\e[3~"   delete-char

# add completion provied by bin installed via brew
if [[ -d "$HOME/.brew/share/zsh/site-functions/" ]]; then
    fpath=($HOME/.brew/share/zsh/site-functions/ $fpath)
fi

# Autocompletion amelioree
autoload -U compinit && compinit

# Autocompletion de type menu
zstyle ':completion:*' menu select

# Couleur prompt
autoload -U colors && colors

# fucking mac and their /Volume/<hdd_name>
cd "`echo $PWD | sed 's:/Volumes/Data::'`"

# Definition des variables
if [ -z $USER]; then
    USER=`/usr/bin/whoami`
    export USER
fi
GROUP=`/usr/bin/id -gn $user`
export GROUP
MAIL="$USER@student.42.fr"
export MAIL
LIB="$HOME/libft"
export LIB

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
        STATUS=$(echo "$ISGIT" | grep "modified:\|renamed:\|new file:\|deleted:" | grep -v ".vim/bundle\|untracked")
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
    PROMPT="%B%{$fg[green]%}%n@%m%{$NORMAL%}%B:%{$fg[blue]%}%~%{$NORMAL%}
    %B%{$COLOR3%}> %{$NORMAL%}%b"
}

# Load global aliases
if [ -f ~/.aliases ]; then
    source ~/.aliases
fi

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

# update symlink in case of zsf change
if [[ ! -f $HOME/.old_home ]]; then
    echo $HOME > $HOME/.old_home
fi
OLD_HOME=$(cat $HOME/.old_home)
if [[ "$OLD_HOME" != "$HOME" ]]; then
    echo $HOME > $HOME/.old_home
    if [[ `basename $HOME` = "mdelage" ]]; then
        env GEAM=true $HOME/.dotfiles/install.sh -c -l
    else
        $HOME/.dotfiles/install.sh -c -l
    fi
    echo "+------------------------+"
    echo "| /!\\ You've changed zsf |"
    echo "+------------------------+"
fi

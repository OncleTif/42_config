#!/bin/bash

# LN contain files which will get a symlink
LN=("aliases" "ls_colors" "vim" "vimrc" "zshrc")
# DEST is the destination dir
DEST=$HOME
# SRC is the source dir
SRC="${DEST}/.dotfiles"

# display usage of the script
function usage()
{
    echo -e "Usage: $1 <options>\n"
    echo "By default the following symlink will be created :"
    for i in ${LN[@]}; do
        echo -e "\t${DEST}/.${i} -> ${SRC}/${i}"
    done
    echo ""
    echo "Suported options :"
    echo -e "\t-c|--clean : delete all symlink and restore previous file if any"
    echo -e "\t-e|--existing : list all existing symlink"
    echo -e "\t-f|--files file1,file2 : give a list a files comma separated"
    echo -e "\t-l|--list : list all available file on which you can crete symlink"
    echo -e "\t-h|--help : display this help"
    exit 0
}

# create the symlink
function do_ln()
{
    for i in ${LN[@]}; do
        if [[ -f "${SRC}/${i}" ]]; then
            if [[ -f "${DEST}/.${i}" ]]; then
                mv "${DEST}/.${i}" "${DEST}/.${i}.old"
            fi
            ln -s "${SRC}/${i}" "${DEST}/.${i}"
        fi
    done
}

# delete the symlink
function rm_ln()
{
    FILES=$(ls ${SRC})
    for i in ${FILES[@]}; do
        if [[ -L "${DEST}/.${i}" ]]; then
            rm "${DEST}/.${i}"
            if [[ -f "${DEST}/.${i}.old" ]]; then
                mv "${DEST}/.${i}.old" "${DEST}/.${i}"
            fi
        fi
    done
}

# list the existing symlink
function existing()
{
    FILES=$(ls ${SRC})
    for i in ${FILES[@]}; do
        if [[ -L "${DEST}/.${i}" ]]; then
            ls -l "${DEST}/.${i}"
        fi
    done
}

# redifine LN variable based on user input
function get_files_list()
{
    IFS=','
    LN=($1)
}

# get the arg of the script
while test $# -gt 0; do
    case "$1" in
        -h|--help)
            usage $0
            ;;
        -c|--clean)
            rm_ln
            exit 0
            ;;
        -l|--list)
            ls -l ${SRC}
            exit 0
            ;;
        -e|--existing)
            existing
            exit 0
            ;;
        -f|--files)
            shift
            get_files_list $1
            ;;
        -g|--geam)
            GEAM=true
            LINUX=true
            ;;
        --g42)
            GEAM=true
            G42=true
            ;;
        *)
            usage $0
            ;;
    esac
    shift
done

# if it's me, add the git config
if [[ -n "${GEAM}" ]]; then
    LN+=("gitconfig" "gitignore_global")
fi

# if it's me on linux
if [[ -n "${LINUX}" ]]; then
    LN+=("irssi" "tmux" "tmux.config")
fi

do_ln

cd ${SRC}
git submodule init
git submodule update

if [[ -n "${G42}" ]]; then
    cd $HOME
    git clone git@github.com:Geam/libft.git libft
    git clone git@github.com:Geam/scripts.git scripts
    ln -s /nfs/sgoinfre
    brew update
    source $HOME/.zshrc
    brew install htop tig
fi

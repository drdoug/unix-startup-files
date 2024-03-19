#!/bin/bash

function updateFile
        {

        cmp -s $1 $2
        _RET=$?
        if [[ $_RET != 0 ]];
        then
                _OUTOFDATE=1
                printf "%-50.50s needs to be updated from %s\n" "$2" "$1"
                if [[ $_FIND_DIFFS == 1 ]];
                then
                        printf "\nDIFFERENCES between %s and %s:\n" "$1" "$2"
                        diff "$1" "$2"
                        printf "\n"
                fi
                if [[ $_FORCE_COPY == 1 ]];
                then
                        printf "Copy %s to %s? [y or n]: " "$1" "$2"
                        read _COPYABLE
                        if [[ $_COPYABLE == 'y' ]];
                        then
                                cp "$1" "$2"
                        else
                                printf "     %s was NOT copied to %s\n" "$1" "$2"
                        fi
                fi
        fi
        }

function createNeededDirs
        {
        if [[ ! -d "$1" ]];
        then
                printf "The directory '%s' does not yet exist.  Create it now? [y or n]: " "$1"
                read _CREATEDIR
                if [[ $_CREATEDIR == 'y' ]];
                then
                        mkdir -p "$1"
                else
                        printf "     '%s' was NOT created.  Files residing in this directory will not be available.\n" "$1"
                fi
        fi
        }

function _help
        {

        printf "Usage: %s [-d][-F][-C]\n" "$0"
        printf "       The -d flag will print differences between these files and what is installed\n"
        printf "       The -F flag will ask if you wish to update out-of-date files, otherwise only a check is performed\n"
        printf "       The -C flag will ask if you wish to create missing configuration directories\n"
        exit 1
        }

_OUTOFDATE=0
_FIND_DIFFS=0
_FORCE_COPY=0

while getopts "dFC" opt; do
        case ${opt} in
        d )
                _FIND_DIFFS=1
                ;;
        F )
                _FORCE_COPY=1
                ;;
        C )
                createNeededDirs ~/.config/bash
                createNeededDirs ~/.config/zsh
                createNeededDirs ~/.vim/colors
                ;;
        \? )
                _help
                ;;
        esac
done

updateFile dot-bash-profile		        ~/.bash_profile
updateFile config-bash-bashrc		        ~/.config/bash/bashrc
updateFile config-bash-git.bash		        ~/.config/bash/git.bash
updateFile config-bash-sdirs.bash		~/.config/bash/sdirs.bash
updateFile config-bash-lists.bash		~/.config/bash/lists.bash
updateFile config-bash-colors.bash		~/.config/bash/colors.bash
updateFile config-bash-prompt.bash		~/.config/bash/prompt.bash
updateFile config-bash-prompt-ZSH.bash		~/.config/bash/prompt-ZSH.bash
updateFile config-bash-hostSpecificSetup.bash	~/.config/bash/hostSpecificSetup.bash
updateFile config-bash-colorTable               ~/.config/bash/colorTable

updateFile dot-zshenv                           ~/.zshenv
updateFile config-zsh-zshrc                     ~/.config/zsh/.zshrc
updateFile config-zsh-zlogout                   ~/.config/zsh/.zlogout

updateFile dot-vim-slash-vimrc		        ~/.vim/vimrc
updateFile dot-vim-slash-gvimrc        		~/.vim/gvimrc
updateFile dot-vim-colors-aurora.vim            ~/.vim/colors/aurora.vim

if [[ $_OUTOFDATE -eq 0 ]];
then
        printf "All files are up-to-date.\n"
fi

exit 0

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

function _help
        {

        printf "Usage: %s [-d][-F]\n" "$0"
        printf "       The -d flag will print differences between these files and what is installed\n"
        printf "       The -F flag will ask if you wish to update out-of-date files, otherwise only a check is performed\n"
        exit 1
        }

_OUTOFDATE=0
_FIND_DIFSS=0
_FORCE_COPY=0

while getopts "dF" opt; do
        case ${opt} in
        d )
                _FIND_DIFFS=1
                ;;
        F )
                _FORCE_COPY=1
                ;;
        \? )
                _help
                ;;
        esac
done

updateFile dot-bashrc		                ~/.bashrc
updateFile dot-bash-profile		        ~/.bash_profile

updateFile dot-bash-colors-dot-bash		~/.bash-colors.bash
updateFile dot-bash-git-dot-bash		~/.bash-git.bash
updateFile dot-bash-hostSpecificSetup-dot-bash	~/.bash-hostSpecificSetup.bash
updateFile dot-bash-lists-dot-bash		~/.bash-lists.bash
updateFile dot-bash-prompt-dot-bash		~/.bash-prompt.bash
updateFile dot-bash-sdirs-dot-bash		~/.bash-sdirs.bash

updateFile dot-zshenv                           ~/.zshenv
updateFile dot-zsh-slash-colorTable             ~/.zsh/colorTable
updateFile dot-zsh-slash-dot-zshrc              ~/.zsh/.zshrc

updateFile dot-vim-slash-vimrc		        ~/.vim/vimrc
updateFile dot-vim-slash-gvimrc        		~/.vim/gvimrc

if [[ $_OUTOFDATE -eq 0 ]];
then
        printf "All files are up-to-date.\n"
fi

exit 0

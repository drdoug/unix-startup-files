#!/bin/bash

declare -a allFiles=( \
        dot-bash-profile                              ~/.bash_profile \
        config-bash-bashrc                            ~/.config/shells/bashrc \
        config-bash-git.bash                          ~/.config/shells/git.bash \
        config-bash-dirs.bash                         ~/.config/shells/dirs.bash \
        config-bash-colors.bash                       ~/.config/shells/colors.bash \
        config-bash-prompt.bash                       ~/.config/shells/prompt.bash \
        config-bash-prompt-ZSH.bash                   ~/.config/shells/prompt-ZSH.bash \
        config-bash-colorTable                        ~/.config/shells/colorTable \
         \
        dot-zshenv                                    ~/.zshenv \
        config-zsh-zshrc                              ~/.config/shells/.zshrc \
        config-zsh-zlogout                            ~/.config/shells/.zlogout \
        config-zsh-dirs.zsh                           ~/.config/shells/dirs.zsh \
         \
        config-common-newlist.sh                      ~/.config/shells/newlist.sh \
        config-common-hostSpecificSetup.sh            ~/.config/shells/hostSpecificSetup.sh \
         \
        dot-vim-slash-vimrc                           ~/.vim/vimrc \
        dot-vim-slash-gvimrc                          ~/.vim/gvimrc \
        dot-vim-colors-aurora.vim                     ~/.vim/colors/aurora.vim \
         \
        config-nvim-init.vim                          ~/.config/nvim/init.vim \
        config-nvim-lua-init.lua                      ~/.config/nvim/lua/init.lua \
        config-nvim-lua-options.lua                   ~/.config/nvim/lua/options.lua \
        config-nvim-lua-keymaps.lua                   ~/.config/nvim/lua/keymaps.lua \
        config-nvim-lua-functions.lua                 ~/.config/nvim/lua/functions.lua \
        config-nvim-lua-vim-settings.lua              ~/.config/nvim/lua/vim-settings.lua \
        config-nvim-colors-aurora.vim                 ~/.config/nvim/colors/aurora.vim \
        config-nvim-lua-plugins-diags.lua             ~/.config/nvim/lua/plugins/diags.lua \
        config-nvim-lua-plugins-lualine.lua           ~/.config/nvim/lua/plugins/lualine.lua \
        config-nvim-lua-plugins-neotree.lua           ~/.config/nvim/lua/plugins/neotree.lua \
        config-nvim-lua-plugins-telescope.lua         ~/.config/nvim/lua/plugins/telescope.lua \
        config-nvim-lua-plugins-treesitter.lua        ~/.config/nvim/lua/plugins/treesitter.lua \
        config-nvim-lua-plugins-lsp-config.lua        ~/.config/nvim/lua/plugins/lsp-config.lua \
        )

function updateFile
        {

        cmp -s $1 $2
        _RET=$?
        if [[ $_RET != 0 ]];
        then
                _OUTOFDATE=1

                if [[ $_INSTALL_COPIES == 1 && $_FORCE_UPDATES == 1 ]];
                then
                        printf "Only ONE of the -F or -X option can be used.\nCannot continue.\n"

                        #
                        # this will exit
                        #
                        _help
                fi

                printf "%-50.50s is different from %s\n" "$2" "$1"

                if [[ $_FIND_DIFFS == 1 ]];
                then
                        printf "\nDIFFERENCES between %s and %s:\n" "$1" "$2"
                        diff "$1" "$2"
                        printf "\n"
                fi

                if [[ $_INSTALL_COPIES == 1 ]];
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

                if [[ $_FORCE_UPDATES == 1 ]];
                then
                        if [[ $_WARNED_ONCE == 0 ]];
                        then
                                printf " +-------------------------------------------+\n"
                                printf ' | mmmm     mm   mm   m   mmm  mmmmmm mmmmm  |\n'
                                printf ' | #   "m   ##   #"m  # m"   " #      #   "# |\n'
                                printf ' | #    #  #  #  # #m # #   mm #mmmmm #mmmm" |\n'
                                printf ' | #    #  #mm#  #  # # #    # #      #   "m |\n'
                                printf ' | #mmm"  #    # #   ##  "mmm" #mmmmm #    " |\n'
                                printf " +-------------------------------------------+\n"
                                printf " |   This option will OVERWRITE the MASTER   |\n"
                                printf " |   files with any locally installed files  |\n"
                                printf " |   that are different.  This should ONLY   |\n"
                                printf " |   be done AFTER changing local files and  |\n"
                                printf " |    TESTING that the changes are CORRECT   |\n"
                                printf " |    and WORTHY of BEING SAVED as MASTERS   |\n"
                                printf " +-------------------------------------------+\n"
                                _WARNED_ONCE=1
                        fi

                        printf "OVERWRITE %s WITH %s? [y or n]: " "$1" "$2"
                        read _COPYABLE
                        if [[ $_COPYABLE == 'y' ]];
                        then
                                cp "$2" "$1"
                                printf "     %s was OVERWRITTEN with %s\n" "$1" "$2"
                        else
                                printf "     %s was NOT OVERWRITTEN with %s\n" "$1" "$2"
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
        printf "       The -X flag will ask if you wish to OVERWRITE these MASTER FILES with THOSE INSTALLED WITH THE CURRENT LOGIN.\n"
        printf "              WARNING: this is ONLY used when you need to change the default file contents.\n"
        exit 1
        }

_WARNED_ONCE=0

_OUTOFDATE=0
_FIND_DIFFS=0
_FORCE_UPDATES=0
_INSTALL_COPIES=0

while getopts "dFCX" opt; do
        case ${opt} in
        d )
                _FIND_DIFFS=1
                ;;
        F )
                _INSTALL_COPIES=1
                ;;
        C )
                createNeededDirs ~/.config/shells
                createNeededDirs ~/.vim/colors
                createNeededDirs ~/.config/nvim/colors
                createNeededDirs ~/.config/nvim/lua/plugins
                ;;
        X )
                _FORCE_UPDATES=1
                ;;
        \? )
                _help
                ;;
        esac
done

for (( i=0; i<${#allFiles[@]}; i+=2));
do
        updateFile "${allFiles[$i]}" "${allFiles[$i+1]}"
done
 
if [[ $_OUTOFDATE -eq 0 ]];
then
        printf "All files are up-to-date with masters.\n"
fi

exit 0

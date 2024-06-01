#-=-=-=-=-=-=-=-=

#
# bashrc-dir
#
# the following functions manage directory history.
# Typing 'b' goes back to the most recently visited
# directory, typing 'B' goes forward in the opposite
# direction.  Basically a circular list of visited
# directories. These commands, and the basic cd and
# chdir commands work because of the chpwd hook,
# called when a new directory is visited.
# Details below:
#
#  -numbered directory history for quick return
#   command               action
#     v [-q] n          switch MAXDIRS to be n, and list previous directories
#                        (this creates "n" aliases, numbered 1 through n)
#     v                 (verbose) list previous directories visited (MAXDIRS)
#     b                 go back to previous directory (most recent directory)
#     B                 go backwards through directory list
#     1                 switch with directory numbered 1 (previous directory)
#     2                 switch with directory numbered 2 (second to previous directory)
#     3                 switch with directory numbered 3 (third to previous directory)
#     n                 switch with directory numbered n (nth previous directory, up to MAXDIRS)
#

MAXDIRS=20                # default numbered directory aliases; change with sdirs cmd

#
# set up header for window title
# to show directory name. Disabled
# if WINDOWHEADER is not 'yes'.
#
function _setWindowHeader
        {

        #
        # tput needs TERM if not interactive...
        #
        export TERM=${TERM:-"dumb"}

        case $TERM in
        xterm*)
                PRE_WINTABHEADER=$'\e'"]0;"
                PRE_TABHEADER=$'\e'"]1;"
                PRE_WINHEADER=$'\e'"]2;"
                POST_WINHEADER=$'\a'
                ;;
        sun*)
                if [[ $TTY != "/dev/console" && $TTY != "/dev/syscon" ]];
                then
                        PRE_WINHEADER=$'\e'"]l"
                        POST_WINHEADER=$'\e'"\\"
                else
                        PRE_WINHEADER=""
                        POST_WINHEADER="\\n"
                fi
                ;;
        *)
                PRE_WINHEADER=""
                POST_WINHEADER="\\n"
                ;;
        esac
        }

#
# actually display the window header
#
function _windowHeaderUpdate
        {

        if [[ $WINDOWHEADER != "yes" ]];
        then
                return
        fi

        _gitText=""
        if [[ $SHOWGITBRANCH = "yes" ]];
        then
                if type git-text &>/dev/null
                then
                        _gitText=$(git-text)
                fi
        fi

        if [[ "$TERM_PROGRAM" = "iTerm.app" ]];
        then
                #
                # MacOS
                #
                printf "%b%s  %s%b" "${PRE_TABHEADER}" "${PWD}" "${_gitText}" "${POST_WINHEADER}"
        else
                #
                # try Linux terminal
                #
                printf "%b%s %s%b" "${PRE_WINTABHEADER}" "${PWD}" "${_gitText}" "${POST_WINHEADER}"
        fi
        }

#
# Read previous directory list from local
# file saved at last interactive logout.
#
function _getPreviousDirs
        {

        if [[ -r "${PREVIOUSLY_VISITED_DIRS}" ]];
        then
                read -A _DIRS<"${PREVIOUSLY_VISITED_DIRS}"
        else
                for (( index = 1; index <= $MAXDIRS; index++ ))
                do
                        if [[ -z "${_DIRS[$index]}" ]];
                        then
                                _DIRS[$index]=~
                        fi
                done
        fi
        }

#
# verbose; function to list all visited directories.
# Also used to create array of visited directories.
# Array can be adjusted larger or smaller.
#
# usage: v [-q][DirectoryArraySize]
#
function v
        {
        let index=0
        let quiet=0
        let existing=$MAXDIRS

        #
        # check for size adjustments
        #
        if (( $# >= 1 ))
        then
                #
                # typically -q only used when initializing the directory array
                #
                if [[ $1 = "-q" ]];
                then
                        let quiet=1
                        shift
                        if (( $# <= 0 ))
                        then
                                return 0
                        fi
                fi

                #
                # somewhat arbitrary limit
                #
                re="^[0-9]+$"
                if [[ "$1" =~ $re ]];
                then
                        if (( $1 > 2 && $1 < 99 ))
                        then
                                if (( $quiet != 1 ))
                                then
                                        printf "%s: Changing number of saved directories from %d to %d\n" "v" "$MAXDIRS" "$1"
                                fi
                                MAXDIRS=$1;
                                shift
                        else
                                printf "%s: number of saved directories must be between 3 and 99\n" "v"
                                return 1
                        fi
                fi

                #
                # check for extra args
                #
                if (( $# > 0 ))
                then
                        printf "Unrecognized argument.\nUsage: "v" [-q][NumDirectoriesToRemember]\n"
                fi

                #
                # set empty directory slots to home
                #
                for (( index = 0; index <= $MAXDIRS; index++ ))
                do
                        if [[ ! "${_DIRS[$index]}" ]];
                        then
                                _DIRS[$index]=~
                        fi

                        #
                        # Generate an alias for each number between 0 and MAXDIRS,
                        # each of which will chdir to the numbered entry in the
                        # array, then swap the contents with the top entry of the array.
                        #
                        if (( $index > 0 ))
                        then
                                alias $index='"cd" "${_DIRS['$index']}";DIR="${_DIRS['$index']}";_DIRS['$index']="${_DIRS[0]}";_DIRS[0]="$DIR";_windowHeaderUpdate;printf "%s\n" "${_DIRS[0]}"'
                        fi
                done

                #
                # remove residual aliases if new DIRS is smaller than before
                #
                while [[ $index -le $existing ]];
                do
                        unalias $index
                        let index=$index+1;
                done
        fi

        if (( $quiet != 0 ))
        then
                return 0
        fi

        printf "%7.7s: %s\n" "now-> " "${PWD}"
        for (( index = 1; index <= $MAXDIRS; index++ ))
        do
                if (( $index == 1 ))
                then
                        printf "%7.7s: %s\n" "b->1" "${_DIRS[$index]}"
                        continue
                fi
                if (( $index == $MAXDIRS ))
                then
                        printf "%7.7s: %s\n" "B->$MAXDIRS" "${_DIRS[$index]}"
                        continue
                fi
                printf "%7.7s: %s\n" "$index" "${_DIRS[$index]}"
        done
        }

#
# function: back
# Change to most recent directory
#
# usage: b
#
function b
        {
        "cd" "${_DIRS[1]}"
        err=$?
        if (( $err != 0 ))
        then
                printf "%s\n" "Cannot find last directory (${_DIRS[1]}) at this time."
                return
        fi
        _windowHeaderUpdate
        printf "%s\n" "${_DIRS[1]}"

        local SAVE=${_DIRS[0]}
        let index=0
        for DIR in "${_DIRS[@]}";
        do
                let next=$index+1
                _DIRS[$index]=${_DIRS[$next]}
                let index=$next
                if [[ $index -gt $MAXDIRS ]];
                then
                        break
                fi
        done
        let index=$index-1
        _DIRS[$index]="$SAVE"
        }

#
# function: un-back
# Change to least recent directory - opposite of back
# (f for forward was not available...)
#
# usage: B
#
function B
        {
        let index=0
        let found=-1
        for DIR in "${_DIRS[@]}";
        do
                if [[ "${_DIRS[$index]}" ]];
                then
                        let found=$index;
                fi
                let index=$index+1;
                if [[ $index -gt $MAXDIRS ]];
                then
                        break
                fi
        done
        if [[ $found -lt 0 ]];
        then
                printf "%s\n" "Cannot find former directory at this time."
                return
        fi
        "cd" "${_DIRS[$found]}"
        err=$?
        if (( $err != 0 ))
        then
                printf "%s\n" "Cannot find former directory (${_DIRS[$found]}) at this time."
                return
        fi

        _windowHeaderUpdate
        printf "%s\n" "${_DIRS[$found]}"

        local NEXT
        local LAST=${_DIRS[0]}
        local SAVE=${_DIRS[$found]}
        let index=0
        for DIR in "${_DIRS[@]}";
        do
                let next=$index+1
                NEXT=${_DIRS[$next]}
                _DIRS[$next]=$LAST
                LAST=$NEXT
                let index=$next
                if [[ $index -gt $MAXDIRS ]];
                then
                        break
                fi
        done
        _DIRS[0]="$SAVE"
        }

#
# Basis of cd variant.  Change to named
# directory, which is added to an array.
#
# usage: cd NewDirectory
#
function customChangeDirectory
        {
        "cd" "${1:-"$HOME"}"
        err=$?
        if (( $err != 0 ))
        then
                return
        fi

        _windowHeaderUpdate
        LAST=${_DIRS[0]}
        let index=0
        for DIR in "${_DIRS[@]}";
        do
                let next=$index+1
                NEXT="${_DIRS[$next]}"
                _DIRS[$next]=$LAST
                LAST=$NEXT
                let index=$next
                if [[ $index -gt $MAXDIRS ]];
                then
                        break
                fi
        done
        _DIRS[0]="${PWD}"
        }

#
# set up the directory management feature
# safe to remove (unset) after called
#
function setDirectoryManagement
        {

        MAXDIRS="${MAXDIRS:-"30"}"

        #
        # check if the window's header can be adjusted
        #
        _setWindowHeader
        unset -f _setWindowHeader

        #
        # Finally, set the number of expected directory entries
        #
        v -q $MAXDIRS
        }

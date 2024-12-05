#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

#
# dirs.zsh
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
#     v                 (verbose) list previous directories visited (MAXDIRS)
#     v [-q] n          (verbose) switch MAXDIRS to be n, and list previous directories
#                        (this creates "n" functions, named 1 through n)
#     b                 go back to previous directory (most recent directory)
#     B                 go backwards through directory list
#     1                 switch with directory numbered 1 (previous directory)
#     2                 switch with directory numbered 2 (second to previous directory)
#     3                 switch with directory numbered 3 (third to previous directory)
#     n                 switch with directory numbered n (nth previous directory, up to MAXDIRS)
#

MAXDIRS=30              # default numbered directory aliases; change with v cmd

#
# not interactive, be terse
#
if [[ ! $- =~ i ]];
then
        WINDOWHEADER="no"
        SHOWGITBRANCH="no"
fi

#
# set up header for window title
# to show directory name. Disabled
# if WINDOWHEADER is not 'yes'.
#
function _initDirName
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
        if [[ $SHOWGITBRANCH == "yes" ]];
        then
                if type git-text &>/dev/null
                then
                        _gitText=$(git-text)
                fi
        fi

        if [[ "$TERM_PROGRAM" == "iTerm.app" ]];
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
# The .zlogout file saves the array.
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
                if [[ "$1" =~ "^[0-9]+$" ]];
                then
                        if (( $1 > 2 && $1 < 99 ))
                        then
                                if (( $1 > $MAXDIRS ))
                                then
                                        if (( $quiet != 1 ))
                                        then
                                                printf "%s: Increasing saved directories from %d to %d\n" "$0" "$MAXDIRS" "$1"
                                        fi
                                        MAXDIRS=$1;
                                else
                                        if (( $quiet != 1 ))
                                        then
                                                if (( $MAXDIRS == $1 ))
                                                then
                                                        printf "%s: Keeping %d saved directories\n" "$0" "$MAXDIRS"
                                                else
                                                        printf "%s: Decreasing saved directories from %d to %d\n" "$0" "$MAXDIRS" "$1"
                                                fi
                                        fi
                                        _decreaseNumDirs "$1"
                                fi
                                shift
                        else
                                printf "%s: number of saved directories must be between 3 and 99\n" "$0"
                                return 1
                        fi
                fi

                #
                # check for extra args
                #
                if (( $# > 0 ))
                then
                        printf "Unrecognized argument.\nUsage: $0 [-q][NumDirectoriesToRemember]\n"
                fi

                #
                # set empty directory slots to home
                #
                for (( index = 1; index <= $MAXDIRS; index++ ))
                do
                        if [[ -z "${_DIRS[$index]}" ]];
                        then
                                _DIRS[$index]=~
                        fi

                        #
                        # Generate a function for each number between 1 and MAXDIRS,
                        # each of which will chdir to the numbered entry in the
                        # array, then swap the contents with the top entry of the array.
                        #
                        eval "function $index { _visitListedDirectory $index ; }"
                done

                #
                # remove residual functions if new DIRS is smaller than before
                #
                while [[ $index -le $existing ]];
                do
                        ${_DIRS[$index]}=()
                        unset -f "$index"
                        let index=$index+1;
                done
        fi

        if (( $quiet != 0 ))
        then
                return 0
        fi

        printf "%7.7s: %s\n" "now-> " "${PWD}"
        for (( index = 1; index <= ${MAXDIRS}; index++ ))
        do
                if (( $index == 1 ))
                then
                        printf "%7.7s: %s\n" "b->1" "${_DIRS[$index]}"
                        continue
                fi
                if (( $index == ${#_DIRS} ))
                then
                        printf "%7.7s: %s\n" "B->${#_DIRS}" "${_DIRS[$index]}"
                        continue
                fi
                printf "%7.7s: %s\n" "$index" "${_DIRS[$index]}"
        done
        }

#
# To shorten an array, it seems we need to copy the
# original array, delete it then copy back only the
# elements that fit into the decreased space.
#
function _decreaseNumDirs
        {
        local index
        let size=$1

        # we need double quotes around the reference to provide a list with
        # double-quoted entries.  Othersize, we get each element (characters).
        # Using ${_DIRS[*]} is not affected by quotes.
        tmp=("${_DIRS[@]}")

        unset _DIRS
        for (( index = 1; index < $1; index++ ))
        do
                if [[ -z "${_DIRS[$index]}" ]];
                then
                        _DIRS[$index]=${tmp[$index]}
                fi
        done
        unset tmp
        MAXDIRS=$index
        }

#
# This is a zsh hook which is called when
# the process moves to a new directory.
#
function chpwd
        {

        #
        # check if triggered by numeric function (ie 1 to $MAXDIRS)
        #
        _windowHeaderUpdate

        #
        # if a simple swap of directories was made with
        # an existing entry, don't push anything
        #
        if [[ "${funcstack[2]}" = '_visitListedDirectory' ]];
        then
                return 0
        fi

        if [[ "${funcstack[2]}" = 'b' ]];
        then
                _DIRS[1,-2]=(${_DIRS[2,-1]})
                _DIRS[-1]="${OLDPWD}"
        else
                #
                # Whether 'B' or an explicit 'cd' command,
                # push that previous directory on the stack
                # and drop the last directory from the end
                #
                _DIRS[2,-1]=(${_DIRS[1,-2]})
                _DIRS[1]="${OLDPWD}"
        fi
        return 0;
        }

#
# function: back
# Change to most recent directory
#
# usage: b
#
function b
        {

        chdir "${_DIRS[1]}"
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

        chdir "${_DIRS[-1]}"
        }

#
# Common code called by each of the created functions,
# named 1 through $MAXDIRS, to reduce their size
#
function _visitListedDirectory
        {

        _newDir="${1:-1}"
        chdir "${_DIRS[$_newDir]}"
        err=$?
        if (( $err != 0 ))
        then
                printf "%s\n" "Directory (${_DIRS[$_newDir]}) is not available at this time."
                return 1
        fi
        DIR="${_DIRS[$_newDir]}"
        _DIRS[$_newDir]="${OLDPWD}"
        return 0
        }

set -A _DIRS

_initDirName ; unset -f _initDirName
_windowHeaderUpdate
_getPreviousDirs
v -q $MAXDIRS

#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

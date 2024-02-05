#-=-=-=-=-=-=-=-=

#
# bash-prompt
#

PROMPT_ID='\uFC09'
PROMPT_LOCK='\uF023'
PROMPT_OTHER='\uF109'
PROMPT_LINUX='\uE712'
PROMPT_MACOS='\uF302'
PROMPT_UBUNTU='\uF31B'
PROMPT_REDHAT='\uF316'
PROMPT_CENTOS='\uF304'
PROMPT_GIT_BRANCH='\uE0A0'
PROMPT_R_UP_TRANSITION='\uE0BA'
PROMPT_L_UP_TRANSITION='\uE0BC'
PROMPT_BLOCK_TRANSITION='\uE0CC'
PROMPT_R_DOWN_TRANSITION='\uE0BE'
PROMPT_L_DOWN_TRANSITION='\uE0B8'
PROMPT_R_SPIKE_TRANSITION='\uE0CA'
PROMPT_L_SPIKE_TRANSITION='\uE0C8'
PROMPT_R_FLAME_TRANSITION='\uE0C2'
PROMPT_L_FLAME_TRANSITION='\uE0C0'
PROMPT_R_PIXEL_TRANSITION='\uE0C5'
PROMPT_L_PIXEL_TRANSITION='\uE0C4'
PROMPT_R_CURVE_TRANSITION='\uE0B6'
PROMPT_L_CURVE_TRANSITION='\uE0B4'
PROMPT_R_ARROW_TRANSITION='\uE0B2'
PROMPT_L_ARROW_TRANSITION='\uE0B0'
#PROMPT_COMMIT='\uF151'         #stagedstr
#PROMPT_STAGE='\uF01B'          #unstagedstr
#PROMPT_BRANCH='\uE725'         #branch

function promptHelp
        {
        printf "%s\n" "prompt: adjust the command prompt"
        printf "%s\n" "  NOTE: predefined prompts are available with the 'p' command"

        printf "\n"
        printf "%s\n" "Usage:"
        printf "%s\n" "     prompt {Colors | Snippets}..."
        printf "%s\n" "     prompt -h"
        printf "%s\n" "     prompt -p"
        printf "%s\n" "     prompt -v"
        printf "%s\n" "NOTE: rprompt sets the prompt on the right side of the command line."

        printf "\n"
        printf "%s\n" "Options:"
        printf "%s\n" "        -h - Display this message."
        printf "%s\n" "        -p - construct the prompt from the 'pstr' or 'rpstr' variables."
        printf "%s\n" "             Use  'pstr+='colors snippets' to build a complex prompt."
        printf "%s\n" "             Use 'rpstr+='colors snippets' to build a prompt to"
        printf "%s\n" "                          display on the right side of the window."
        printf "%s\n" "             Additional arguments on the command line after '-p' will be ignored."
        printf "%s\n" "        -v - print the current prompt command, suitable for saving and executing."
        printf "%s\n" "             Additional arguments on the command line after '-v' will be ignored.\n"

        printf "%s\n" "Colors:"
        printf "%s\n" "             Black Blue Cyan Grey Green Magenta Red Yellow White"
        printf "%s\n" "             and 246 more; type 'showcolors' to see them."
        printf "%s\n" "     NNN   - select color number NNN (from 0 to 255)"
        printf "%s\n" "     NOTE:   If 2 colors are provided in sequence, the second one"
        printf "%s\n" "             is used as a background color.  A transition symbol"
        printf "%s\n" "             can be specified before a new foreground/background"
        printf "%s\n" "             pair to highlight the change; see Transitions below.\n"

        printf "%s\n" "Snippets:"
        printf "%s\n" "      .     - add '#' if root, otherwise add '>'"
        printf "%s\n" "      ,     - add '#' if root, otherwise add '$'"
#DM     printf "%s\n" "      B     - (or 'b') toggle Bold text mode"
        printf "%s\n" "      date  - day, month, date: Tue Jan 23"
        printf "%s\n" "      Date  - YYYY-MM-DD: 1996-01-23"
#DM     printf "%s\n" "      dir   - name of current directory"
#DM     printf "%s\n" "      dir2  - name of current directory and its parent"
#DM     printf "%s\n" "      dir3  - name of current directory, its parent and grandparent"
        printf "%s\n" "      Dir   - full path name of current directory"
        printf "%s\n" "      gitb  - git branch in current directory, or 'no repo'"
        printf "%s\n" "      gito  - git downstream and upstream offsets"
        printf "%s\n" "      Gitb  - git branch and offsets in current directory only if one exists"
        printf "%s\n" "              PROMPT_GIT_FORMAT has printf style format, '%s [%s]' by default"
        printf "%s\n" "      hist  - number in command history"
        printf "%s\n" "      host  - hostname"
        printf "%s\n" "      Host  - hostname, fully qualified"
#DM     printf "%s\n" "      id    - display a new icon if the effective user ID is root"
#DM     printf "%s\n" "      lock  - display a lock icon if unable to write in current directory"
        printf "%s\n" "      nl    - newline"
        printf "%s\n" "      os    - operating system icon"
        printf "%s\n" "      path  - full path name of current directory"
        printf "%s\n" "      ret   - last command's return value (or caught signal name)"
        printf "%s\n" "      Ret   - last command's return value, (or signal name) only if non-zero"
        printf "%s\n" "      sp    - space"
        printf "%s\n" "      time  - HH:MM AM/PM"
        printf "%s\n" "      Time  - HH:MM 24-hour clock"
        printf "%s\n" "      ul    - toggle underline text mode"
        printf "%s\n" "      user  - user name"
#DM     printf "%s\n" "      vcs   - version control branch information for git, hg, svn, cvs"
        printf "%s\n" "   <other>  - include <other> in the prompt"
        printf "%s\n" "Transitions:"
        printf "%s\n" " '>' or '<' - arrow transition to new colors (default)"
        printf "%s\n" " ')' or '(' - curve transition to new colors"
        printf "%s\n" "      #     - pixel block transition to new colors"
        printf "%s\n" "      /     - upward slant transition to new colors"
        printf "%s\n" "      \     - downward slant transition to new colors"
        printf "%s\n" "      ~     - flame transition to new colors"
        printf "%s\n" "      =     - spike transition to new colors"
        printf "%s\n" "      +     - block transition to new colors"
        printf "%s\n" " NOTE:      - Don't include 'sp' before Gitb or Ret, they include their own."
        printf "%s\n" " BUGS:      - Ret will currently not work properly if Gitb preceeds it in the prompt."
        printf "%s\n" "              it's best to put Gitb last in the prompt if it's used."
        printf "%s\n" "Example:"
        printf "%s\n" "   prompt Green user @ host sp Grey30 time sp White hist sp Red Ret White ';'"
        printf "%s\n" " Currently:"
        printf "%s\n" "      L:     ${pstr}"
        printf "%s\n" "      R:     ${rpstr}"

        }

#
# psvar[1] - vi command line editing mode segment
# psvar[2] - special marker segment if EUID is root
# psvar[3] - Previous command's return code segment
# psvar[4] - Reserved for vcs segment
# psvar[5] - Reserved for Git segment
# psvar[6] - Reserved for Lock segment, when directory is not writable
# psvar[7] - First prompt segment having a single background color
# psvar[8] - Next prompt segment having a single background color
#
PSV_VI=1
PSV_ID=2
PSV_RET=3
PSV_VCS=4
PSV_GIT=5
PSV_LOCK=6
PSV_StartSegment=7

_idPromptUsed=''
_vcsPromptUsed=''
_gitPromptUsed=''
_lockPromptUsed=''

EDIT_MODE_PROMPT=''

#
# This is performed before each prompt is displayed.
# The psvar array contains variables available to the
# prompt which can be updated dynamically
#
function precmd
        {


        #
        # return code analysis must always come first
        #
        psvar[${PSV_RET}]=$?
        if [[ ${psvar[${PSV_RET}]} == 0 ]];
        then
                psvar[${PSV_RET}]=''
        else
                if (( ${psvar[${PSV_RET}]} > 128 ));
                then
                        psvar[${PSV_RET}]=$(kill -l ${psvar[${PSV_RET}]})
                fi
        fi

        if [[ ! -z $_lockPromptUsed ]];
        then
                psvar[${PSV_LOCK}]=''
                if [[ ! -w $PWD ]];
                then
                        psvar[${PSV_LOCK}]="$(print $PROMPT_LOCK)"
                fi
        fi

        if [[ ! -z $_idPromptUsed ]];
        then
                psvar[${PSV_ID}]=''
                if [[ $USERID == 0 ]];
                then
                        psvar[${PSV_ID}]="$(print $PROMPT_ID)"
                fi
        fi

        if [[ ! -z $_vcsPromptUsed ]];
        then
                vcs_info
                if [[ -n $vcs_info_msg_0_ ]];
                then
                        psvar[${PSV_VCS}]="$(print ${PROMPT_GIT_BRANCH} $vcs_info_msg_0_)"
                else
                        psvar[${PSV_VCS}]=''
                fi
        fi

        if [[ ! -z $_gitPromptUsed ]];
        then
                if [[ ! -z $(git-branch-name) ]];
                then
                        psvar[${PSV_GIT}]="$(printf "${PROMPT_GIT_FORMAT}" "$(git-branch-name)" "$(_git-ahead-behind)")"
                else
                        psvar[${PSV_GIT}]=''
                fi
        fi
        }

#
# Set the foreground and background colors, as
# well as a possibly hidden item.  Either a
# request for such an item, or a change in the
# background color is used to indicate a new
# segment.  All segments are added to the
# prompt string
#
function promptSegment
        {
        local _color=$1

        if [[ -z $_fg ]];
        then
                #
                # no foreground color yet, set it now
                #
                _fg=$_color
                _seg+="\\[$(tput setaf $_fg)\\]"
                return
        fi

        #
        # foreground color has been set, this must be a background color
        #
        if [[ -z ${_bg} ]];
        then
                #
                # this is first segment
                #
                _bg="$_color"
                if [[ ! -z $_buildRightPrompt ]];
                then
                        _seg+="\\[$(tput setaf $_bg)\\]"
                        _seg+="$(printf $_rpromptTransition)"
                        _seg+="\\[$(tput setaf $_fg)\\]"
                fi
                _seg+="\\[$(tput setab $_bg)\\]"

                #
                # Reset the 'foreground color found' indicator
                #
                _fg=''
                return
        fi

        #
        # for the regular left side prompt, set
        # the foreground to the background color
        #
        if [[ -z $_buildRightPrompt ]];
        then
                _seg+="\\[$(tput setaf $_bg)\\]"
        fi

        #
        # If a potentially hidden item was requested
        # for the prompt, then add this segment before
        # closing it off. A check is done before the
        # prompt is displayed to see if the item is
        # supposed to appear.
        #
        case $_checkHiddenSegment in
        Ret)
                psvar[$_segIndex]="%(${PSV_RET}V.${_seg}.)"
                ;;
        lock)
                psvar[$_segIndex]="%(${PSV_LOCK}V?${_seg}?)"
                ;;
        vcs)
                psvar[$_segIndex]="%(${PSV_VCS}V?${_seg}?)"
                ;;
        git)
                psvar[$_segIndex]="%(${PSV_GIT}V?${_seg}?)"
                ;;
        vi)
                psvar[$_segIndex]="%(${PSV_VI}V?${_seg}?)"
                ;;
        id)
                psvar[$_segIndex]="%(${PSV_ID}V?${_seg}?)"
                ;;
        *)
                psvar[$_segIndex]="$_seg"
                ;;
        esac
        _checkHiddenSegment=''

        #
        # here we know that both foreground and background
        # colors are set, and a potentially hidden item
        # has been added if requested.  Close off this
        # current segment and save it.
        #
        (( _segIndex++ ))
        _seg=''
        _bg="$_color"

        if [[ ! -z $_buildRightPrompt ]];
        then
                #
                # draw arrow first with foreground color
                # set to previous background on right side
                # in a new segment
                #
                _seg+="\\[$(tput setaf $_bg)\\]"
                _seg+="$(printf $_rpromptTransition)"
                _seg+="\\[$(tput setab $_bg)\\]"
        else
                #
                # start a new segment on the left
                #
                _seg+="\\[$(tput setab $_bg)\\]"
                _seg+="$(printf $_lpromptTransition)"
        fi
        _seg+="\\[$(tput setaf $_fg)\\]"

        #
        # Reset the 'foreground color found' indicator
        #
        _fg=''
        }

#
# fun with prompts
#
        # bash prompt escape sequence "snippets"
        #  \!   history number
        #  \#   command number
        #  \$   # for root, $ for user
        #  \@   Time in 12hr am/pm
        #  \A   Time in 24hr HH:MM
        #  \D{format} date in strftime format
        #  \H   hostname
        #  \T   Time in 12hr
        #  \V   version with patch number
        #  \W   Basename of current dir ($HOME with ~)
        #  \[   begins non-printing chars
        #  \]   ends   non-printing chars
        #  \\   backslash
        #  \a   ASCII bell (also \007)
        #  \d   date
        #  \e   ASCII escape character (033)
        #  \h   hostname up to the first '.'
        #  \j   number of jobs currently managed by the shell
        #  \l   basename of the shell's terminal device name
        #  \n   newline
        #  \nnn character for octal nnn
        #  \r   carriage return
        #  \s   shell name
        #  \t   Time in 24hr HH:MM:SS
        #  \u   username
        #  \v   version
        #  \w   Current directory ($HOME with ~)

pstr=''
rpstr=''
_buildRightPrompt=''

function _lastDirEntries
        {
        _ndirs=${1-"1"}
        pwd|awk -F / -v n=$_ndirs '{if( n > NF) n = NF; o = $NF; for( f = 1; f < n; f++) o = $( NF - f) "/" o; print o}'
        }

function prompt
        {

        _lpromptTransition="$PROMPT_L_ARROW_TRANSITION"
        _buildRightPrompt=''
        _commonPrompt $@
        return $?
        }

function rprompt
        {

        _rpromptTransition="$PROMPT_R_ARROW_TRANSITION"
        _buildRightPrompt=true
        _commonPrompt $@
        return $?
        }

function _commonPrompt
        {
        _lpromptSource=''
        _rpromptSource=''

        if [[ $# -eq 0 || $1 == '-h' ]];
        then
                promptHelp
                return 0
        fi

        case $1 in
        -p)
                if [[ ! -z $_buildRightPrompt ]];
                then
                        if [[ ! -z $rpstr ]];
                        then
                                _rpromptSource=$rpstr
                        else
                                promptHelp
                                return 1
                        fi
                else
                        if [[ ! -z $pstr ]];
                        then
                                _lpromptSource=$pstr
                        else
                                promptHelp
                                return 1
                        fi
                fi
                ;;
        -v)
                if [[ ! -z $_buildRightPrompt ]];
                then
                        if [[ -z $_rpromptSource ]];
                        then
                                printf "No right-side prompt settings available.\n"
                                promptHelp
                                return 1
                        fi

                        echo "rprompt $_rpromptSource"
                else
                        if [[ -z $_lpromptSource ]];
                        then
                                printf "No left-side prompt settings available.\n"
                                promptHelp
                                return 1
                        fi

                        echo "prompt $_lpromptSource"
                fi
                return 0
                ;;
        -)
                if [[ ! -z $_buildRightPrompt ]];
                then
                        RPS1=''
                else
                        PS1=''
                fi
                return 0
                ;;
        *)
                if [[ ! -z $_buildRightPrompt ]];
                then
                        rpstr="$@"
                        _rpromptSource=$rpstr
                else
                        pstr="$@"
                        _lpromptSource=$pstr
                fi
                ;;
        esac

        if type getColors &>/dev/null
        then
                getColors
        fi

        _boldStarted=''
        _vcsPromptUsed=''
        _gitPromptUsed=''
        _lockPromptUsed=''
        _underlineStarted=''
        _checkHiddenSegment=''
        PROMPT_GIT_FORMAT=${PROMPT_GIT_FORMAT:-"%s [%s]"}

        _fg=''
        _bg=''
        _seg=''

        _segIndex=$PSV_StartSegment

        if [[ ! -z $_buildRightPrompt ]];
        then
                _pSource=${_rpromptSource}
        else
                _pSource=${_lpromptSource}
        fi

        for cmd in ${_pSource};
        do
                #
                # check for color names first
                #
                color=${_colorTable[${cmd}]}
                if [[ ! -z $color ]];
                then
                        promptSegment $color
                        continue
                fi

                #
                # check for color indexes next
                #
                if [[ "$cmd" =~ '^[0-9]+$' ]];
                then
                        if (( $cmd >= 0 && $cmd <= 255 ))
                        then
                                promptSegment $cmd
                                continue
                        fi
                fi

                #
                # finally check for symbols
                #
                case "$cmd" in
                b|B)
                        if [[ ! -z _boldStarted ]];
                        then
                                _seg+="\\033[2m"
                                _boldStarted=''
                        else
                                _seg+="\\033[34;1m"
                                _boldStarted=true
                        fi
                        ;;
                Gitb) 
                        _seg+='${psvar[${PSV_GIT}]}'
                        _checkHiddenSegment="git"
                        _gitPromptUsed=true
                        ;;
                lock)
                        _seg+='${psvar[${PSV_LOCK}]}'
                        _checkHiddenSegment="lock"
                        _lockPromptUsed=true
                        ;;
                id)
                        _seg+='${psvar[${PSV_ID}]}'
                        _checkHiddenSegment="id"
                        _idPromptUsed=true
                        ;;
                os)
                        case $SYS_SPECIFIC in
                        MacOS)
                                _seg+="$(printf $PROMPT_MACOS)"
                                ;;
                        centos)
                                _seg+="$(printf $PROMPT_CENTOS)"
                                ;;
                        rhel)
                                _seg+="$(printf $PROMPT_REDHAT)"
                                ;;
                        ubuntu)
                                _seg+="$(printf $PROMPT_UBUNTU)"
                                ;;
                        Linux)
                                _seg+="$(printf $PROMPT_LINUX)"
                                ;;
                        *)
                                _seg+="$(printf $PROMPT_OTHER)"
                                ;;
                        esac
                        ;;
                Ret)
                        _seg+='${psvar[${PSV_RET}]}'
                        _checkHiddenSegment="Ret"
                        ;;
                ul)
                        if [[ ! -z _underlineStarted ]];
                        then
                                _seg+="%u"
                                _underlineStarted=''
                        else
                                _seg+="%U"
                                _underlineStarted=true
                        fi
                        ;;
                vi)
                        _seg+='${psvar[${PSV_VI}]}'
                        _checkHiddenSegment="vi"
                        ;;
                vcs)
                        _seg+='${psvar[${PSV_VCS}]}'
                        _checkHiddenSegment="vcs"
                        _vcsPromptUsed=true
                        ;;
                date)   _seg+="%D{%a %b %f}"         ;;
                Date)   _seg+="%D{%Y-%m-%d}"         ;;
                Dir)    _seg+="%0d"                  ;;
                dir)    _seg+="%1d"                  ;;
                dir2)   _seg+="%2d"                  ;;
                dir3)   _seg+="%3d"                  ;;
                gitb)   _seg+='$(git-branch)'        ;;
                gito)   _seg+='$(_git-ahead-behind)' ;;
                hist)   _seg+="\!"                   ;;
                Hist)   _seg+="\#"                   ;;
                host)   _seg+="\h"                   ;;
                Host)   _seg+="\H"                   ;;
                nl)     _seg+="\n"                   ;;
                path)   _seg+="\W"                   ;;
                ret)    _seg+='${psvar[${PSV_RET}]}' ;;
                sp)     _seg+=" "                    ;;
                time)   _seg+="\D{%I:%M %p}"         ;;
                Time)   _seg+="\d"                   ;;
                tty)    _seg+="%y"                   ;;
                user)   _seg+="\u"                   ;;
                ,)      _seg+="\$"                   ;;
                .)      _seg+=">"                    ;;
                #
                # transitions
                #
                '>'|'<')
                        if [[ -z $_buildRightPrompt ]];
                        then
                                _lpromptTransition="$PROMPT_L_ARROW_TRANSITION"
                        else
                                _rpromptTransition="$PROMPT_R_ARROW_TRANSITION"
                        fi
                        ;;
                ')'|'(')
                        if [[ -z $_buildRightPrompt ]];
                        then
                                _lpromptTransition="$PROMPT_L_CURVE_TRANSITION"
                        else
                                _rpromptTransition="$PROMPT_R_CURVE_TRANSITION"
                        fi
                        ;;
                '#')
                        if [[ -z $_buildRightPrompt ]];
                        then
                                _lpromptTransition="$PROMPT_L_PIXEL_TRANSITION"
                        else
                                _rpromptTransition="$PROMPT_R_PIXEL_TRANSITION"
                        fi
                        ;;
                '/')
                        if [[ -z $_buildRightPrompt ]];
                        then
                                _lpromptTransition="$PROMPT_L_UP_TRANSITION"
                        else
                                _rpromptTransition="$PROMPT_R_UP_TRANSITION"
                        fi
                        ;;
                '\')
                        if [[ -z $_buildRightPrompt ]];
                        then
                                _lpromptTransition="$PROMPT_L_DOWN_TRANSITION"
                        else
                                _rpromptTransition="$PROMPT_R_DOWN_TRANSITION"
                        fi
                        ;;
                '~')
                        if [[ -z $_buildRightPrompt ]];
                        then
                                _lpromptTransition="$PROMPT_L_FLAME_TRANSITION"
                        else
                                _rpromptTransition="$PROMPT_R_FLAME_TRANSITION"
                        fi
                        ;;
                '=')
                        if [[ -z $_buildRightPrompt ]];
                        then
                                _lpromptTransition="$PROMPT_L_SPIKE_TRANSITION"
                        else
                                _rpromptTransition="$PROMPT_R_SPIKE_TRANSITION"
                        fi
                        ;;
                '+')
                        if [[ -z $_buildRightPrompt ]];
                        then
                                _lpromptTransition="$PROMPT_BLOCK_TRANSITION"
                        else
                                _rpromptTransition="$PROMPT_BLOCK_TRANSITION"
                        fi
                        ;;
                #
                # anything else
                #
                *)
                        _seg+="${cmd}"
                        ;;
                esac
                _fg=''
        done

#DM     if [[ ! -z _vcsPromptUsed ]];
#DM     then
#DM             zstyle ':vcs_info:*' check-for-changes true
#DM     else
#DM             zstyle ':vcs_info:*' check-for-changes false
#DM     fi

        if [[ ! -z $_bg ]];
        then
                if [[ -z $_buildRightPrompt ]];
                then
                        _seg+="\\[$(tput setaf $_bg)\\]"
                fi
                case $_checkHiddenSegment in
                Ret)
                        psvar[$_segIndex]="%(${PSV_RET}V.${_seg}.)"
                        ;;
                lock)
                        psvar[$_segIndex]="%(${PSV_LOCK}V?${_seg}?)"
                        ;;
                vcs)
                        psvar[$_segIndex]="%(${PSV_VCS}V?${_seg}?)"
                        ;;
                git)
                        psvar[$_segIndex]="%(${PSV_GIT}V?${_seg}?)"
                        ;;
                id)
                        psvar[$_segIndex]="%(${PSV_ID}V?${_seg}?)"
                        ;;
                *)
                        psvar[$_segIndex]="$_seg"
                        ;;
                esac
                (( _segIndex++ ))
                _seg="%k"
                if [[ -z $_buildRightPrompt ]];
                then
                        _seg+="$(print $_lpromptTransition)"
                fi
        else
                _seg+="%k"
        fi
        _seg+="\\[$(tput sgr0)\\]"
        psvar[$_segIndex]="$_seg"

        #
        # finally fill the prompt string with the segments
        #
        TMP_PROMPT=''
        for (( index = ${PSV_StartSegment}; index <= ${_segIndex}; index++ ))
        do
                if [[ ! -z "${psvar[$index]}" ]];
                then
                        TMP_PROMPT+="${psvar[$index]}"
                fi
        done
        if [[ ! -z $_buildRightPrompt ]];
        then
                RPS1=${TMP_PROMPT}
        else
                PS1=${TMP_PROMPT}
        fi
        return 0
        }

function NOTHINGYET
        {
        local       BLACK='0'
        local         RED='1'
        local       GREEN='2'
        local      YELLOW='3'
        local        BLUE='4'
        local      PURPLE='5'
        local        CYAN='6'
        local       WHITE='7'
        local        GRAY='236'

        local      ORANGE='172'
        local       BROWN='94'
        local         SKY='75'

        local       RESET='\\[$(tput sgr0)\\]'

        local  foreground=''
        local  foundColor=true
        local     enhance=autoBright
        local needRetCode=false

        if [[ $# -eq 0 || $1 == '-h' ]];
        then
                promptHelp
                return 0
        fi

        # bash prompt escape sequence "snippets"
        #  \!   history number
        #  \#   command number
        #  \$   # for root, $ for user
        #  \@   Time in 12hr am/pm
        #  \A   Time in 24hr HH:MM
        #  \D{format} date in strftime format
        #  \H   hostname
        #  \T   Time in 12hr
        #  \V   version with patch number
        #  \W   Basename of current dir ($HOME with ~)
        #  \[   begins non-printing chars
        #  \]   ends   non-printing chars
        #  \\   backslash
        #  \a   ASCII bell (also \007)
        #  \d   date
        #  \e   ASCII escape character (033)
        #  \h   hostname up to the first '.'
        #  \j   number of jobs currently managed by the shell
        #  \l   basename of the shell's terminal device name
        #  \n   newline
        #  \nnn character for octal nnn
        #  \r   carriage return
        #  \s   shell name
        #  \t   Time in 24hr HH:MM:SS
        #  \u   username
        #  \v   version
        #  \w   Current directory ($HOME with ~)

        if [[ $1 == "-p" ]];
        then
                _savedPrompt=${_savedPrompt:-": No prompt settings applied yet."}
                printf "%s\n" "prompt $_savedPrompt"
                return
        fi

        PS1=''

        PROMPT_GIT_FORMAT=${PROMPT_GIT_FORMAT:-"%s"}
        _savedPrompt="$@"

        for cmd in "$@";
        do
                foundColor=true
                enhance=autoBright

                #
                # check for colours first
                #
                case $cmd in
                black | Black)
                        let foreground=${BLACK}
                        ;;
                red | Red)
                        let foreground=${RED}
                        ;;
                green | Green)
                        let foreground=${GREEN}
                        ;;
                yellow | Yellow)
                        let foreground=${YELLOW}
                        ;;
                blue | Blue)
                        let foreground=${BLUE}
                        ;;
                purple | Purple)
                        let foreground=${PURPLE}
                        ;;
                cyan | Cyan)
                        let foreground=${CYAN}
                        ;;
                white | White)
                        let foreground=${WHITE}
                        ;;
                gray | gray0 | Gray | Gray0)
                        let foreground=${GRAY}
                        ;;
                gray1 | Gray1)
                        let foreground="${GRAY} + 2"
                        ;;
                gray2 | Gray2)
                        let foreground="${GRAY} + 4"
                        ;;
                gray3 | Gray3)
                        let foreground="${GRAY} + 6"
                        ;;
                orange | Orange)
                        let foreground="${ORANGE}"; enhance=extendedBright
                        ;;
                brown | Brown)
                        let foreground="${BROWN}"; enhance=extendedBright
                        ;;
                sky | Sky)
                        let foreground="${SKY}"; enhance=extendedBright
                        ;;
                rand)
                        let foreground="$RANDOM % 254 + 1"
                        ;;
                -c*)
                        let foreground="${cmd:2}"
                        ;;
                *)
                        foundColor=false
                        ;;
                esac

                if [[ $foundColor = "true" ]];
                then
                        if [[ ${cmd:0:1} == [A-Z] ]];
                        then
                                if [[ $enhance == 'autoBright' ]];
                                then
                                        let "foreground += 8" 
                                elif [[ $enhance == 'extendedBright' ]];
                                then
                                        let "foreground += 36" 
                                fi
                        fi
                        PS1="${PS1}\\[$(tput setaf ${foreground})\\]"
                        continue
                fi

                #
                # check for snippets to include
                #
                case $cmd in
                ret)
                        PS1="${PS1}\$_RET"
                        needRetCode=true
                        ;;
                Ret)
                        PS1="${PS1}\$(_RET=\$?;if [[ \$_RET != 0 ]]; then printf \" \$_RET\"; fi)"
                        #PS1="${PS1}\$(if [[ \$_RET != 0 ]]; then printf \"\$_RET\"; fi)"
                        needRetCode=true
                        ;;
                hist)
                        PS1="${PS1}\!"
                        ;;
                Hist)
                        PS1="${PS1}\#"
                        ;;
                date)
                        PS1="${PS1}\d"
                        ;;
                Date)
                        PS1="${PS1}\D{%Y-%m-%d}"
                        ;;
                time)
                        PS1="${PS1}\@"
                        ;;
                Time)
                        PS1="${PS1}\T"
                        ;;
                user)
                        PS1="${PS1}\u"
                        ;;
                dir)
                        PS1="${PS1}\W"
                        ;;
                Dir | path)
                        PS1="${PS1}\w"
                        ;;
                host)
                        PS1="${PS1}\h"
                        ;;
                Host)
                        PS1="${PS1}\H"
                        ;;
                gitb)
                        if type git-branch &>/dev/null
                        then
                                PS1="${PS1}\$(git-branch)"
                        fi
                        ;;
                Gitb)
                        if type git-branch-name &>/dev/null
                        then
                                PS1="${PS1}\$(_BR=\$(git-branch-name);if [[ \${_BR} != \"\" ]]; then printf \" \${PROMPT_GIT_FORMAT}\" \"\${_BR}\"; fi)"
                        fi
                        ;;
                gito)
                        if type git-offset &>/dev/null
                        then
                                PS1="${PS1}\$(git-offset)"
                        fi
                        ;;
                nl)
                        PS1="${PS1}\n"
                        ;;
                sp)
                        PS1="${PS1} "
                        ;;
                $)
                        PS1="${PS1}\$"
                        ;;
                .)
                        if [[ $USERID -eq 0 ]];
                        then
                                PS1="${PS1}# "
                        else
                                PS1="${PS1}>"
                        fi
                        ;;
                *)
                        PS1="${PS1}${cmd}"
                        ;;
                esac
        done

        #
        # We need to save the previous command's return
        # code in case a command is run within the
        # prompt itself and overwrites it.
        #
        #if [[ $needRetCode == "true" ]];
        #then
                #PS1="\$(export _RET=\$?)${PS1}"
        #fi

        PS1="${PS1}${RESET}"

        return
        }

#
# some help to select
# a preset prompt format
#
function presetPromptHelp
        {
        #
        # these messages correspond to the numeric
        # options in the case statement of the 'p'
        # function below.  Specifically, the first
        # prompt refers to case 1) and so forth.
        #
        promptOptions=(
                'vivid prompt; blue left and right side with arrows'
                'simple prompt; username and history number'
                'color prompt; username, host, directory and history number'
                'color prompt with right-side indicators and git details'
                'color prompt with right-side indicators and version control info'
                'vivid simple prompt'
                'vivid prompt'
                'vivid prompt with right-side indicators and git details'
                'vivid prompt with right-side indicators and version control info'
                'vivid blue prompt with green right-side indicators and version control info'
                )
        printf "%s\n" "p: select a preset format for command line prompts:"
        printf "\n"

        let index=1
        for txt in "${promptOptions[@]}";
        do
                if (( $CHOSEN_PRESET_PROMPT == $index ))
                then
                        printf "%s\n" "p $index  > $txt"
                else
                        printf "%s\n" "p $index    $txt"
                fi
                (( index++ ))
        done
        printf "\n"
        printf "%s\n" "p -h - display this message"
        printf "%s\n" "Use 'prompt' to adjust prompt details."
        printf "Currently:"
        printf "   L: %s\n" "${pstr}"
        printf "   R: %s\n" "${rpstr}"
        }

#
# create some
# predefined prompts
#
let CHOSEN_PRESET_PROMPT=4
function p
        {

        if [[ $# -eq 0 || $1 == '-h' ]];
        then
                presetPromptHelp
                return 0
        fi

        let prevChoice=${CHOSEN_PRESET_PROMPT}
        let CHOSEN_PRESET_PROMPT=$1
        case $1 in
        0)
                #
                # user@sys parent/dir histnum [rootIcon]         [viIcon][retCode][lock][GIT] date time
                #
                pstr=''
                pstr+='Grey85 Blue3 user @ White host sp '
                pstr+='> Grey85 Grey39 > B White Blue3 dir2 '
                pstr+='> Grey85 Grey39 > White Blue3 hist '
                pstr+='> Grey85 Grey39 '
                pstr+='White DodgerBlue id'
                prompt -p

                rpstr=''
                rpstr+='< Black Grey39 < '
                rpstr+='B Gold Blue2 vi '
                rpstr+='B DarkOrange Blue2 Ret '
                rpstr+='B Orange Blue2 lock '
                rpstr+='B White Blue2 vcs gito '
                rpstr+='Grey78 Blue2 date '
                rpstr+='< Black Grey39 < '
                rpstr+='White Blue2 time '
                rprompt -p
                ;;
        9)
                #
                # OSicon user@sys parent/dir histnum [rootIcon]         [viIcon][retCode][lock][GIT] date time
                #
                pstr=''
                pstr+='White Black sp os sp '
                pstr+=') B White Blue3 sp user Grey70 @ host sp '
                pstr+='~ B White DodgerBlue sp dir2 sp '
                pstr+='> B Black Turquoise sp hist sp '
                pstr+='White Maroon id'
                prompt -p

                rpstr=''
                rpstr+='Black Gold sp vi sp '
                rpstr+='White Maroon sp Ret sp '
                rpstr+='Black Orange sp lock sp '
                rpstr+='B White DarkGreen vcs sp gito sp '
                rpstr+='Black SeaGreen2 sp date sp '
                rpstr+='Black DarkSeaGreen2 sp time sp '
                rprompt -p
                ;;
        8)
                #
                # OSicon user@sys parent/dir histnum [rootIcon]         [viIcon][retCode][lock][GIT] date time
                #
                pstr=''
                pstr+='White Black sp os sp '
                pstr+='B White Wheat1 sp user Cornsilk @ host sp '
                pstr+='B White DarkGoldenrod sp dir2 sp '
                pstr+='B Black Tan sp hist sp '
                pstr+='White Maroon id'
                prompt -p

                rpstr=''
                rpstr+='Black Gold sp vi sp '
                rpstr+='White Maroon sp Ret sp '
                rpstr+='Black Orange sp lock sp '
                rpstr+='< B White Purple3 vcs sp gito sp '
                rpstr+='( White MediumPurple sp date sp '
                rpstr+='White Purple1 sp time sp '
                rprompt -p
                ;;
        7)
                #
                # sys dir histnum [rootIcon]         [viIcon][retCode][lock][GIT] time
                #
                pstr=''
                pstr+='B White Blue3 sp host sp '
                pstr+='~ B White DodgerBlue sp dir sp '
                pstr+='> B Black Turquoise sp hist sp '
                pstr+='White Red id'
                prompt -p

                rpstr=''
                rpstr+='Black Gold sp vi sp '
                rpstr+='White Maroon sp Ret sp '
                rpstr+='Black Orange sp lock sp '
                rpstr+='B White DarkGreen vcs sp gito sp '
                rpstr+='Black DarkSeaGreen2 sp time sp '
                rprompt -p
                ;;
        6)
                #
                # user histnum [rootIcon]               time
                #
                prompt 'White Blue3 sp user Grey70 @ host sp Black Turquoise sp hist sp White Red id'
                rprompt 'B White DarkGreen vcs sp gito sp Black SeaGreen sp time sp '
                ;;
        5)
                #
                # user histnum [rootIcon]
                #
                prompt 'White Blue3 sp user sp dir sp hist sp White Maroon id'
                rprompt -
                ;;
        4)
                #
                # for Dark Screen
                # user@sys parent/dir histnum rootSym         [viIcon] [retCode] [lock] [VCS] date time
                #
                prompt 'B DodgerBlue user @ host CornflowerBlue sp dir2 SkyBlue sp White hist .'

                rpstr=''
                rpstr+='Gold sp vi sp '
                rpstr+='Maroon sp Ret sp '
                rpstr+='SandyBrown sp lock sp '
                rpstr+='LightSkyBlue vcs sp gito sp '
                rpstr+='DodgerBlue sp date sp '
                rpstr+='SkyBlue sp time sp '
                rprompt -p
                ;;
        3)
                #
                # for Light Screen
                # user@sys parent/dir histnum rootSym         [viIcon] [retCode] [lock] [VCS] date time
                #
                pstr=''
                pstr+='Blue3 user Navy @ host '
                pstr+='sp Black dir2 '
                pstr+='sp Purple4 hist .'
                prompt -p

                rpstr=''
                rpstr+='Gold sp vi sp '
                rpstr+='Maroon sp Ret sp '
                rpstr+='Orange sp lock sp '
                rpstr+='Purple4 sp vcs sp gito sp '
                rpstr+='Maroon sp date sp '
                rpstr+='Blue3 sp time sp '
                rprompt -p
                ;;
        2)
                #
                # user@sys time histnum rootSym
                #
                prompt 'B DodgerBlue user @ host sp SkyBlue time sp White hist .'
                rprompt -
                ;;
        1)
                #
                # user@sys histnum rootSym
                #
                prompt 'White user sp hist .'
                rprompt -
                ;;
        *)
                #
                # false alarm - reset the preset prompt choice
                #
                CHOSEN_PRESET_PROMPT=${prevChoice}
                echo "Unrecognized prompt: '$1'"
                echo ""
                presetPromptHelp
                return 0
                ;;
        esac
        }
#
# start with a simple colored prompt
#
p $CHOSEN_PRESET_PROMPT

#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

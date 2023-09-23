#-=-=-=-=-=-=-=-=

#
# bash-prompt
#

function promptHelp
        {
        printf "%s\n" "Adjust the bash command prompt"
        printf "%s\n" ""
        printf "%s\n" "Usage:"
        printf "%s\n" "       $FUNCNAME {Colors | Snippets}..."
        printf "%s\n" "       $FUNCNAME -p"
        printf "%s\n" "   Options:"
        printf "%s\n" "           -p - print the current prompt command, suitable for saving and executing."
        printf "%s\n" "                additional arguments on the command line after '-p' will be ignored."
        printf "%s\n" "    Colors:"
        printf "%s\n" "                black blue cyan gray green purple red white"
        printf "%s\n" "                yellow orange brown sky gray gray1 gray2 gray3"
        printf "%s\n" "                 Capitalize the name to get brighter color (eg. Blue vs blue)"
        printf "%s\n" "        -cNNN - select color number NNN (from 0 to 254)"
        printf "%s\n" "        rand  - select a random color"
        printf "%s\n" "  Snippets:"
        printf "%s\n" "        nl    - newline"
        printf "%s\n" "        sp    - space"
        printf "%s\n" "        $     - add '#' if root, otherwise add '$'"
        printf "%s\n" "        .     - add '#' if root, otherwise add '>'"
        printf "%s\n" "        hist  - number in command history"
        printf "%s\n" "        Hist  - number in command session"
        printf "%s\n" "        date  - day, month, date: Tue Jan 23"
        printf "%s\n" "        Date  - YYYY-MM-DD: 1996-01-23"
        printf "%s\n" "        time  - time, AM/PM"
        printf "%s\n" "        Time  - time, 24-hour clock"
        printf "%s\n" "        user  - user name"
        printf "%s\n" "        dir   - name of current directory"
        printf "%s\n" "        Dir   - full path name of current directory"
        printf "%s\n" "        path  - full path name of current directory"
        printf "%s\n" "        host  - hostname"
        printf "%s\n" "        Host  - hostname, fully qualified"
        printf "%s\n" "        gitb  - git branch in current directory"
        printf "%s\n" "        Gitb  - git branch in current directory only if one exists"
        printf "%s\n" "        gito  - git downstream and upstream offset"
        printf "%s\n" "        ret   - last command's return value"
        printf "%s\n" "        Ret   - last command's return value, only if non-zero"
        printf "%s\n" "     <other>  - include <other> in the prompt"
        printf "%s\n" "   NOTE:      - Don't include 'sp' before Gitb or Ret, they include their own."
        printf "%s\n" "   BUGS:      - Ret will currently not work properly if Gitb preceeds it in the prompt."
        printf "%s\n" "                it's best to put Gitb last in the prompt if it's used."
        printf "%s\n" "   Example:"
        printf "%s\n" "        prompt Green user @ host sp gray2 time sp white hist sp Red Ret White '>'"
        }

function prompt
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

        local       RESET='\[$(tput sgr0)\]'

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
        #  \[   begins non-printing chars
        #  \]   ends   non-printing chars
        #  \a   ASCII bell (also \007)
        #  \e   ASCII escape character (033)
        #  \d   date
        #  \D{format} date in strftime format
        #  \h   hostname up to the first '.'
        #  \H   hostname
        #  \j   number of jobs currently managed by the shell
        #  \l   basename of the shell's terminal device name
        #  \n   newline
        #  \r   carriage return
        #  \u   username
        #  \s   shell name
        #  \w   Current directory ($HOME with ~)
        #  \W   Basename of current dir ($HOME with ~)
        #  \t   Time in 24hr HH:MM:SS
        #  \A   Time in 24hr HH:MM
        #  \T   Time in 12hr
        #  \@   Time in 12hr am/pm
        #  \!   history number
        #  \#   command number
        #  \v   version
        #  \V   version with patch number
        #  \$   # for root, $ for user
        #  \nnn character for octal nnn
        #  \\   backslash

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
                        PS1="${PS1}\[$(tput setaf ${foreground})\]"
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
                'display simple prompt'
                'display color prompt'
                'display color prompt with right-side indicators'
                'display color prompt with right-side indicators and git details'
                'display vivid simple prompt'
                'display vivid prompt'
                'display vivid prompt with right-side indicators'
                'display vivid prompt with right-side indicators and git details'
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
        }

#
# create some
# predefined prompts
#
let CHOSEN_PRESET_PROMPT=2
#                                        function p
#                                                {
#
#                                                if [[ $# -eq 0 || $1 == '-h' ]];
#                                                then
#                                                        presetPromptHelp
#                                                        return 0
#                                                fi
#
#                                                let prevChoice=${CHOSEN_PRESET_PROMPT}
#                                                let CHOSEN_PRESET_PROMPT=$1
#                                                case $1 in
#                                                8)
#                                                        #
#                                                        # OSicon user@sys parent/dir histnum [rootIcon]         [viIcon] [retCode] [VCS] [lock] date time
#                                                        #
#                                                        pstr=''
#                                                        pstr+='Black Khaki os '
#                                                        pstr+='b Black Lime sp user Grey35 b @ host sp '
#                                                        pstr+='White Blue3 sp dir2 sp '
#                                                        pstr+='DarkBlue Tan sp hist sp '
#                                                        pstr+='White Maroon id'
#                                                        prompt -p
#
#                                                        rpstr=''
#                                                        rpstr+='Black Gold sp vi sp '
#                                                        rpstr+='White Maroon sp Ret sp '
#                                                        rpstr+='White DarkOrange1 sp vcs sp '
#                                                        rpstr+='Black Orange sp lock sp '
#                                                        rpstr+='NavyBlue Honeydew sp date sp '
#                                                        rpstr+='Black SeaGreen sp time sp '
#                                                        rprompt -p
#                                                        ;;
#                                                7)
#                                                        #
#                                                        # OSicon user@sys parent/dir histnum [rootIcon]         [viIcon][retCode][GIT][lock] date time
#                                                        #
#                                                        pstr=''
#                                                        pstr+='Black Khaki os '
#                                                        pstr+='b Black Lime sp user Grey35 b @ host sp '
#                                                        pstr+='White Blue3 sp dir2 sp '
#                                                        pstr+='DarkBlue Tan sp hist sp '
#                                                        pstr+='White Maroon id'
#                                                        prompt -p
#
#                                                        rpstr=''
#                                                        rpstr+='Black Gold sp vi sp '
#                                                        rpstr+='White Maroon sp Ret sp '
#                                                        rpstr+='White DarkOrange1 sp Gitb sp '
#                                                        rpstr+='Black Orange sp lock sp '
#                                                        rpstr+='NavyBlue Honeydew sp date sp '
#                                                        rpstr+='Black SeaGreen sp time sp '
#                                                        rprompt -p
#                                                        ;;
#                                                6)
#                                                        #
#                                                        # user histnum [rootIcon]               time
#                                                        #
#                                                        prompt 'Black Lime sp user Grey39 @ host sp DarkBlue Tan sp hist sp White Maroon id'
#                                                        rprompt 'Black SeaGreen sp time sp '
#                                                        ;;
#                                                5)
#                                                        #
#                                                        # user histnum [rootIcon]
#                                                        #
#                                                        prompt 'Black Lime sp user sp DarkBlue Tan sp hist sp White Maroon id'
#                                                        rprompt -
#                                                        ;;
#                                                4)
#                                                        #
#                                                        # user@sys parent/dir histnum rootSym         [viIcon] [retCode] [VCS] [lock] date time
#                                                        #
#                                                        pstr=''
#                                                        pstr+='Lime user Green @ host '
#                                                        pstr+='sp Grey74 dir2 '
#                                                        pstr+='sp White hist .'
#                                                        prompt -p
#
#                                                        rpstr=''
#                                                        rpstr+='Gold sp vi sp '
#                                                        rpstr+='Maroon sp Ret sp '
#                                                        rpstr+='Yellow sp vcs sp '
#                                                        rpstr+='Orange sp lock sp '
#                                                        rpstr+='Grey74 sp date sp '
#                                                        rpstr+='SeaGreen sp time sp '
#                                                        rprompt -p
#                                                        ;;
#                                                3)
#                                                        #
#                                                        # user@sys parent/dir histnum rootSym         [viIcon][retCode][GIT][lock] date time
#                                                        #
#                                                        pstr=''
#                                                        pstr+='Lime user Green @ host '
#                                                        pstr+='sp Grey74 dir2 '
#                                                        pstr+='sp White hist .'
#                                                        prompt -p
#
#                                                        rpstr=''
#                                                        rpstr+='Gold sp vi sp '
#                                                        rpstr+='Maroon sp Ret sp '
#                                                        rpstr+='Yellow sp Gitb sp '
#                                                        rpstr+='Orange sp lock sp '
#                                                        rpstr+='Grey74 sp date sp '
#                                                        rpstr+='SeaGreen sp time sp '
#                                                        rprompt -p
#                                                        ;;
#                                                2)
#                                                        #
#                                                        # user@sys time histnum rootSym
#                                                        #
#                                                        pstr=''
#                                                        pstr+='Lime user Green @ host '
#                                                        pstr+='sp Grey74 time '
#                                                        pstr+='sp White hist .'
#                                                        prompt -p
#
#                                                        rprompt -
#                                                        ;;
#                                                1)
#                                                        #
#                                                        # user@sys histnum rootSym
#                                                        #
#                                                        prompt 'Lime user sp White hist .'
#
#                                                        rprompt -
#                                                        ;;
#                                                *)
#                                                        #
#                                                        # false alarm - reset the preset prompt choice
#                                                        #
#                                                        CHOSEN_PRESET_PROMPT=${prevChoice}
#                                                        echo "Unrecognized prompt: '$1'"
#                                                        echo ""
#                                                        presetPromptHelp
#                                                        return 0
#                                                        ;;
#                                                esac
#                                                }
#                                        #
#                                        # start with a simple colored prompt
#                                        #
#                                        p $CHOSEN_PRESET_PROMPT

PROMPT_GIT_FORMAT="[%s]"
prompt blue user @ Blue host sp Gray1 time sp Yellow '[bash]' sp Gray3 hist Red Ret Orange Gitb White .
#prompt green user @ Green host sp Gray2 time sp White hist Red Ret Orange Gitb White .
#prompt green user @ Green host sp Red Ret White .


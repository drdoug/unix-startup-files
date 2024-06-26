#-=-=-=-=-=-=-=-=

#
# bashrc-colors
#
# playing with ANSI colors
#

COLORTABLE=~/.config/shells/colorTable

#
# determine is label over the given
# color should be bblack or white
#
function _isBackgroundDark
        {
        local i=$1

        if (( i == 4 || i == 12 ))
        then
                return 1
        fi

        if (( i >= 232 && i <= 243 ))
        then
                return 1
        fi

        if (( i <= 16 && i % 8 < 2 ))
        then
                return 1
        fi

        if (( i >= 17 && i <= 231 ))
        then
                (( i -= 16 ))
                if (( ( i % 6 * 11 + i / 6 % 6 * 14 + i / 36 * 10) < 58 ))
                then
                        return 1
                fi
        fi
        return 0
        }

declare -ga _colorNames
declare -gA _colorTable=( \
                        [Black]=0 [Maroon]=1   [Green]=2 [Olive]=3 \
                        [Navy]=4  [Magenta]=5  [Cyan]=6  [Silver]=7 \
                        [Grey]=8  [Red]=9      [Lime]=10 [Yellow]=11 \
                        [Blue]=12 [Fuchsia]=13 [Aqua]=14 [White]=15 \
                        )
_gotColors=''

#
# Read colors from local database.
#
function getColors
        {
        local i
        #local _color

        #
        # already retrieved, return now
        #
        if [[ ! -z $_gotColors ]];
        then
                return 0
        fi

        let i=1
        while read -r _color _index
        do
                _colorNames[$i]=$_color
                _colorTable[$_color]=$_index
                (( i++ ))
        done < "${COLORTABLE}"
        _gotColors=true

        if (( $i == 1 ))
        then
                _colorNames=("Black" "Red" "Green" "Yellow" "Blue" "Purple" "Cyan" "White" "Grey")
                _colorTables=("0" "1" "2" "3" "4" "5" "6" "7" "236")
        fi
        }

#
# display colors with names and index numbers
#
function showcolors
        {
        local _color
        local _verbose=''

        getColors

        case $1 in
        -h )
                printf "%s\n\n" "Show available colors with names and index numbers for prompts."
                printf "%s\n" "Usage:"
                printf "%s\n" "       $0      display colors normally"
                printf "%s\n" "       $0 -h   display this message"
                printf "%s\n" "       $0 -v   display colors spread out for effect"
                return 0
                ;;
        -v )
                _verbose=true
                ;;
        esac

        #for (( _index=0; _index<=${#_colorTable[@]}; _index++ ))
        for _index in {0..255} ;
        do
                let fgrd=16

                _isBackgroundDark $_index
                err=$?
                if (( $err != 0 ))
                then
                        (( --fgrd ))
                fi

                let i=$_index+1
                #_color=${!_colorTable[$_index]}
                _color=${_colorNames[$i]}

                printf "$(tput setaf ${fgrd})$(tput setab ${_index}) %16.16s [%3d] $(tput sgr0) " $_color ${_colorTable[$_color]}
                #printf "$(tput setaf ${fgrd})$(tput setab ${_index}) %16.16s [%3d] $(tput sgr0) " $_color $_index
                if (( _index == 7 )) || (( _index == 15 )) || ( (( _index > 15 )) && (( (_index-15) % 6 == 0 )) );
                then
                        printf "$(tput sgr0)\n";
                        if [[ ! -z $_verbose ]];
                        then
                                printf "\n"
                        fi
                fi
        done
        }

function setColors
        {

        #
        # Note: MacOS 'ls' uses different colors, see below
        # Color Specification codes, concatenated to tag assignment:
        #       38;5;0 to 38;5;255 for 88-color and 256-color modes foreground colors
        #       48;5;0’ to ‘48;5;255’ for 88-color and 256-color modes background colors.
        #           (use showcolors command, defined above)
        #   Example, 'fi=38;5;228' shows Khaki file names when added to LS_COLORS 
        #       1 for bold,
        #       4 for underline,
        #       5 for blink,
        #       7 for inverse,
        #
        #       39 for default foreground color
        #       30 to 37 for foreground colors:
        #           Black       30
        #           DarkRed     31
        #           DarkGreen   32
        #           DarkYellow  33
        #           DarkBlue    34
        #           DarkMagenta 35
        #           DarkCyan    36
        #           Gray        37
        #       90’ to ‘97’ for 16-color mode foreground colors:
        #           DarkGray    90
        #           Red         91
        #           Green       92
        #           Yellow      93
        #           Blue        94
        #           Magenta     95
        #           Cyan        96
        #           White       97
        #       49 for default background color
        #       40 to 47 for background colors:
        #           Black       40
        #           DarkRed     41
        #           DarkGreen   42
        #           DarkYellow  43
        #           DarkBlue    44
        #           DarkMagenta 45
        #           DarkCyan    46
        #           Gray        47
        #       100 to 107 for 16-color mode background colors:
        #           DarkGray    100
        #           Red         101
        #           Green       102
        #           Yellow      103
        #           Blue        104
        #           Magenta     105
        #           Cyan        106
        #           White       107
        #

        #
        # Grep tags:
        #       sl=     selected lines
        #       cx=     whole context lines
        #       rv      bool to reverse sl and cx
        #       mt=     matching text (default 0;31 red)
        #       ms=     matching selected line's text (default 0;31 red)
        #       mc=     matching context line's text (default 0;31 red)
        #       fn=     file name (default 35 magenta)
        #       ln=     line numbers (default 32 green)
        #       bn=     byte number (default 32 green)
        #       se=     separators (default 36 cyan)
        #

        #
        # color definitions for 'ls', 'grep' and autocompletion
        #
        newlist color LS_COLORS -e

        addcolor 'no=00'
        #
        # system criteria
        #
        addcolor 'fi=38;5;226'          # file

        addcolor 'bd=00;91'             # block device
        addcolor 'ca=00;91'             # capabilities have been set (?)
        addcolor 'cd=38;5;198'          # character device
        addcolor 'di=01;95'             # directory
        addcolor 'do=01;35'             # Solaris DOOR
        addcolor 'ex=01;32'             # executable
        addcolor 'ln=01;36'             # link (hard or symbolic)
        addcolor 'mh=00'                # multiple hard links exist
        addcolor 'or=40;31;01'          # orphan - symlink to nowhere
        addcolor 'ow=04;01;32'          # other-writable (002) and not sticky
        addcolor 'tw=04;01;32'          # other-writable (002) and sticky
        addcolor 'pi=40;33'             # named pipe or fifo
        addcolor 'rs=0'                 # reset code (?)
        addcolor 'sg=30;43'             # set GID bit set
        addcolor 'so=01;35'             # socket endpoint
        addcolor 'st=37;44'             # sticky bit
        addcolor 'su=37;41'             # set UID bit set
        #
        # filename criteria (alphabetic)
        #
        addcolor '*.bmp=00;35'          # BMP image file (Bitmap Image File)
        addcolor '*.cpio=00;31'         # CPIO file package
        addcolor '*.csh=00;32'          # C-shell script
        addcolor '*.doc=00;35'          # Microsoft Word Document
        addcolor '*.docx=00;35'         # Microsoft Word Document
        addcolor '*.gif=00;35'          # GIF image file (Graphics Interface Format)
        addcolor '*.gz=00;31'           # GNU compressed file (gzip)
        addcolor '*.jpg=00;35'          # JPEG image file (Joiint Photographic Experts Group)
        addcolor '*.png=00;35'          # Portable Network Graphics file
        addcolor '*.ppt=00;35'          # Microsoft PowerPoint Document
        addcolor '*.pptx=00;35'         # Microsoft PowerPoint Document
        addcolor '*.rpm=00;31'          # RedHat package manager
        addcolor '*.sh=00;32'           # shell script
        addcolor '*.tar=00;31'          # tar file (Tape ARchive)
        addcolor '*.tgz=00;31'          # compressed tar file (gzipped tar)
        addcolor '*.tif=00;35'          # TIFF file (Tag Image File Format)
        addcolor '*.tz=00;31'           # compressed tar file
        addcolor '*.xbm=00;35'          # X Bitmap File (X11 windowing system)
        addcolor '*.xls=00;35'          # Microsoft Excel Document
        addcolor '*.xlsx=00;35'         # Microsoft Excel Document
        addcolor '*.xpm=00;35'          # X Pixmap File (X11 windowing system)
        addcolor '*.zip=00;31'          # compressed file (zip)

        case "$OSTYPE" in
                "Linux")
                        #
                        # See if we can be more specific about the distribution
                        #
                        if [[ -r "/etc/os-release" ]];
                        then
                                SYS_SPECIFIC=$(grep '^ID='<"/etc/os-release"|sed -e 's/^ID=\(.*\)/\1/')
                        else
                                SYS_SPECIFIC=Linux
                        fi
                        #
                        # check for the GNU version of ls
                        #
                        if [[ $USECOLOR = "true" ]];
                        then
                                "grep" "--version" 2>&1|grep GNU>/dev/null
                                err=$?
                                if (( $err == 0 ))
                                then
                                        export GREP_COLORS='mt=38;5;46:fn=38;5;200:ln=38;5;11'
                                        alias grep='grep --color=auto'
                                fi

                                "ls" "--version" 2>&1|grep GNU>/dev/null
                                err=$?
                                if (( $err == 0 ))
                                then
                                        #
                                        # set defaults for GNU 'ls' colors on black background
                                        #
                                        alias ls='ls --color=auto -F'
                                fi
                        else
                                unalias ls   &>/dev/null
                                unalias grep &>/dev/null
                        fi
                        ;;
                "Darwin")
                        SYS_SPECIFIC="MacOS"

                        #
                        # check for grep and ls colorization
                        #
                        if [[ $USECOLOR = "true" ]];
                        then
                                #
                                # LSCOLORS unknown in zsh
                                #
                                export GREP_COLORS='mt=38;5;46:fn=38;5;200:ln=38;5;11'
                                alias grep='grep --color=auto'

                                #
                                # MacOS Filesystem Entry Attributes
                                #   Position    Purpose
                                #       1       Directory
                                #       2       symbolic link
                                #       3       socket
                                #       4       named pipe
                                #       5       executable
                                #       6       block device
                                #       7       character device
                                #       8       executable with set UID
                                #       9       executable with set GID
                                #      10       Directory other-writable (002) with sticky bit
                                #      11       Directory other-writable (002) without sticky bit
                                #
                                # MacOS Color Attributes (foreground first, background second)
                                #            (eg 'Cx' yields Bold Green on default background)
                                #   Code        Color
                                #     a         Black
                                #     b         Red
                                #     c         Green
                                #     d         Brown
                                #     e         Blue
                                #     f         Magenta
                                #     g         Cyan
                                #     h         Light Grey
                                #     A         Dark Grey
                                #     B         Bold Red
                                #     C         Bold Green
                                #     D         Bold Brown (Yellow)
                                #     E         Bold Blue
                                #     F         Bold Magenta
                                #     G         Bold Cyan
                                #     H         Bright White
                                #     x         Default
                                #
                                export LSCOLORS="CxgxGxGxDxAxhxBxBxBxBx"

                                alias ls='ls --color=auto -F'
                        else
                                unalias ls &>/dev/null
                        fi
                        ;;
                *)
                        SYS_SPECIFIC=''
                        ;;
        esac
        }


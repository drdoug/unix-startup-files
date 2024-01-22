#-=-=-=-=-=-=-=-=

#
# bashrc-git
#
# git support for xterm, prompts and setup
#

function _git-ahead-behind
        {

        curr_branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null);
        curr_remote=$(git config branch.$curr_branch.remote 2>/dev/null);
        curr_merge_branch=$(git config branch.$curr_branch.merge 2>/dev/null|cut -d / -f 3);
        git rev-list --left-right --count $curr_branch...$curr_remote/$curr_merge_branch 2>/dev/null|tr -s '\t' '|';
        }

function git-branch-name
        {

        git branch 2>/dev/null|sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
        }

function git-branch
        {
        GITBRANCH=$(git-branch-name)
        if [[ "$GITBRANCH" = "" ]];
        then
                GITBRANCH="no repo"
        fi
        printf "$GITBRANCH"
        }

function git-offset
        {
        GITBRANCH=$(git-branch-name)
        if [[ "$GITBRANCH" = "" ]];
        then
                GITOFFSETS="0|0"
        else
                GITOFFSETS=$(_git-ahead-behind)
        fi
        printf "$GITOFFSETS"
        }

function git-text
        {
        GITBRANCH=$(git-branch-name)
        if [[ "$GITBRANCH" = "" ]];
        then
                GITBRANCH="no repo"
                GITOFFSETS="0|0"
        else
                GITOFFSETS=$(_git-ahead-behind)
        fi
        printf "[$GITBRANCH $GITOFFSETS]"
        }

function git-setup
        {
        git config --global user.name 'drdoug'
        git config --global user.email 'drdoug@mimeticsystems.com'
        }

function git-slac
        {
        git config --global user.name 'Doug Murray'
        git config --global user.email 'drm@slac.stanford.edu'
        }

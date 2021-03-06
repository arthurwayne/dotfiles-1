# ~/.bashrc: executed by bash(1) for non-login shells.

alias p="cd .."
alias pp="p;p"
alias ppp="pp;p"
alias pppp="ppp;p"
alias ppppp="pppp;p"
alias pppppp="ppppp;p"
alias ppppppp="pppppp;p"
alias sshu="ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
alias scpu="scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
alias serve="python -m SimpleHTTPServer"
alias json="python -m json.tool"
alias im="git"
alias viim="vim -n" #vim with no swap file
alias same="fgrep -x -f"
function m {
    OLDIFS="$IFS"
    IFS=$(echo -en "\n\b")
    declare -a arr=("mp3" "flac" "m4a" "mkv" "avi" "mp4" "wav" "ogg")
    for ext in "${arr[@]}"; do
        for file in *.$ext; do
            if [ $file != "*.$ext" ]; then
                mpv *.$ext
                break
            fi
        done
    done
    IFS="$OLDIFS"
}
alias plo="p;lo"
alias polo="plo"

alias cls="clear;ls"

function fuck() {
    killall -9 "$2";
    if [ $? == 0 ]; then
        echo " (╯°□°）╯︵    $(echo $2|flip &2>/dev/null)"
    fi
}

## Git-Commit-Push
function gcp {
    CMD="gcp"
    MSG="'some commit message'"
    REMOTE="origin"
    BRANCH="master"
    TXT="Usage: $CMD $MSG\n       $CMD $MSG $BRANCH\n       $CMD $MSG $REMOTE $BRANCH"
    if [ $# -lt 1 ] || [ $# -gt 3 ] || ([ $# == 1 ] && [ "$1" == "--help" -o "$1" == "-h" ]); then
        echo -e "$TXT"
    elif [ $# == 3 ]; then
        git commit -a -m "$1"
        git push $2 $3
    elif [ $# == 2 ]; then
        gcp "$1" $REMOTE $2
    elif [ $# == 1 ]; then
        gcp "$1" $BRANCH
    fi
}

alias gap="gcp" #gap is easier to type :p
alias poop="gcp" #and poop is funny

# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

#jump and mark
export MARKPATH=$HOME/.marks
function jump {
    cd -P $MARKPATH/$1 2>/dev/null || echo "No such mark: $1"
}
function mark {
    mkdir -p $MARKPATH; ln -s $(pwd) $MARKPATH/$1
}
function unmark {
    rm $MARKPATH/$1
}
function marks {
    ls -l $MARKPATH | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -t/\t-/g' && echo
}
alias jp="jump"
alias mk="mark"
_completemarks() {
  local curw=${COMP_WORDS[COMP_CWORD]}
  local wordlist=$(gfind $MARKPATH -type l -printf "%f\n")
  COMPREPLY=($(echo $(compgen -W '${wordlist[@]}' -- "$curw")/))
  return 0
}

complete -F _completemarks jump unmark jp mk

#color ls
alias ls="ls -G"
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"


alias lsgit="git ls"
alias lsg="lsgit"

alias clsg="clear;lsg"

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    #PS1='$debian_chroot\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PS1='$debian_chroot\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='$debian_chroot\u:\w\$ '
fi
unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias lo='ls -t | tail -r'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#    . /etc/bash_completion
#fi

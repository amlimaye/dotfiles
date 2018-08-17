#.bashrc

# Source /etc/bashrc, which on CentOS implies sourcing /etc/profile.d/*.sh
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Initialize the garden in-shell function
# eval "$(/usr/bin/garden-exec)"

#personalized things start here --

#make a bunch of aliases
alias rm='/bin/rm -i'
alias mv='/bin/mv -i'
alias cp='/bin/cp -i'
alias ls='/bin/ls --color'
alias ll='ls -l'
alias vi='vim'
alias less='less -S'
alias hg='history | grep'
alias gst='git status'
alias gl='git log'
alias glp='git log --pretty=oneline'
alias ga='git add'
alias gd='git diff'
alias l='ls'
alias wcl='wc -l'
alias k="kill"
alias ipython="ipython --TerminalInteractiveShell.editing_mode=vi"

#trick out shell prompt
export PS1="\n\\[$(tput setaf 6)\\]\u@\h \\[$(tput sgr0)\\]\\[$(tput setaf 3)\\]\w\\[$(tput sgr0)\\]\n$ "

#expand history calls like !XX so I can edit them before executing again
shopt -s histverify

#turn on vi mode
set -o vi

#remap keys
xmodmap ~/.Xmodmap

#easy git commits
function gcm () {
    git commit -m "$*"
}

#make eog stop spewing stuff to the terminal
function eog () {
    /usr/bin/eog "$@" &> /dev/null &
}

#kill shell-managed jobs easily
function kj () {
    for jobnum in "$@"
    do
        kill %${jobnum}
    done
}

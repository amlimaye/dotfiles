#.bashrc

# this is so that binaries installed by homebrew get used before the ones in /usr/bin
export PATH="/usr/local/bin:$PATH"

# and include MATLAB in the path
export PATH="$PATH:/Applications/MATLAB_R2018a.app/bin"

# include VMD in the path. that bin directory is a hacked bin I made myself
# that just has a symlink to the binary above
export PATH="$PATH:/Applications/VMD 1.9.3.app/Contents/vmd/bin"

#make a bunch of aliases

# useful for editing and sourcing bash_profile
alias vibp='vi ~/.bash_profile'
alias sbp='source ~/.bash_profile'

# make rm, mv, cp ask before doing destructive things
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

# this one merits some explanation. -G = colored output, -p = slashes after directories, -F = * after exec, | after pipe, @ after symlinks, etc., -h = human-readable size units
alias ls='ls -GpFh'
alias ll='ls -l'
alias l='ls'

# because who wants old-school vi?
alias vi='vim'

# alias MATLAB to not start the GUI
alias matlab='matlab -nodesktop'

# alias gimp
function gimp() {
    /Applications/GIMP-2.10.app/Contents/MacOS/gimp "$@" &> /dev/null&
}

# make vmd shut up
alias vmd='vmd 2>/dev/null'

# alias avogadro
alias avogadro='/Applications/Avogadro2.app/Contents/MacOS/Avogadro2'

# the brew-installed macvim uses a script called mvim to run the gui. i'm used to saying gvim.
alias gvim="mvim"
alias gvimd="mvim& disown;"

# use "py" as the alias for python3
alias py="python3"

# system things shouldn't use pip, so i feel safe aliasing "pip"->"pip3"
alias pip="pip3"

# log into athena
alias athena="ssh -K -l amlimaye athena.dialup.mit.edu"

# log into xsede
alias xsede="ssh -l amlimaye login.xsede.org"

# get a Kerberos ticket using my keytab file
alias ktkinit="kinit -k -t ~/.kerberos.keytab amlimaye@ATHENA.MIT.EDU"

# chop long lines when using less
alias less='less -S'
alias hg='history | grep'

# useful git aliases
alias gst='git status'
alias gl='git log'
alias glp='git log --pretty=oneline'
alias ga='git add'
alias gd='git diff'

# some other useful things
alias wcl='wc -l'
alias k="kill"
alias ipython="ipython --TerminalInteractiveShell.editing_mode=vi"

#trick out shell prompt
export PS1="\n\\[$(tput setaf 6)\\]\u@\h \\[$(tput sgr0)\\]\\[$(tput setaf 3)\\]\w\\[$(tput sgr0)\\]\n$ "

#expand history calls like !XX so I can edit them before executing again
shopt -s histverify

#turn on vi mode
set -o vi

#make default editor vim
export EDITOR=vim

#easy git commits
function gcm () {
    git commit -m "$*"
}

function cometscp () {
    scp amlimaye@comet-ln2.sdsc.edu:/home/amlimaye/$1 .
}

#kill shell-managed jobs easily
function kj () {
    for jobnum in "$@"
    do
        kill %${jobnum}
    done
}

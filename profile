################################################################################
## ~/.profile

## ┬─┐┬─┐┌┐┐┬ ┬
## │─┘│─┤ │ │─┤
## │  ┘ │ │ │ ┴
########## PATH

# GENERAL
PATH=$PATH:/usr/local/bin:/usr/local/sbin:/usr/local/games:/usr/games:/usr/sbin:/sbin:$HOME/g/scripts:$HOME/x/scripts
MANPATH=$MANPATH:/usr/local/share/man/
# TEXLIVE
PATH=/usr/local/texlive/2012/bin/i386-linux:$PATH; export PATH
MANPATH=/usr/local/texlive/2012/texmf/doc/man:$MANPATH; export MANPATH
INFOPATH=/usr/local/texlive/2012/texmf/doc/info:$INFOPATH; export INFOPATH

## ┬─┐┬─┐┌─┐┌┌┐┬─┐┌┐┐
## │─┘│┬┘│ │││││─┘ │ 
## │  │└┘┘─┘┘ ││   │ 
############## PROMPT

PS1="]" # bold: "\[\033[1;37m\]]\[\033[00m\]"

## ┬─┐┐ │┬─┐┌─┐┬─┐┌┐┐┐─┐
## ├─ ┌┼┘│─┘│ ││┬┘ │ └─┐
## ┴─┘│ └│  ┘─┘│└┘ │ ──┘
################ EXPORTS

export TERM="vt100"
export EDITOR="vim"
export SUDO_EDITOR="vim"
export PAGER=less
export IRCSERVER=irc.freenode.net
export HISTCONTROL=ignoreboth
export HISTSIZE=10000
export HISTFILESIZE=10000
export PDFVIEWER=xpdf
export NNTPSERVER=snews://news.eternal-september.org:563

## ┬─┐┬  o┬─┐┐─┐┬─┐┐─┐
## │─┤│  ││─┤└─┐├─ └─┐
## ┘ │└─┘│┘ │──┘┴─┘──┘
############## ALIASES

# COREUTILS
alias ls='ls --classify --tabsize=0 --literal --color=none --show-control-chars --human-readable'
alias l='ls -CF --color=none'
alias ll='ls -kl --color=none'
alias la='ls -a'
alias lla='ls -kla --color=none'
alias lslist='ls -RClS'
alias lsi='ls -1si'
alias rm='rm -v'
alias srm='srm -vv --interactive'
alias df='df --human-readable'
alias mkdir='mkdir -v'
alias s='cd ..'
alias chmod='chmod -v'

# OTHERS
alias reload='source ~/.profile'
alias exit='history -a && exit'
alias c='clear'
alias less='less -z-2 -XFM'
alias zless='zless -z-2 -XPM".?ltlines %lt-%lb?L/%L. .byte %bB?s/%s. ?e(END) :?pB%pB\%..%t"'
alias grep='grep --color=none'
alias egrep='egrep --color=none'
alias rezo='sudo watch netstat -alpe --ip'
alias lastkernelvers="curl -Ss -k https://www.kernel.org/finger_banner 2>&1"
alias slrn="slrn -C-"

# FORTUNE COOKIES
alias xfiles="fortune ~/.fortunes/xfiles"
alias hitchhiker="fortune ~/.fortunes/hitchhiker"
alias fgump="fortune ~/.fortunes/fgump"
alias starwars="fortune ~/.fortunes/starwars"
alias chalkboard="fortune ~/.fortunes/chalkboard"
alias bashfr="fortune ~/.fortunes/bashfr"
alias nethackcookies="fortune ~/.fortunes/nethackcookies"
alias kaamelott="fortune ~/.fortunes/kaamelott"
alias droit="fortune ~/.fortunes/droit"

# FUNZ AND GAMES
alias starwars_telnet='telnet towel.blinkenlights.nl'
alias hak5='telnet bbs.hak5.org'
alias nethack_t='telnet nethack.alt.org'
alias sl='sl -a'
alias myip='curl ifconfig.me'

## ┬─┐┬ ┐┌┐┐┌─┐┌┐┐o┌─┐┌┐┐┐─┐
## ├─ │ │││││   │ ││ ││││└─┐
## │  └─┘ └┘└─┘ │ │┘─┘ └┘──┘
################## FUNCTIONS

# VERBOSE CD
cd ()
{
   builtin cd "$@"
   echo "directory changed to $PWD"
}

## ┬ ┐┌┌┐┬─┐┐─┐┬┌ 
## │ │││││─┤└─┐├┴┐
## └─┘┘ │┘ │──┘│ ┘
############ UMASK

#umask 077

## ┌┌┐o┐─┐┌─┐┬─┐┬  ┬  ┬─┐┌┐┐┬─┐┌─┐┬ ┐┐─┐
## ││││└─┐│  ├─ │  │  │─┤│││├─ │ ││ │└─┐
## ┘ ││──┘└─┘┴─┘└─┘└─┘┘ │ └┘┴─┘┘─┘└─┘──┘
########################## MISCELLANEOUS

# USE BASH-COMPLETION, IF AVAILABLE
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

# BLOCK CURSOR
echo -e '\033[?6c'

################################################################################
## ~/.profile

## ┬─┐┬─┐┌┐┐┬ ┬
## │─┘│─┤ │ │─┤
## │  ┘ │ │ │ ┴
########## PATH

# GENERAL
PATH=$PATH:/usr/local/bin:/usr/local/sbin:/usr/local/games:/usr/games:/usr/sbin:/sbin:$HOME/e/
MANPATH=$MANPATH:/usr/local/share/man/
# TEXLIVE
PATH=/usr/local/texlive/2012/bin/i386-linux:$PATH; export PATH
MANPATH=/usr/local/texlive/2012/texmf/doc/man:$MANPATH; export MANPATH
INFOPATH=/usr/local/texlive/2012/texmf/doc/info:$INFOPATH; export INFOPATH

## ┬─┐┬─┐┌─┐┌┌┐┬─┐┌┐┐
## │─┘│┬┘│ │││││─┘ │ 
## │  │└┘┘─┘┘ ││   │ 
############## PROMPT

PS1="\[\033[1;37m\]]\[\033[00m\]"

## ┬─┐┐ │┬─┐┌─┐┬─┐┌┐┐┐─┐
## ├─ ┌┼┘│─┘│ ││┬┘ │ └─┐
## ┴─┘│ └│  ┘─┘│└┘ │ ──┘
################ EXPORTS

export TERM="vt100"
export EDITOR=zile
export SUDO_EDITOR="emacsclient -c -a emacs"
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
alias lsd='ls -Alktr --color=none'
alias lsn='ls -Alktrn --color=none'
alias lslist='ls -RClS'
alias lsi='ls -1si'
alias mv='/usr/local/bin/patch-mv -g -v --interactive'
alias cp='/usr/local/bin/patch-cp -g -v --interactive'
alias rm='rm -v'
alias srm='srm -vv --interactive'
alias df='df --human-readable'
alias mkdir='mkdir -v'
alias s='cd ..'
alias chmod='chmod -v'

# URXVT IN COLORS
alias urxvt_black='urxvt -bg black'
alias urxvt_purple='urxvt -bg "#300a24"'
alias urxvt_lblue='urxvt -bg "#264141"'
alias urxvt_blue='urxvt -bg "#001b33"'
alias urxvt_rblue='urxvt -bg "rgb:00/00/a8"'
alias urxvt_green='urxvt -bg "#1C3623"'

# OTHERS
alias startx='startx -- -dpi 96 -nolisten tcp'
alias x='startx'
alias reload='source ~/.profile'
alias exit='history -a && exit'
alias bye='exit'
alias c='clear'
alias less='less -z-2 -XFM'
alias zless='zless -z-2 -XPM".?ltlines %lt-%lb?L/%L. .byte %bB?s/%s. ?e(END) :?pB%pB\%..%t"'
alias most='most -C'
alias more='more -d'
alias filelisting='figlet -f computer "file listing" | sed '1d' > \[0000\]_file_listing.txt && ls -1si >> ls-i.txt'
alias logmess='sudo tail -f /var/log/messages /var/log/vsftpd.log /usr/local/nginx/logs/access.log /usr/local/nginx/logs/error.log /home/illovae/.mpdscribble/mpdscribble.log /var/log/icecast2/access.log'
#alias mutt='mutt -y'
alias grep='grep --color=none'
alias egrep='egrep --color=none'
alias rezo='sudo watch netstat -alpe --ip'
alias linux_logo='linux_logo -F "#O #V\n#ECompiled #C\n#N #M #T #R\n#T #P\n#H #U"'
#alias xlock="xlock -mode space -font "-*-terminus-*-*-*-*-14-*-*-*-*-*-*-*" -bg black -fg white"
alias psm='ps gaxo %cpu,%mem,pid,comm | sort +0nr | head -n 10'
alias rss="rsstail -tlpaHv"
alias lastkernelvers="curl -Ss https://www.kernel.org/finger_banner 2>&1"
alias alsamixer="alsamixer -g"
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
alias playchess='xboard -fcp "gnuchess depth 1 --easy --xboard" -boardSize Slim -showCoords true -highlightLastMove true -flashCount 3 -flashRate 5 -showButtonBar false -titleInWindow true -showThinking true -ponderNextMove false'
alias playcrafty='xboard -fcp "crafty xboard sd=4 sn=100000 ponder=off book=off"'
alias playfisc='xboard -ics -icshost freechess.org'
alias doom='prboom -nomusic -iwad ~/m/IWADs/DOOM/DOOM.WAD'
alias doom2='prboom -nomusic -iwad ~/m/IWADs/DOOM2/DOOM2.WAD'
alias doomlep='prboom -nomusic -iwad ~/m/IWADs/DOOM/DOOM.WAD -file ~/m/IWADs/DOOMLEP/JPTR_V40.WAD'
alias plutonia='prboom -nomusic -iwad ~/m/IWADs/PLUTONIA/plutonia.wad'
alias tnt='prboom -nomusic -iwad ~/m/IWADs/TNT/tnt.wad'
alias quake1='nq-x11 -width 800 -height 600 -fullscreen'
alias tuxnes='tuxnes -E -S'
alias sl='sl -a'
alias myip='curl ifconfig.me'

# FUNZ FROM INTERNET
alias commandlinefu="wget -qO - http://www.commandlinefu.com/commands/random/plaintext | sed -n '1d; /./p'"
alias xkcd='feh $(lynx -nolist -dump http://xkcd.com/|grep "imgs.xkcd.com/comics/")'
alias dilbert='feh $(wget -q -O - http://dilbert.com |grep STR_EmbedCode |cut -d "\"" -f12)'
alias bonjourmadame='feh $(wget -q -O - http://www.bonjourmadame.fr | grep -Eo "(http://[0-9]+.media.tumblr.com/[^\"]+.jpg)" |head -n 1)'

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

# EMACS-W3M FROM CLI
emacs-w3m(){ emacsclient -e "(w3m \"$@\")";}

# KILL EMACS FROM CLI
emacs-kill(){ emacsclient --e "(progn (setq kill-emacs-hook \'nil) (kill-emacs))";}

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

# SOURCE
source ~/.radio

# BLOCK CURSOR
echo -e '\033[?6c'

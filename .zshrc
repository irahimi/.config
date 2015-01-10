#!/bin/zsh

#Completion Styles
zstyle ':completion:*' list-colors ${(s.:.)LSCOLORS}
zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' group-name ''
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._- ]=* r:|=*' 'r:|[._-]=* r:|=* l:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*' menu select
zstyle ':completion:*' select-prompt %S%p %s
zstyle ':completion:*' use-compctl true
zstyle :compinstall filename '/Users/irahimi/.zshrc'
autoload -Uz compinit
compinit

autoload -U edit-command-line
zle -N edit-command-line

#History
HISTFILE=~/.zhist
HISTSIZE=1000
SAVEHIST=1000

#Shell options
setopt SHARE_HISTORY INC_APPEND_HISTORY HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE
setopt AUTO_CD CD_ABLE_VARS
setopt MULTIOS EXTENDED_GLOB NOTIFY CLOBBER NO_HUP FUNCTION_ARG_ZERO RM_STAR_SILENT NO_BEEP NO_MATCH
setopt LIST_TYPES SHORT_LOOPS
setopt INTERACTIVE_COMMENTS

#Key bindings
bindkey -v #be like vi
bindkey -M viins -R '^@-^?' self-insert
bindkey -M viins '^I'  expand-or-complete
bindkey -M viins '^M'  accept-line
bindkey -M viins '^H'  vi-backward-delete-char
bindkey -M viins '^?'  vi-backward-delete-char
bindkey -M viins '^L'  clear-screen
bindkey -M viins '^['  vi-cmd-mode
bindkey -M viins '^U'  push-input
bindkey -M viins '^A'  beginning-of-line
bindkey -M viins '^E'  end-of-line
bindkey -M viins '^[.' insert-last-word
bindkey -M viins '^R'  history-incremental-search-backward
bindkey -M viins '^S'  history-incremental-search-forward
bindkey -M viins '^P'  history-search-backward
bindkey -M viins '^N'  history-search-forward

# Prompt Building
autoload -U colors
if [[ "$terminfo[colors]" -gt 8 ]]; then
    colors
fi
RESET="$reset_color"

PROMPT="%{$fg[green]%}"                         # Prompt defaults to green
PROMPT=$PROMPT"[%n@%m:"                         # Username and hostname
PROMPT=$PROMPT"%{$fg_bold[cyan]%}%1~%{$RESET%}"  # Working directory
PROMPT=$PROMPT"%{$fg[green]%}][%(?.%{$fg[green]%}.%{$fg_bold[red]%})%?%{$fg[green]%}]"             # Return code of last command
PROMPT=$PROMPT"%#%{$RESET%} "                   # $ for user and # for root
export PROMPT

RPROMPT="%{$fg[magenta]%}[%W %*]%{$RESET%}"
TMOUT=1
TRAPALRM() { zle reset-prompt }
export RPROMPT

#export LANG=en_US.UTF8
#export LC_ALL=en_US.UTF8
export PATH=~/.bin:~/.brew/bin:~/.brew/sbin:/usr/local/bin:/usr/texbin:~/.cabal/bin:$PATH

export MANPATH=~/.brew/share/man:$MANPATH
export GOPATH=~/Projects/Go
export EDITOR="vim"
export PAGER="vimpager"
export CLICOLOR=1
export LSCOLORS="gxbxDxDxfxexexBxBxGxGx"
export PYTHONSTARTUP="/Users/irahimi/.pythonrc"

alias tac="sed -n '1!G;h;\$p'"
alias hist="history"
alias lsl="CLICOLOR_FORCE=1 ls -OhpF@"

postcmd () { stty sane }
load () { uptime | awk -F "load averages:" '{ print $2 }' }
battery () { ioreg -l | grep -i capacity | tr '\n' ' | ' | awk '{printf("%.2f%%", $10/$5 * 100)}'; echo }
man2pdf() { man -t $1 | open -f -a /Applications/Preview.app }
up() { for updirs in $(gseq ${1:-1}); do cd ..; done }
c () { autoload -U zcalc;zcalc }
qlook() { qlmanage -p "$@" >& /dev/null; };
todo() { vim ~/.todo }
icns2png() { sips -s format png $1 --out $(echo $1 | sed "s/icns/png/g") }
ccal() { \cal $@ | sed -E "s/(^|[^0-9])($(date +%e))( |$)/\1$(echo -e "\033[0;36m\2\033[0m")\3/" }
find-book() { mdfind -onlyin ~/Documents/Books/ $@ }
albumart() { curl -s "http://www.albumart.org/index.php?searchk=`mpc | head -n1 | tr ' ' '+'`&itempage=1&newsearch=1&searchindex=Music" | python -c "import sys; from lxml.etree import parse, HTMLParser; print parse(sys.stdin, HTMLParser()).xpath('//div[@id=\'main_left\']/ul/li/div/a/img/@src')[0]" }

stty -ixany
stty ixon
stty sane
pr -m -t -w $COLUMNS ~/.motd <(archey -c)

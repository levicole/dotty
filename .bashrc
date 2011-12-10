# ~/.bashrc
# vim:set ft=sh sw=2 sts=2:
stty -ixon
source "$HOME/.hashrc"

VISUAL=vim
EDITOR="$VISUAL"
LESS="FRX"
RI="--format ansi -T"
TERM="xterm-256color"

export VISUAL EDITOR LESS RI

export CLICOLOR=1
export LSCOLORS=gxgxcxdxbxegedabagacad

export CLICOLOR LSCOLORS

function parse_git_deleted {
  [[ $(git status 2> /dev/null | grep deleted:) != "" ]] && echo "-"
}
function parse_git_added {
  [[ $(git status 2> /dev/null | grep "Untracked files:") != "" ]] && echo '+'
}
function parse_git_modified {
  [[ $(git status 2> /dev/null | grep modified:) != "" ]] && echo "*"
}
function parse_git_dirty {
  echo "$(parse_git_added)$(parse_git_modified)$(parse_git_deleted)"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/<\1$(parse_git_dirty)>/"
}

export PS1="\[\033[01;32m\]\u\[\033[00m\]:\[\033[1;35m\]\W\[\033[0;34m\] \$(parse_git_branch)\[\033[00m\]$ "

[ ! -f "/etc/bash_completion" ] || . "/etc/bash_completion"

[ ! -f "$HOME/.bashrc.local" ] || . "$HOME/.bashrc.local"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# ~/.bashrc
# vim:set ft=sh sw=2 sts=2:
stty -ixon

rails_root() {
  (
  dir=${1:-$(pwd)}
  i=0
  while [ "/" != "$dir" -a "$i" -ne 16 ]; do
    if [ -f "$dir/config/environment.rb" ]; then
      echo "$dir"
      return 0
    fi
    dir="$(dirname "$dir")"
    i=$(expr $i + 1)
  done
  return 1
  )
}

script_rails() {
  if [ -f "`rails_root`/script/rails" ]; then
    "`rails_root`/script/rails" "$@"
  else
    local name
    name="$1"
    shift
    "`rails_root`/script/$name" "$@"
  fi
}

twiki () {
  say -v Zarvox 'beedee-beedee-beedee'
  rake db:migrate && rake db:migrate:redo && rake db:test:prepare
}

VISUAL=vim
EDITOR="$VISUAL"
LESS="FRX"
RI="--format ansi -T"
TERM="xterm-256color"

export VISUAL EDITOR LESS RI TERM

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


LONG_PS1="\033[1;35m\]\W\e[0;33m\](\$(rvm-prompt))\033[0;34m\]\$(parse_git_branch)\[\033[00m\] $ "
MEDIUM_PS1='\[\033[1;35m\]\W\[\033[0;34m\]$(parse_git_branch)\[\033[00m\] $ '
SHORT_PS1="$(parse_git_dirty) $ "

export PS1=$MEDIUM_PS1

[ ! -f "/etc/bash_completion" ]  || . "/etc/bash_completion"


[ ! -f "$HOME/.bashrc.local" ] || . "$HOME/.bashrc.local"

[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh

alias gpr='git pull --rebase'
alias gd='git diff'
alias gdc='git diff --cached'
alias gst='git status'
alias lc='lev.io-client'
alias td='todo.sh'
alias geeknote='python $HOME/my/geeknote/geeknote.py'

function serveup {
  ruby -run -e  httpd -- -p 5000 $(pwd)
}

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

export GOPATH="$HOME/my/go"

PATH="/usr/local/share/python:/usr/local/bin:$PATH:$HOME/.rvm/bin:$HOME/my/go/bin" # Add RVM to PATH for scripting

[[ -s "$HOME/.levio" ]] && source "$HOME/.levio"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export PATH=$PATH:$HOME/my/android/adt-bundle-mac-x86_64/sdk/tools
export PATH=$PATH:$HOME/my/android/adt-bundle-mac-x86_64/sdk/platform-tools
export ANDROID_HOME=~/my/android/adt-bundle-mac-x86_64/sdk

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

complete -C /usr/local/bin/terraform terraform

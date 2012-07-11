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

# declare -r PROMPT_COMMAND="levi_prompt"

LONG_PS1="\033[1;35m\]\W\e[0;33m\](\$(rvm-prompt))\033[0;34m\]\$(parse_git_branch)\[\033[00m\] $ "
MEDIUM_PS1="\033[1;35m\]\W\033[0;34m\]\$(parse_git_branch)\[\033[00m\] $ "
SHORT_PS1="$(parse_git_dirty) $ "

levi_prompt () {
  current=`pwd`
  if [ -z $LPWD ]; then
    LPWD=`pwd`
    PS1=${LONG_PS1}
  else
    if [ "$LPWD" == "$current" ]; then
      PS1=${SHORT_PS1}
    else
      LPWD=`pwd`
      PS1=${LONG_PS1}
    fi
  fi
  export PS1=$PS1
}

export PS1=$MEDIUM_PS1

PROJ_DIR="$HOME/projects"

lcd()
{
  cd "$PROJ_DIR/$1"
}


_lcd()
{
  local cur projects

  COMPRELPY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  projects=$(\ls "$PROJ_DIR/")

  if [ $COMP_CWORD -eq 1 ]; then
    eval 'COMPREPLY=( $(compgen -o filenames -W "$projects" $cur) )'
  fi

  return 0
}

complete -o filenames -F _lcd lcd

[ ! -f "/etc/bash_completion" ]  || . "/etc/bash_completion"

[ ! -f "$HOME/.bashrc.local" ] || . "$HOME/.bashrc.local"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

# ~/.bashrc
# vim:set ft=sh sw=2 sts=2:
stty -ixon

VISUAL=vim
EDITOR="$VISUAL"
LESS="FRX"
RI="--format ansi -T"

export INPUTRC=~/.inputrc

export PATH="/usr/local/mysql/bin:$PATH"


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
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/(\1$(parse_git_dirty))/"
}
export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[00m\]\$(parse_git_branch)$ "

function chop(){
	CURRENT_BRANCH=$(git branch | grep '\*')
	git checkout ${1:-"master"} || exit 1
	git branch -d ${CURRENT_BRANCH:2}
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

if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then . "$HOME/.rvm/scripts/rvm"; fi
if [[ -s "$HOME/.aliases" ]]; then . "$HOME/.aliases"; fi

[ ! -f "$HOME/.bashrc.local" ] || . "$HOME/.bashrc.local"

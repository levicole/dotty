get_bundle() {
  git submodule add "git://github.com/$1/$2.git" ".vim/bundle/$2"
}

get_bundle duff vim-bufonly
get_bundle godlygeek tabular
get_bundle kchmck vim-coffee-script
get_bundle leshill vim-json
get_bundle mileszs ack.vim
get_bundle pangloss vim-javascript
get_bundle tpope vim-abolish
get_bundle tpope vim-bundler
get_bundle scrooloose nerdcommenter
get_bundle tpope vim-cucumber
get_bundle tpope vim-endwise
get_bundle tpope vim-eunuch
get_bundle tpope vim-fugitive
get_bundle tpope vim-git
get_bundle tpope vim-haml
get_bundle tpope vim-markdown
get_bundle tpope vim-pathogen
get_bundle tpope vim-rake
get_bundle tpope vim-ragtag
get_bundle tpope vim-rails
get_bundle tpope vim-repeat
get_bundle tpope vim-rsi
get_bundle tpope vim-sensible
get_bundle tpope vim-sleuth
get_bundle tpope vim-speeddating
get_bundle tpope vim-unimpaired
get_bundle tpope vim-surround
get_bundle vim-ruby vim-ruby
get_bundle vim-scripts bufkill.viml


git submodule update
vim -c 'call pathogen#helptags()|q'

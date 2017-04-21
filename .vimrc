execute pathogen#infect()

syntax on
filetype plugin indent on

let mapleader="\<Space>"

augroup vimrc
  autocmd!
  autocmd GuiEnter * set guifont=Monaco:h16 guioptions-=T columns=120 lines=70 number
augroup END

autocmd BufRead,BufNewFile *.hamlc setlocal filetype=haml
autocmd FileType go setlocal shiftwidth=4 tabstop=4 expandtab
autocmd FileType handlebars setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType asm setlocal shiftwidth=8 tabstop=8 expandtab

let g:mustache_abbreviations = 1

colorscheme afterglow

let NERDTreeHijackNetrw=0

let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

set number

set tags=./vtags,vtags,./tags,tags

let g:rails_ctags_arguments=["-o ctags"]

autocmd User Rails Rnavcommand sass app/stylesheets -glob=**/* -suffix=.sass
autocmd User Rails Rnavcommand feature features -suffix=.feature
autocmd User Rails Rnavcommand factory spec/factories -default=model() -suffix=_factory.rb
autocmd User Rails Rnavcommand admin app/admin -suffix=_admin.rb -default=model()
autocmd User Rails Rnavcommand worker app/workers -suffix=_worker.rb -default=model()

map <leader>] :bnext<CR>
map <leader>[ :bprevious<CR>

imap dt5 <!DOCTYPE html>

noremap ,s :source ~/.vimrc.local

let g:unite_winwidth = 40
let g:unite_enable_start_insert = 1

call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <C-p> :Unite file_rec/async<cr>

let g:racer_cmd = "/Users/levicole/.cargo/bin/racer"
let $RUST_SRC_PATH="/Users/levicole/rust-src/src"

let g:jsx_extension_required = 0

let g:projectionist_heuristics = {
      \ "mix.exs": {
      \     "lib/*.ex": {
      \       "type": "lib",
      \       "alternate": "test/{}_test.exs",
      \       "template": [
      \         "defmodule {camelcase|dot} do",
      \         "  @moduledoc \"\"\"",
      \         "  \"\"\"",
      \         "end"
      \       ]
      \     },
      \     "test/*_test.exs": {
      \       "type": "test",
      \       "alternate": "lib/{}.ex",
      \       "template": [
      \         "defmodule {camelcase|dot}Test do",
      \         "  use ExUnit.Case",
      \         "end"
      \       ]
      \     },
      \     "*": {
      \       "make": "mix"
      \     }
      \   }
      \ }
if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

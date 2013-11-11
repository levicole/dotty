execute pathogen#infect()

syntax on
filetype plugin indent on

augroup vimrc
  autocmd!
  autocmd GuiEnter * set guifont=Monaco:h16 guioptions-=T columns=120 lines=70 number
augroup END

autocmd BufRead,BufNewFile *.hamlc setlocal filetype=haml
autocmd FileType go setlocal shiftwidth=4 tabstop=4 expandtab
colorscheme solarized

let NERDTreeHijackNetrw=0

let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

set number

autocmd User Rails Rnavcommand sass app/stylesheets -glob=**/* -suffix=.sass
autocmd User Rails Rnavcommand feature features -suffix=.feature
autocmd User Rails Rnavcommand factory spec/factories -default=model() -suffix=_factory.rb
autocmd User Rails Rnavcommand admin app/admin -suffix=_admin.rb -default=model()
autocmd User Rails Rnavcommand worker app/workers -suffix=_worker.rb -default=model()

imap dt5 <!DOCTYPE html>

noremap ,s :source ~/.vimrc.local

let g:unite_winwidth = 40
let g:unite_enable_start_insert = 1

call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <C-p> :Unite file_rec/async<cr>
nnoremap <C-o> :Unite outline -vertical <cr>

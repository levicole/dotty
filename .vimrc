runtime! autoload/pathogen.vim
if exists('g:loaded_pathogen')
  call pathogen#runtime_prepend_subdirectories(expand('~/.vimbundles'))
endif

syntax on
filetype plugin indent on

augroup vimrc
  autocmd!
  autocmd GuiEnter * set guifont=Monaco:h16 guioptions-=T columns=120 lines=70 number
augroup END

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

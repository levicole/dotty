runtime! autoload/pathogen.vim
if exists('g:loaded_pathogen')
  call pathogen#runtime_prepend_subdirectories(expand('~/.vimbundles'))
endif

source ~/.vimrc.local

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
autocmd User Rails Rnavcommand fabricator spec/fabricators -suffix=_fabricator.rb
autocmd User Rails Rnavcommand pmodel vendor/plugins/chc_hci/app/models -suffix=.rb
autocmd User Rails Rnavcommand pspec vendor/plugins/chc_hci/spec -glob=**/* -suffix=_spec.rb
autocmd User Rails Rnavcommand plib vendor/plugins/chc_hci/lib -suffix=.rb

imap dt5 <!DOCTYPE html>

function! Rlocalize(lk) range
  let saved_reg_type = getregtype('"')
  let old_reg = getreg('"')
  normal! ""gvy
  let selection = getreg('"')
  let key = split(a:lk, '\.')
  let phrase = key[-1].": \"".selection."\""
  call setreg('l', phrase)
  call setreg('"', old_reg, saved_reg_type)
  normal! gvd
  exe "normal i t(\"".a:lk."\")"
  .s/\(\S\)\s\+/\1 /g
  .s/\s\+$//
endfunction

command! -nargs=* -range Translate call Rlocalize(<f-args>)
command! TP normal o<space><esc>x"lp
noremap ,s :source ~/.vimrc.local
inoremap <C-X>c #<C-R>=system('colorpick')<CR>

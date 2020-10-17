if has("multi_byte")
  set encoding=utf-8
  setglobal fileencoding=utf-8
else
  echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif

" Enable syntax highlighting
syntax on
colorscheme fancy

" Display line numbers on the left
set number

" Enable use of the mouse for all modes
set mouse=a

" Allow copy / past on vim
set clipboard=unnamedplus,unnamed,autoselect

" Allow backspapcing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" Enable autoindent
set autoindent
set smartindent

" Spaces are used
"set expandtab
"set shiftwidth=2
"set tabstop=2

" I want to find what I'm looking for
set hlsearch

" WSL yank support
let s:clip = "/mnt/c/Windows/System32/clip.exe"
if executable(s:clip)
  augroup WSLYank
    autocmd!
    autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
  augroup END
endif

" Compiler
compiler gcc

" Remove trailing whitespace
au BufWritePre * "%s/\s\+$//e"

" Automatic header
au BufNewFile *.c 0r ~/.vim/templates/c.header
au BufNewFile *.c exe "1," . 10 . "g/File Name :.*/s//File Name : " .expand("%")
au BufNewFile *.c exe "1," . 10 . "g/Creation Date :.*/s//Creation Date : " .strftime("%d-%m-%Y")
au BufNewFile *.c exe "$"
au BufWritePre,FileWritePre *.c exe "normal ma"
au BufWritePre,FileWritePre *.c exe "1," . 10 . "g/Last Modified :.*/s/Last Modified :.*/Last Modified : " .strftime("%c")
au BufWritePost,FileWritePost *.c exe "normal `a"

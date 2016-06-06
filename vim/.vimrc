" @pvcarrera vimrc

" Include Vundle
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
  Plugin 'gmarik/Vundle.vim'
  Plugin 'tpope/vim-fugitive.git'
  Plugin 'vim-scripts/ScrollColors'
  Plugin 'thoughtbot/vim-rspec'
  Plugin 'tpope/vim-rails'
  Plugin 'rking/ag.vim'
  Plugin 'bogado/file-line'
  Plugin 'elixir-lang/vim-elixir'
call vundle#end()            " required

filetype plugin indent on    " required

imap jj <Esc>
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" Whitespace
set tabstop=2 shiftwidth=2 expandtab
set nowrap
set backspace=indent,eol,start " allow backspacing over everything in insert mode

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

set nobackup		" do not keep a backup file, use versions instead
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set ignorecase " search are case insensitive ...
set smartcase " ... unless they contain at least one capital letter

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch!
  nnoremap <F3> :set hlsearch!<CR>
endif

" add jbuilder syntax highlighting
au BufNewFile,BufRead *.json.jbuilder set ft=ruby

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

color codeschool
:set cpoptions+=$ " puts a $ marker for the end of words/lines in cw/c$ commands
:set number

" RSpec.vim mappings
:let mapleader = ","
map <Leader>t :w<CR>:call RunCurrentSpecFile()<CR>
map <Leader>s :w<CR>:call RunNearestSpec()<CR>
map <Leader>l :w<CR>:call RunLastSpec()<CR>
map <Leader>a :w<CR>:call RunAllSpecs()<CR>

" Remove trailing waite spaces
autocmd BufWritePre * :%s/\s\+$//e

" Configure vim tree
let g:netrw_liststyle=3
map <leader>k :Explore<cr>

" Configure cursor
" Change cursor shape in different modes (for iTerm on OS X)
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
" Highligth cursor line
set cursorline
hi CursorLine  term=underline  guibg=#555555  cterm=underline ctermbg=0

" Add spellchek
" Move to next misspelled word s] Move backwards ]s
" Show suggestions z=
set spell spelllang=en_gb

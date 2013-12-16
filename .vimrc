" Make Vim more useful
set nocompatible
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed
" Enhance command-line completion
set wildmenu
" Allow cursor keys in insert mode
set esckeys
" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Add the g flag to search/replace by default
set gdefault
" Use UTF-8 without BOM
set encoding=utf-8 nobomb
" Change mapleader
let mapleader=","
" Don’t add empty newlines at the end of files
set binary
set noeol
" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
endif

" Respect modeline in files
set modeline
set modelines=4
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
" Enable line numbers
set number
" Enable syntax highlighting
syntax on
" Highlight current line
set cursorline
" Make tabs as wide as four spaces
set tabstop=4
set shiftwidth=4
set shiftround
" Show “invisible” characters
" set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
" set list
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
" Highlight dynamically as pattern is typed
set incsearch
" Always show status line
set laststatus=2
" Enable mouse in all modes
set mouse=a
" Disable error bells
set noerrorbells
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
" set ruler
" Don’t show the intro message when starting Vim
set shortmess=atI
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it’s being typed
set showcmd
" Use relative line numbers
if exists("&relativenumber")
 	set relativenumber
 	au BufReadPost * set relativenumber
endif
" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Easy switch between splits with Ctrl-h, j, k, l
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Increase width of current vertical split
nmap <C-v> :vertical resize +5<cr>

" Toggle NERDTree
nmap <C-b> :NERDTreeToggle<cr>

" Jeffrey Way Laravel tips: @todo Learn and use!
" Laravel abbrevs
abbrev gm !php artisan generate:model
abbrev gc !php artisan generate:controller
abbrev gmig !php artisan generate:migration

" Laravel framework common files
nmap <leader>lr :e app/routes.php<cr>
nmap <leader>lca :e app/config/app.php<cr>
nmap <leader>lcd :e app/config/database.php<cr>
nmap <leader>lc :e composer.json

set wildignore+=*/vendor/**
set wildignore+=*/node_modules/**

" Create/edit file in the current directory
nmap :ed :edit %:p:h/

"" PHP
" Easily create class. @todo: Make this actually work!
function! Class()
	let name = input('Class Name? ')
	let namespace = input('Any Namespace? ')

	if strlen(namespace)
		exec 'normal i<?php namespace ' . namespace . ';'
	else
		exec 'normal i<?php'
	endif

	" Open class
	exec 'normal iclass ' . name . ' {}O'

	exec 'normal i	public function __construct()	{			}kkA'
endfunction
nmap <leader>1 :call Class()<cr>

" Add a new dependency to a PHP class
function! AddDependency()
	let dependency = input('Var Name: ')
	let namespace = input('Class Path: ')

	let segments = split(namespace, '\')
	let typehint = segments[-1]

	exec 'normal gg/construct%i, ' . typehint . ' $' . dependency . '/}O$this->a' . dependency . ' = $' . dependency . ';==o?{kO	protected $' . dependency . ';?{Ouse ' . namespace . ';'
	
	" Remove opening comma if there is only one dependency
	exec 'normal :%s/(, /(/g'
endfunction
nmap <leader>2 :call AddDependency()<cr>

" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Automatic commands
if has("autocmd")
	" Enable file type detection
	filetype on
	" Treat .json files as .js
	autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
endif

set background=dark
colorscheme solarized


" " Vundle
" filetype off

" set rtp+=~/.vim/bundle/vundle/
" call vundle#rc()

" Bundle 'gmarik/vundle'
" 
" " My bundles
" Bundle 'kien/ctrlp.vim'
" " " -- or --
" " Bundle 'twe4ked/vim-peepopen'
" " 
" Bundle 'Lokaltog/vim-easymotion'
" Bundle 'bling/vim-airline'
" Bundle 'altercation/vim-colors-solarized'
" Bundle 'scrooloose/nerdtree'
" 
" " Ctrl-P key mapping
" let g:ctrlp_map = '<c-p>'
" 
" filetype plugin indent on

" " enable powerline symbols for airline
" let g:airline_powerline_fonts=1

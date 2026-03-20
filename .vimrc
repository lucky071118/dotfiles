" ~/.vimrc - Vim configuration

" ── Plugin manager (vim-plug) ────────────────────────────────────────────────
" Run :PlugInstall after adding new plugins.
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'          " Sensible defaults
Plug 'tpope/vim-fugitive'          " Git integration
Plug 'tpope/vim-commentary'        " gc to comment/uncomment
Plug 'tpope/vim-surround'          " cs/ds/ys to change surrounding chars
Plug 'airblade/vim-gitgutter'      " Show git diff in the sign column
Plug 'dense-analysis/ale'          " Async linting and fixing
Plug 'vim-airline/vim-airline'     " Status/tab line
Plug 'preservim/nerdtree'          " File tree sidebar
Plug 'ctrlpvim/ctrlp.vim'          " Fuzzy file finder
Plug 'joshdick/onedark.vim'        " One Dark color scheme

call plug#end()

" ── General settings ────────────────────────────────────────────────────────
set nocompatible               " use Vim settings, not Vi
filetype plugin indent on      " enable file-type detection
syntax enable                  " enable syntax highlighting

set encoding=utf-8
set fileencoding=utf-8
set number                     " show line numbers
set relativenumber             " relative line numbers for easier motion
set cursorline                 " highlight the current line
set showmatch                  " briefly jump to matching bracket
set wrap                       " wrap long lines
set linebreak                  " wrap at word boundaries
set scrolloff=8                " keep 8 lines visible above/below cursor

set hlsearch                   " highlight search matches
set incsearch                  " incremental search
set ignorecase                 " case-insensitive search…
set smartcase                  " …unless the pattern has uppercase

set expandtab                  " use spaces instead of tabs
set tabstop=4                  " a tab = 4 spaces
set shiftwidth=4               " indent width
set softtabstop=4
set autoindent
set smartindent

set hidden                     " allow switching buffers without saving
set history=1000
set undofile                   " persist undo history across sessions
set undodir=~/.vim/undo

set backupdir=~/.vim/backup//  " store backup files in one place
set directory=~/.vim/swap//    " store swap files in one place

set wildmenu                   " enhanced command-line completion
set wildmode=list:longest,full
set laststatus=2               " always show status line
set showcmd                    " show partial commands in status bar
set ruler                      " show cursor position
set splitbelow splitright      " more natural window splits

set mouse=a                    " enable mouse in all modes

" ── Color scheme ────────────────────────────────────────────────────────────
if has('termguicolors')
  set termguicolors
endif
silent! colorscheme onedark

" ── Key mappings ────────────────────────────────────────────────────────────
let mapleader = " "            " use space as leader key

" Clear search highlighting
nnoremap <leader>/ :nohlsearch<CR>

" Save and quit shortcuts
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :x<CR>

" Toggle NERDTree
nnoremap <leader>n :NERDTreeToggle<CR>

" Buffer navigation
nnoremap <Tab>   :bnext<CR>
nnoremap <S-Tab> :bprev<CR>

" Window navigation with Ctrl + h/j/k/l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Move lines up/down with Alt + j/k
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Fugitive shortcuts
nnoremap <leader>gs :Git status<CR>
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gl :Git log --oneline<CR>

" ── Plugin configuration ──────────────────────────────────────────────────
" ALE – enable fix-on-save for common file types
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   '*':          ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'python':     ['black'],
\}

" NERDTree – hide help banner, show hidden files
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI  = 1

" CtrlP – ignore common noise directories
let g:ctrlp_custom_ignore = {
\   'dir':  '\v[\/](\.git|node_modules|dist|build|__pycache__)$',
\   'file': '\v\.(pyc|pyo|class|o|so)$',
\}

" ── Ensure runtime directories exist ─────────────────────────────────────────
for s:dir in ['~/.vim/undo', '~/.vim/backup', '~/.vim/swap']
  if !isdirectory(expand(s:dir))
    call mkdir(expand(s:dir), 'p')
  endif
endfor

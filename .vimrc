" -------------------------------------------------------------------
" Basic Settings
" -------------------------------------------------------------------
set nocompatible            " Disable Vi compatibility (Enable Vim features)
set encoding=utf-8          " Set internal encoding to UTF-8
set fileencoding=utf-8      " Set file encoding on save to UTF-8
set fileencodings=utf-8,cp932,euc-jp,default,latin1 " Auto-detect character encodings

" -------------------------------------------------------------------
" Display / Appearance
" -------------------------------------------------------------------
syntax on                   " Enable syntax highlighting
"set number                  " Show line numbers
"set cursorline              " Highlight the current line (horizontal)
set showmatch               " Highlight matching parentheses
set title                   " Set terminal title to the filename being edited
"set laststatus=2            " Always show the status line
set wrap                    " Wrap long lines (use 'nowrap' if preferred)
set showcmd                 " Show incomplete commands in the status line

" -------------------------------------------------------------------
" Indentation / Tabs
" -------------------------------------------------------------------
set expandtab               " Convert tabs to spaces (Essential)
set tabstop=4               " Width of a tab character
set shiftwidth=4            " Width of auto-indent
set softtabstop=4           " Delete multiple spaces as if they were a tab
set autoindent              " Copy indent from current line when starting a new line
set smartindent             " Smart auto-indenting (C-like)

" -------------------------------------------------------------------
" Search
" -------------------------------------------------------------------
set ignorecase              " Case insensitive search
set smartcase               " Case sensitive if uppercase is used
set incsearch               " Incremental search (search as you type)
set hlsearch                " Highlight search results

" -------------------------------------------------------------------
" Operation / Editing
" -------------------------------------------------------------------
set backspace=indent,eol,start " Allow backspacing over everything in insert mode
set whichwrap=b,s,h,l,<,>,[,]  " Allow left/right keys to cross line boundaries
"set clipboard+=unnamedplus     " Sync with OS clipboard (Requires +clipboard)
set mouse=a                    " Enable mouse support (selection and scrolling)

" -------------------------------------------------------------------
" Invisible to  visible
" -------------------------------------------------------------------
set list
" tab: ▸  , space at end the of a line: · , NBSP: •
set listchars=tab:▸\ ,trail:·,nbsp:•

" Color
"autocmd ColorScheme * highlight Whitespace guifg=#505050 ctermfg=239

" -------------------------------------------------------------------
" Others
" -------------------------------------------------------------------
set history=200             " Number of command history entries to keep
set hidden                  " Allow switching buffers without saving (hide unsaved buffers)
filetype plugin indent on   " Enable filetype-specific plugins and indentation

" -------------------------------------------------------------------
" Key Mappings
" -------------------------------------------------------------------
" Set space key as a leader key
let mapleader = " "

" Copy in clipboard
if has('macunix')
  vnoremap <C-c> y:call system('pbcopy', @")<CR>
elseif exists('$WSL_DISTRO_NAME') || exists('$WSL_INTEROP')
  vnoremap <C-C> y:call system('clip.exe', @")<CR>
endif

" Insert a blank line in normal mode by enter key
nnoremap <CR> o<Esc>

" Write by Leader + w
nnoremap <Leader>w :write<CR>

" Quit by Leader + q
nnoremap <Leader>q :quit<CR>

" Escape from insert mode by jk
inoremap jk <Esc>

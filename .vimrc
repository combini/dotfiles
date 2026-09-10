" -------------------------------------------------------------------
" Basic Settings
" -------------------------------------------------------------------
set nocompatible            " Disable Vi compatibility (Enable Vim features)
set encoding=utf-8          " Set internal encoding to UTF-8
set fileencoding=utf-8      " Set file encoding on save to UTF-8
set fileencodings=ucs-bom,utf-8,cp932,euc-jp,default,latin1 " Auto-detect character encodings

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

" Insert a blank line below in normal mode by leader + o
nnoremap <Leader>o o<Esc>

" Insert a blank line below in normal mode by leader + o
nnoremap <Leader>O o<Esc>

" Write by Leader + w
nnoremap <Leader>w :write<CR>

" Quit by Leader + q
nnoremap <Leader>q :quit<CR>

" Escape from insert mode by jk
inoremap jk <Esc>

" Split windows
nnoremap <Leader>s :split<CR>
nnoremap <Leader>v :vsplit<CR>

" Equalize window size
nnoremap <Leader>= <C-w>=

" Move between windows by leader + hjkl
nnoremap <Leader>h <C-w>h
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k
nnoremap <Leader>l <C-w>l

" -------------------------------------------------------------------
" System Clipboard
" -------------------------------------------------------------------
" Copy text to system clipboard
function! CopyToClipboard(text) abort
  if has('clipboard')
    call setreg('+', a:text)

  elseif executable('pbcopy')
    call system('pbcopy', a:text)

  elseif executable('wl-copy')
    call system('wl-copy', a:text)

  elseif executable('xclip')
    call system('xclip -selection clipboard', a:text)

  elseif executable('xsel')
    call system('xsel --clipboard --input', a:text)

  elseif executable('clip.exe')
    call system('clip.exe', a:text)

  else
    echohl WarningMsg
    echo "No system clipboard available"
    echohl None
  endif
endfunction


" Get text from system clipboard
function! GetClipboard() abort
  if has('clipboard')
    return getreg('+')

  elseif executable('pbpaste')
    return system('pbpaste')

  elseif executable('wl-paste')
    return system('wl-paste')

  elseif executable('xclip')
    return system('xclip -selection clipboard -o')

  elseif executable('xsel')
    return system('xsel --clipboard --output')

  elseif executable('powershell.exe')
    return substitute(
          \ system('powershell.exe -NoProfile -Command Get-Clipboard'),
          \ "\r", "", "g")

  else
    echohl WarningMsg
    echo "No system clipboard available"
    echohl None
    return ''
  endif
endfunction


" Paste system clipboard like normal p
function! PasteFromClipboard() abort
  let l:text = GetClipboard()

  if empty(l:text)
    return
  endif

  " Save temporary register z
  let l:save_z = getreg('z', 1, 1)
  let l:save_z_type = getregtype('z')

  " Guess whether clipboard contents are linewise or characterwise
  let l:type = l:text =~ "\n$" ? 'V' : 'v'

  call setreg('z', l:text, l:type)
  normal! "zp

  " Restore register z
  call setreg('z', l:save_z, l:save_z_type)
endfunction


" Visual selection -> system clipboard
vnoremap <silent> <leader>y y:call CopyToClipboard(@")<CR>

" System clipboard -> Vim
nnoremap <silent> <leader>p :call PasteFromClipboard()<CR>

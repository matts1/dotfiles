" zsh
set shell=zsh

map <Leader>s :SyntasticToggleMode<CR>

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

vnoremap <c-_> :Commentary<CR>
nnoremap <c-_> :Commentary<CR>
inoremap <c-_> <c-o>:Commentary<CR>

" General {{{
" Use indentation for folds
set foldmethod=indent
set foldnestmax=5
set foldlevelstart=99
set foldcolumn=0

" Sets how many lines of history VIM has to remember
set history=700

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
if ! exists("mapleader")
  let mapleader = ","
endif

if ! exists("g:mapleader")
  let g:mapleader = ","
endif

" Leader key timeout
set tm=2000

" Allow the normal use of "," by pressing it twice
noremap ,, ,

" Use par for prettier line formatting
set formatprg=par
let $PARINIT = 'rTbgqR B=.,?_A_a Q=_s>|'

" Kill the damned Ex mode.
nnoremap Q <nop>

" Make <c-h> work like <c-h> again (this is a problem with libterm)
if has('nvim')
  nnoremap <BS> <C-w>h
endif

" }}}

" vim-plug {{{

set nocompatible

if has('nvim')
  call plug#begin('~/.config/nvim/bundle')
else
  call plug#begin('~/.vim/bundle')
endif

" Support bundles
Plug 'jgdavey/tslime.vim'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'ervandew/supertab'
Plug 'benekastah/neomake'
Plug 'moll/vim-bbye'
Plug 'vim-scripts/gitignore'
Plug 'vim-syntastic/syntastic'

" Git
Plug 'tpope/vim-fugitive'
Plug 'int3/vim-extradite'

" Bars, panels, and files
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'ap/vim-buftabline'

" Text manipulation
Plug 'vim-scripts/Align'
Plug 'simnalamburt/vim-mundo'
Plug 'tpope/vim-commentary'
Plug 'godlygeek/tabular'
Plug 'michaeljsmith/vim-indent-object'
Plug 'easymotion/vim-easymotion'
Plug 'ConradIrwin/vim-bracketed-paste'

" Debuggers
Plug 'critiqjo/lldb.nvim'

" Haskell
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'enomsg/vim-haskellConcealPlus', { 'for': 'haskell' }
Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }
Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
Plug 'Twinside/vim-hoogle', { 'for': 'haskell' }
Plug 'mpickering/hlint-refactor-vim', { 'for': 'haskell' }

" Colorscheme
Plug 'vim-scripts/wombat256.vim'

call plug#end()

" }}}

" VIM user interface {{{

" Disable mouse
set mouse=

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu
" Tab-complete files up to longest unambiguous prefix
set wildmode=list:longest,full

" Always show current position
set ruler
set number

" Show trailing whitespace
set list
" But only interesting whitespace
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

" Height of the command bar
set cmdheight=1

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
" set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set vb t_vb=

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
  let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
  let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif
" }}}

" Colors and Fonts {{{

try
  colorscheme wombat256mod
catch
endtry

" Adjust signscolumn to match wombat
hi! link SignColumn LineNr

" Use pleasant but very visible search hilighting
hi Search ctermfg=white ctermbg=173 cterm=none guifg=#ffffff guibg=#e5786d gui=none
hi! link Visual Search

" Match wombat colors in nerd tree
hi Directory guifg=#8ac6f2

" Searing red very visible cursor
hi Cursor guibg=red

" Don't blink normal mode cursor
set guicursor=n-v-c:block-Cursor
set guicursor+=n-v-c:blinkon0

" Set extra options when running in GUI mode
if has("gui_running")
  set guioptions-=T
  set guioptions-=e
  set guitablabel=%M\ %t
endif
set t_Co=256

" Set utf8 as standard encoding and en_US as the standard language
if !has('nvim')
  " Only set this for vim, since neovim is utf8 as default and setting it
  " causes problems when reloading the .vimrc configuration
  set encoding=utf8
endif

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Use powerline fonts for airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_powerline_fonts = 1
let g:airline_symbols.space = "\ua0"
" }}}

" Files, backups and undo {{{

" Turn backup off, since most stuff is in Git anyway...
set nobackup
set nowb
set noswapfile

" Source the vimrc file after saving it
augroup sourcing
    autocmd!
    if has('nvim')
        autocmd bufwritepost init.vim source $MYVIMRC
    else
        autocmd bufwritepost .vimrc source $MYVIMRC
    endif
augroup END

" Open file prompt with current path
nmap <leader>e :e <C-R>=expand("%:p:h") . '/'<CR>

" Show undo tree
nmap <silent> <leader>u :MundoToggle<CR>

nnoremap U :redo<CR>

" Text, tab and indent related {{{

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Copy and paste to os clipboard
nmap <leader>y "*y
vmap <leader>y "*y
nmap <leader>d "*d
vmap <leader>d "*d
nmap <leader>p "*p
vmap <leader>p "*p

" }}}

" Visual mode related {{{

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

" }}}

" Moving around, tabs, windows and buffers {{{

" Treat long lines as break lines (useful when moving around in them)
nnoremap j gj
nnoremap k gk


" Disable highlight when <leader><cr> is pressed
" but preserve cursor coloring
nmap <silent> <leader><cr> :noh\|hi Cursor guibg=red<cr>

" Return to last edit position when opening files (You want this!)
augroup last_edit
    autocmd!
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \   exe "normal! g`\"" |
                \ endif
augroup END
" Remember info about open buffers on close
set viminfo^=%

" close vim
nmap <leader>q :bufdo bw!<CR>:q<CR>

" Fuzzy find files
let g:ctrlp_max_files=0
let g:ctrlp_show_hidden=1
let g:ctrlp_custom_ignore = { 'dir': '\v[\/](.git|.cabal-sandbox|.stack-work|.idea|.o|.hi)$' }

" }}}

" Save on switching to normal mode
inoremap <silent> <ESC> <ESC>:update<CR>
inoremap <silent> <C-o> <C-o>:update<CR><C-o>

function! InsertTerminal()
    if filereadable(expand(":%p")) == 0
        execute "normal! i"
    endif
endfunction

" Use <Esc> to escape terminal insert mode
tnoremap <Esc> <C-\><C-n>
" Make terminal split moving behave like normal neovim
" tnoremap <c-h> <C-\><C-n><C-w>h<C-o>:call InsertTerminal()<CR>
" tnoremap <c-j> <C-\><C-n><C-w>j<C-o>:call InsertTerminal()<CR>
" tnoremap <c-k> <C-\><C-n><C-w>k<C-o>:call InsertTerminal()<CR>
" tnoremap <c-l> <C-\><C-n><C-w>l<C-o>:call InsertTerminal()<CR>

" noremap <c-h> <c-w>h<C-o>:call InsertTerminal()<CR>
" noremap <c-j> <c-w>j<C-o>:call InsertTerminal()<CR>
" noremap <c-k> <c-w>k<C-o>:call InsertTerminal()<CR>
" noremap <c-l> <c-w>l<C-o>:call InsertTerminal()<CR>
" inoremap <c-h> <c-o><c-h><C-o>:call InsertTerminal()<CR>
" inoremap <c-j> <c-o><c-j><C-o>:call InsertTerminal()<CR>
" inoremap <c-k> <c-o><c-k><C-o>:call InsertTerminal()<CR>
" inoremap <c-l> <c-o><c-l><C-o>:call InsertTerminal()<CR>

tnoremap <c-h> <C-\><C-n><C-w>h
tnoremap <c-j> <C-\><C-n><C-w>j
tnoremap <c-k> <C-\><C-n><C-w>k
tnoremap <c-l> <C-\><C-n><C-w>l

noremap <c-h> <c-w>h
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-l> <c-w>l
inoremap <c-h> <c-o><c-h>
inoremap <c-j> <c-o><c-j>
inoremap <c-k> <c-o><c-k>
inoremap <c-l> <c-o><c-l>

nmap <leader>r <space>output<CR>i<UP><CR><ESC><space><CR>

" Open various kinds of window splits in each direction
" new, copy, move, terminal, open
nmap <leader>nh :leftabove  vnew<CR>
nmap <leader>ch :leftabove  vsplit<CR>
nmap <leader>mh :leftabove  vsplit<CR><C-l>:bp<CR><C-h>
" nmap <leader>th :leftabove  vsplit<CR><leader>tt
nmap <leader>th :leftabove  vsplit<CR>:terminal<CR><ESC>:file output<CR>i
nmap <leader>oh :leftabove  vsplit<CR><leader>oo

nmap <leader>nl :rightbelow vnew<CR>
nmap <leader>cl :rightbelow vsplit<CR>
nmap <leader>ml :rightbelow vsplit<CR><C-h>:bp<CR><C-l>
" nmap <leader>tl :rightbelow vsplit<CR><leader>tt
nmap <leader>tl :rightbelow vsplit<CR>:terminal<CR><ESC>:file output<CR>i
nmap <leader>ol :rightbelow vsplit<CR><leader>oo

nmap <leader>nk :leftabove  new<CR>
nmap <leader>ck :leftabove  split<CR>
nmap <leader>mk :leftabove  split<CR><C-j>:bp<CR><C-k>
" nmap <leader>tk :leftabove  split<CR><leader>tt
nmap <leader>tk :leftabove  split<CR>:terminal<CR><ESC>:file output<CR>i
nmap <leader>ok :leftabove  split<CR><leader>oo

nmap <leader>nj :rightbelow new<CR>
nmap <leader>cj :rightbelow split<CR>
nmap <leader>mj :rightbelow split<CR><C-k>:bp<CR><C-j>
" nmap <leader>tj :rightbelow split<CR><leader>tt
nmap <leader>tj :rightbelow split<CR>:terminal<CR><ESC>:file output<CR>i
nmap <leader>oj :rightbelow split<CR><leader>oo

nnoremap <silent> <leader>nn :e<CR>
noremap <leader>tt :terminal<CR><ESC>
" :file output<CR>
nnoremap <leader>oo :CtrlP<CR>


map <C-space> za

" don't close buffers when you aren't displaying them
set hidden

" don't close terminal buffers when you aren't displaying them
autocmd TermOpen * set bufhidden=hide

" previous buffer, next buffer
nnoremap <leader>bp :bp<cr>
nnoremap <leader>bn :bn<cr>

" maximise
nnoremap <leader>bm <c-w>o

" close file
noremap <leader>bd :Bd!<cr>
" close file and pane
noremap <leader>bc :q<cr>

" fuzzy find buffers
noremap <space> :CtrlPBuffer<cr>

" }}}

" Status line {{{

" Always show the status line
set laststatus=2

" }}}

" Editing mappings {{{

" Utility function to delete trailing white space
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

" }}}

" Helper functions {{{

function! CmdLine(str)
  exe "menu Foo.Bar :" . a:str
  emenu Foo.Bar
  unmenu Foo
endfunction

function! VisualSelection(direction, extra_filter) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  elseif a:direction == 'gv'
    call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.' . a:extra_filter)
  elseif a:direction == 'replace'
    call CmdLine("%s" . '/'. l:pattern . '/')
  elseif a:direction == 'f'
    execute "normal /" . l:pattern . "^M"
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

" }}}

" NERDTree {{{

" Close nerdtree after a file is selected
let NERDTreeQuitOnOpen = 1

function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

function! ToggleFindNerd()
  if IsNERDTreeOpen()
    exec ':NERDTreeToggle'
  else
    exec ':NERDTreeFind'
  endif
endfunction

" If nerd tree is closed, find current file, if open, close it
nmap <silent> <leader>f <ESC>:call ToggleFindNerd()<CR>
nmap <silent> <leader>F <ESC>:NERDTreeToggle<CR>

" }}}

" Alignment {{{

" Stop Align plugin from forcing its mappings on us
let g:loaded_AlignMapsPlugin=1
" Align on equal signs
map <Leader>a= :Align =<CR>
" Align on commas
map <Leader>a, :Align ,<CR>
" Align on pipes
map <Leader>a<bar> :Align <bar><CR>
" Prompt for align character
map <leader>ap :Align
" }}}

" Tags {{{

" map <leader>tt :TagbarToggle<CR>

set tags=tags;/
set cst
set csverb

" }}}

" Git {{{

let g:extradite_width = 60
" Hide messy Ggrep output and copen automatically
function! NonintrusiveGitGrep(term)
  execute "copen"
  " Map 't' to open selected item in new tab
  execute "nnoremap <silent> <buffer> t <C-W><CR><C-W>T"
  execute "silent! Ggrep " . a:term
  execute "redraw!"
endfunction

command! -nargs=1 GGrep call NonintrusiveGitGrep(<q-args>)
nmap <leader>gs :Gstatus<CR>
nmap <leader>gg :copen<CR>:GGrep 
nmap <leader>gl :Extradite!<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gb :Gblame<CR>

function! CommittedFiles()
  " Clear quickfix list
  let qf_list = []
  " Find files committed in HEAD
  let git_output = system("git diff-tree --no-commit-id --name-only -r HEAD\n")
  for committed_file in split(git_output, "\n")
    let qf_item = {'filename': committed_file}
    call add(qf_list, qf_item)
  endfor
  " Fill quickfix list with them
  call setqflist(qf_list)
endfunction

" Show list of last-committed files
nnoremap <silent> <leader>g? :call CommittedFiles()<CR>:copen<CR>

" }}}

" Completion {{{
set completeopt+=longest

" Use buffer words as default tab completion
let g:SuperTabDefaultCompletionType = '<c-x><c-p>'

" }}}

" Unmap
autocmd VimEnter * unmap <leader>rwp
autocmd VimEnter * unmap <leader>swp


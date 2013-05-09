set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-repeat'

Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails.git'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-speeddating'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-haml'
Bundle 'vim-ruby/vim-ruby'
Bundle 'jgdavey/vim-blockle'
Bundle 'godlygeek/tabular'
Bundle 'kchmck/vim-coffee-script'
Bundle 'pangloss/vim-javascript'

Bundle 'jgdavey/vim-turbux'
Bundle 'skalnik/vim-vroom'

Bundle 'tpope/vim-vividchalk'
Bundle 'jgdavey/vim-railscasts'

Bundle 'mileszs/ack.vim'
Bundle 'ggreer/the_silver_searcher'
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'goldfeld/vim-seek'
Bundle 'vim-scripts/ZoomWin'
Bundle 'duff/vim-bufonly'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'mattn/gist-vim'

syntax on
filetype plugin indent on

set visualbell
set wildmenu
set wildmode=list:longest,full
set splitright
set splitbelow
set hidden
set guifont=Monaco:h16
set guioptions-=T guioptions-=e guioptions-=L guioptions-=r
set shell=bash
set background=dark
set tabstop=2
set shiftwidth=2
set expandtab
set nofoldenable
set ignorecase smartcase
set autoindent
set backspace=indent,eol,start

augroup vimrc
  autocmd!
  autocmd GuiEnter * set columns=120 lines=70 number
augroup END

let mapleader = ","
vmap D y'>p
imap <c-l> <space>=><space>
imap <c-c> <esc>
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>
cnoremap %% <C-R>=expand('%:h').'/'<cr>
nnoremap Y y$


function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <leader>n :call RenameFile()<cr>

function! PromoteToLet()
  :normal! dd
  " :exec '?^\s*it\>'
  :normal! P
  :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  :normal ==
endfunction
:command! PromoteToLet :call PromoteToLet()
:map <leader>p :PromoteToLet<cr>


au BufWritePost .vimrc so ~/.vimrc
autocmd QuickFixCmdPost *grep* cwindow

colorscheme railscasts

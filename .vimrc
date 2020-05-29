" vimrc - James He

" Plugins
set nocompatible
filetype off
" Start Vundle - THIS IS CONFIGURED FOR WINDOWS, SORRY
" REFER TO VUNDLE DOCS FOR UNIX-BASED MACHINES
set rtp+=$HOME/.vim/bundle/Vundle.vim/
call vundle#begin('$HOME/.vim/bundle/')
" Plugin List
Plugin 'VundleVim/Vundle.vim'
Plugin 'morhetz/gruvbox'
Plugin 'preservim/nerdtree'
Plugin 'prettier/vim-prettier'
Plugin 'itchyny/lightline.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'dense-analysis/ale'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'jiangmiao/auto-pairs'
" End Vundle
call vundle#end()
filetype plugin indent on

" Set encoding to UTF-8
set encoding=utf-8

" Gruvbox theme configuration
let g:gruvbox_termcolors=16
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='hard'
set background=dark
colorscheme gruvbox

" Lightline
set laststatus=2
set noshowmode
let g:lightline={
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
    \   },
    \ 'component_function': {
    \   'gitbranch':'FugitiveHead',
    \   'filename': 'RelativeFilePath',
    \   },
    \ }
function! RelativeFilePath()
    return @%
endfunction
let g:unite_force_overwrite_statusline=0
let g:vimfiler_force_overwrite_statusline=0
let g:vimshell_force_overwrite_statusline=0

" NERDTree
let g:NERDTreeWinPos='right'
let g:NERDTreeWinSize=35
map <leader>nn :NERDTreeToggle<cr>

" Don't redraw while executing macros
set lazyredraw

" Error sounds
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Splits are not shit
set splitbelow
set splitright

" Color syntax
syntax enable

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

" Faster saving and quitting
nmap <leader>w :w!<cr>
nmap <leader>wq :wq!<cr>

" Line numbering
set number relativenumber
set nu rnu

" Backspaces
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Highlight
" Search terms
set hlsearch

" Comments
highlight Comment ctermfg=grey

" Show ruler
set ruler

" tabs and indentation
set autoindent
set tabstop=4
set shiftwidth=4
set textwidth=79
set expandtab

" show matching brackets
set showmatch
set matchtime=3

" ale linting
let g:ale_linters={
    \ 'python': ['flake8', 'pylint'],
    \ 'javascript': ['eslint'],
    \ }
let b:ale_fixers={
    \ '*': ['remove_trailing_lines', 'trim_whitespace'],
    \ 'python': ['flake8', 'pylint'],
    \ 'javascript': ['prettier', 'eslint'],
    \ 'vue': ['eslint'],
    \ 'scss': ['prettier'],
    \ 'html': ['prettier'],
    \ }
let g:ale_fix_on_save=1

" Reformatting
au FileType javascript setlocal formatprg=prettier
au FileType javascript.jsx setlocal formatprg=prettier
au FileType typescript setlocal formatprg=prettier\ --parser\ typescript
au FileType html setlocal formatprg=js-beautify\ --type\ html
au FileType scss setlocal formatprg=prettier\ --parser\ css
au FileType css setlocal formatprg=prettier\ --parser\ css

" python specific buffer configs
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set fileformat=unix |
    \ set colorcolumn=80 |
    \ highlight ColorColumn ctermbg=darkgray

" js / html / css specific configs
au BufNewFile,BufRead *.js,*.jsx,*.html,*.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ highlight ColorColumn ctermbg=darkgray |
    \ call matchadd('ColorColumn','\%81v',100)

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=grey guibg=grey
match ExtraWhitespace /\s\+$/

augroup ColorcolumnOnlyInInsertMode
  autocmd!
  autocmd InsertEnter * setlocal colorcolumn=80
  autocmd InsertLeave * setlocal colorcolumn=0
augroup END

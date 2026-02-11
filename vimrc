vim9script

g:mapleader = ","

set nocompatible

# install Plug if not instaled
var plug_path = '~/.vim/autoload/plug.vim'
var plug_url = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

if empty(glob(plug_path))
    execute "!curl -fLo " s:plug_path "--create-dirs" s:plug_url
    autocmd VimEnter * PlugInstall --sync
endif

set termguicolors

if getenv('TERM_PROGRAM') =~ 'Apple_Terminal'
    &t_SI = "\e[5 q" # SI = INSERT mode
    &t_SR = "\e[4 q" # SR = REPLACE mode
    &t_EI = "\e[1 q" # EI = NORMAL mode (ELSE)
endif


plug#begin()

Plug 'ntessore/unicode-math.vim'

# colorschemes
#
Plug 'morhetz/gruvbox'
Plug 'altercation/vim-colors-solarized'
Plug 'lifepillar/vim-solarized8'
Plug 'sonph/onehalf', {'rtp' : 'vim' }
Plug 'habamax/vim-sugarlily'
Plug 'sainnhe/gruvbox-material'
Plug 'sainnhe/everforest'

Plug 'tomtom/tcomment_vim'
# tcomment
map <leader>cc gcc

Plug 'vim-scripts/Align'
Plug 'scrooloose/nerdtree'
map <leader>t :NERDTree<cr>
g:NERDTreeHijackNetrw = 0


Plug 'bling/vim-airline'

if !exists('g:airline_symbols')
    g:airline_symbols = {}
endif

# powerline symbols
g:airline_left_sep = ''
g:airline_left_alt_sep = ''
g:airline_right_sep = ''
g:airline_right_alt_sep = ''
g:airline_symbols.branch = ''
g:airline_symbols.readonly = ''
g:airline_symbols.linenr = ''

g:airline#extensions#tabline#enabled = 1
g:airline#extensions#tabline#formatter = 'default'
g:airline#extensions#tabline#fnamemod = ':t'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-eunuch'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
autocmd FileType cpp,c,python map <buffer> <c-]> <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <leader>s :CocList symbols<cr>

nnoremap <leader>h :CocCommand clangd.switchSourceHeader<cr>

Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

Plug 'ramunas/vim-select'
nnoremap <leader>b :ShowBufferSelection<cr>
nnoremap <leader>f :ShowFileSelection<cr>
nnoremap <leader>g :ShowGitSelection<cr>
autocmd FileType Select b:coc_suggest_disable = 1

command -nargs=1 Grep :ShowGrepList <args>
command -nargs=1 GitGrep :ShowGitGrepList <args>
command -nargs=1 GitGrepRoot :ShowGitGrepRootList <args>

Plug 'itchyny/vim-cursorword'

plug#end()

# :Man command
runtime ftplugin/man.vim


g:everforest_background = 'soft'
g:everforest_enable_italic = 1
set background=light
colorscheme everforest


syntax enable
filetype on
filetype indent on
filetype plugin on

set encoding=utf8
set nofoldenable
set autochdir
set scrolloff=3
set history=10000
set hidden
set textwidth=0
set hlsearch
set backspace=indent,eol,start
set history=1000
set mouse=a
set showmode
set incsearch
set fileformats=unix,dos,mac
set fileencodings=utf8,latin1
set softtabstop=4
set shiftwidth=4
set tabstop=8
set expandtab
set ruler
set showcmd
set laststatus=2
set cinoptions=g0,(0,l1,J
set timeout timeoutlen=1000
set signcolumn=no
set timeoutlen=500
set splitright
set nobackup

map <leader>n :nohlsearch<cr>
map <leader>m <leader>n

imap <c-a> <c-o><home>
imap <c-e> <c-o><end>
imap <c-f> <right>
imap <c-b> <left>
imap <c-n> <down>
imap <c-d> <c-o>x
cnoremap <c-a> <home>
cnoremap <c-b> <left>
cnoremap <c-d> <del>
cnoremap <c-e> <end>
cnoremap <c-f> <right>
cnoremap <c-n> <down>
cnoremap <c-p> <up>


map Y y$

# copy&paste to/from clipboard
map gy "+y
map gp "+p
map gP "+P

map <c-j> <c-w>-
map <c-k> <c-w>+
map <c-h> <c-w><
map <c-l> <c-w>>

map <c-t><c-h> :tabprevious<cr>
map <c-t><c-l> :tabnext<cr>
map <c-t><c-t> :tabnext<cr>

command TN :tabnew
command Tn :tabnew

def OpenTabWithCurrentBuffer()
    var num = bufnr()
    tabnew
    exec "buffer " .. num
enddef

command To OpenTabWithCurrentBuffer()
command TO OpenTabWithCurrentBuffer()


autocmd FileType qf map <buffer> q :bd<cr>
autocmd FileType help map <buffer> q :bd<cr>

command ClearTrailingWhitespace normal mx<cr>:keepjumps keeppatterns %s/\s\+$//g<cr>`x
command! VimRC :e $MYVIMRC
command! HideGutter sign unplace *

autocmd FileType cpp, c setlocal formatprg=clang-format
autocmd FileType javascript setlocal formatprg=npx\ prettier\ --parser=babel\ --tab-width=4

# builtin javascript highlighter is missing keywords
autocmd FileType javascript syntax keyword Statement await async from

# TODO: define it here
command Bdelete call rmns#DeleteBuffer2()

autocmd FileType cpp,xml setlocal matchpairs+=<:>
autocmd FileType cmake setlocal sts=2 | setlocal sw=2

# set keymap=unicode-math
lmap \x ×
lmap \ox ⊗
lmap \a α
lmap \b β
lmap \l λ
lmap \L Λ
lmap \g γ
lmap \G Γ
lmap \e ε
lmap \-> →
lmap \ra →
lmap \la ←
lmap \=> ⇒
lmap \Ra ⇒
lmap \def ≝
lmap \[ ⟦
lmap \] ⟧
lmap \( ⦅
lmap \) ⦆
lmap \iso ≅
lmap \. ⋅

# # fix the dark background of comments
# highlight Comment cterm=NONE

# add a vertical bar for split windows
set fillchars+=vert:┃

def Install_my_coc_packages()
    CocInstall coc-sh
    CocInstall coc-clangd
    CocInstall coc-pyright
    CocInstall coc-texlab
    CocInstall coc-json
    CocInstall coc-tsserver
    CocInstall coc-cmake
enddef

command InstallMyCoc Install_my_coc_packages()

command UpgradeEverything :PlugUpgrade | :PlugUpdate | :CocUpdate
command UpdateEverything :UpgradeEverything


# When SIGUSR1 signal is received by vim, open ~/.vim/rfile. This is to open a
# file from a terminal running within vim.
# Put the following function in ~/.bashrc
# vimedit () { echo $PWD/$1 > $HOME/.vim/rfile && kill -SIGUSR1 $PPID; }
# then from terminal just do:
# vimedit file
autocmd! SigUSR1 * exec "split " .. readfile(expand('~/.vim/rfile'))[0]

autocmd FileType html set omnifunc=htmlcomplete#CompleteTags


# # fix my broken mac keyboard for now
# map § `
# map ± ~
# imap § `
# imap ± ~
# cmap § `
# cmap ± ~
# tmap § `
# tmap ± ~

# better highlighting of keywords for cmake
highlight ModeMsg ctermbg=231 ctermfg=167

# make the cursor visible on mate terminals
highlight MatchParen ctermfg=0

command -nargs=0 -bar Cdt :execute "cd " trim(system("git rev-parse --show-toplevel"))

def ShowDocumentation()
    if g:CocAction('hasProvider', 'hover')
        g:CocActionAsync('definitionHover')
    else
        feedkeys('K', 'in')
    endif
enddef

nnoremap <silent> K <ScriptCmd>ShowDocumentation()<CR>


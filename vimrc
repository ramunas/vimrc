let mapleader = ","

" solves the problem of ouputing these raw in gnome-terminal
let &t_TI = ""
let &t_TE = ""

set nocompatible

" install Plug if not instaled
let s:plug_path = '~/.vim/autoload/plug.vim'
let s:plug_url = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

if empty(glob(s:plug_path))
    execute "!curl -fLo " s:plug_path "--create-dirs" s:plug_url
    autocmd VimEnter * PlugInstall --sync
endif


call plug#begin()

Plug 'ntessore/unicode-math.vim'

" colorschemes
"
Plug 'morhetz/gruvbox'
" Plug 'junegunn/seoul256.vim'
Plug 'altercation/vim-colors-solarized'
" Plug 'sonph/onehalf', {'rtp' : 'vim' }
Plug 'habamax/vim-sugarlily'

Plug 'tomtom/tcomment_vim'
" tcomment
map <leader>cc gcc

Plug 'vim-scripts/Align'
Plug 'scrooloose/nerdtree'
map <leader>t :NERDTree<cr>
let g:NERDTreeHijackNetrw=0


" Plug 'bling/vim-airline'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#tabline#fnamemod = ':t'


Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-eunuch'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
autocmd FileType cpp,c,python map <buffer> <c-]> <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <leader>s :CocList symbols<cr>
command CocHover :call CocActionAsync('doHover')
command CocSwitchHeader :execute 'edit' CocRequest('clangd', 'textDocument/switchSourceHeader', {'uri': 'file://'.expand("%:p")})
nnoremap <leader>h :CocSwitchHeader<cr>


Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

Plug 'ramunas/vim-select'
nnoremap <leader>b :ShowBufferSelection<cr>
nnoremap <leader>f :ShowFileSelection<cr>
nnoremap <leader>g :ShowGitSelection<cr>
autocmd FileType Select let b:coc_suggest_disable = 1

command -nargs=1 Grep :ShowGrepList <args>
command -nargs=1 GitGrep :ShowGitGrepList <args>
command -nargs=1 GitGrepRoot :ShowGitGrepRootList <args>

call plug#end()


" Load man page plugin
runtime ftplugin/man.vim

let g:solarized_termcolors=256
" set background=light
" colorscheme solarized

" if &term == 'xterm-256color'
"     set termguicolors
" endif
let g:gruvbox_contrast_dark='soft'
let g:gruvbox_vert_split='blue'
" Colors for XTerm: https://github.com/morhetz/gruvbox-contrib/blob/master/xresources/gruvbox-dark.xresources
" set background=dark
" set background=light
" colorscheme gruvbox

" set background=light
" colorscheme onehalflight

set background=light
" check the end of the file for a colorschem patch
colorscheme sugarlily

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
set expandtab           " Use spaces in place of tabs
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set laststatus=2
set cinoptions=g0,(0,l1,J
set timeout timeoutlen=1000
set signcolumn=no
set timeoutlen=500

" turn on the modeline detection in files
set modeline
set modelines=10
set splitright
set nobackup

" where to search for `tags' file
set tags=./tags,./../tags

map <leader>n :nohlsearch<cr>
map <leader>m <leader>n

" Some basic mappings
map K k
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

" copy&paste to/from clipboard
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

autocmd BufNewFile,BufRead *.ML setf sml
autocmd BufNewFile,BufRead *.tex set ft=tex

autocmd FileType qf map <buffer> q :bd<cr>
autocmd FileType help map <buffer> q :bd<cr>

command ClearTrailingWhitespace normal mx<cr>:keepjumps keeppatterns %s/\s\+$//g<cr>`x
command! VimRC :e $MYVIMRC
command! HideGutter sign unplace *

command ClangFormat call rmns#FilterBufferCommand("clang-format")
command! JsPretty call rmns#FilterBufferCommand("prettier --parser=babel --tab-width=4")

" builtin javascript highlighter is missing keywords
autocmd FileType javascript syntax keyword Statement await async from

command Bdelete call rmns#DeleteBuffer2()
command -nargs=1 Info :call rmns#ShowGnuInfoDocPage('<args>')
command! -nargs=1 -range Enclose :s/\%V\(.*\)\%V\(.\)/<args>\1\2<args>/

autocmd FileType cpp,xml setlocal matchpairs+=<:>
autocmd FileType cmake setlocal sts=2 | setlocal sw=2

if getenv('TERM_PROGRAM') =~ 'Apple_Terminal'
    let &t_SI ="\e[5 q" "SI = INSERT mode
    let &t_SR ="\e[4 q" "SR = REPLACE mode
    let &t_EI ="\e[1 q" "EI = NORMAL mode (ELSE)
endif

call rmns#LoadAbbreviations()
command UpdateAbbreviations call rmns#LoadAbbreviations()

" fix the dark background of comments
highlight Comment cterm=NONE

function s:install_my_coc_packages()
    CocInstall coc-sh
    CocInstall coc-clangd
    CocInstall coc-python
    CocInstall coc-texlab
    CocInstall coc-json
    CocInstall coc-tsserver
    CocInstall coc-cmake
endfunction

command InstallMyCoc call s:install_my_coc_packages()

command UpgradeEverything :PlugUpgrade | :PlugUpdate | :CocUpdate
command UpdateEverything :UpgradeEverything


" When SIGUSR1 signal is received by vim, open ~/.vim/rfile. This is to open a
" file from a terminal running within vim.
" Put the following function in ~/.bashrc
" vimedit () { echo $PWD/$1 > $HOME/.vim/rfile && kill -SIGUSR1 $PPID; }
" then from terminal just do:
" vimedit file
autocmd! SigUSR1 * exec "split " . readfile(expand('~/.vim/rfile'))[0]

command! -range SendToTerm call rmns#SendBufLinesToTerminalBuffer(<line1>, <line2>)
map gt :SendToTerm<cr>

autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

" make the cursor visible on mate terminals
hi MatchParen ctermfg=0

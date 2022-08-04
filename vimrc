let mapleader = ","

" solves the problem of ouputing these raw in gnome-terminal
let &t_TI = ""
let &t_TE = ""

if !has("nvim") | set nocompatible | endif

if hostname() =~ "RamunassMacBook"
    set shell=/usr/local/bin/bash
endif


" install Plug if not instaled
let s:plug_path = '~/.vim/autoload/plug.vim'
if has("nvim") | let s:plug_path = '~/.config/nvim/autoload/plug.vim' | endif
let s:plug_url = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

if empty(glob(s:plug_path))
    execute "!curl -fLo " . s:plug_path . " --create-dirs " . s:plug_url
  autocmd VimEnter * PlugInstall --sync
endif


call plug#begin()

" colorschemes
"
Plug 'morhetz/gruvbox'
" Plug 'junegunn/seoul256.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'sonph/onehalf', {'rtp' : 'vim' }
" Plug 'rakr/vim-one'
" Plug 'nightsense/carbonized'
" Plug 'rakr/vim-two-firewatch'
Plug 'jnurmine/Zenburn'

Plug 'tomtom/tcomment_vim'
" tcomment
map <leader>cc gcc

Plug 'vim-scripts/Align'
Plug 'scrooloose/nerdtree'
map <leader>t :NERDTree<cr>
let g:NERDTreeHijackNetrw=0


Plug 'bling/vim-airline'

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
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <leader>s :CocList symbols<cr>
command CocHover :call CocActionAsync('doHover')
command CocSwitchHeader :execute 'edit' CocRequest('clangd', 'textDocument/switchSourceHeader', {'uri': 'file://'.expand("%:p")})
nnoremap <leader>h :CocSwitchHeader<cr>


Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

Plug 'ramunas/vim-select'
nnoremap <leader>b :call Buffers()<cr>
nnoremap <leader>f :call Files()<cr>
nnoremap <leader>g :call GitFiles()<cr>
autocmd FileType Select let b:coc_suggest_disable = 1

" Plug 'https://manu@framagit.org/manu/coq-au-vim.git'
" Plug 'jvoorhis/coq.vim'
" Plug 'rust-lang/rust.vim'

call plug#end()

" Load man page plugin
runtime ftplugin/man.vim

" let g:solarized_termcolors=256
" set background=light
" colorscheme solarized

let g:gruvbox_contrast_dark='soft'
let g:gruvbox_vert_split='blue'
" Colors for XTerm: https://github.com/morhetz/gruvbox-contrib/blob/master/xresources/gruvbox-dark.xresources
set background=dark
" set background=light
colorscheme gruvbox

" set background=light
" colorscheme onehalflight

" set background=light
" colorscheme carbonized-light

" colorscheme two-firewatch

" colorscheme zenburn


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

" live preview of the substitution command
if has('nvim') | set inccommand=nosplit | endif

let perl_want_scope_in_variables = 1
let perl_extended_vars = 1
let perl_string_as_statement = 1
let python_highlight_all = 1

" where to search for `tags' file
set tags=./tags,./../tags

map <leader>n :nohlsearch<cr>
map <leader>m <leader>n

" Some basic mappings
map Y y$
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

map <c-j> <c-w>-
map <c-k> <c-w>+
map <c-h> <c-w><
map <c-l> <c-w>>

map <c-t><c-h> :tabprevious<cr>
map <c-t><c-l> :tabnext<cr>
map <c-t><c-t> :tabnext<cr>

command TN :tabnew
command Tn :tabnew

" Make <esc> behave in terminal window like in an ordinary window.
if has('nvim')
    tnoremap <esc> <c-\><c-n>
endif

" Project specific settings
" autocmd BufNewFile,BufRead
"             \ /Users/ramunas/Dropbox/Projects/BroadastSessions/*.tex,/Users/ramunasgutkovas/Projects/BroadastSessions/*.tex
"             \ set tabstop=4 shiftwidth=4 ft=tex spell spelllang=en_gb

autocmd BufNewFile,BufRead *.ML setf sml
autocmd FileType qf map <buffer> q :bd<cr>
autocmd FileType help map <buffer> q :bd<cr>
autocmd BufNewFile,BufRead *.tex set ft=tex

command ClearTrailingWhitespace normal mx<cr>:keepjumps keeppatterns %s/\s\+$//g<cr>`x
command! VimRC :e $MYVIMRC
command! HideGutter sign unplace *

" highlight SignColumn ctermbg=DarkCyan ctermfg=DarkCyan

function ClangFormat()
    let p = getcurpos()
    :%!clang-format
    call setpos('.', p)
endfunction
command ClangFormat call ClangFormat()

function JavascriptPretty()
    let p = getcurpos()
    :%!prettier --stdin --parser=babel --tab-width=4
    call setpos('.', p)
endfunction
command JsPretty call JavascriptPretty()

" autocmd FileType javascript syntax keyword Statement await async from

" function DeleteBuffer()
"     python3 << EOF
" import vim
" buf = vim.current.window.buffer
" win = vim.current.window
" if len(vim.buffers) == 1:
"     vim.command("enew")
"
" nextbuffer = None
" for b in vim.buffers:
"     if b.number != buf.number:
"         nextbuffer = b
"         break
"
" if nextbuffer == None:
"     vim.command("bdelete")
" else:
"     for w in vim.windows:
"         if w.buffer.number == buf.number:
"             vim.current.window = w
"             vim.command("buffer %d" % nextbuffer.number)
"     vim.current.window = win
"
"     vim.command("bwipeout %d" % buf.number)
" EOF
" endfunction

" command Bdelete call DeleteBuffer()

command Bdelete call rmns#DeleteBuffer2()

function ShowInfo(x)
    new
    execute ':%!info ' . a:x
    syntax match Identifier |^\* .*:|
    syntax match Identifier |^\d.*$|
    syntax match Identifier |^=\+$|
    syntax match Identifier |^*\+$|
    setlocal nobuflisted nomodified buftype=nofile bufhidden=wipe readonly
    map q :q<cr>
endfunction
command -nargs=1 Info :call ShowInfo('<args>')


command! -nargs=1 -range Enclose :s/\%V\(.*\)\%V\(.\)/<args>\1\2<args>/

autocmd FileType cpp,xml setlocal matchpairs+=<:>
autocmd FileType cmake setlocal sts=2 | setlocal sw=2

if getenv('TERM_PROGRAM') =~ 'Apple_Terminal'
    let &t_SI ="\e[5 q" "SI = INSERT mode
    let &t_SR ="\e[4 q" "SR = REPLACE mode
    let &t_EI ="\e[1 q" "EI = NORMAL mode (ELSE)
endif

function LoadAbbreviations()
    set iskeyword+=\
    set iskeyword+=_
    python3 << EOF
import vim
import os
import os.path
shortcuts = os.environ['HOME'] + '/shortcuts'

if os.path.isfile(shortcuts):
    with open(shortcuts, 'r', encoding="utf-8") as f:
        for l,r in [x.strip().split(' ') for x in f]:
            vim.command('iabbrev %s %s' % (l,r))
EOF
endfunction

call LoadAbbreviations()
command UpdateAbbreviations call LoadAbbreviations()

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


function! GetVisibleTerminalBufNr()
    for x in term_list()
        let wid =  bufwinid(x)
        if wid > 0
            return x
        endif
    endfor
    return -1
endfunction

function! SendToTerminalBuffer(lnum1, lnum2)
    let buf = GetVisibleTerminalBufNr()
    if buf < 0
        echo "No terminal found"
        return
    endif

    " stutter copying to a terminal. Otherwise, the terminal might be too slow
    " at handling the characters, and some may be list and corrupted.
    for l in getline(a:lnum1, a:lnum2)
        sleep 1m
        call term_sendkeys(buf, l . "\n")
        redraw
    endfor

    " call term_sendkeys(buf, join(getline(a:lnum1, a:lnum2), "\n") . "\n")
endfunction

command! -range SendToTerm call SendToTerminalBuffer(<line1>, <line2>)
map gt :SendToTerm<cr>

autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

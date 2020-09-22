let mapleader = ","

if !has("nvim") | set nocompatible | endif


" install Plug if not instaled
let s:plug_path = '~/.vim/autoload/plug.vim'
if has("nvim") | let s:plug_path = '~/.config/nvim/autoload/plug.vim' | endif
let s:plug_url = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

if empty(glob(s:plug_path))
    execute "!curl -fLo " . s:plug_path . " --create-dirs " . s:plug_url
  autocmd VimEnter * PlugInstall --sync
endif


call plug#begin()

Plug 'morhetz/gruvbox'
Plug 'junegunn/seoul256.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'sonph/onehalf', {'rtp' : 'vim' }
Plug 'ayu-theme/ayu-vim'
Plug 'rakr/vim-one'

Plug 'tomtom/tcomment_vim'
" tcomment
map <leader>cc gcc

Plug 'vim-scripts/Align'
Plug 'scrooloose/nerdtree'
map <leader>t :NERDTree<cr>


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


Plug 'tpope/vim-fugitive'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

autocmd FileType cpp,c,python map <buffer> <c-]> <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'


Plug 'ramunas/vim-select'
nnoremap <leader>b :call Buffers()<cr>
nnoremap <leader>f :call Files()<cr>
nnoremap <leader>v :call LanguageClientSymbolList()<cr>
" Disable deoplete for the Select buffers
" if g:loaded_deoplete
" if g:deoplete#enable_at_startup
"     autocmd FileType Select call deoplete#custom#buffer_option('auto_complete', v:false)
" endif

autocmd FileType Select let b:coc_suggest_disable = 1

Plug 'https://manu@framagit.org/manu/coq-au-vim.git'
Plug 'jvoorhis/coq.vim'

Plug 'rust-lang/rust.vim'

call plug#end()

" Load man page plugin
runtime ftplugin/man.vim

" let g:solarized_termcolors=256
" set background=light
" colorscheme solarized

let g:gruvbox_contrast_dark='soft'
let g:gruvbox_vert_split='blue'
" Colors for XTerm: https://github.com/morhetz/gruvbox-contrib/blob/master/xresources/gruvbox-dark.xresources
" set background=dark
" colorscheme gruvbox

set background=light
colorscheme onehalflight



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
if has('nvim')
    set inccommand=nosplit
endif


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

function DeleteBuffer()
    python3 << EOF
import vim
buf = vim.current.window.buffer
win = vim.current.window
if len(vim.buffers) == 1:
    vim.command("enew")

nextbuffer = None
for b in vim.buffers:
    if b.number != buf.number:
        nextbuffer = b
        break

if nextbuffer == None:
    vim.command("bdelete")
else:
    for w in vim.windows:
        if w.buffer.number == buf.number:
            vim.current.window = w
            vim.command("buffer %d" % nextbuffer.number)
    vim.current.window = win

    vim.command("bwipeout %d" % buf.number)
EOF
endfunction

function ShowInfo(x)
    new
    execute ':%!info ' . a:x
    syntax match Type |^\* .*:|
    setlocal nobuflisted nomodified buftype=nofile bufhidden=wipe readonly
endfunction
command -nargs=1 Info :call ShowInfo('<args>')

command Bdelete call DeleteBuffer()

command! -nargs=1 -range Enclose :s/\%V\(.*\)\%V\(.\)/<args>\1\2<args>/

autocmd FileType cpp,xml setlocal matchpairs+=<:>
autocmd FileType cmake setlocal sts=2 | setlocal sw=2

" optional reset cursor on start:
" if &term =~ "xterm" && ! getenv('HOST') =~ 'eseln'
    " let &t_SI = "\e[6 q"
    " let &t_EI = "\e[2 q"

    let &t_SI ="\e[5 q" "SI = INSERT mode
    let &t_SR ="\e[4 q" "SR = REPLACE mode
    let &t_EI ="\e[1 q" "EI = NORMAL mode (ELSE)
" endif


function LoadAbbreviations()
    set iskeyword+=\
    set iskeyword+=_
    " set iskeyword+=-
    " set iskeyword+=>
    " set iskeyword+=<
    " set iskeyword+==
    " set iskeyword+=:
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


let mapleader = ","

if !has("nvim") | set nocompatible | endif

set rtp+=~/.config/nvim/myplugins



call plug#begin()

Plug 'altercation/vim-colors-solarized'
Plug 'tomtom/tcomment_vim'
" tcomment
map <leader>cc gcc

Plug 'vim-scripts/Align'
Plug 'scrooloose/nerdtree'
map <leader>t :NERDTree<cr>

Plug 'vim-scripts/tla.vim'
Plug 'flazz/vim-colorschemes'
Plug 'jreybert/vimagit'


Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"<Paste>


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


Plug 'neovimhaskell/haskell-vim'
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`



Plug 'Shougo/denite.nvim'

" Define mappings
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q denite#do_map('quit')
  nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
endfunction


nnoremap <leader>f :Denite file<cr>
nnoremap <leader>b :Denite buffer<cr>


if has('nvim')
else
    Plug 'roxma/vim-hug-neovim-rpc'
    Plug 'roxma/nvim-yarp'
endif


Plug 'Shougo/deoplete.nvim'
let g:deoplete#enable_at_startup = 1


" Plug 'xavierd/clang_complete'
" let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/'


Plug 'zchee/deoplete-jedi'
Plug 'carlitux/deoplete-ternjs'
Plug 'Shougo/neco-vim'  " deoplete completion for VimL commands
Plug 'Shougo/neco-syntax'  " deoplete completion for VimL syntax

Plug 'luochen1990/rainbow'


Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
let g:LanguageClient_serverCommands = {
  \ 'cpp': ['clangd'],
  \ }
let g:LanguageClient_diagnosticsEnable = v:false

function SetLSPShortcuts()
  nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
  nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
  nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
  nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
  nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
  nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
  nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
  nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
  nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
  nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
endfunction()

augroup LSP
  autocmd!
  autocmd FileType cpp,c call SetLSPShortcuts()
augroup END


call plug#end()



" True-color support
" set termguicolors

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


" turn on the modeline detection in files
set modeline
set modelines=10

set splitright
set nobackup

" live preview of the substitution command
if has('nvim')
    set inccommand=nosplit
endif


if has('nvim')
    " set termguicolors
endif


let perl_want_scope_in_variables = 1
let perl_extended_vars = 1
let perl_string_as_statement = 1
let python_highlight_all = 1
" Disable auto spell checking
" all - to all the file types
" none - for files which do not have a filetype
" let spell_auto_type=''

" where to search for `tags' file
set tags=./tags,./../tags


map <leader>n :nohlsearch<cr>
map <leader>m :nohlsearch<cr>

" Remap the annoying K to nothing
" map K <nop>


" goto beginning of line
imap <c-a> <c-o><home>
" goto end of line
imap <c-e> <c-o><end>
" forward by one charecter
imap <c-f> <right>
" move the cursor backward by one charecter
imap <c-b> <left>
" move down one line
imap <c-n> <down>
" delete the next charecter
imap <c-d> <c-o>x

cnoremap <c-a> <home>
cnoremap <c-b> <left>
cnoremap <c-d> <del>
cnoremap <c-e> <end>
cnoremap <c-f> <right>
cnoremap <c-n> <down>
cnoremap <c-p> <up>

" To use this mapping: first, delete some text (using any normal Vim command,
" such as daw, dt, in normal mode, x in visual mode). Then, use visual mode to
" select some other text, and press Ctrl-X. The two pieces of text should then
" be swapped.
vnoremap <C-X> <Esc>`.``gvP``P


map Y y$

" map j gj
" map k gk


noremap s :vsplit<cr>
noremap S :split<cr>


"filetype plugin indent on
"syntax on

" syn keyword smlKeyword as op


" load non-interactively current (in a buffer) file with pwb
autocmd FileType sml
            \ map gl :!pwb sml "@%:p"<CR>|
            \ map gi :!rlwrap pwb sml -i "@%:p"<CR>|
            \ map gz :!rlwrap pwb load-instance "%:p"<CR>



function RunLatex()
    RunInPanel pdflatex -halt-on-error main.tex && cp main.pdf a.pdf && cp main.pdf b.pdf
endfunction

if has('nvim')
    autocmd FileType tex map <buffer> gr :call RunLatex()<cr>
    " autocmd FileType tex map <buffer> gr :vsplit +terminal\ pdflatex\ -halt-on-error\ main.tex<CR>
else
    autocmd FileType tex map <buffer> gr :!pdflatex -halt-on-error main.tex<CR>
endif


if has('nvim')
    autocmd FileType cpp,c map <buffer> gr :vsplit +terminal\ make\ &&\ ./main<CR>
else
    autocmd FileType cpp,c map <buffer> gr :!make && ./main<CR>
endif


let g:solarized_termcolors=256
set background=light
" set background=dark
colorscheme solarized
" colorscheme tayra
" colorscheme xoria256


" disable lexical error highlighting in tex files
let g:tex_no_error=1


" Make <esc> behave in terminal window like in an ordinary window.
if has('nvim')
    tnoremap <esc> <c-\><c-n>
endif


" Working with git
if has('nvim')
    command GDiff te git diff
    command SDiff te svn diff | colordiff | less -r
else
    command GDiff !git diff
endif
command GPush :vsplit +terminal\ git\ push
command GPull :vsplit +terminal\ git\ pull
command Diff :GDiff
" command Pull :GPull
" command Push :GPush
command Push :RunInPanel git push
command Pull :RunInPanel git pull

command GLog :te git log


" Project specific settings
autocmd BufNewFile,BufRead
            \ /Users/ramunas/Dropbox/Projects/BroadastSessions/*.tex,/Users/ramunasgutkovas/Projects/BroadastSessions/*.tex
            \ set tabstop=4 shiftwidth=4 ft=tex spell spelllang=en_gb


autocmd BufNewFile,BufRead *.ML setf sml


autocmd FileType qf map <buffer> q :bd<cr>
autocmd FileType help map <buffer> q :bd<cr>


autocmd BufNewFile,BufRead *.tex set ft=tex




command ClearTrailingWhitespace normal mx<cr>:keepjumps keeppatterns %s/\s\+$//g<cr>`x
command! VimRC :e $MYVIMRC
command! MyVimRC :e $MYVIMRC
command! MyPlugins :e ~/.config/nvim/myplugins
command! MySnippets :e ~/.config/nvim/myplugins/snippets
command! Plugged :e ~/.config/nvim/plugged
command! HideGutter sign unplace *

" highlight SignColumn guibg=darkgrey
" highlight SignColumn ctermbg=LightYellow ctermfg=LightYellow
highlight SignColumn ctermbg=DarkCyan ctermfg=DarkCyan

" Fix the european keyboard layout
map § `
map ± ~
imap ± ~
imap § `



vim.g.mapleader = ','

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.tabstop = 2
vim.opt.cursorcolumn = false
vim.opt.ignorecase = false
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.number = false
vim.opt.relativenumber = false
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.signcolumn = "no"
vim.opt.splitright = true


vim.keymap.set('n', '<leader>n', ':nohlsearch<cr>')
vim.keymap.set('n', '<leader>m', ':nohlsearch<cr>')

vim.keymap.set({'i', 'c'}, '<c-a>', '<home>')
vim.keymap.set({'i', 'c'}, '<c-e>', '<end>')
vim.keymap.set({'i', 'c'}, '<c-f>', '<right>')
vim.keymap.set({'i', 'c'}, '<c-b>', '<left>')
vim.keymap.set({'i', 'c'}, '<c-p>', '<up>')
vim.keymap.set({'i', 'c'}, '<c-n>', '<down>')
vim.keymap.set('i', '<c-d>', '<c-o>x')
vim.keymap.set('c', '<c-d>', '<del>')

vim.keymap.set('n', '<c-j>', '<c-w>-')
vim.keymap.set('n', '<c-k>', '<c-w>+')
vim.keymap.set('n', '<c-h>', '<c-w><')
vim.keymap.set('n', '<c-l>', '<c-w>>')

vim.keymap.set('n', 'Y', 'y$')
vim.keymap.set('v', 'gy', '"+y')
vim.keymap.set('n', 'gp', '"+p')
vim.keymap.set('n', 'gP', '"+P')

vim.keymap.set('n', '<C-t><C-h>', ':tabprevious<CR>')
vim.keymap.set('n', '<C-t><C-l>', ':tabnext<CR>')
vim.keymap.set('n', '<C-t><C-t>', ':tabnext<CR>')

vim.keymap.set('t', '<c-w>', '<c-\\><c-n><c-w>')
vim.cmd([[autocmd TermOpen * startinsert]])

vim.cmd([[
autocmd FileType cpp,c setlocal formatprg=clang-format
autocmd FileType javascript,javascriptreact setlocal formatprg=npx\ prettier\ --parser=babel\ --tab-width\ 4
]])

vim.lsp.enable('clangd')
vim.cmd [[map <leader>h :LspClangdSwitchSourceHeader<cr>]]

vim.lsp.enable('ts_ls') -- javascript, jsx, etc.
vim.lsp.enable('cmake')
vim.lsp.enable('bashls')
vim.lsp.enable('pyright') -- python

-- To install plug.vim
-- curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
--       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-eunuch'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'itchyny/vim-cursorword'
Plug 'tomtom/tcomment_vim'
Plug 'nvim-tree/nvim-tree.lua' -- side-bar file browser
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'sainnhe/everforest'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter'

vim.call('plug#end')

vim.opt.background = 'light'
vim.cmd 'colorscheme everforest'

vim.cmd([[map <leader>cc gcc]])

pcall(function()
	require("telescope").setup({
		pickers = {
			find_files = {
				hidden = true
			}
		}
	})

	local builtin = require('telescope.builtin')
	vim.keymap.set('n', '<leader>b', builtin.buffers)
	vim.keymap.set('n', '<leader>f', builtin.find_files)
	vim.keymap.set('n', '<leader>g', builtin.live_grep)
	vim.keymap.set('n', '<leader>s', builtin.lsp_document_symbols)
end)

pcall(function()
	require("nvim-tree").setup({
		respect_buf_cwd = true,
		renderer = {
			icons = {
				show = {
					file = false,
					folder = false,
					folder_arrow = true,
				},
				glyphs = {
					folder = {
						arrow_closed = '>',
						arrow_open = 'v'
					}
				}
			}
		}
	})

	vim.keymap.set('n', '<leader>t', ':NvimTreeOpen<cr>')
end)

-- vim.treesitter.language.register('tsx', { 'javascriptreact' })
-- vim.api.nvim_create_autocmd( 'FileType', { pattern = 'javascriptreact',
-- callback = function(args)
-- 	vim.treesitter.start()
-- 	-- vim.treesitter.start(args.buf, 'javascript')
-- 	--vim.bo[args.buf].syntax = 'on'  -- only if additional legacy syntax is needed
-- end})

vim.api.nvim_create_user_command('To', function()
	local bufnr = vim.api.nvim_get_current_buf()
	vim.cmd.tabnew()
	vim.cmd(string.format("buffer %d", bufnr))
end, {})
vim.api.nvim_create_user_command('TO', ':To', {})

vim.api.nvim_create_user_command('Bdelete', function()
	local bufnr = vim.api.nvim_get_current_buf()
	vim.cmd('bnext')
	vim.api.nvim_buf_delete(bufnr, {})
end, {})

vim.cmd [[command! -nargs=0 -bar Cdt :execute "cd " trim(system("git rev-parse --show-toplevel"))]]

-- When SIGUSR1 signal is received by vim, open ~/.vim/rfile. This is to open a
-- file from a terminal running within vim.
-- Put the following function in ~/.bashrc
-- vimedit () { echo $PWD/$1 > $HOME/.vim/rfile && kill -SIGUSR1 $PPID; }
-- then from terminal just do:
-- vimedit file
-- vim.cmd("autocmd! SigUSR1 * exec 'split ' .. readfile(expand('~/.vim/rfile'))[0]")
vim.cmd("autocmd! Signal SIGUSR1 exec 'split ' .. readfile(expand('~/.vim/rfile'))[0]")


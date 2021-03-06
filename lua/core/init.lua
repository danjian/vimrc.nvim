local M = {}

function M:setup()
	M:before()

	require("core.loader"):setup()

	M:after()
end

function M:before()
	helper.vim.wo.fillchars='eob: '
	helper.vim.opt.termguicolors = true

	-- 基础配置
	helper.command('set enc=utf-8')
	helper.command('set ruler')
	helper.command('set number')
	helper.command('set relativenumber')
	helper.command('set langmenu=en')
	helper.command('set guioptions-=r')
	helper.command('set guioptions-=L')
	helper.command('set guioptions-=b')
	helper.command('set guioptions+=!')
	helper.command('set completeopt=menuone,noinsert,noselect,preview')
	helper.command('set hidden')
	helper.command('set expandtab')
	helper.command('set tabstop=4')
	helper.command('set shiftwidth=4')
	helper.command('set termguicolors')
	helper.command('set nowritebackup')
	helper.command('set hidden')
	helper.command('set encoding=utf-8')
	helper.command('set cmdheight=2')
	helper.command('set updatetime=100')
	helper.command('set dir=~/.vim.swcache')
	helper.command('set udir=~/.vim.swcache')
	helper.command('set bdir=~/.vim.swcache')
	helper.command('set nocompatible')
	helper.command('set autoindent')
	helper.command('set fileformat=unix')
	helper.command('set clipboard=unnamed')
	helper.command('syntax enable')

	-- disbale netrw file explorer
	helper.command("let loaded_netrwPlugin=1")
	-- color scheme
	helper.command("colorscheme vim-monokai-tasty")
	-- gitsigns
	helper.command("autocmd BufEnter * :highlight link GitSignsCurrentLineBlame Visual")
    -- number
	helper.command("autocmd! InsertEnter * :set norelativenumber")
	helper.command("autocmd! InsertLeave * :set relativenumber")
end


function M:after()    
    -- select default project
    require("core.util"):selectProject()

    -- bind keymaps
    require("core.keymap"):setup()
end

return M
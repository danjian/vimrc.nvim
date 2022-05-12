local M = {}

local opts = { noremap=true, silent=true }


function M:setup()
	-- basic
	helper.keymap("n", "<leader><leader>", '<C-W>w', opts)
    helper.keymap("n", "<leader>h", '<C-W>h', opts)
    helper.keymap("n", "<leader>l", '<C-W>l', opts)
    helper.keymap("n", "<C-l>", ':lua require("component.session").load()<CR>', opts)
    helper.keymap("n", "<C-s>", ':lua require("component.session").save()<CR>', opts)
	helper.keymap("n", "<C-w>", ':w<CR>', opts)
	helper.keymap("n", "<C-c>", ':w !pbcopy<CR>', opts)

    -- basic tab switch
    helper.keymap("n", "<Tab>1", ':tabn 1<CR>', opts)
    helper.keymap("n", "<Tab>2", ':tabn 2<CR>', opts)
    helper.keymap("n", "<Tab>3", ':tabn 3<CR>', opts)
    helper.keymap("n", "<Tab>4", ':tabn 4<CR>', opts)
    helper.keymap("n", "<Tab>5", ':tabn 5<CR>', opts)
    helper.keymap("n", "<Tab>c1", ':tabclose 1<CR>', opts)
    helper.keymap("n", "<Tab>c2", ':tabclose 2<CR>', opts)
    helper.keymap("n", "<Tab>c3", ':tabclose 3<CR>', opts)
    helper.keymap("n", "<Tab>c4", ':tabclose 4<CR>', opts)
    helper.keymap("n", "<Tab>c5", ':tabclose 5<CR>', opts)
    helper.keymap("n", "<Tab>cc", ':tabclose<CR>', opts)

	-- nvim tree
	helper.keymap("n","ff",':lua require("component.fileexplorer").fileManager()<CR>',opts)
    helper.keymap("n", "fc", ':NvimTreeFindFile <CR>', opts)
    helper.command("autocmd BufEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), '&filetype') == 'NvimTree' | quit | endif")

    -- buffline
    helper.keymap("n", "<leader>1", ':lua require("component.bufferline"):gotoId(1)<CR>', opts)
    helper.keymap("n", "<leader>2", ':lua require("component.bufferline"):gotoId(2)<CR>', opts)
    helper.keymap("n", "<leader>3", ':lua require("component.bufferline"):gotoId(3)<CR>', opts)
    helper.keymap("n", "<leader>4", ':lua require("component.bufferline"):gotoId(4)<CR>', opts)
    helper.keymap("n", "<leader>5", ':lua require("component.bufferline"):gotoId(5)<CR>', opts)
    helper.keymap("n", "<leader>6", ':lua require("component.bufferline"):gotoId(6)<CR>', opts)
    helper.keymap("n", "<leader>7", ':lua require("component.bufferline"):gotoId(7)<CR>', opts)
    helper.keymap("n", "<leader>8", ':lua require("component.bufferline"):gotoId(8)<CR>', opts)
    helper.keymap("n", "<leader>9", ':lua require("component.bufferline"):gotoId(9)<CR>', opts)
    helper.keymap("n", "<leader>0", ':lua require("component.bufferline"):gotoId(10)<CR>', opts)
    helper.keymap("n", "<leader>cc", ':BufDel<CR>', opts)
    helper.keymap("n", "<leader>cl", ':BufferLineCloseLeft<CR>', opts)
    helper.keymap("n", "<leader>cr", ':BufferLineCloseRight<CR>', opts)
    helper.keymap("n", "<leader>e", ':e!<CR>', opts)
    helper.keymap("n", "<leader>r", ':BufferLineMoveNext<CR>', opts)
    helper.keymap("n", "<leader>l", ':BufferLineMovePrev<CR>', opts)

    -- lsp basic
    helper.vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
	helper.vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
	helper.vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
	helper.vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)


    -- telescope
	helper.keymap("n", "sf", ':lua require("component.telescope").findFiles()<CR>', opts)
    helper.keymap("n", "ss", ':lua require("telescope.builtin").live_grep()<CR>', opts)
    helper.keymap("n", "slr", ':lua require("telescope.builtin").lsp_references()<CR>', opts)
    helper.keymap("n", "sld", ':lua require("telescope.builtin").lsp_definitions()<CR>', opts)
    helper.keymap("n", "sls", ':lua require("telescope.builtin").lsp_document_symbols()<CR>', opts)
    helper.keymap("n", "sle", ':lua require("telescope.builtin").diagnostics()<CR>', opts)
    helper.keymap("n", "slt", ':lua require("telescope.builtin").treesitter()<CR>', opts)
    helper.keymap("n", "sb", ':lua require("telescope.builtin").buffers()<CR>', opts)
    helper.keymap("n", "sk", ':lua require("telescope.builtin").keymaps()<CR>', opts)
    helper.keymap("n", "sp", ':lua require("component.telescope").selectProjects()<CR>', opts)
    helper.keymap("n", "sgb", ':lua require("component.telescope").selectGitBranches()<CR>', opts)
    helper.keymap("n", "sgd", ':DiffviewOpen<CR>', opts)
    helper.keymap("n", "sgh", ':DiffviewFileHistory<CR>', opts)


    -- float terminal
    helper.keymap("n", "`t", '<CMD>lua require("FTerm").toggle()<CR>', opts)
    helper.keymap("t", "`t", '<C-\\><C-n>:lua require("FTerm").toggle()<CR>', opts)
end


function M:lspAttach(_, bufnr)
	helper.vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	helper.vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	helper.vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	helper.vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	helper.vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	helper.vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	helper.vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	helper.vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	helper.vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	helper.vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	helper.vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	helper.vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	helper.vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	helper.vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

return M
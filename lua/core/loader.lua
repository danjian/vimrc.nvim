local M = {
    components = {
    	-- LSP
        "lsp",
        -- 浮动终端
        "terminal",
        -- vim底部状态栏
        "statusline",
        -- 缓冲区状态栏
        "bufferline",
        -- 文件管理器
        'fileexplorer',
        -- 检索器
        'telescope',
        -- 启动仪表板
        'dashboard',
        -- git
        "git",
    }
}

function M:setup()
    M:before()

    -- 加载组件
    for _, component in ipairs(self.components) do
        if not helper.debug then
            local ok, c = pcall(require, "component." .. component)
            if ok then
                c:setup()
            end
        else
            require("component." .. component):setup()
        end
    end

    M:after()
end

function M:before()
    helper.packer.startup(
        function()
            use {"wbthomason/packer.nvim"}
            use {"glepnir/dashboard-nvim"}
            use {"nvim-telescope/telescope.nvim", requires = {{"nvim-lua/plenary.nvim"}}}
            use {"patstockwell/vim-monokai-tasty"}
            use {"akinsho/bufferline.nvim", tag = "*"}
            use {"nvim-lualine/lualine.nvim"}
            use {
                "kyazdani42/nvim-tree.lua",
                requires = {
                    "kyazdani42/nvim-web-devicons"
                }
            }
            use {"neovim/nvim-lspconfig"}
            use {"williamboman/nvim-lsp-installer"}

            use {"hrsh7th/cmp-nvim-lsp"}
            use {"hrsh7th/cmp-buffer"}
            use {'hrsh7th/cmp-path'}
            use {"hrsh7th/cmp-cmdline"}
            use {"hrsh7th/nvim-cmp"}
            -- vsnip users
            use {"hrsh7th/cmp-vsnip"}
            use {"hrsh7th/vim-vsnip"}
            
            use {"nvim-lua/lsp-status.nvim"}
            use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
            use {"lewis6991/gitsigns.nvim"}
            use {"numToStr/FTerm.nvim"}
            use {'numToStr/Comment.nvim'}
        end
    )
end

function M:after()
end

return M

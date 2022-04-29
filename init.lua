-- 全局变量
_G.helper = {
    -- 全部项目列表
    projects = {},
    -- 当前项目
    project = {},
    -- 是否debug模式
    debug = true,
    -- vim
    g =  vim.g,
    -- 包管理工具
    packer = nil,
    -- neovim映射
    vim = vim,
    fn = vim.fn,
    command = vim.api.nvim_command,
    keymap = vim.api.nvim_set_keymap,
}

-- 项目信息初始化
_G.helper.projects = { 
    {
        id = 1,
        name = "My Project",
        icon = "🚀",
        dir  = "~/",
        lsp_dir =  "~/",
        desc = "根目录",
    },
}

-- 默认项目
_G.helper.project = helper.projects[1]

-- 配置nvim
local nvim = require("nvim")
if not nvim:prepared() then
    nvim:prepare()
end
nvim:setup()

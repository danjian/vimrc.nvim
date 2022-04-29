local M = {}

function M:setup()
    local config = {
        options = {
            icons_enabled = true,
            theme = M:themes(),
            component_separators = {left = "", right = ""},
            section_separators = {left = "", right = ""},
            disabled_filetypes = {},
            always_divide_middle = true,
            globalstatus = true
        },
        sections = {
            lualine_a = {"mode"},
            lualine_b = {"branch"},
            lualine_c = {},
            lualine_x = {"filetype","diff", "diagnostics"},
            lualine_y = {"progress"},
            lualine_z = {"location"}
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {"filename"},
            lualine_x = {"location"},
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {},
        extensions = {}
    }
    -- M:insertComponentRight(config,{  
    --     function()
    --     local msg = ''
    --     local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    --     local clients = vim.lsp.get_active_clients()
    --     if next(clients) == nil then
    --       return msg
    --     end
    --     for _, client in ipairs(clients) do
    --       local filetypes = client.config.filetypes
    --       if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
    --         return ' '..client.name
    --       end
    --     end
    --     return msg
    --   end,
    --   icon = '',
    --   color = { fg = '#ffffff', gui = '' },}
    -- );

    require("lualine").setup(config)
end

function M:themes()
    local colors = {
        black = "#1c1e26",
        white = "#6C6F93",
        red = "#F43E5C",
        green = "#09F7A0",
        blue = "#25B2BC",
        yellow = "#F09383",
        gray = "#E95678",
        darkgray = "#1A1C23",
        lightgray = "#2E303E",
        inactivegray = "#1C1E26",
        dark = "#000000",
        light = "#FFFFFF",
    }

    return {
        normal = {
            a = {bg = colors.green, fg = colors.dark, gui = "bold"},
            b = {bg = colors.lightgray, fg = colors.light},
            c = {bg = colors.darkgray, fg = colors.light}
        },
        insert = {
            a = {bg = colors.blue, fg = colors.black, gui = "bold"},
            b = {bg = colors.lightgray, fg = colors.white},
            c = {bg = colors.darkgray, fg = colors.white}
        },
        visual = {
            a = {bg = colors.yellow, fg = colors.black, gui = "bold"},
            b = {bg = colors.lightgray, fg = colors.white},
            c = {bg = colors.darkgray, fg = colors.white}
        },
        replace = {
            a = {bg = colors.red, fg = colors.black, gui = "bold"},
            b = {bg = colors.lightgray, fg = colors.white},
            c = {bg = colors.darkgray, fg = colors.white}
        },
        command = {
            a = {bg = colors.gray, fg = colors.black, gui = "bold"},
            b = {bg = colors.lightgray, fg = colors.white},
            c = {bg = colors.darkgray, fg = colors.white}
        },
        inactive = {
            a = {bg = colors.inactivegray, fg = colors.lightgray, gui = "bold"},
            b = {bg = colors.inactivegray, fg = colors.lightgray},
            c = {bg = colors.inactivegray, fg = colors.lightgray}
        }
    }
end

function M:insertComponentRight(config,component)
  table.insert(config.sections.lualine_x, component)
end

return M

local M = {}

local branchStatusCache = {}
local outputCache = {}
local diffJob = nil

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
            lualine_x = {"filetype", "diff", "diagnostics"},
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
    -- branch status
    M:insertComponentRight(
        config.sections.lualine_b,
        {
            function()
                return branchStatusCache[helper.vim.api.nvim_get_current_buf()] or ''
            end,
            color = { fg = 'yellow' }
        }
    )

    require("lualine").setup(config)
    M:after()
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
        light = "#FFFFFF"
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

function M:updateBranchStatusArgs()
    if #vim.fn.expand("%") == 0 then
        M.status_args = nil
        return
    end
    local trim = require("core.util").trim

    local git_dir = require("lualine.components.branch.git_branch").find_git_dir()
    if git_dir == nil or git_dir == ""  then
        M.status_args = nil
        return
    end
    local work_dir = string.sub(git_dir, 1, -5)
    local cmd = string.format('git -C %s --no-pager diff --no-color --no-ext-diff -U0',work_dir)

    M.status_args = {
        cmd = cmd,
        on_stdout = function(_, data,e)
            if next(data) then
                outputCache = vim.list_extend(outputCache, data)
            end
        end,
        on_stderr = function(_, data,e)
            data = table.concat(data, "\n")
            if #data > 0 then
                outputCache = {}
            end
        end,
        on_exit = function(id, data, event)
            local branchStatus = ""
            if #outputCache > 0 and trim(outputCache[1]) ~='' then
                branchStatus = "✗"
            end
            branchStatusCache[helper.vim.api.nvim_get_current_buf()] = branchStatus
        end
    }
    M:updateBranchStatus()
end

function M:updateBranchStatus()
    if M.status_args ~= nil then
        outputCache = {}
        if diffJob then
            diffJob:stop()
        end

        diffJob = require("core.util.job"):job(M.status_args)
        if diffJob then
            diffJob:start()
        end
    end
end


function M:insertComponentRight(section, component)
    table.insert(section, component)
end

local function check(data)
    for _, line in ipairs(data) do
        print(line)
    end
end

function M:after()
    helper.command("autocmd BufEnter * lua require('component.statusline'):updateBranchStatusArgs()")
    helper.command("autocmd BufWritePost * lua require('component.statusline'):updateBranchStatus()")
end

return M

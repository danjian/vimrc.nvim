local M = {}

function M:setup()
    require("telescope").setup(
        {
            defaults = {
                layout_config = {
                    vertical = {width = 0.5}
                }
            }
        }
    )
    M:after()
end

function M:findFiles()
    require("telescope.builtin").find_files({search_dirs = {helper.dir}})
end

function M:grepString()
    require("telescope.builtin").grep_string({search_dirs = {helper.dir}})
end

function M:selectProjects()
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local opts = {}
    local actions = require "telescope.actions"
    local action_state = require "telescope.actions.state"

    local results = {}
    for _, entry in ipairs(helper.projects) do
      table.insert(results, entry)
    end

    local view = require('nvim-tree.view')
    if view.is_visible() then
        pcall(view.close, "")
    end

    pickers.new(opts, {
        prompt_title = "Select Project",
        finder = finders.new_table {
            results = results,
            entry_maker = function(entry)
                return {
                  value = entry,
                  ordinal = entry.id,
                  display = entry.icon .. " 【" .. entry.name.."】".. entry.desc,
                }
            end,
        },
        previewer = nil,
        sorter = nil,
        attach_mappings = function(_)
            actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                if selection == nil then
                  return
                end
                -- 选择时，切换项目信息
                helper.project = selection.value

                require("core.util"):selectProject()
                require("component.fileexplorer").fileManager()
            end)
            return true
        end,
    }):find()
end

function M:after()
end

function M:selectGitBranches()
    local git_dir = require("lualine.components.branch.git_branch").find_git_dir()
    local work_dir = string.sub(git_dir, 1, -5)
    require("telescope.builtin").git_branches({ cwd =  work_dir})
end

return M

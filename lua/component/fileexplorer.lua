local M = {}

function M:setup()
    require("nvim-tree").setup {
        auto_reload_on_write = true,
        disable_netrw = false,
        hijack_cursor = false,
        hijack_netrw = true,
        hijack_unnamed_buffer_when_opening = false,
        ignore_buffer_on_setup = false,
        open_on_setup = false,
        open_on_setup_file = false,
        open_on_tab = false,
        sort_by = "name",
        update_cwd = false,
        view = {
            width = 30,
            height = 30,
            hide_root_folder = true,
            side = "left",
            preserve_window_proportions = false,
            number = false,
            relativenumber = false,
            signcolumn = "yes",
            mappings = {
                custom_only = false,
                list = {
				    { key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
				    { key = "<C-e>", action = "edit_in_place" },
				    { key = "O", action = "edit_no_picker" },
				    { key = { "<2-RightMouse>", "<C-]>" }, action = "cd" },
				    { key = "<C-v>", action = "vsplit" },
				    { key = "<C-x>", action = "split" },
				    { key = "<C-t>", action = "tabnew" },
				    { key = "<", action = "prev_sibling" },
				    { key = ">", action = "next_sibling" },
				    { key = "P", action = "parent_node" },
				    { key = "<BS>", action = "close_node" },
				    { key = "<Tab>", action = "" },
				    { key = "K", action = "first_sibling" },
				    { key = "J", action = "last_sibling" },
				    { key = "I", action = "toggle_git_ignored" },
				    { key = "H", action = "toggle_dotfiles" },
				    { key = "R", action = "refresh" },
				    { key = "a", action = "create" },
				    { key = "d", action = "remove" },
				    { key = "D", action = "trash" },
				    { key = "r", action = "rename" },
				    { key = "<C-r>", action = "full_rename" },
				    { key = "x", action = "cut" },
				    { key = "c", action = "copy" },
				    { key = "p", action = "paste" },
				    { key = "y", action = "copy_name" },
				    { key = "Y", action = "copy_path" },
				    { key = "gy", action = "copy_absolute_path" },
				    { key = "[c", action = "prev_git_item" },
				    { key = "]c", action = "next_git_item" },
				    { key = "-", action = "dir_up" },
				    { key = "q", action = "close" },
				    { key = "g?", action = "toggle_help" },
				    { key = "W", action = "collapse_all" },
				    { key = "S", action = 'system_open' },
				    { key = "s", action = '' },
				    { key = ".", action = "run_file_command" },
				    { key = "<C-k>", action = "toggle_file_info" },
				    { key = "U", action = "toggle_custom" },
				                }
            }
        },
        renderer = {
            indent_markers = {
                enable = false,
                icons = {
                    corner = "└ ",
                    edge = "│ ",
                    none = "  "
                }
            },
            icons = {
                webdev_colors = true
            }
        },
        hijack_directories = {
            enable = true,
            auto_open = true
        },
        update_focused_file = {
            enable = false,
            update_cwd = false,
            ignore_list = {}
        },
        ignore_ft_on_setup = {},
        system_open = nil,
        diagnostics = {
            enable = false,
            show_on_dirs = false,
            icons = {
                hint = "",
                info = "",
                warning = "",
                error = ""
            }
        },
        filters = {
            dotfiles = false,
            custom = {},
            exclude = {
            }
        },
        git = {
            enable = true,
            ignore = true,
            timeout = 1000
        },
        actions = {
            use_system_clipboard = true,
            change_dir = {
                enable = true,
                global = false,
                restrict_above_cwd = false
            },
            open_file = {
                quit_on_open = false,
                resize_window = true,
                window_picker = {
                    enable = true,
                    chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                    exclude = {
                        filetype = {"notify", "packer", "qf", "diff", "fugitive", "fugitiveblame"},
                        buftype = {"nofile", "terminal", "help"}
                    }
                }
            }
        },
        trash = {
            cmd = "trash",
            require_confirm = true
        },
        log = {
            enable = false,
            truncate = false,
            types = {
                all = false,
                config = false,
                copy_paste = false,
                diagnostics = false,
                git = false,
                profile = false
            }
        },
    }

    M:after()
end

function M:fileManager( show )
	local view = require('nvim-tree.view')
    if view.is_visible() then
        view.close()
    else
        local previous_buf = helper.vim.api.nvim_get_current_buf()
        require('nvim-tree').open(helper.project.dir)
        helper.vim.cmd "noautocmd wincmd p"
    end
end

function M:focus()
    require("nvim-tree").focus(true)
end


function M:after()
	helper.keymap("n","ff",':lua require("component.fileexplorer").fileManager()<CR>',{noremap = true, silent = true})
    helper.keymap("n", "fc", ':lua require("component.fileexplorer").focus()<CR>', {noremap = true, silent = true})
    helper.command("autocmd BufEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), '&filetype') == 'NvimTree' | quit | endif")
end
return M

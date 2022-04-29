local M = {}

function M:setup()
    local g = helper.g
	g.dashboard_custom_header = {
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        " ______ _            _                                 _     __        _             ",
        "(_) |  | |        \\_|_)                       |       | |   (_|\\      | |    |       ",
        "    |  | |   _      |    _  __   _   _  _   __|    __ | |      /   _  | |  __|   __  ",
        "    |  |/ \\ |/     _|   |/ /  | |/  / |/ | /  |   /  \\|/      /  /|/  |/  /  |  /  | ",
        " (_/\\_/|   ||__  \\(/\\___|__\\_/|/|__/  |  |_\\_/|_  \\__/|__/   /__/ |__/|__/\\_/|_/\\_/|_",
        "                             /|                       |\\      /|                     ",
        "                             \\|                       |/      \\|                     ",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
    }
    g.dashboard_default_executive = "telescope"
    g.dashboard_session_directory = helper.fn.stdpath("data") .. "/sessions"
    g.dashboard_custom_section = {
        find_file = {
            description = {"Find File           sf"},
            command = 'lua require("component.telescope").findFiles()'
        },
        file_explorer = {
            description = {"File Manager        ff"},
            command = 'lua require("component.fileexplorer").fileManager("open")'
        },
        find_string = {
            description = {"Grep String         ss"},
            command = 'lua require("component.telescope").grepString()'
        },
        last_session = {
            description = {"Load Session        ls"},
            command = 'lua vim.cmd(":silent RestoreSession")'
        }
    }
    g.dashboard_custom_footer = {
        "",
        "",
        "",
        "",
        "",
        "",
    }
end

return M
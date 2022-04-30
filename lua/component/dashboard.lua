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
    }
    g.dashboard_default_executive = "telescope"
    g.dashboard_custom_section = {
        _1 = {
            description = {" File Search         sf"},
            command = 'lua require("component.telescope").findFiles()'
        },
        _2 = {
            description = {" File Manager        ff"},
            command = 'lua require("component.fileexplorer").fileManager("open")'
        },
        _3 = {
            description = {" Pick Project        sp"},
            command = 'lua require("component.telescope").selectProjects()'
        },
        _4 = {
            description = {" Load Session      <C-l>"},
            command = 'lua require("component.session").load()'
        }
    }
    g.dashboard_custom_footer = {
        "",
        "",
        "",
        "",
        "",
        "talk is cheap, show me the code",
    }
end

return M
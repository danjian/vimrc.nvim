local M = {}

function M:selectProject()
    helper.command("cd " .. helper.project.dir)
    require("component.lsp"):setup()
end

function M.trim(s)
    return s:gsub("^%s+", ""):gsub("%s+$", "")
end

function M.split(s, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(s, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

return M

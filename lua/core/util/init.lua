local M = {}

function M:selectProject()
	helper.command("cd ".. helper.project.dir)
	require("component.lsp"):setup()
end


function M.trim(s)
	return s:gsub("^%s+", ""):gsub("%s+$", "")
end

return M
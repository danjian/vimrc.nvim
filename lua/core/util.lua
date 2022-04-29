local M = {}

function M:selectProject()
	helper.command("cd ".. helper.project.dir)
	require("component.lsp"):setup()
end

return M
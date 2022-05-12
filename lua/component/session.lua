local M = {}

function M:setup()

end

function M:load()
	local session = {}
	local json = require("core.util.json")
	local f = io.open(os.getenv("HOME").."/.nvim.session","r")

	if f ~= nil then
		io.input(f)
		local str = io.read()
		session = json.decode(str)
		helper.project = session.project
		for _,v in ipairs(session.buffers) do
			helper.command("badd "..v)
			if session.current == nil or session.current == "" then
				session.current = v
			end
		end
	end
	local view = require('nvim-tree.view')
    if view.is_visible() then
    	pcall(view.close,{})
    end
    require("core.util"):selectProject()
    require("component.fileexplorer").fileManager()
	helper.command("e ".. session.current)
    print("Session loaded!")
end


function M:save()
	local json = require("core.util.json")
	local state = require("bufferline.state")
    local commands = require("bufferline.commands")
    local session = {
    	project = helper.project,
    	buffers = {},
    	current = '',
    }
    local length = #state.components
    local index = commands.get_current_element_index(state)
    for _, item in ipairs(helper.vim.list_slice(state.components, 1, length)) do
		local t = helper.vim.api.nvim_buf_get_name(item.id)
		table.insert(session.buffers,t)
		if _ == index then
			session.current = t
		end
    end

    local f = io.open(os.getenv("HOME").."/.nvim.session","w+")
    f:write(json.encode(session))
    f:close()
    print("Session saved!")
end

return M
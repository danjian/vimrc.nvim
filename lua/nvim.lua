local M =  {}

-- 核心配置
function M:setup()
	require("core"):setup();
end

-- 检查packer
function M:prepared()
	local ok, packer = pcall(require, 'packer')
	if ok then
		helper.packer = packer
	end
	return ok
end

-- 安装packer
function M:prepare()
	print("Packer is installing")
	local path = helper.fn.stdpath("data").. '/site/pack/packer/start/packer.nvim'
	local output = helper.fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', path })
	if helper.vim.v.shell_error ~= 0 then
        vim.notify(output, 'Error')
    end
    helper.command('quitall')
end

return M
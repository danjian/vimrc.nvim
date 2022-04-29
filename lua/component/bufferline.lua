local M = {}

function M:setup()
    require("bufferline").setup {
        options = {
            mode = "buffers",
            numbers = "ordinal",
            close_icon = "",
            indicator_icon = "▎",
            buffer_close_icon = "",
            modified_icon = "~",
            left_trunc_marker = "",
            right_trunc_marker = "",
            diagnostics = "nvim_lsp",
		    diagnostics_update_in_insert = true,
		    diagnostics_indicator = function(count, level, diagnostics_dict, context)
                return ''
		    end,
			show_buffer_icons = true,
			show_buffer_default_icon = true,
            separator_style = "slant",
            always_show_bufferline = true,
            sort_by = "id",
            persist_buffer_sort = true,
            show_tab_indicators= true,
            offsets = {{filetype = "NvimTree", text = "File Explorer", text_align = "center"}},
		},
        highlights = {
            buffer_selected = {
              gui = "none",
              guifg = "white"
            },
            numbers_selected = {
              gui = "none",
              guifg = "white"
            },
        },
    }

    M:after()
end

function M:after()
    helper.keymap("n", "<Tab>1", ':BufferLineGoToBuffer 1<CR>', {noremap = true, silent = true})
    helper.keymap("n", "<Tab>2", ':BufferLineGoToBuffer 2<CR>', {noremap = true, silent = true})
    helper.keymap("n", "<Tab>3", ':BufferLineGoToBuffer 3<CR>', {noremap = true, silent = true})
    helper.keymap("n", "<Tab>4", ':BufferLineGoToBuffer 4<CR>', {noremap = true, silent = true})
    helper.keymap("n", "<Tab>5", ':BufferLineGoToBuffer 5<CR>', {noremap = true, silent = true})
    helper.keymap("n", "<Tab>6", ':BufferLineGoToBuffer 6<CR>', {noremap = true, silent = true})
    helper.keymap("n", "<Tab>7", ':BufferLineGoToBuffer 7<CR>', {noremap = true, silent = true})
    helper.keymap("n", "<Tab>8", ':BufferLineGoToBuffer 8<CR>', {noremap = true, silent = true})
    helper.keymap("n", "<Tab>9", ':BufferLineGoToBuffer 9<CR>', {noremap = true, silent = true})
    helper.keymap("n", "<Tab>0", ':BufferLineGoToBuffer 10<CR>', {noremap = true, silent = true})
    helper.keymap("n", "<Tab>cc", ':lua require("component.bufferline"):close()<CR>', {noremap = true, silent = true})
    helper.keymap("n", "<Tab>cr", ':BufferLineCloseLeft<CR>', {noremap = true, silent = true})
    helper.keymap("n", "<Tab>cl", ':BufferLineCloseRight<CR>', {noremap = true, silent = true})
end

function M:close()
    local state = require("bufferline.state")
    local commands = require("bufferline.commands")
    local config = require("bufferline.config")
    local index = commands.get_current_element_index(state)
    for _, item in ipairs(vim.list_slice(state.components, index, index)) do
        if config:is_tabline() then
            helper.vim.cmd("tabclose " .. item.id)
        else
            helper.vim.api.nvim_buf_delete(item.id, { force = true })
        end
    end
end

return M

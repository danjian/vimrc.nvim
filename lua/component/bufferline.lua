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
end

function M:gotoId(id)
    require("bufferline").go_to_buffer(id, true)
end

return M

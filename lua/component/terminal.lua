local M = {}

function M:setup()
    require("FTerm").setup(
        {
            -- Filetype of the terminal buffer
            ft = "Terminal",
            -- Command to run inside the terminal. It could be a `string` or `table`
            cmd = os.getenv("SHELL"),
            -- Neovim's native window border. See `:h nvim_open_win` for more configuration options.
            border = "double",
            -- Close the terminal as soon as shell/command exits.
            -- Disabling this will mimic the native terminal behaviour.
            auto_close = true,
            -- Highlight group for the terminal. See `:h winhl`
            hl = "Normal",
            -- Transparency of the floating window. See `:h winblend`
            blend = 0,
            -- Object containing the terminal window dimensions.
            -- The value for each field should be between `0` and `1`
            dimensions = {
                height = 0.8, -- Height of the terminal window
                width = 0.8, -- Width of the terminal window
                x = 0.5, -- X axis of the terminal window
                y = 0.5 -- Y axis of the terminal window
            },
            -- Callback invoked when the terminal exits.
            -- See `:h jobstart-options`
            on_exit = nil,
            -- Callback invoked when the terminal emits stdout data.
            -- See `:h jobstart-options`
            on_stdout = nil,
            -- Callback invoked when the terminal emits stderr data.
            -- See `:h jobstart-options`
            on_stderr = nil
        }
    )

    M:after()
end

function M:after()
    helper.keymap("n", "`t", '<CMD>lua require("FTerm").toggle()<CR>', {noremap = true, silent = true})
    helper.keymap("t", "`t", '<C-\\><C-n>:lua require("FTerm").toggle()<CR>', {noremap = true, silent = true})
end

return M

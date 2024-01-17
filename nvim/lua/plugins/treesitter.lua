local M = { "nvim-treesitter/nvim-treesitter" }

M.config = function()
    require 'nvim-treesitter.configs'.setup {
        ensure_installed = "all",
        auto_install = true,
        highlight = {
            enable = true,
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<CR>",
                scope_incremental = "<CR>",
                node_incremental = "<TAB>",
                node_decremental = "<S-TAB>",
            },
        },
        refactor = {
            highlight_definitions = {
                enable = false,
                -- Set to false if you have an `updatetime` of ~100.
                clear_on_cursor_move = true,
            },
            highlight_current_scope = { enable = false },
            smart_rename = {
                enable = false,
                keymaps = {
                    smart_rename = "grr",
                },
            },
            navigation = {
                enable = false,
                keymaps = {
                    goto_definition = "gnd",
                    list_definitions = "gnD",
                    list_definitions_toc = "gO",
                    goto_next_usage = "<a-*>",
                    goto_previous_usage = "<a-#>",
                },
            },
        },
    }
end

return M

local M = {"nvim-treesitter/nvim-treesitter"}

M.config = function()
    require'nvim-treesitter.configs'.setup {
        context_commentstring = {
            enable = true
        },
        ensure_installed = "all",
        auto_install = true,
        highlight = {
            enable = false,
        },
        incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = "gnn",
              node_incremental = "grn",
              scope_incremental = "grc",
              node_decremental = "grm",
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
                enable = true,
                keymaps = {
                    smart_rename = "grr",
                },
            },
            navigation = {
                enable = true,
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

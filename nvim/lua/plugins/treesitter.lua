return {
    'nvim-treesitter/nvim-treesitter',
    config = function()
        require 'nvim-treesitter.configs'.setup {
            modules = {},
            sync_install = false,
            ignore_install = {},
            auto_install = true,
            ensure_installed = {
                "c_sharp",
                "typescript",
                "javascript",
                "html",
                "css",
                "lua",
                "rust",
                "go",
                "clojure"
            },
            highlight = {
                enable = true,
                disable = { "markdown", "vim", "help" },
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
        }
    end
}

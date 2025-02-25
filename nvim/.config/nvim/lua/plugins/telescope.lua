local M = {
    "nvim-telescope/telescope.nvim",
}

M.lazy = false
M.priority = 1000

M.config = function()
    local telescope = require("telescope")
    local previewers = require("telescope.previewers")

    telescope.setup {
        extensions = {
            ["ui-select"] = {
                require("telescope.themes").get_cursor {}
            },
            -- https://github.com/smartpde/telescope-recent-files
            recent_files = {
                only_cwd = true,
            }
        },
        defaults = {
            shorten_path = true,
            file_ignore_patterns = { "node_modules", ".git" },
            layout_strategy = "vertical",
            layout_config = { height = 0.95, width = 0.95 },
        },
        pickers = {
            find_files = {
                find_command = { "fd", "--hidden", "-i", "--type", "f", "--strip-cwd-prefix" }
            },
        },
    }

    telescope.load_extension("ui-select")
    telescope.load_extension("fzf")
    telescope.load_extension("recent_files")

    require('keymaps').telescope(telescope)
end

M.dependencies = {
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
    },
    {
        "junegunn/fzf.vim",
    },
    {
        "smartpde/telescope-recent-files",
    },
}

return M

local M = {
    "nvim-telescope/telescope.nvim",
}

M.config = function()
    local telescope = require("telescope")

    telescope.setup{
        extensions = {
            ["ui-select"] = {
                require("telescope.themes").get_cursor{}
            }
        },
        defaults = {
            shorten_path = true,
            file_ignore_patterns = { "node_modules", ".git" },
            layout_strategy = "vertical",
            layout_config = { height = 0.95, width = 0.95 },
        },
    }

    telescope.load_extension("ui-select")
    telescope.load_extension("fzf")
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
}

return M

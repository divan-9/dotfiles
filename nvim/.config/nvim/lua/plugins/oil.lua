return {
    'stevearc/oil.nvim',
    -- dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    config = function()
        local keymaps = require("keymaps")
        local oil = require("oil")
        oil.setup({
            view_options = {
                show_hidden = true,
            },
        })
        keymaps.oil(oil)
    end
}

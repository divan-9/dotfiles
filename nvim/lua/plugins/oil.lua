return {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    config = function()
        local keymaps = require("keymaps")
        local oil = require("oil")
        oil.setup()
        keymaps.oil(oil)
    end
}

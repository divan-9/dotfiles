local M = { "akinsho/toggleterm.nvim" }

local opts = {
    open_mapping = [[<c-j>]],
    direction = "float",
    shell = "fish",
    highlights = {
    },
}

M.config = function()
    require("toggleterm").setup(opts)
end

return M

local M = { "numToStr/Comment.nvim" }

M.dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" };

function M.config()
    require("Comment").setup({
    })
end

return M

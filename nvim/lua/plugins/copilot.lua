local M = { "zbirenbaum/copilot.lua" }

function M.config()
    require("copilot").setup({
        suggestion = {
            auto_trigger = true,
            keymap = {
            },
        },
        filetypes = {
            yaml = true,
        },
    })
end

return M

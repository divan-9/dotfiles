local M = { "zbirenbaum/copilot.lua" }

function M.config()
    require("copilot").setup({
        suggestion = {
            auto_trigger = true,
            keymap = {
               accept = "<C-L>",
               accept_word = false,
               accept_line = false,
               next = "<M-]>",
               prev = "<M-[>",
               dismiss = "<C-\\>",
            },
        },
        filetypes = {
            yaml = true,
        },
    })
end

return M

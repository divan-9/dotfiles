local M = {
    "folke/which-key.nvim",
}

vim.cmd([[
    autocmd FileType vue lua vue()
]])

local normal_mappings  = {
    ["<leader>"] = {
        ["w"] = { ":w<cr>", "Write buffer" },
        ["L"] = {
            name = "+configs",
            ["c"] = { ":e ~/.config/nvim/init.lua<cr>", "init.lua" },
            ["p"] = { ":e ~/.config/nvim/lua/plugins<cr>", "plugins" },
        },
        ["f"] = { ":Telescope find_files hidden=true<cr>", "Find files" },
        ["o"] = { ":Telescope oldfiles<cr>", "Old files" },
        ["e"] = { ":NvimTreeToggle<cr>", "NvimTree" },
        ["r"] = { ":lua vim.lsp.buf.rename()<cr>", "Rename" },
        ["h"] = { ":nohl<cr>", "Nohl" },
        ["/"] = { "<Plug>(comment_toggle_linewise_current)", "Toggle comment" },
        ["q"] = { ":cclose<cr>", "Close Quick Fix List" },
        ["d"] = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
        ["n"] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Next diagnostic" },
        ["m"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Prev diagnostic" },
    },
    ["g"] = {
        ["U"] = { ":lua require('telescope.builtin').lsp_references()<cr>", "Preview usages" },
        ["u"] = { ":lua vim.lsp.buf.references()<cr>", "Goto usages" },
        ["i"] = { ":lua vim.lsp.buf.implementation()<cr>", "Goto implementation" },
        ["d"] = { ":lua vim.lsp.buf.definition()<cr>", "Goto definitions" },
        ["D"] = { ":lua vim.lsp.buf.declaration()<cr>", "Goto definitions" },
    },
    ["d"] = {
        ["o"] = { ":lua vim.lsp.buf.code_action()<cr>", "Code actions" },
    },
    ["m"] = {
        ["k"] = { ":Dotnet<cr>", "Build dotnet solution" },
    },
    ["<C-j>"] = { ":ToggleTerm<cr>", "Toggle Term"},
    ["<C-n>"] = { ":cnext<cr>", "Next Quick Fix"},
    ["<C-m>"] = { ":cprev<cr>", "Prev Quick Fix"},
}

local visual_mappings = {
    ["<leader>"] = {
        ["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Toggle comment" }
    }
}

local normal_mappings_coc = {
    ["g"] = {
        ["u"] = {"<Plug>(coc-references)", "Coc: Goto usages"},
        ["i"] = {"<Plug>(coc-implementation)", "Coc: Goto implementation"},
        ["d"] = {"<Plug>(coc-definition)", "Coc: Goto definition"},
    },
    ["<leader>"] = {
        ["r"] = { "<Plug>(coc-rename)", "Coc: Rename" },
        ["d"] = { ":<C-u>CocList diagnostics<cr>", "Coc: Diagnostics" },
        ["n"] = { ":CocNext<cr>", "Coc: Next" },
        ["m"] = { ":CocPrev<cr>", "Coc: Prev" },
    },
    ["d"] = {
        ["o"] = { "<Plug>(coc-codeaction)", "Coc: Code actions" },
    },
}

function vue()
    local wk = require("which-key")
    wk.register(normal_mappings_coc)
end

vim.cmd("autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()")

M.config = function()
    local wk = require("which-key")

    wk.setup({
      key_labels = { ["<leader>"] = "SPC" },
    })

    wk.register(normal_mappings)
    wk.register(visual_mappings, { mode = "v" })
end

return M

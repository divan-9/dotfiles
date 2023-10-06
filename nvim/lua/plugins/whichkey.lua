local M = {
    "folke/which-key.nvim",
}

local uuid = require('uuid-nvim')

vim.cmd([[
    autocmd FileType cs lua lsp()
    autocmd FileType vue lua coc()
    autocmd FileType ts lua coc()
]])

local normal_mappings  = {
    ["<leader>"] = {
        ["i"] = { 
            name = "+insert",
            ["g"] = {  uuid.insert_v4, "GUID" }
        },
        ["w"] = { ":w<cr>", "Write buffer" },
        ["L"] = {
            name = "+configs",
            ["c"] = { ":e ~/.config/nvim/init.lua<cr>", "init.lua" },
            ["p"] = { ":e ~/.config/nvim/lua/plugins<cr>", "plugins" },
            ["r"] = { ":LspRestart<cr>", "Resart LSP server"},
        },
        ["l"] = {
            name = "+lsp",
            ["f"] = { ":lua vim.lsp.buf.format()<cr>", "Format buffer" },
            ["c"] = { ":ConjureConnect<cr>", "Conjure Connect"},
            ["r"] = { ":Lein", "Start lein repl using vim-jack-in" }
        },
        ["f"] = { ":Telescope find_files hidden=true<cr>", "Find files" },
        ["o"] = { ":Telescope oldfiles<cr>", "Old files" },
        ["e"] = { ":NvimTreeToggle<cr>", "NvimTree" },
        ["r"] = { ":lua vim.lsp.buf.rename()<cr>", "Rename" },
        ["h"] = { ":nohl<cr>", "Nohl" },
        ["/"] = { "<Plug>(comment_toggle_linewise_current)", "Toggle comment" },
        ["q"] = { ":cclose<cr>", "Close Quick Fix List" },
        ["<cr>"] = { ":cc<cr>", "Goto Quick Fix Entry" },
        ["d"] = { ":Diag<cr>", "Diagnostics" },
        ["n"] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Next diagnostic" },
        ["m"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Prev diagnostic" },
        ["g"] = { ":LazyGitCurrentFile<cr>", "Lazy Git" },
        ["F"] = { ":CocCommand prettier.forceFormatDocument<cr>", "Coc:prettier" },
        ["b"] = {
            name = "+buffers",
            ["b"] = { ":Telescope buffers<cr>", "List buffers" },
            ["d"] = { ":bd|bn<cr>", "Delete buffer" }
        },
        ["t"] = {
            name = "+tabs",
            ["t"] = { ":tabnew<cr>", "New tab" },
            ["n"] = { ":tabnext<cr>", "Next tab" },
            ["p"] = { ":tabprevious<cr>", "Previous tab" },
            ["c"] = { ":tabclose<cr>", "Close tab" },
            ["1"] = { ":tabfirst<cr>", "First tab" },
            ["2"] = { ":tablast<cr>", "Last tab" },
        }
    },
    ["g"] = {
        ["U"] = { ":lua require('telescope.builtin').lsp_references()<cr>", "Preview usages" },
        ["u"] = { ":lua vim.lsp.buf.references()<cr>", "Goto usages" },
        ["i"] = { ":lua vim.lsp.buf.implementation()<cr>", "Goto implementation" },
        ["d"] = { ":lua vim.lsp.buf.definition()<cr>", "Goto definitions" },
        ["D"] = { ":lua vim.lsp.buf.declaration()<cr>", "Goto definitions" },
        ["h"] = { "^", "Go to the start of the line" },
        ["l"] = { "$", "Go to the end of the line" },
    },
    ["d"] = {
        ["o"] = { ":lua vim.lsp.buf.code_action()<cr>", "Code actions" },
    },
    ["m"] = {
        ["k"] = { ":Dotnet<cr>", "Build dotnet solution" },
    },
    ["<C-j>"] = { ":2ToggleTerm<cr>", "Toggle Term"},
    ["<C-n>"] = { ":cnext<cr>", "Next Quick Fix"},
    ["<C-m>"] = { ":cprev<cr>", "Prev Quick Fix"},
    ["U"] = { "<C-r>", "Redo" },
}

local visual_mappings = {
    ["<leader>"] = {
        ["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Toggle comment" }
    },
    ["g"] = {
        ["h"] = { "^", "Go to the start of the line" },
        ["l"] = { "$", "Go to the end of the line" },
    },
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

function coc()
    local wk = require("which-key")
    wk.register(normal_mappings_coc, {
        buffer = vim.api.nvim_get_current_buf()
    })
end

function lsp()
    local wk = require("which-key")
    wk.register(normal_mappings)
end

vim.api.nvim_create_autocmd({"BufWritePre"}, { 
    pattern = "*.cs",
    callback = function()
        vim.lsp.buf.format()
    end
})

vim.api.nvim_create_autocmd({"BufWritePre"}, { 
    pattern = "*.clj",
    callback = function()
        vim.lsp.buf.format()
    end
})

vim.api.nvim_create_autocmd({"BufWritePre"}, { 
    pattern = "*.ts",
    callback = function()
        vim.api.nvim_command("CocCommand prettier.forceFormatDocument")
    end
})

M.config = function()
    local wk = require("which-key")

    wk.setup({
      key_labels = { ["<leader>"] = "SPC" },
    })

    wk.register(normal_mappings)
    wk.register(visual_mappings, { mode = "v" })
end

return M

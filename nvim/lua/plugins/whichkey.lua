local M               = {
    "folke/which-key.nvim",
    lazy = false,
}

local uuid            = require('uuid-nvim')

local normal_mappings = {
    ["]"] = {
        ["g"] = { "<Plug>(coc-diagnostic-next)", "Next diagnostic" },
        ["d"] = { ":CocNext diagnostics<cr>", "CocNext diagnostics" }
    },
    ["["] = {
        ["g"] = { "<Plug>(coc-diagnostic-prev)", "Prev diagnostic" },
        ["d"] = { ":CocPrev diagnostics<cr>", "CocPrev diagnostics" }
    },
    ["<leader>"] = {
        ["r"] = { "<Plug>(coc-rename)", "Coc: Rename" },
        ["d"] = { ":<C-u>CocList diagnostics<cr>", "Coc: Diagnostics" },
        ["i"] = {
            name = "+insert",
            ["g"] = { uuid.insert_v4, "GUID" }
        },
        ["w"] = { ":w<cr>", "Write buffer" },
        ["W"] = { ":setlocal wrap! linebreak<cr>", "Toggle wrap" },
        ["L"] = {
            name = "+configs",
            ["c"] = { ":e ~/.config/nvim/init.lua<cr>", "init.lua" },
            ["p"] = { ":e ~/.config/nvim/lua/plugins<cr>", "plugins" },
            ["r"] = { ":LspRestart<cr>", "Resart LSP server" },
        },
        ["l"] = {
            name = "+lsp",
            ["f"] = { "<Plug>(coc-format)", "Coc: Format" },
            ["c"] = { ":ConjureConnect<cr>", "Conjure Connect" },
            ["r"] = { ":Lein", "Start lein repl using vim-jack-in" },
            ["d"] = { ":Clj -M:dev -e \"(require '[flow-storm.api :as fs-api]) (fs-api/local-connect)\"<cr>",
                "Start flow-storm repl" }
        },
        ["s"] = {
            ["s"] = { ":Telescope live_grep<cr>", "Live grep" }
        },
        ["f"] = { ":Telescope find_files hidden=true<cr>", "Find files" },
        ["o"] = { ":Telescope oldfiles<cr>", "Old files" },
        ["e"] = { ":NvimTreeToggle<cr>", "NvimTree" },
        ["h"] = { ":nohl<cr>", "Nohl" },
        ["/"] = { "<Plug>(comment_toggle_linewise_current)", "Toggle comment" },
        ["q"] = { ":cclose<cr>", "Close Quick Fix List" },
        ["<cr>"] = { ":cc<cr>", "Goto Quick Fix Entry" },
        ["g"] = { ":G<cr>", "Fugitive" },
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
        ["u"] = { "<Plug>(coc-references)", "Coc: Goto usages" },
        ["i"] = { "<Plug>(coc-implementation)", "Coc: Goto implementation" },
        ["d"] = { "<Plug>(coc-definition)", "Coc: Goto definition" },
        ["h"] = { "^", "Go to the start of the line" },
        ["l"] = { "$", "Go to the end of the line" },
    },
    ["d"] = {
        ["o"] = { "<Plug>(coc-codeaction-cursor)", "Coc: Code actions" },
        ["r"] = { "<Plug>(coc-codeaction-refactor)", "Coc: Code actions refactor" },
    },
    ["m"] = {
        ["k"] = { ":Dotnet<cr>", "Build dotnet solution" },
    },
    ["<C-j>"] = { ":2ToggleTerm<cr>", "Toggle Term" },
    ["<C-e>"] = {
        function()
            require('nvim-tree.api').tree.toggle({ current_window = true })
        end,
        "NvimTree"
    },
    -- ["<C-e>"] = { ":NvimTreeToggle<cr>", "NvimTree" },
    -- ["<C-e>"] = { ":Ex<cr>", "Explore" },
    ["<C-n>"] = { ":cnext<cr>", "Next Quick Fix" },
    ["<C-p>"] = { ":cprev<cr>", "Prev Quick Fix" },
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

-- TODO: Find appropriate place for this
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = "*.ts,*.json,*.md",
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

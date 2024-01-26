local M = {}

function register_visual(mappings)
    for key, mapping in pairs(mappings) do
        vim.keymap.set("v", key, mapping[1], { noremap = true, silent = true, desc = mapping[2] })
    end
end

function register_normal(mappings)
    for key, mapping in pairs(mappings) do
        vim.keymap.set("n", key, mapping[1], { noremap = true, silent = true, desc = mapping[2] })
    end
end

function M.setup()
    register_visual({
        ["J"] = { ":m '>+1<CR>gv=gv", "Move selected text down" },
        ["K"] = { ":m '<-2<CR>gv=gv", "Move selected text up" },
        ["gh"] = { "^", "Go to the start of the line" },
        ["gl"] = { "$", "Go to the end of the line" },
    })

    register_normal({
        ["<leader>w"] = { ":w<CR>", "Write buffer" },
        ["<leader>W"] = { ":setlocal wrap! linebreak<cr>", "Toggle wrap" },
        ["<leader>/"] = { "<Plug>(comment_toggle_linewise_current)", "Toggle comment" },
        ["<leader>h"] = { ":nohl<cr>", "Nohl" },
        ["<leader>bd"] = { ":bd|bn<cr>", "Delete buffer" },

        ["gh"] = { "^", "Goto: start of the line" },
        ["gl"] = { "$", "Goto: end of the line" },
        ["<C-n>"] = { ":cnext<cr>", "Next Quick Fix" },
        ["<C-p>"] = { ":cprev<cr>", "Prev Quick Fix" },
        ["U"] = { "<C-r>", "Redo" },

        ["mk"] = { ":Dotnet<cr>", "Build dotnet solution" },
        ["<C-j>"] = { ":2ToggleTerm<cr>", "Toggle Term" },
    })

    -- Quickfix
    register_normal({
        ["<leader>q"] = { ":cclose<cr>", "Close Quick Fix List" },
        ["<leader><cr>"] = { ":cc<cr>", "Goto Quick Fix Entry" },
    })

    -- To be sorted out
    register_visual({
        ["<leader>/"] = { "<Plug>(comment_toggle_linewise_visual)", "Toggle comment" }
    })
    register_normal({
        ["<leader>g"] = { ":G<cr>", "Fugitive" },
        ["<leader>lc"] = { ":ConjureConnect<cr>", "Conjure Connect" },
        ["<leader>lr"] = { ":Lein", "Start lein repl using vim-jack-in" },
        ["<leader>ld"] = {
            ":Clj -M:dev -e \"(require '[flow-storm.api :as fs-api]) (fs-api/local-connect)\"<cr>",
            "Start flow-storm repl" }
    })
end

function M.oil(module)
    register_normal({
        ["-"] = { function() module.open(nil) end, "Open Oil file browser" },
    })
end

function M.lsp_on_attach(opts)
    register_normal({
        ["<leader>lf"] = { function() vim.lsp.buf.format({ async = true }) end, "Format buffer" },
        ["<leader>r"] = { vim.lsp.buf.rename, "LSP: Rename" },
        ["do"] = { vim.lsp.buf.code_action, "LSP: Code actions" },
    })
end

function M.uuid(module)
    register_normal({
        ["<leader>ig"] = { module.insert_v4, "Insert GUID" },
    })
end

function M.telescope(module)
    register_normal({
        ["<leader>ss"] = { ":Telescope live_grep<CR>", "Telescope: Live grep" },
        ["<leader>f"]  = { ":Telescope find_files hidden=true<CR>", "Telescope: Find files" },
        ["<leader>o"]  = { ":Telescope oldfiles<CR>", "Telescope: Old files" },
        ["<leader>bb"] = { ":Telescope buffers<cr>", "Telescope: List buffers" },
        ["<leader>sm"] = { ":Telescope keymaps<cr>", "Telescope: Keymaps" },
    })
end

function M.fugitive(module)
end

return M

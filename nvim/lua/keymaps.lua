local M = {}

function M.setup()
    -- move lines up and down
    vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected text down" })
    vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected text up" })

    vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Write buffer" })
    vim.keymap.set("n", "<leader>W", ":setlocal wrap! linebreak<cr>", { desc = "Toggle wrap" })

    -- dir explorer
    vim.keymap.set("n", "-", ":Oil<CR>", { desc = "Open Oil" })
end

function M.lsp_on_attach(opts)

    vim.keymap.set("n", "<leader>lf",
        function() vim.lsp.buf.format({ async = true }) end,
        { noremap = true, silent = true, desc = "LSP: Format buffer" })

    vim.keymap.set("n", "<leader>r",
        vim.lsp.buf.rename,
        { noremap = true, silent = true, desc = "LSP: Rename" })

    vim.keymap.set("n", "do",
        vim.lsp.buf.code_action,
        { noremap = true, silent = true, desc = "LSP: Code actions" })
end

return M

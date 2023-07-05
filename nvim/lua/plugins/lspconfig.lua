local M = { "neovim/nvim-lspconfig" }

M.dependencies = {
    "Hoffs/omnisharp-extended-lsp.nvim",
    "simrat39/rust-tools.nvim",
}

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

M.config = function()
    local lsp = require("lspconfig")

    lsp.omnisharp.setup({
        cmd = { 
            "dotnet", 
            "/Users/dmitryivanov/.vscode/extensions/ms-dotnettools.csharp-1.26.0-darwin-arm64/.omnisharp/1.39.7-net6.0/OmniSharp.dll",
            '--languageserver', 
            '--hostPID', 
            tostring(vim.fn.getpid()),
        },
        enable_editorconfig_support = true,
        enable_ms_build_load_projects_on_demand = false,
        enable_roslyn_analyzers = false,
        organize_imports_on_format = false,
        enable_import_completion = true,
        sdk_include_prereleases = false,
        analyze_open_documents_only = false,
        handlers = {
          ["textDocument/definition"] = require('omnisharp_extended').handler,
        },
        on_attach = function(client, bufnr)
            -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
            vim.keymap.set('n', '<C-k>', ":lua vim.lsp.buf.signature_help()<cr>", { buffer = bufnr })
        end
    })

    lsp.rust_analyzer.setup{
        on_attach = function(client, bufnr)
            --vim.api.nvim_set_keymap('n', 'do', ":RustCodeAction<cr>", {noremap = false})
        end,
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy"
                },
            },
        },
    }

    lsp.tsserver.setup({})
end

return M

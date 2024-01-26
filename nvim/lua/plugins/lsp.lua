return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
        'neovim/nvim-lspconfig',
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'L3MON4D3/LuaSnip',
        "Hoffs/omnisharp-extended-lsp.nvim",
        "j-hui/fidget.nvim",
        "pmizio/typescript-tools.nvim",
    },
    config = function()
        local fidget = require("fidget")
        local lsp_zero = require('lsp-zero')
        local lsp = require('lspconfig')

        require("fidget").setup({})

        lsp_zero.on_attach(function(client, bufnr)
            -- see :help lsp-zero-keybindings
            -- to learn the available actions
            lsp_zero.default_keymaps({
                preserve_mappings = false,
                buffer = bufnr
            })

            require("keymaps").lsp_on_attach({
                buffer = bufnr
            })

            fidget.notify("LSP client attached");
        end)

        lsp.lua_ls.setup({
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                    diagnostics = {
                        globals = { "vim" }
                    },
                    format = {
                        enable = true,
                    }
                }
            }
        })

        lsp.omnisharp.setup({
            cmd = {
                "dotnet",
                "/Users/dmitryivanov/omnisharp/v1.39.10/OmniSharp.dll",
                '--languageserver',
                '--hostPID',
                tostring(vim.fn.getpid()),
            },
            enable_editorconfig_support = true,
            enable_roslyn_analyzers = true,
            organize_imports_on_format = true,
            enable_import_completion = true,
            handlers = {
                ["textDocument/definition"] = require('omnisharp_extended').handler,
            },
            on_attach = function(client, bufnr)
                client.server_capabilities.semanticTokensProvider = nil
            end
        });

        require('typescript-tools').setup({})
    end
}

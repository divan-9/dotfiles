return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
        'neovim/nvim-lspconfig',
        'saghen/blink.cmp',
        -- 'hrsh7th/nvim-cmp',
        -- 'hrsh7th/cmp-nvim-lsp',
        'L3MON4D3/LuaSnip',
        "Hoffs/omnisharp-extended-lsp.nvim",
        "j-hui/fidget.nvim",
        "pmizio/typescript-tools.nvim",
    },
    config = function()
        vim.diagnostic.config({
            virtual_text = false,
            underline = false,
            update_in_insert = false,
        })

        -- Show line diagnostics automatically in hover window
        vim.o.updatetime = 250
        vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

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

            fidget.notify("LSP client attached:" .. client.name);
        end)

        local cfg = require('go.lsp').config()
        lsp.gopls.setup(cfg)

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
                "/Users/dmitryivanov/omnisharp/v1.39.11/OmniSharp.dll",
                -- "mono",
                -- "/Users/dmitryivanov/omnisharp/omnisharp-osx/omnisharp/OmniSharp.exe",
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
                ["textDocument/publishDiagnostics"] = vim.lsp.with(
                    vim.lsp.diagnostic.on_publish_diagnostics, {
                        virtual_text = false
                    }
                ),
            },
            on_attach = function(client, bufnr)
                fidget.notify("OmniSharp client attaching...");
                -- client.server_capabilities.semanticTokensProvider = true
                -- client.server_capabilities.semanticTokensProvider = nil
            end
        });

        lsp.volar.setup({
            init_options = {
                vue = {
                    -- disable hybrid mode
                    hybridMode = false,
                },
            },
            on_attach = function(client, bufnr)
                vim.opt.shiftwidth = 2
                fidget.notify("Volar client attaching...");
            end
        });

        capabilities = require('blink.cmp').get_lsp_capabilities()
        require('typescript-tools').setup({
            filetypes = {
                "typescript",
                "javascript",
                -- "vue",
            },
            settings = {
                capabilities = capabilities,
                tsserver_plugins = {
                    "@vue/typescript-plugin"
                }
            }
        })
    end
}

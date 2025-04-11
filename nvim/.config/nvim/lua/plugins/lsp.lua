return {
    'neovim/nvim-lspconfig',
    branch = 'v3.x',
    dependencies = {
        'saghen/blink.cmp',
        "Hoffs/omnisharp-extended-lsp.nvim",
        "j-hui/fidget.nvim",
        "pmizio/typescript-tools.nvim",
        {
            'mrcjkb/rustaceanvim',
            version = '^5', -- Recommended
            lazy = false,   -- This plugin is already lazy
        }
    },
    config = function()
        vim.diagnostic.config({
            virtual_text = true,
            underline = false,
            update_in_insert = false,
        })

        -- Show line diagnostics automatically in hover window
        vim.o.updatetime = 250
        vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

        local fidget = require("fidget")
        local lsp = require('lspconfig')

        require("fidget").setup({})

        vim.api.nvim_create_autocmd('LspAttach', {
            desc = 'LSP actions',
            callback = function(event)
                local opts = { buffer = event.buf }
                local client = vim.lsp.get_client_by_id(event.data.client_id)

                vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                vim.keymap.set('n', 'gd', "<cmd>lua require('omnisharp_extended').lsp_definition()<cr>", opts)
                vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                vim.keymap.set('n', 'gi', "<cmd>lua require('omnisharp_extended').lsp_implementation()<cr>", opts)
                vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                vim.keymap.set('n', 'gr', "<cmd>lua require('omnisharp_extended').lsp_references()<cr>", opts)
                vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
                vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

                require("keymaps").lsp_on_attach(opts)
                fidget.notify("LSP client attached:" .. client.name);
            end,
        })

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
                vim.fn.expand("$HOME/omnisharp/v1.39.11/OmniSharp.dll"),
                '--languageserver',
                '--hostPID',
                tostring(vim.fn.getpid()),
            },
            settings = {
                FormattingOptions = {
                    EnableEditorConfigSupport = true,
                    OrganizeImports = true,
                },
                MsBuild = {
                    LoadProjectsOnDemand = false,
                },
                RoslynExtensionsOptions = {
                    EnableAnalyzersSupport = true,
                    EnableImportCompletion = true,
                    AnalyzeOpenDocumentsOnly = nil,
                },
                Sdk = {
                    IncludePrereleases = true,
                },
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

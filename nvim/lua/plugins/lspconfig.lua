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

            client.server_capabilities.semanticTokensProvider = {
              full = vim.empty_dict(),
              legend = {
                tokenModifiers = { "static_symbol" },
                tokenTypes = {
                  "comment",
                  "excluded_code",
                  "identifier",
                  "keyword",
                  "keyword_control",
                  "number",
                  "operator",
                  "operator_overloaded",
                  "preprocessor_keyword",
                  "string",
                  "whitespace",
                  "text",
                  "static_symbol",
                  "preprocessor_text",
                  "punctuation",
                  "string_verbatim",
                  "string_escape_character",
                  "class_name",
                  "delegate_name",
                  "enum_name",
                  "interface_name",
                  "module_name",
                  "struct_name",
                  "type_parameter_name",
                  "field_name",
                  "enum_member_name",
                  "constant_name",
                  "local_name",
                  "parameter_name",
                  "method_name",
                  "extension_method_name",
                  "property_name",
                  "event_name",
                  "namespace_name",
                  "label_name",
                  "xml_doc_comment_attribute_name",
                  "xml_doc_comment_attribute_quotes",
                  "xml_doc_comment_attribute_value",
                  "xml_doc_comment_cdata_section",
                  "xml_doc_comment_comment",
                  "xml_doc_comment_delimiter",
                  "xml_doc_comment_entity_reference",
                  "xml_doc_comment_name",
                  "xml_doc_comment_processing_instruction",
                  "xml_doc_comment_text",
                  "xml_literal_attribute_name",
                  "xml_literal_attribute_quotes",
                  "xml_literal_attribute_value",
                  "xml_literal_cdata_section",
                  "xml_literal_comment",
                  "xml_literal_delimiter",
                  "xml_literal_embedded_expression",
                  "xml_literal_entity_reference",
                  "xml_literal_name",
                  "xml_literal_processing_instruction",
                  "xml_literal_text",
                  "regex_comment",
                  "regex_character_class",
                  "regex_anchor",
                  "regex_quantifier",
                  "regex_grouping",
                  "regex_alternation",
                  "regex_text",
                  "regex_self_escaped_character",
                  "regex_other_escape",
                },
              },
              range = true,
            }
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

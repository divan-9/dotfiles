return {
    "elentok/format-on-save.nvim",
    config = function()
        local format_on_save = require("format-on-save")
        local formatters = require("format-on-save.formatters")

        local dprint = formatters.shell({
            cmd = { "dprint", "fmt", "--stdin", "%" }
        })

        local xmllint = formatters.shell({
            cmd = { "xmllint", "--format", "-" }
        })

        local gofmt = function()
            require("go.format").goimports()
        end

        format_on_save.setup({
            exclude_path_patterns = {
                "/node_modules/",
                ".local/share/nvim/lazy",
            },
            formatter_by_ft = {
                css = formatters.lsp,
                html = formatters.lsp,
                rust = formatters.lsp,
                cs = formatters.lsp,
                lua = formatters.lsp,
                md = dprint,
                typescript = dprint,
                javascript = dprint,
                json = dprint,
                xml = xmllint,
                go = formatters.lsp,
            }
        })
    end
}

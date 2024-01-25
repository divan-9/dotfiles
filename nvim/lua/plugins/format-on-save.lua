return {
    "elentok/format-on-save.nvim",
    config = function()
        local format_on_save = require("format-on-save")
        local formatters = require("format-on-save.formatters")
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
                typescript = formatters.lsp,
                javascript = formatters.lsp,
                json = formatters.prettierd,
            }
        })
    end
}

return {
    "plasticboy/vim-markdown",
    dependencies = {
        "godlygeek/tabular"
    },
    init = function()
        vim.g.vim_markdown_folding_disabled = 1
    end,
}

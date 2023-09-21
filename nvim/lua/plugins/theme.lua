return 
{
    { "ful1e5/onedark.nvim" },
    { "EdenEast/nightfox.nvim" },
    { "aktersnurra/no-clown-fiesta.nvim" },
    {
        "sainnhe/sonokai",
        config = function()
            vim.g.sonokai_style = "maia"
        end
    },
    { "catppuccin/nvim" },
    { "kamwitsta/flatwhite-vim" },
    {
        "arcticicestudio/nord-vim",
        config = function()
            vim.g.nord_bold = 1
            vim.g.nord_italic = 1
            vim.g.nord_italic_comments = 1
            vim.g.nord_underline = 1
        end
    }
}

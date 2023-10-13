return {
    {"TrevorS/uuid-nvim"},
    { 
        "folke/neoconf.nvim", 
        cmd = "Neoconf" 
    },
    {
        "folke/neodev.nvim",
    },
    { 
        "nvim-lua/plenary.nvim",
    },
    {
        "ggandor/lightspeed.nvim"
    },
    {
       "dhruvasagar/vim-prosession",
        dependencies = { "tpope/vim-obsession" },
    },
    {
        "kdheepak/lazygit.nvim",
    },
    { "EdenEast/nightfox.nvim" },
    {
        "sainnhe/sonokai",
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.sonokai_style = "maia"
            vim.cmd([[colorscheme sonokai]])
        end
    },
    { "catppuccin/nvim" },
}

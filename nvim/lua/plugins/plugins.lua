return {
    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()
        end
    },
    { "TrevorS/uuid-nvim" },
    { "tpope/vim-fugitive" },
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
        "folke/zen-mode.nvim",
        opts = {
            backdrop = 0.8,
            width = .5
        }
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    { "typedclojure/vim-typedclojure" }
}

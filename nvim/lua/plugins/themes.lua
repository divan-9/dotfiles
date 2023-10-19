return {
    { "EdenEast/nightfox.nvim" },
    {
        "sainnhe/sonokai",
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.sonokai_style = "maia"
        end
    },
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require('kanagawa').setup({
                compile = false,
                overrides = function(colors)
                    local theme = colors.theme
                    return {
                        NormalFloat = { bg = "none" },
                        FloatBorder = { bg = "none" },
                        FloatTitle = { bg = "none" },
                        NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
                        -- LightspeedShortcut = { fg = theme.syn.keyword, bold = true },
                        -- LightspeedLabel = { fg = theme.syn.keyword },
                        -- LightspeedUniqueChar = { fg = theme.syn.keyword, bold = true },
                    }
                end
            })

            vim.cmd([[colorscheme kanagawa]])
        end
    },
    {
        "catppuccin/nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require('catppuccin').setup({
                highlight_overrides = {
                    all = function(colors)
                        return {
                            NvimTreeNormal = { fg = colors.none },
                            NormalFloat = { bg = colors.none },
                            FloatBorder = { bg = colors.none },
                            FloatTitle = { bg = colors.none },
                            NormalDark = { fg = colors.fg_dim, bg = colors.bg_m3 },
                        }
                    end
                }
            })

            -- vim.cmd([[colorscheme catppuccin]])
        end
    },
}

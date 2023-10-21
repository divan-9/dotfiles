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
            local palette = {
                sumiInk6 = "#54546D"
            }

            require('kanagawa').setup({
                compile = false,
                colors = {
                    theme = {
                        wave = {
                            ui = {
                                bg_visual = palette.sumiInk6
                            }
                        }
                    }
                },
                overrides = function(colors)
                    local theme = colors.theme
                    return {
                        NormalFloat = { bg = "none" },
                        FloatBorder = { bg = "none" },
                        FloatTitle = { bg = "none" },
                        NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
                        LightspeedLabel = {
                            fg = theme.syn.string,
                            bold = true,
                            underline = true,
                            bg = theme.ui.bg_search
                        },
                        LightspeedLabelDistant = {
                            fg = theme.syn.number,
                            bold = true,
                            underline = true,
                            bg = theme.ui.bg_search
                        },
                        LightspeedShortcut = {
                            fg = theme.syn.identifier,
                            bold = true,
                            underline = true,
                            bg = theme.ui.bg_search
                        },
                        LightspeedMaskedChar = {
                            fg = theme.syn.parameter,
                            bold = true,
                            underline = true,
                            bg = theme.ui.bg_search
                        },
                        LightspeedUnlabeledMatch = {
                            fg = theme.syn.fun,
                            bold = true,
                            underline = true,
                            bg = theme.ui.bg_search
                        },
                        LightspeedOneCharMatch = {
                            fg = theme.syn.statement,
                            bold = true,
                            underline = true,
                            bg = theme.ui.bg_search
                        },
                        LightspeedUniqueChar = {},
                        LightspeedPendingOpArea = {},
                        LightspeedGreyWash = {},
                        LightspeedCursor = {},

                    }
                end
            })

            vim.cmd([[colorscheme kanagawa-wave]])
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

return {
    {
        "AlexvZyl/nordic.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("nordic").setup({
                override = {
                    Normal = { bg = "#0d181a" },
                    Visual = { bg = "#6A3900" },
                    VisualNOS = { bg = "#6A3900" },
                }
            })
        end
    },
    {
        "EdenEast/nightfox.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require('nightfox').setup({
                palettes = {
                    terafox = {
                        bg1 = "#0d181a", -- Default bg
                    },
                }
            })
        end
    },
    { "rmehri01/onenord.nvim" },
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
                sumiInk6 = "#54546D",
                surimiOrange = "#FFA066",
                roninYellow = "#FF9E3B",
                carpYellow = "#E6C384",
            }

            require('kanagawa').setup({
                compile = false,
                colors = {
                    theme = {
                        dragon = {
                            ui = {
                                bg = "#0d181a", -- Default bg
                            }
                        },
                        wave = {
                            syn = {
                                -- statement = palette.surimiOrange,
                                keyword = palette.roninYellow,
                                -- type = palette.roninYellow,
                            },
                            ui = {
                                -- better selection
                                -- bg_visual = palette.sumiInk6,
                                bg_visual = "#F8DE7E",
                                -- bg_visual = "#7daea3",
                                -- nontext = "#b1b1b1",
                                nontext = "#d1d0c5",
                                bg = "#171b20",
                                bg_m3 = "#323437",
                                bg_gutter = "#171b20", -- Default bg

                                --   :root {
                                --   --dark: #323437;
                                --   --light: #d1d0c5;
                                --   --link: #7daea3;
                                -- }
                            }
                        }
                    }
                },
                overrides = function(colors)
                    local theme = colors.theme
                    return {
                        Visual = { bg = theme.ui.bg_visual, fg = "black" },
                        -- Fix for nvim-tree
                        NormalFloat = { bg = "none" },
                        FloatBorder = { bg = "none" },
                        FloatTitle = { bg = "none" },
                        NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

                        -- Fix for lighspeed
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

            vim.cmd([[colorscheme kanagawa]])
            -- vim.cmd([[colorscheme typewriter-night]])
            -- vim.cmd([[colorscheme terafox]])
            -- vim.cmd([[colorscheme catppuccin-mocha]])
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

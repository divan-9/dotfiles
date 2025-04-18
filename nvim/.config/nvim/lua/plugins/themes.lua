return {
    "zaldih/themery.nvim",
    lazy = false,
    priority = 500,
    config = function()
        local themery = require("themery")
        themery.setup({
            themes = {
                {
                    name = "dark: nord",
                    colorscheme = "nordern",
                    before = [[
                        local colors = require('nordern.colors')
                        vim.opt.background = "dark"
                        vim.api.nvim_set_hl(0, 'Property', { fg = colors.snow.c0 })
                        vim.api.nvim_set_hl(0, 'Parameter', { fg = colors.snow.c1 })
                        vim.api.nvim_set_hl(0, 'CopilotSuggestion', { fg = colors.aurora.purple })
                    ]]
                },
                {
                    name = "light: solarized",
                    colorscheme = "solarized",
                    before = [[
                        vim.opt.background = "light"
                    ]]
                },
                {
                    name = "dark: default",
                    colorscheme = "default",
                    before = [[
                        vim.opt.background = "dark"
                    ]]
                },
                {
                    name = "light: default",
                    colorscheme = "default",
                    before = [[
                        vim.opt.background = "light"
                    ]]
                },
                {
                    name = "light: paper",
                    colorscheme = "paper",
                    before = [[
                        vim.opt.background = "light"
                    ]]
                }

            },
            livePreview = true,
        })

        require("keymaps").themery(themery);
    end,
    dependencies = {
        {
            'maxmx03/solarized.nvim',
            lazy = false,
            priority = 1000,
            opts = {},
            config = function(_, opts)
                vim.o.termguicolors = true
                vim.o.background = 'light'
                require('solarized').setup(opts)
                vim.cmd.colorscheme 'solarized'
            end,
        },
        {
            "yorik1984/newpaper.nvim",
            priority = 1000,
        },
        {
            "yorickpeterse/nvim-grey",
            priority = 1000,
            config = function()
            end,
        },
        {
            "yorickpeterse/vim-paper",
            priority = 1000,
            config = function()
            end,
        },
        {
            "fcancelinha/nordern.nvim",
            branch = "master",
            priority = 1000,
            opts = {
                brigther_comments = false,
                brighter_constants = false,
                italic_comments = false,
                transparent = false,
            }
        },
        {
            "arcticicestudio/nord-vim",
            lazy = false,
            priority = 1000,
            config = function()
                vim.o.termguicolors = true
                -- vim.o.background = 'dark'
                -- vim.cmd.colorscheme 'nord'
                vim.api.nvim_create_autocmd("ColorScheme", {
                    pattern = "*",
                    callback = function()
                        vim.api.nvim_set_hl(0, 'DiagnosticUnderlineHint', { undercurl = false })
                    end
                })
            end,
        },
        {
            "sainnhe/sonokai",
            lazy = false,
            priority = 1000,
            config = function()
                vim.g.sonokai_style = "default"
                -- vim.g.sonokai_colors_override = {
                --     bg3 = { "#4e5054", "235" }
                -- }
                -- vim.cmd.colorscheme("sonokai")
            end
        },
        -- {
        --     "rebelot/kanagawa.nvim",
        --     lazy = false,
        --     priority = 1000,
        --     config = function()
        --         local palette = {
        --             sumiInk6 = "#54546D",
        --             surimiOrange = "#FFA066",
        --             roninYellow = "#FF9E3B",
        --             carpYellow = "#E6C384",
        --         }
        --
        --         require('kanagawa').setup({
        --             compile = false,
        --             colors = {
        --                 theme = {
        --                     dragon = {
        --                         ui = {
        --                             bg = "#0d181a", -- Default bg
        --                         }
        --                     },
        --                     wave = {
        --                         syn = {
        --                             -- statement = palette.surimiOrange,
        --                             -- keyword = palette.roninYellow,
        --                             -- keyword = palette.surimiOrange,
        --                             keyword = "#FADA5E",
        --                             -- type = palette.roninYellow,
        --                         },
        --                         ui = {
        --                             -- better selection
        --                             -- bg_visual = palette.sumiInk6,
        --                             -- bg_visual = "#F8DE7E",
        --
        --                             bg_visual = "#AFD7FF",
        --                             -- bg_visual = "#7daea3",
        --                             -- nontext = "#b1b1b1",
        --                             nontext = "#d1d0c5",
        --                             bg = "#171b20",
        --                             bg_m3 = "#323437",
        --                             bg_gutter = "#171b20", -- Default bg
        --
        --                             --   :root {
        --                             --   --dark: #323437;
        --                             --   --light: #d1d0c5;
        --                             --   --link: #7daea3;
        --                             -- }
        --                         }
        --                     }
        --                 }
        --             },
        --             overrides = function(colors)
        --                 local theme = colors.theme
        --                 return {
        --                     Visual = { bg = theme.ui.bg_visual, fg = "black" },
        --                     -- Fix for nvim-tree
        --                     NormalFloat = { bg = "none" },
        --                     FloatBorder = { bg = "none" },
        --                     FloatTitle = { bg = "none" },
        --                     NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
        --                     DiagnosticUnderlineHint = { underline = false },
        --                     CursorLineNr = { fg = theme.diag.warning, bg = theme.ui.bg_gutter, bold = false },
        --                     -- Fix for lighspeed
        --                     LightspeedLabel = {
        --                         fg = theme.syn.string,
        --                         bold = true,
        --                         underline = true,
        --                         bg = theme.ui.bg_search
        --                     },
        --                     LightspeedLabelDistant = {
        --                         fg = theme.syn.number,
        --                         bold = true,
        --                         underline = true,
        --                         bg = theme.ui.bg_search
        --                     },
        --                     LightspeedShortcut = {
        --                         fg = theme.syn.identifier,
        --                         bold = true,
        --                         underline = true,
        --                         bg = theme.ui.bg_search
        --                     },
        --                     LightspeedMaskedChar = {
        --                         fg = theme.syn.parameter,
        --                         bold = true,
        --                         underline = true,
        --                         bg = theme.ui.bg_search
        --                     },
        --                     LightspeedUnlabeledMatch = {
        --                         fg = theme.syn.fun,
        --                         bold = true,
        --                         underline = true,
        --                         bg = theme.ui.bg_search
        --                     },
        --                     LightspeedOneCharMatch = {
        --                         fg = theme.syn.statement,
        --                         bold = true,
        --                         underline = true,
        --                         bg = theme.ui.bg_search
        --                     },
        --                     LightspeedUniqueChar = {},
        --                     LightspeedPendingOpArea = {},
        --                     LightspeedGreyWash = {},
        --                     LightspeedCursor = {},
        --                 }
        --             end
        --         })
        --
        --         vim.cmd([[colorscheme sonokai]])
        --         -- vim.cmd([[colorscheme kanagawa]])
        --         -- vim.cmd([[colorscheme typewriter-night]])
        --         -- vim.cmd([[colorscheme terafox]])
        --         -- vim.cmd([[colorscheme catppuccin-mocha]])
        --     end
        -- },
        -- {
        --     "catppuccin/nvim",
        --     lazy = false,
        --     priority = 1000,
        --     config = function()
        --         require('catppuccin').setup({
        --             highlight_overrides = {
        --                 all = function(colors)
        --                     return {
        --                         NvimTreeNormal = { fg = colors.none },
        --                         NormalFloat = { bg = colors.none },
        --                         FloatBorder = { bg = colors.none },
        --                         FloatTitle = { bg = colors.none },
        --                         NormalDark = { fg = colors.fg_dim, bg = colors.bg_m3 },
        --                     }
        --                 end
        --             }
        --         })
        --
        --         -- vim.cmd([[colorscheme catppuccin]])
        --     end
        -- }
    },
}

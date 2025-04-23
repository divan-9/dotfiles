return {
    "zaldih/themery.nvim",
    lazy = false,
    priority = 500,
    config = function()
        vim.api.nvim_create_autocmd("ColorScheme", {
            pattern = "nordern",
            callback = function()
                local U = require('nordern.utils')
                local colors = require('nordern.colors')

                vim.api.nvim_set_hl(0, 'Property', { fg = colors.snow.c0 })
                vim.api.nvim_set_hl(0, 'Parameter', { fg = colors.snow.c1 })
                vim.api.nvim_set_hl(0, 'CopilotSuggestion', { fg = colors.aurora.purple })
                vim.api.nvim_set_hl(0, 'Visual', { bg = colors.aurora.yellow, fg = "#000000" })
                vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextHint', { fg = colors.night.c3 })
                vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextInfo', { fg = colors.night.c3 })
                vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextError', { fg = U.blend('#bf616a', '#2E3440', 0.5) })
                vim.api.nvim_set_hl(0, 'WhichKeyNormal', { bg = colors.night.c1 })
                vim.api.nvim_set_hl(0, 'WhichKeyBorder', { fg = colors.aurora.purple })
                -- vim.api.nvim_set_hl(0, 'BlinkCmpDocBorder', { fg = colors.aurora.purple, bg = colors.night.c0 })
            end
        })

        local themery = require("themery")

        themery.setup({
            themes = {
                {
                    name = "dark: nord",
                    colorscheme = "nordern",
                    before = [[
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

        require("keymaps").themery(themery)
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
    },
}

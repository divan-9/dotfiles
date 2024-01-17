local M = { "hoob3rt/lualine.nvim" }
M.enabled = false
M.dependencies = {
}

M.lazy = false

local opts = {
    options = {
        icons_enabled = true,
        theme = 'material',
        component_separators = { '', '' },
        section_separators = { '', '' },
        disabled_filetypes = {}
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = {
            { 'diagnostics' },
            -- { '%{coc#status()}' }
        },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {},
    winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
            { 'filename', path = 1 },
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },
    inactive_winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
            { 'filename', path = 1 },
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    }
}

M.config = function()
    require("lualine").setup(opts)
end

return M

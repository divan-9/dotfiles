-- options
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.opt.fixendofline = false
vim.opt.autowrite = true
vim.opt.langmap =
"ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"
vim.opt.encoding = "utf-8"
vim.opt.wrap = false
vim.opt.number = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.hidden = true
vim.opt.laststatus = 2
vim.opt.list = true
vim.opt.listchars = "tab:> ,trail:⋅"
vim.opt.cursorline = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.o.updatetime = 250
vim.opt.scrolloff = 5
vim.o.signcolumn = "number"

-- Position the (global) quickfix window at the very bottom of the window
-- (useful for making sure that it appears underneath splits)
-- NOTE: Using a check here to make sure that window-specific location-lists
-- aren't effected, as they use the same `FileType` as quickfix-lists.
vim.cmd [[
    autocmd FileType qf if (getwininfo(win_getid())[0].loclist != 1) | wincmd J | endif")
]]

vim.cmd [[
    autocmd FileType html setlocal shiftwidth=2 tabstop=2
    autocmd FileType vue setlocal shiftwidth=2 tabstop=2
    autocmd FileType vue setlocal shiftwidth=2 tabstop=2
]]

vim.api.nvim_create_autocmd({ "BufRead" }, {
    pattern = "*.md",
    callback = function()
        vim.cmd [[
            setlocal wrap linebreak nolist
        ]]
    end
})

vim.api.nvim_create_autocmd({ "BufRead" }, {
    pattern = { "*.props", "*.csproj", "*.targets" },
    callback = function()
        vim.cmd [[
            setfiletype xml
        ]]
    end
})

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
vim.o.completeopt = "menu,noinsert,noselect,preview"
-- Position the (global) quickfix window at the very bottom of the window
-- (useful for making sure that it appears underneath splits)
-- NOTE: Using a check here to make sure that window-specific location-lists
-- aren't effected, as they use the same `FileType` as quickfix-lists.
vim.cmd [[
    autocmd FileType qf if (getwininfo(win_getid())[0].loclist != 1) | wincmd J | endif")
]]

vim.filetype.add({
    extension = {
        props = 'xml',
        csproj = 'xml',
        targets = 'xml',
    }
})

require("options")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "git@github.com:folke/lazy.nvim.git",
    lazypath,
  })
end

vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup("plugins", {
    cache = {
        enabled = false,
    },
    install = { colorscheme = { "sonokai", "nord" } },
})

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("commands")
    require("repl")
    -- vim.cmd[[colorscheme nordfox]]
    vim.cmd[[colorscheme catppuccin]]
  end,
})

local Terminal  = require('toggleterm.terminal').Terminal

local repl = Terminal:new({
  cmd = "lein repl",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "i", "<C-j>", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("startinsert!")
  end,
})

function _repl_toggle()
  repl:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>lr", "<cmd>lua _repl_toggle()<CR>", {noremap = true, silent = true})

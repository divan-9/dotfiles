local Job = require 'plenary.job'
local Path = require 'plenary.path'
-- Custom Rg commad (grep in dir)
vim.api.nvim_create_user_command(
  'Rg',
  function(opts)
    local lines = {}

    local args = opts.fargs
    table.insert(args, '--vimgrep')

    local job = Job:new({
      command = '/opt/homebrew/bin/ag',
      args = args,
      env = {},
      cwd = vim.fn.getcwd(),
      on_stdout = function(_, line)
        table.insert(lines, line)
      end,
      on_exit = vim.schedule_wrap(function(j, code)
        vim.fn.setqflist({}, "r", {
          title = "RG",
          lines = lines,
          efm = "%f:%l:%c:%m",
        })
        vim.cmd.copen()
      end),
    })
    vim.cmd.cclose()
    job:start()
  end,
  { nargs = "?" })

vim.api.nvim_create_user_command(
  "Dotnet",
  function(opts)
    local current_file = Path:new(vim.fn.expand('%:p'))
    local dir = current_file:parent()
    local counter = 0
    local solution = ""
    while (counter < 10) do
      local search_mask = Path:new(dir, "*.sln").filename
      solution = vim.split(vim.fn.glob(search_mask), '\n')[1]
      if solution ~= "" then
        break
      end
      dir = dir:parent()
      counter = counter + 1
    end

    if solution == "" then
      print("No *.sln files found. " .. vim.fn.expand('%:p'))
      return
    end

    print("Building solution: " .. solution)

    local lines = {}
    local job = Job:new({
      command = 'dotnet',
      args = { "build", solution, "/p:GenerateFullPaths=true", "/v:q", "/nologo", "/clp:ErrorsOnly" },
      cwd = vim.fn.getcwd(),
      on_stdout = function(_, line)
        if string.find(line, ": error") then
          table.insert(lines, line)
        end
      end,
      on_exit = vim.schedule_wrap(function(j, code)
        print("Build finished. Code=" .. code)
        if code ~= 0 then
          vim.fn.setqflist({}, "r", {
            title = "Build",
            lines = lines,
            efm = " %#%f(%l\\,%c): %m",
          })
          vim.cmd.copen()
        end
      end),
    })

    vim.cmd.cclose()
    job:start()
  end,
  { nargs = "?" }
)

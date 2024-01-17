local M = { "kyazdani42/nvim-tree.lua" }
M.dependencies = { "kyazdani42/nvim-web-devicons" }

local HEIGHT_RATIO = 0.9 -- You can change this
local WIDTH_RATIO = 0.5  -- You can change this too

local opts = {
    git                 = {
        enable = true,
        ignore = true,
        show_on_dirs = false,
        timeout = 400,
    },
    -- disables netrw completely
    disable_netrw       = true,
    -- hijack netrw window on startup
    hijack_netrw        = true,
    -- open the tree when running this setup function
    -- open_on_setup       = false,
    -- will not open on setup if the filetype is in this list
    -- ignore_ft_on_setup  = {},
    -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
    open_on_tab         = false,
    -- hijack the cursor in the tree to put it at the start of the filename
    hijack_cursor       = false,
    -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
    update_cwd          = false,
    -- show lsp diagnostics in the signcolumn
    diagnostics         = {
        enable = false,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        }
    },
    -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
    update_focused_file = {
        -- enables the feature
        enable      = true,
        -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
        -- only relevant when `update_focused_file.enable` is true
        update_cwd  = false,
        -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
        -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
        ignore_list = {}
    },
    -- configuration options for the system open command (`s` in the tree by default)
    system_open         = {
        -- the command to run this, leaving nil should work in most cases
        cmd  = nil,
        -- the command arguments as a list
        args = {}
    },
    view                = {
        float = {
            enable = false,
            open_win_config = function()
                local screen_w = vim.opt.columns:get()
                local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
                local window_w = screen_w * WIDTH_RATIO
                local window_h = screen_h * HEIGHT_RATIO
                local window_w_int = math.floor(window_w)
                local window_h_int = math.floor(window_h)
                local center_x = (screen_w - window_w) / 2
                local center_y = ((vim.opt.lines:get() - window_h) / 2)
                    - vim.opt.cmdheight:get()
                return {
                    border = "rounded",
                    relative = 'editor',
                    row = center_y,
                    col = center_x,
                    width = window_w_int,
                    height = window_h_int,
                }
            end,
        },
        width = function()
            return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
        end,
    },
    -- view = {
    --   adaptive_size = true,
    --   -- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
    --   width = 50,
    --   -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
    --   side = 'right',
    --   -- if true the tree will resize itself after opening a file
    --   mappings = {
    --     -- custom only false will merge the list with the default mappings
    --     -- if true, it will only use your list to set the mappings
    --     custom_only = false,
    --     -- list of mappings to set on the tree manually
    --     list = {}
    --   }
    -- }
    on_attach           = function(bufnr)
        local api = require('nvim-tree.api')

        local function opts(desc)
            return {
                desc = 'nvim-tree: ' .. desc,
                buffer = bufnr,
                noremap = true,
                silent = true,
                nowait = true
            }
        end

        local mappings = {
            -- BEGIN_DEFAULT_ON_ATTACH
            ["<C-]>"] = { api.tree.change_root_to_node, "CD" },
            ["<C-e>"] = { api.node.open.replace_tree_buffer, "Open: In Place" },
            ["<C-k>"] = { api.node.show_info_popup, "Info" },
            ["<C-r>"] = { api.fs.rename_sub, "Rename: Omit Filename" },
            ["<C-t>"] = { api.node.open.tab, "Open: New Tab" },
            ["<C-v>"] = { api.node.open.vertical, "Open: Vertical Split" },
            ["<C-x>"] = { api.node.open.horizontal, "Open: Horizontal Split" },
            ["<BS>"] = { api.node.navigate.parent_close, "Close Directory" },
            ["<CR>"] = { api.node.open.replace_tree_buffer, "Open: In Place" },
            -- ["<CR>"] = { api.node.open.edit, "Open" },
            ["<Tab>"] = { api.node.open.preview, "Open Preview" },
            [">"] = { api.node.navigate.sibling.next, "Next Sibling" },
            ["<"] = { api.node.navigate.sibling.prev, "Previous Sibling" },
            ["."] = { api.node.run.cmd, "Run Command" },
            ["-"] = { api.tree.change_root_to_parent, "Up" },
            ["a"] = { api.fs.create, "Create" },
            ["bmv"] = { api.marks.bulk.move, "Move Bookmarked" },
            ["B"] = { api.tree.toggle_no_buffer_filter, "Toggle No Buffer" },
            ["c"] = { api.fs.copy.node, "Copy" },
            ["C"] = { api.tree.toggle_git_clean_filter, "Toggle Git Clean" },
            ["[c"] = { api.node.navigate.git.prev, "Prev Git" },
            ["]c"] = { api.node.navigate.git.next, "Next Git" },
            ["d"] = { api.fs.remove, "Delete" },
            ["D"] = { api.fs.trash, "Trash" },
            ["E"] = { api.tree.expand_all, "Expand All" },
            ["e"] = { api.fs.rename_basename, "Rename: Basename" },
            ["]e"] = { api.node.navigate.diagnostics.next, "Next Diagnostic" },
            ["[e"] = { api.node.navigate.diagnostics.prev, "Prev Diagnostic" },
            ["F"] = { api.live_filter.clear, "Clean Filter" },
            ["f"] = { api.live_filter.start, "Filter" },
            ["g?"] = { api.tree.toggle_help, "Help" },
            ["gy"] = { api.fs.copy.absolute_path, "Copy Absolute Path" },
            ["H"] = { api.tree.toggle_hidden_filter, "Toggle Dotfiles" },
            ["I"] = { api.tree.toggle_gitignore_filter, "Toggle Git Ignore" },
            ["J"] = { api.node.navigate.sibling.last, "Last Sibling" },
            ["K"] = { api.node.navigate.sibling.first, "First Sibling" },
            ["m"] = { api.marks.toggle, "Toggle Bookmark" },
            ["o"] = { api.node.open.edit, "Open" },
            ["O"] = { api.node.open.no_window_picker, "Open: No Window Picker" },
            ["p"] = { api.fs.paste, "Paste" },
            ["P"] = { api.node.navigate.parent, "Parent Directory" },
            ["q"] = { api.tree.close, "Close" },
            ["r"] = { api.fs.rename, "Rename" },
            ["R"] = { api.tree.reload, "Refresh" },
            -- ["s"] = { api.node.run.system, "Run System" },
            ["S"] = { api.tree.search_node, "Search" },
            ["U"] = { api.tree.toggle_custom_filter, "Toggle Hidden" },
            ["W"] = { api.tree.collapse_all, "Collapse" },
            ["x"] = { api.fs.cut, "Cut" },
            ["y"] = { api.fs.copy.filename, "Copy Name" },
            ["Y"] = { api.fs.copy.relative_path, "Copy Relative Path" },
            ["<2-LeftMouse>"] = { api.node.open.edit, "Open" },
            ["<2-RightMouse>"] = { api.tree.change_root_to_node, "CD" },
            -- END_DEFAULT_ON_ATTACH

            -- Mappings migrated from view.mappings.list
            ["l"] = { api.node.open.edit, "Open" },
            ["h"] = { api.node.navigate.parent_close, "Close Directory" },
            ["v"] = { api.node.open.vertical, "Open: Vertical Split" },
        }

        for keys, mapping in pairs(mappings) do
            vim.keymap.set("n", keys, mapping[1], opts(mapping[2]))
        end
    end,
}

M.config = function()
    require("nvim-tree").setup(opts)
end

return M

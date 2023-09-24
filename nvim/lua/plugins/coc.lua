local M = { "neoclide/coc.nvim" }
M.build = "yarn install --frozen-lockfile"

function M.config()

    -- Always show the signcolumn, otherwise it would shift the text each time
    -- diagnostics appeared/became resolved
    vim.opt.signcolumn = "yes"

    -- Autocomplete
    function _G.check_back_space()
        local col = vim.fn.col('.') - 1
        return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
    end

    -- Use Tab for trigger completion with characters ahead and confirm completion
    local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
    vim.keymap.set("i", "<TAB>", 'coc#pum#visible() ? coc#pum#confirm() : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)

    -- Make <CR> to accept selected completion item or notify coc.nvim to format
    -- <C-g>u breaks current undo, please make your own choice
    -- vim.keymap.set("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

    -- Use K to show documentation in preview window
    function _G.show_docs()
        local cw = vim.fn.expand('<cword>')
        if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
            vim.api.nvim_command('h ' .. cw)
        elseif vim.api.nvim_eval('coc#rpc#ready()') then
            vim.fn.CocActionAsync('doHover')
        else
            vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
        end
    end
    vim.keymap.set("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})

    vim.api.nvim_create_autocmd({"BufWritePre"}, { 
        pattern = "*.cs, *.clj, *.json",
        callback = function()
            vim.fn.CocActionAsync('format')
        end
    })

    vim.api.nvim_create_autocmd({"BufWritePre"}, { 
        pattern = "*.ts, *.js",
        callback = function()
            vim.cmd[[
                :call coc#rpc#notify('runCommand', ['prettier.formatFile'])
            ]]
        end
    })
end

return M

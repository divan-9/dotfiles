return {
    "Olical/conjure",
    lazy = false,
    dependencies = {
        "tpope/vim-dispatch",
        "clojure-vim/vim-jack-in",
        "radenling/vim-dispatch-neovim",
    },
    config = function()
        -- vim.g["conjure#client#clojure#nrepl#connection#auto_repl#cmd"] = "lein"
    end
}

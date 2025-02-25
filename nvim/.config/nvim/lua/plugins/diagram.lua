return {
    "3rd/diagram.nvim",
    enabled = false,
    dependencies = {
        "3rd/image.nvim",
    },
    config = function()
        require("diagram").setup({})
    end,
}

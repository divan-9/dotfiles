return {
    'rcarriga/nvim-notify',
    config = function()
        local notify = require("notify")
        notify.setup({
            stages = "static",
            timeout = 10000,
            background_colour = "#000000",
            level = vim.log.levels.INFO,
            max_width = 80,
            max_height = 20,
            minimum_width = 20,
            minimum_height = 5,
            render = "minimal",
            top_down = false,
            fps = 60,
        })
        vim.notify = notify
    end
}

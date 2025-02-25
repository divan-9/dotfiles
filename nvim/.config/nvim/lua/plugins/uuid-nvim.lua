return {
    "TrevorS/uuid-nvim",
    config = function()
        local keymaps = require("keymaps")
        keymaps.uuid(require("uuid-nvim"))
    end
}

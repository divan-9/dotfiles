return {
    { 'echasnovski/mini.nvim', version = false },
    {
        'echasnovski/mini.ai',
        version = false,
        config = function()
            require('mini.ai').setup()
        end
    }
}

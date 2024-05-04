-- Because Windows doesn't have tmux...
if string.find(vim.loop.os_uname().sysname, 'Windows') then
    return {
        'akinsho/toggleterm.nvim',
        version = '*',
        config = function()
            local toggleterm = require('toggleterm')

            toggleterm.setup({
                open_mapping = [[<C-\>]],
                close_on_exit = false,
                shell = 'powershell',
                direction = 'float',
                float_opts = {
                    boarder = 'single',
                }
            })
        end,
    }
else
    return {}
end

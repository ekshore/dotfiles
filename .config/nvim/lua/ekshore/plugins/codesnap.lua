return {
    'mistricky/codesnap.nvim',
    lazy = 'true',
    build = 'make',
    event = 'VeryLazy',
    opts = {
        mac_window_bar = true,
        watermark = '',
        preview_title = '',
        editor_font_family = 'Hack Nerd Font Mono',
        has_breadcrumbs = true,
        has_line_number = true,
        bg_padding = 0, 
    },
    config = function(_, opts)
        require('codesnap').setup(opts)
        vim.keymap.set('v', '<leader>cc', ':CodeSnap<CR>')
        vim.keymap.set('v', '<leader>cs', ':CodeSnapSave<CR>')
    end
}

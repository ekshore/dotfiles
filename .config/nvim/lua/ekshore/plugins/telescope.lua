return {
    'nvim-telescope/telescope.nvim', 
    tag = '0.1.4', 
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function() 
        local telescope = require('telescope')
        local builtin = require('telescope.builtin')

        telescope.setup({})

        vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Fuzzy find files in cwd' })
        vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Fuzzy find files in git' })
        vim.keymap.set('n', '<leader>ps', function()
	        builtin.grep_string( { search = vim.fn.input('Grep > ') })
        end, { desc = 'grep search project' })

        vim.keymap.set('n', '<leader>gh', builtin.git_commits, { desc = 'View git commits' })

        -- Search help
        vim.keymap.set('n', '<leader>?', builtin.help_tags, { desc = 'Search help' })
        vim.keymap.set('n', '<leader>m?', builtin.man_pages, { desc = 'Search man pages' })

        telescope.load_extension('fzf')
    end,
}

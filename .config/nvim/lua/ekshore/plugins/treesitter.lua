return {
    'nvim-treesitter/nvim-treesitter',
    -- event = { 'BufReadPre', 'BufNewFile' },
    lazy = false,
    build = ':TSUpdate',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-context',
    },
    config = function()
        local languages = {
                'rust',
                'typescript',
                'javascript',
                'c',
                'vim',
                'lua',
                'yaml',
                'toml',
                'json',
                'markdown',
                'html',
                'css',
        }
        require('nvim-treesitter').install(languages)

          vim.api.nvim_create_autocmd('FileType', {
              pattern = languages,
              callback = function()
                  -- syntax highlighting, provided by Neovim
                  vim.treesitter.start()
                  -- folds, provided by Neovim
                  -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                  -- vim.wo.foldmethod = 'expr'
                  -- indentation, provided by nvim-treesitter
                  vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
              end,
          })
    end,
}

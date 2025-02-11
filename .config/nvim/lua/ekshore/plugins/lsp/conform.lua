return {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        local conform = require('conform')
        conform.setup({
            formatters_by_ft = {
                rust = { 'rustfmt' },
                javascript = { 'prettier' },
                javascriptreact = { 'prettier' },
                typescript = { 'prettier' },
                typescriptreact = { 'prettier' },
            },
            log_level = vim.log.levels.TRACE,
            notify_on_error = true,
            notify_no_formatters = true,
        })
        vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
            conform.format({
                -- lsp_fallback = true,
                async = false,
                timeout_ms = 500,
            })
        end)
    end
}

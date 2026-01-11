return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
        local cmp_nvim_lsp = require('cmp_nvim_lsp')

        local keymap = vim.keymap
        local opts = { noremap = true, silent = true }

        local on_attach = function(client, bufnr)
            opts.buffer = bufnr

            opts.desc = 'Show LSP implementations'
            keymap.set('n', 'gi', ':Telescope lsp_references<CR>', opts)

            -- opts.desc = ''
            -- keymap.set('n', '<leader>vrr', vim.lsp.buf.references, opts)

            opts.desc = 'Show LSP definitions'
            keymap.set('n', 'gd', ':Telescope lsp_definitions<CR>', opts)

            -- opts.desc = 'Go to definition'
            -- keymap.set('n', 'gD', function() vim.lsp.buf.definition() end, opts)

            opts.desc = 'Go to declaration'
            keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)

            opts.desc = 'Show LSP type definitions'
            keymap.set('n', 'gt', ':Telescope lsp_type_definitions<CR>', opts)

            -- opts.desc = ''
            -- keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)

            opts.desc = 'Show diagnostics for file'
            keymap.set('n', '<leader>D', ':Telescope diagnostics bufner=0<CR>', opts)

            opts.desc = 'Show diagnositcs for line'
            keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)

            opts.desc = 'Jump to next diagnostic'
            keymap.set('n', '[d', vim.diagnostic.goto_next, opts)

            opts.desc = 'Jump to previous diagnostic'
            keymap.set('n', ']d', vim.diagnostic.goto_prev, opts)

            opts.desc = 'See available code actions'
            keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)

            opts.desc = 'Smart Rename'
            keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

            opts.desc = 'Hover info'
            keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)

            opts.desc = 'Signature Help'
            keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)

            opts.desc = 'Restart LSP'
            keymap.set('n', '<leader>rs', ':LspRestart<CR>', opts)
        end

        local capabilities = cmp_nvim_lsp.default_capabilities()

        local icons = { Error = ' ', Warn = ' ', Hint = '󰠠 ', Info = ' ' }
        for type, icon in pairs(icons) do
            local hl = 'DiagnosticSign' .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
        end

        -- Configure individual LS's
        ----------------------------

        -- configure rust analyzer
        vim.lsp.config('rust_analyzer', {
            capabilities = capabilities,
            on_attach = on_attach,
            cmd = {
                -- 'rustup', 'run', 'stable', 'rust-analyzer'
                'rustup', 'run', 'nightly', 'rust-analyzer'
            },
            settings = {
                ['rust-analyzer'] = {
                    -- cargo = {
                    --     features = { 'ssr', 'hydrate' },
                    -- },
                    -- procMacro = {
                    --     ignored = {
                    --         leptos_macros = {
                    --             "server",
                    --         }
                    --     }
                    -- }
                }
            }
        })
        vim.lsp.enable('rust_analyzer')

        -- configure Dockerfile language server
        vim.lsp.config('dockerls', {
            capabilities = capabilities,
            on_attach = on_attach,
        })
        vim.lsp.enable('dockerls')

        -- configure json server
        vim.lsp.config('jsonls', {
            capabilities = capabilities,
            on_attach = on_attach,
        })
        vim.lsp.enable('jsonls')

        -- configure toml language server
        vim.lsp.config('taplo', {
            capabilities = capabilities,
            on_attach = on_attach,
        })
        vim.lsp.enable('taplo')

        -- configure typescript server
        vim.lsp.config('ts_ls', {
            capabilities = capabilities,
            on_attach = on_attach,
        })
        vim.lsp.enable('ts_ls')

        -- configure html
        vim.lsp.config('html', {
            capabilities = capabilities,
            on_attach = on_attach,
        })
        vim.lsp.enable('html')

        -- configure css server
        vim.lsp.config('cssls', {
            capabilities = capabilities,
            on_attach = on_attach,
        })
        vim.lsp.enable('cssls')

        -- configure tailwindcss
        vim.lsp.config('tailwindcss', {
            capabilities = capabilities,
            on_attach = on_attach,
        })
        vim.lsp.enable('tailwindcss')

        -- configure lua server
        vim.lsp.config("lua_ls", {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = { -- custom settings for lua
                Lua = {
                    -- make the language server recognize "vim" global
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        -- make language server aware of runtime files
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.stdpath("config") .. "/lua"] = true,
                        },
                    },
                },
            },
        })
        vim.lsp.enable('lua_ls')
    end,
}

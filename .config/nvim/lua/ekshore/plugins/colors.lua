return {
    -- 'catppuccin/nvim', name='catppuccin',
    -- 'rebelot/kanagawa.nvim',
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
	config = function()
		vim.cmd([[colorscheme gruvbox]])
	end,
}

return {
	{
		'folke/neodev.nvim',
		lazy = false,
		priority = 20000,
		opts = {
			library = {
				plugins = {
					'nvim-dap-ui',
					'nvim-treesitter',
					'plenary.nvim',
					'telescope.nvim'
				},
			}
		}
	},
	{ 'ray-x/guihua.lua', event = 'UiEnter', build = 'cd lua/fzy && make' }
}

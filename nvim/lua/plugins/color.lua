return {
	{
		'uga-rosa/ccc.nvim',
		cmd = { 'CccPick', 'CccConvert', 'CccHighlighterEnable', 'CccHighlighterToggle', 'CccHighlighterDisable' },
		config = function()
			require'ccc'.setup()
		end
	},
	{
		'folke/twilight.nvim',
		event = 'BufRead',
		config = function()
			vim.cmd[[TwilightEnable]]
		end
	},
	{ 'folke/styler.nvim', cmd = 'Styler' }
}


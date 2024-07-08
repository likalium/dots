return {
	{
		-- Color picker and highlighter plugin for Neovim
		'uga-rosa/ccc.nvim',
		cmd = {
			'CccPick',
			'CccConvert',
			'CccHighlighterToggle',
			'CccHighlighterEnable',
			'CccHighlighterDisable',
		},
		config = true,
	},
	{
		-- Twilight is a Lua plugin for Neovim 0.5 that dims inactive portions of the code you're editing using TreeSitter.
		'folke/twilight.nvim',
		opts = {}
	}
}


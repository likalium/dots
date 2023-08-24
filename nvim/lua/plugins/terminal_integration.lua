return {
	-- Not sure i need this, but since it can be cool i put it as comment
	-- { 'willothy/flatten.nvim', lazy = false, priority = 1001, config = true }
	{
		'akinsho/toggleterm.nvim',
		cmd = {
			'ToggleTerm', 'ToggleTermToggleAll', 'TermExec', 'TermSelect', 'ToggleTermSendCurrentLine', 'ToggleTermSendVisualLines', 'ToggleTermSendVisualSelection', 'ToggleTermSetName'
		},
		keys = {
			{'<leader>te', '<cmd>ToggleTerm<CR>' },
			{'<leader>tef', '<cmd>ToggleTerm direction=float<CR>' }
		},
		version = '*',
		opts = { float_opts = { border = 'rounded' } }
	}
}

return {
	{
		'kevinhwang91/nvim-hlslens',
		lazy = false,
		keys = {
			{ 'n', [[<cmd>execute('normal! ' . v:count1 . 'n')<CR><cmd>lua require('hlslens').start()<CR>]], {noremap = true, silent = true}},
			{ 'N', [[<cmd>execute('normal! ' . v:count1 . 'N')<CR><cmd>lua require'hlslens'.start()<CR>]], {noremap = true, silent = true}},
			{ '*', [[*<cmd>lua require'hlslens'.start()<CR>]], {noremap = true, silent = true}},
			{ '#', [[#<cmd>lua require'hlslens'.start()<CR>]], {noremap = true, silent = true}},
			{ 'g*', [[g*<cmd>lua require'hlslens'.start()<CR>]], {noremap = true, silent = true}},
			{ 'g#', [[g#<cmd>lua require'hlslens'.start()<CR>]], {noremap = true, silent = true}},
			{ '<leader>l', '<cmd>noh<CR>', {noremap = true, silent = true}}
		},
		config = function()
			require'hlslens'.setup()
		end,
	},
	{
		'AckslD/muren.nvim',
		cmd = { 'MurenToggle', 'MurenFresh', 'MurenUnique' },
		keys = {
			{ '<leader>m', '<cmd>MurenToggle<CR>' }
		},
		opts = {}
	}
}

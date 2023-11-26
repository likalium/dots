return {
	{
		'nvim-zh/colorful-winsep.nvim',
		--event = 'WinNew',
		opts = {
			bg = '#545c7e',
			fg = '#1f2335'
		}
	},
	{
		'sindrets/winshift.nvim',
		keys = {
			{ '<C-w>', '<cmd>WinShift<CR>' }
		},
		opts = {}
	},
	{
		'anuvyklack/windows.nvim',
		event = 'WinNew',
		dependencies = {
			"anuvyklack/middleclass",
			"anuvyklack/animation.nvim"
		},
		keys = {
			{ '<leader>w', "<cmd>WindowsToggleAutowidth<CR>" }
		},
		config = function()
			vim.o.winwidth = 10
			vim.o.winminwidth = 10
			vim.o.equalalways = false
		end,
		opts = {}
	}
}

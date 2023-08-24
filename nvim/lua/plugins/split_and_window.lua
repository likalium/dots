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
		'folke/edgy.nvim',
		event = 'VeryLazy',
		opts = {
			left = {
				{
					title = 'Neo Tree',
					ft = 'neo-tree',
					open = "<leader>t",
					filter = function(buf)
						return vim.b[buf].neo_tree_source == "filesystem"
					end,
				}
			},
			bottom = {
				{
					title = "Terminal",
					ft = 'toggleterm',
					filter = function(buf, win)
						return vim.api.nvim_win_get_config(win).relative == ""
					end,
				},
				"Trouble",
				{ ft = "qf", title = "QuickFix" },
			}
		}
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

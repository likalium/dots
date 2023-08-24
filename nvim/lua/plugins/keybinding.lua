return {
	{
		'folke/which-key.nvim',
		keys = {
			{ '<leader>?', '<cmd>WhichKey<CR>' }
		},
		event = 'VeryLazy',
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end
	},
	{
		'mrjones2014/legendary.nvim',
		keys = {
			{ '<leader>h', '<cmd>Legendary<CR>' }, -- h for Hero, bc there's always a hero in a legend
			{ '<leader>hk', '<cmd>Legendary keymaps<CR>' },
			{ '<leader>hc', '<cmd>Legendary commands<CR>' },
			{ '<leader>hf', '<cmd>Legendary functions<CR>' },
			{ '<leader>ha', '<cmd>Legendary autocmds<CR>' },
			{ '<leader>hr', '<cmd>LegendaryRepeat<CR>' },
			{ '<leader>hr', '<cmd>LegendaryRepeat!<CR>' },
		},
		cmd = { 'Legendary', 'LegendaryRepeat' },
		priority = 10000,
		lazy = false,
		dependencies = { 'kkharji/sqlite.lua' },
	},
	{
		'anuvyklack/hydra.nvim',
		lazy = false,
		config = function()
			local hydra = require'hydra'
			local hint = [[
			Arrow^^^^^^   Select region with <C-v> 
			^ ^ _K_ ^ ^   _f_: surround it with box
			_H_ ^ ^ _L_
			^ ^ _J_ ^ ^                      _<Esc>_
			]]
			hydra({
				name = 'Draw Diagram',
				hint = hint,
				config = {
					color = 'pink',
					invoke_on_body = true,
					hint = {
						border = 'rounded'
					},
					on_enter = function()
						vim.o.virtualedit = 'all'
						vim.cmd([[Lazy load venn.nvim]])
					end,
				},
				mode = 'n',
				body = '<leader>d',
				heads = {
					{ 'H', '<C-v>h:VBox<CR>' },
					{ 'J', '<C-v>j:VBox<CR>' },
					{ 'K', '<C-v>k:VBox<CR>' },
					{ 'L', '<C-v>l:VBox<CR>' },
					{ 'f', ':VBox<CR>', { mode = 'v' }},
					{ '<Esc>', nil, { exit = true } },
				}
			})
		end
	}
}

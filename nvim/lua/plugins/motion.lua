return {
	{
		'ggandor/leap.nvim',
		keys = { 's', 'S', 'gs' },
		config = function()
			require('leap').add_default_mappings()
		end
	},
	{
		'edluffy/specs.nvim',
		event = 'BufEnter',
		keys = {
			{ '<C-b>', "<cmd>lua require'specs'.show_specs()<CR>" }
		},
		config = function()
			local respec = require'specs'
			respec.setup{
				show_jumps = true,
				popup = {
					winhl = "MiniStatuslineModeVisual",
					min_jump = 10,
					inc_ms = 10,
					blend = 20,
					width = 20,
					fader = respec.exp_fader,
					resizer = respec.slide_resizer
				},
			}
		end
	},
	{ 'abecodes/tabout.nvim', keys = { '<Tab>', '<C-t>' }, config = true }
}

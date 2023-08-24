return {
	{
		"nvim-neorg/neorg",
		build = ":Neorg sync-parsers",
		cmd = 'Neorg',
		ft = 'norg',
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("neorg").setup {
				load = {
					["core.defaults"] = {},
					["core.concealer"] = { config = { code_block = { content_only = false } } },
					["core.dirman"] = {
						config = {
							workspaces = {
								notes = "~/notes", lika = "~/Documents/lika", home = "~", journal = "~/journal"
							},
							index = "index.norg"
						},
					},
					["core.ui.calendar"] = {},
					["core.journal"] = {},
					["core.completion"] = { config = { engine = 'nvim-cmp' } },
					["core.export"] = {},
					["core.presenter"] = { config = { zen_mode = "zen-mode" } },
					["core.summary"] = {}
				},
			}
		end,
	},
	-- { "jbyuki/nabla.nvim" }
	{ "NFrid/due.nvim", config = function() require('due_nvim').setup { ft = { '*.md', '*.norg' } } end },
	{ "jbyuki/venn.nvim", }, -- INFO: There is an hydra mode, see ./keybinding.lua
	{
		"RutaTang/quicknote.nvim",
		dependencies = 'nvim-lua/plenary.nvim',
		keys = {
			{ '<leader>nn', "<cmd>lua require'quicknote'.NewNoteAtCurrentLine()" },
			{ '<leader>ns', "<cmd>lua require'quicknote'.ShowNoteSigns()"},
			{ '<leader>no', "<cmd>lua require'quicknote'.OpenNoteAtCurrentLine'"} -- no -> note open
		},
		opts = {
			sign = '󱇗',
			filetype = 'norg'
		}
	}
}

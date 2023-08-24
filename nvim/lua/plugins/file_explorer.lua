return {
	{
		'nvim-neo-tree/neo-tree.nvim',
		cmd = 'Neotree',
		keys = {
			{ '<leader>t', "<cmd>Neotree<CR>" },
			{ '<leader>tf', '<cmd>Neotree float<CR>' }
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		branch = 'v3.x',
		config = function()
			require'neo-tree'.setup({
				popup_border_style = "rounded",
				enable_git_status = true,
				enable_diagnostics = true,
				window = {
					position = "left",
					width = 30,
					mappings = {
						["Z"] = "expand_all_nodes",
					},
				},
				default_component_configs = {
					name = {
						trailing_slash = true,
					},
					modified = {
						symbol = "",
						highlight = 'Character'
					},
				},
				filesystem = {
					filtered_items = {
						visible = true,
						hide_dotfiles = false,
					},
				},
			})
		end,
	},
	{
		'kelly-lin/ranger.nvim',
		keys = {
			{ '<leader>r', '<cmd>Ranger<CR>' }
		},
		cmd = 'Ranger',
		opts = {
			enable_cmds = true,
			replace_netrw = true,
		}
	},
}

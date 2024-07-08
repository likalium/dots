return {
	{
		-- Find, Filter, Preview, Pick. All lua, all the time.
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		keys = {
			{
				"<leader>ff",
				"<cmd>Telescope find_files<cr>",
				desc = "Find files in pwd (Telescope)"
			},
			-- Requires BurntSushi/ripgrep
			{
				"<leader>fg",
				"<cmd>Telescope live_grep<cr>",
				desc = "Grep for string in pwd (Telescope)"
			},
			{
				"<leader>fb",
				"<cmd>Telescope buffers<cr>",
				desc = "List open buffers in Nvim instance (Telescope)"
			},
			{
				'<leader>fh',
				"<cmd>Telescope help_tags<cr>",
				desc = "List available help tags (Telescope)"
			},
			{
				"<leader>ft",
				"<cmd>Telescope filetypes<cr>",
				desc = "Show available filetypes (Telescope)"
			},
		},
		opts = {
			defaults = {
				layout_config = {
					horizontal = {
						preview_width = 0.65
					}
				}
			}
		}
	},
}

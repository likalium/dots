return {
	{
		-- Neovim plugin to manage the file system and other tree like structures.
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		cmd = "Neotree",
		keys = {
			{ ";;", "<cmd>Neotree toggle<cr>",         desc = "Open Neotree" },
			{ ";:", "<cmd>Neotree reveal toggle<cr>",  desc = "Open Neotree and reveal currently active file" },
			{ ";!", "<cmd>Neotree buffers toggle<cr>", desc = "Show buffers (Neotree)" },
			{ ";m", "<cmd>Neotree float<cr>",          desc = "Open Neotree in popup window" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		opts = {
			close_if_last_window = true,
			enable_cursor_hijack = true,
			default_component_configs = {
				modified = {
					symbol = "󰐗",
					-- symbol = "󰄯", -- Alternative
					highlight = "Character",
				},
				name = {
					highlight_opened_files = true,
					highlight = "Identifier",
				},
			},
			popup_border_style = "rounded",
			window = { width = 30 },
			filesystem = { use_libuv_watcher = true },
		},
	},
	{
		-- Neovim file explorer: edit your filesystem like a buffer
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = "Oil",
		keys = {
			{ "<leader>?", "<cmd>Oil<cr>", desc = "Open parent directory (Oil)" },
			{
				"<leader>o",
				"<cmd>lua require('oil').open_float()<cr>",
				desc = "Open parent directory in floating window (Oil)",
			},
		},
		opts = {
			columns = {
				"icon",
				"permissions",
				"size",
				"mtime",
			},
			skip_confirm_for_simple_edits = true,
			experimental_watch_for_changes = true,
		},
	},
}

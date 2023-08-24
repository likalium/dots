return {
	{
		'goolord/alpha-nvim',
		lazy = false,
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			local if_nil = vim.F.if_nil
			local leader = ','
			local function button(hls, sc, txt, keybind, keybind_opts)
				local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")

				local opts = {
					position = "center",
					shortcut = sc,
					cursor = 3,
					width = 30,
					hl = 'DiagnosticHint',
					align_shortcut = "right",
					hl_shortcut = hls,
				}
				if keybind then
					keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
					opts.keymap = { "n", sc_, keybind, keybind_opts }
				end

				local function on_press()
					local key = vim.api.nvim_replace_termcodes(keybind or sc_ .. "<Ignore>", true, false, true)
					vim.api.nvim_feedkeys(key, "t", false)
				end

				return {
					type = "button",
					val = txt,
					on_press = on_press,
					opts = opts,
				}
			end
			require'alpha'.setup({
				layout = {
					{
						type = 'text',
						val = {
							"███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗             ",
							"████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║             ",
							"██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║             ",
							"██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║             ",
							"██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║    ██╗██╗██╗",
							"╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝    ╚═╝╚═╝╚═╝",
						},
						opts = { position = 'center', hl = 'Label' }
					},
					{ type = 'padding', val = 2 },
					{
						type = 'group',
						val = {
							button( 'Float', "nf", "  New file", "<cmd>ene<cr>"),
							button( 'Float', "ff", "󰈞  Find file", "<cmd>Telescope find_files<cr>"),
							button( 'Float', 'fw', '󰈬  Find word', "<cmd>Telescope live_grep<cr>"),
							button( 'Float', 'rf', '  Recent files', "<cmd>Telescope oldfiles<cr>"),
							button( 'Float', 'fb', '  File Browser', '<cmd>Telescope file_browser<CR>'),
							button( 'Float', 'q', '󰩈 Exit', '<cmd>q<CR>')
						},
						opts = { spacing = 1 }
					},
				},
				opts = { margin = 5 },
			})
		end,
	}
}

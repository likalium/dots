return {
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			'nvim-telescope/telescope-file-browser.nvim',
			'nvim-telescope/telescope-media-files.nvim',
			'nvim-lua/plenary.nvim',
			'HUAHUAI23/telescope-session.nvim',
			'AckslD/nvim-neoclip.lua',
			'tsakirist/telescope-lazy.nvim',
			'benfowler/telescope-luasnip.nvim',
			'debugloop/telescope-undo.nvim',
			'xiyaowong/telescope-emoji.nvim',
			'nvim-telescope/telescope-dap.nvim'
		},
		build = 'make',
		cmd = 'Telescope',
		keys = {
			-- FILE pickers
			{ '<leader>ff', '<cmd>Telescope find_files<CR>' },
			{ '<leader>fs', '<cmd>Telescope grep_string<CR>' },
			{ '<leader>fl', '<cmd>Telescope live_grep<CR>' },
			{ '<leader>mf', '<cmd>Telescope media_files'},
			-- VIM pickers
			{ '<leader>vb', '<cmd>Telescope buffers<CR>' },
			{ '<leader>vo', '<cmd>Telescope oldfiles<CR>' },
			{ '<leader>vc', '<cmd>Telescope command_history<CR>' },
			{ '<leader>vs', '<cmd>Telescope search_history<CR>' },
			{ '<leader>vm', '<cmd>Telescope marks<CR>' },
			{ '<leader>vop', '<cmd>Telescope vim_options<CR>' },
			{ '<leader>vr', '<cmd>Telescope registers<CR>' },
			{ '<leader>vf', '<cmd>Telescope filetypes<CR>' },
			-- GIT pickers
			{ '<leader>gc', '<cmd>Telescope git_commits<CR>' },
			{ '<leader>gb', '<cmd>Telescope git_branches<CR>' },

			-- File browser
			{ 'ff', "<cmd>Telescope file_browser<CR>" },

			-- Undo history
			{ '<leader>u', "<cmd>Telescope undo<CR>" }

		},
		config = function()
			local tel = require'telescope'
			local telex = require'telescope'.load_extension
			tel.setup({
				defaults = {
					--layout_strategy = 'vertical',
					layout_config = {
						height = 0.90,
						width = 0.90,
						--preview_height = 0.50,
						preview_width = 0.60,
						preview_cutoff = 0
						--preview_cutoff = 0
					}
				},
				extensions = {
					media_files = {
						filetypes = { 'png', 'jpeg', 'jpg', 'webm', 'pdf', 'mp4', 'webp' }
					}
				}
			})
			telex('file_browser')
			telex('neoclip')
			telex("xray23")
			telex("lazy")
			telex('luasnip')
			telex('undo')
			telex('media_files')
			telex('emoji')
			telex('macros')
			telex('dap')
			telex('yank_history')
		end,
	},
}

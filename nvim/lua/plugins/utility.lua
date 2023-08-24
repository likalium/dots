return {
	{ 'sudormrfbin/cheatsheet.nvim', cmd = 'Cheatsheet' },
	{ 'jghauser/mkdir.nvim', event = 'CmdLineEnter' },
	{ 'kazhala/close-buffers.nvim' },
	{
		'folke/noice.nvim',
		event = 'VeryLazy',
		config = function()
			require('noice').setup({
				lsp = {
					override = {
						['vim.lsp.util.convert_input_to_markdown_lines'] = true,
						['vim.lsp.util.stylize_markdown'] = true,
						['cmp.entry.get_documentation'] = true,
					},
					signature = {
						enabled = true,
					},
				},
				presets = {
					bottom_search = true,
					command_palette = true,
					inc_rename = true,
				},
			})
		end,
		dependencies = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' },
	},
	{
		'saifulapm/chartoggle.nvim',
		keys = { "<leader>,", "<leader>;" },
		config = function()
			require"chartoggle".setup({ leader = "<leader>", keys = {',', ';' } })
		end
	},
	{
		'stevearc/dressing.nvim',
		event = 'UiEnter',
		opts = {}
	},
	{
		'axieax/urlview.nvim',
		cmd = 'UrlView',
		config = function()
			require'urlview'.setup({ default_picker = "telescope" })
		end
	},
	{ 'axieax/typo.nvim' }, -- INFO: There is a cmd defined, see ../config/cmd.lua
	{ 'sitiom/nvim-numbertoggle', event = 'BufEnter' },
	{
		'kevinhwang91/nvim-ufo',
		dependencies = 'kevinhwang91/promise-async',
		event = 'BufRead',
		keys = {
			{ 'zR', '<cmd>lua require"ufo".openAllFolds()<CR>', noremap = true },
			{ 'zM', '<cmd>lua require"ufo".closeAllFolds()<CR>', noremap = true }
		},
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true
			}
			require('ufo').setup()
		end
	},
	{
		'nguyenvukhang/nvim-toggler',
		keys = { '<leader>i' },
		opts = {}
	},
	{
		'jbyuki/instant.nvim',
		cmd = { 'InstantStartServer', 'InstantStartSingle', 'InstantJoinSingle' },
		config = function()
			vim.g.instant_username = "likalium"
		end
	},
	{
		'echasnovski/mini.animate',
		version = false,
		event = 'VeryLazy',
		opts = { close = { enable = false } }
	},
	{
		'ecthelionvi/NeoComposer.nvim',
		dependencies = { "kkharji/sqlite.lua" },
		keys = { '<m-q>' },
		opts = {},
		cmd = { 'ToggleDelay', 'EditMacros', 'ClearNeoComposer' }
	},
	{
		'RutaTang/compter.nvim',
		opts = {
			templates = {
				-- for number
				{
					pattern = [[-\?\d\+]],
					priority = 0,
					increase = function(content)
						content = tonumber(content)
						return content + 1, true
					end,
					decrease = function(content)
						content = tonumber(content)
						return content - 1, true
					end,
				},
				-- for lowercase alphabet
				{
					pattern = [[\l]],
					priority = 0,
					increase = function(content)
						local ansiCode = string.byte(content) + 1
						if ansiCode > string.byte("z") then
							ansiCode = string.byte("a")
						end
						local char = string.char(ansiCode)
						return char, true
					end,
					decrease = function(content)
						local ansiCode = string.byte(content) - 1
						if ansiCode < string.byte("a") then
							ansiCode = string.byte("z")
						end
						local char = string.char(ansiCode)
						return char, true
					end,
				},
				-- for uppercase alphabet
				{
					pattern = [[\u]],
					priority = 0,
					increase = function(content)
						local ansiCode = string.byte(content) + 1
						if ansiCode > string.byte("Z") then
							ansiCode = string.byte("A")
						end
						local char = string.char(ansiCode)
						return char, true
					end,
					decrease = function(content)
						local ansiCode = string.byte(content) - 1
						if ansiCode < string.byte("A") then
							ansiCode = string.byte("Z")
						end
						local char = string.char(ansiCode)
						return char, true
					end,
				},
				-- for date format: dd/mm/YYYY
				{
					pattern = [[\d\{2}/\d\{2}/\d\{4}]],
					priority = 100,
					increase = function(content)
						local ts = vim.fn.strptime("%d/%m/%Y", content)
						if ts == 0 then
							return content, false
						else
							ts = ts + 24 * 60 * 60
							return vim.fn.strftime("%d/%m/%Y", ts), true
						end
					end,
					decrease = function(content)
						local ts = vim.fn.strptime("%d/%m/%Y", content)
						if ts == 0 then
							return content, false
						else
							ts = ts - 24 * 60 * 60
							return vim.fn.strftime("%d/%m/%Y", ts), true
						end
					end,
				}
			}
		}
	},
	{
		'https://git.sr.ht/~reggie/licenses.nvim',
		cmd = { 'LicenseInsert', 'LicenseFetch', 'LicenseUpdate', 'LicenseWrite' },
		config = function()
			require'licenses'.setup({
				copyright_holder = 'likalium',
				license = 'BSD-3-Clause'
			})
		end
	},
	{ 'gaborvecsei/usage-tracker.nvim', lazy = false, config = true }
}

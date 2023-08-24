return {
	{
		'neovim/nvim-lspconfig',
		priority = 500,
		lazy = false,
	},
	{
		'onsails/lspkind.nvim',
		config = function()
			require'lspkind'.init({
				symbol_map = {
					String = "󰬴"
				},
			})
		end,
	},
	{
		'smjonas/inc-rename.nvim',
		config = function()
			require'inc_rename'.setup()
		end,
	},
	{
		'kosayoda/nvim-lightbulb',
		lazy = false,
		config = function()
			require'nvim-lightbulb'.setup({
				autocmd = { enabled = false },
				number = { enabled = true, hl = 'yellow' }
			})
		end,
	},
	{
		'stevearc/aerial.nvim',
		cmd = { 'AerialToggle' },
		keys = {
			{ '<leader>at', '<cmd>AerialToggle<CR>' },
			{ '<leader>ap', '<cmd>AerialPrev<CR>' },
			{ '<leader>an', '<cmd>AerialNext<CR>' }
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons"
		},
		opts = {}
	},
	{
		'mfussenegger/nvim-lint',
		config = function()
			vim.g.code_action_menu_window_border = 'rounded'
			require'lint'.linters_by_ft = {
				cpp = {"cppcheck"},
				c = {"cppcheck"},
				javascript = {"eslint_d"},
				lua = {"luacheck"},
				mardown = {"mardownlint"},
				python = {"flake8"},
				vim = {"vint"},
			}
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
	{
		'weilbith/nvim-code-action-menu',
		cmd = "CodeActionMenu",
		config = function()
			vim.g.code_action_menu_window_border = 'rounded'
		end
	},
	{
		'simrat39/symbols-outline.nvim',
		cmd = 'SymbolsOutline',
		keys = {
			{ '<leader>so', '<cmd>SymbolsOutline<CR>' }
		},
		opts = {
			auto_preview = true,
			position = 'left',
			relative_width = true,
		}
	},
	-- LSP Installer
	{
		'williamboman/mason.nvim',
		lazy = false,
		priority = 2000,
		config = function()
			require'mason'.setup({
				ui = {
					width = 1,
					height = 1,
					border = "rounded",
				},
				pip = { upgrade_pip = true }
			})
		end,
	},
	{
		'williamboman/mason-lspconfig.nvim',
		lazy = false,
		priority = 1000,
		config = function()
			require'mason-lspconfig'.setup({
				ensure_installed = {
					'awk_ls',
					'gopls',
					'bashls',
					'clangd',
					'neocmake',
					'cssls',
					'html',
					'jsonls',
					'tsserver',
					'lua_ls',
					'pyre',
					'taplo',
					'vimls'
				},
			automatic_installation = true,
			})
			require'mason-lspconfig'.setup_handlers {
				function(server_name)
					require('lspconfig')[server_name].setup {}
				end,
			}
		end,
	},
	-- Diagnostics
	{
		'folke/trouble.nvim',
		requires = 'nvim-tree/nvim-web-devicons',
		cmd = 'Trouble',
		keys = {
			{ '<leader>tt', '<cmd>Trouble<CR>' }
		}
	},
}

return {
	-- Priorities is here to make sure that we load mason.nvim first, then mason-lspconfig, then nvim-lspconfig
	{
		-- Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP servers, DAP servers, linters, and formatters.
		"williamboman/mason.nvim",
		config = true,
		lazy = false,
		priority = 500,
		opts = {
			ui = {
				border = "rounded",
				width = 1.0,
				height = 0.9,
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	{
		-- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim.
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		priority = 250,
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"bashls",
					"clangd",
					"cmake",
					"cssls",
					-- 'diagnosticls',
					-- 'dprint',
					"html",
					"jsonls",
					"ltex",
					"lua_ls",
					"marksman",
					"mutt_ls",
					-- 'nil_ls',
					-- 'pkgbuild_language_server',
					"pylyzer",
					"quick_lint_js",
					-- 'ruff',
					"somesass_ls",
					-- 'sqlls',
					"stylelint_lsp",
					"tailwindcss",
					"typos_lsp",
					"vimls",
				},
			})
		end,
	},
	{
		-- Quickstart configs for Nvim LSP
		"neovim/nvim-lspconfig",
		lazy = false,
		priority = 100,
	},
	{
		-- null-ls.nvim reloaded / Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
		"nvimtools/none-ls.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		lazy = false,
		keys = {
			{ "<leader>fo", "<cmd>lua vim.lsp.buf.format()<cr>", desc = "Formats current buffer"}
		},
		config = function()
			local diags = require("null-ls").builtins.diagnostics
			local format = require("null-ls").builtins.formatting
			require("null-ls").setup({
				update_in_insert = true,
				sources = {
					-- Linting
					diags.codespell,
					diags.cppcheck,
					diags.markdownlint,
					diags.pylint,
					diags.spectral,
					diags.stylelint,
					--diags.texidote,
					diags.tidy,
					diags.vale,
					diags.vint,
					-- Formatting
					format.astyle,
					format.biome,
					format.black,
					format.codespell,
					format.prettier,
					format.rustywind,
					format.shellharden,
					format.stylelint,
					format.stylua,
					--format.texlint,
				},
			})
		end,
	},
	{
		--  Code analysis & navigation plugin for Neovim. Navigate codes like a breeze Exploring LSP and Treesitter symbols a piece of cake. Take control like a boss
		"ray-x/navigator.lua",
		lazy = false,
		dependencies = {
			{ "ray-x/guihua.lua", build = "cd lua/fzy && make" },
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			mason = true,
			lsp = { format_on_save = false },
			default_mapping = true,
			icons = {
				icons = false,
			},
		},
	},
	{
		-- Neovim plugin for a code outline window
		"stevearc/aerial.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		cmd = {
			"AerialToggle",
			"AerialOpen",
			"AerialOpenAll",
			"AerialClose",
			"AerialCloseAll",
			"AerialNext",
			"AerialPrev",
			"AerialGo",
			"AerialInfo",
			"AerialNavToggle",
			"AerialNavOpen",
			"AerialNavClose",
		},
		keys = {
			{ "<leader>a", "<cmd>AerialToggle<CR>", desc = "Toggle Aerial window" },
		},
		opts = {
			layout = {
				min_width = 20,
			},
		},
	},
	{
		-- A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing
		"folke/trouble.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		cmd = "Trouble",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle focus=true<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xc",
				"<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=true<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xl",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xq",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
}

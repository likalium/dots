return {
	{
		--  A completion plugin for neovim coded in Lua.
		"hrsh7th/nvim-cmp",
		dependencies = {
			-- Pictograms of completion items
			"onsails/lspkind.nvim",
			-- Snippets
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			-- Buffer / Vim-builtin functionality
			"hrsh7th/cmp-buffer",
			"rasulomaroff/cmp-bufname",
			"hrsh7th/cmp-omni",
			-- LSP
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			-- Filesystem paths
			"FelipeLema/cmp-async-path",
			-- Git
			"petertriho/cmp-git",
			-- Command line
			"hrsh7th/cmp-cmdline",
			-- Symbols
			"kdheepak/cmp-latex-symbols",
			-- Misc
			"mfussenegger/nvim-dap", -- required for 'cmp-dap'
			"rcarriga/cmp-dap",
			"hrsh7th/cmp-nvim-lua",
			"ray-x/cmp-treesitter",
			-- 'ray-x/cmp-sql'
		},
		lazy = false,
		config = function()
			local cmp = require("cmp")
			local default_sources = cmp.config.sources({
				-- Lazydev
				{ name = "lazydev" }, -- folke/lazydev.nvim LuaLS setup for neovim completion source
				-- Snippets
				{ name = "luasnip" }, -- luasnip completion source for nvim-cmp
				-- Buffer / Vim-builtin functionality
				{ name = "buffer" }, -- nvim-cmp source for buffer words
				{ name = "bufname" }, -- Buffer (file) name completion source for nvim-cmp
				{ name = "omni" }, -- nvim-cmp source for omnifunc
				-- LSP
				{ name = "nvim_lsp" }, -- nvim-cmp source for neovim builtin LSP client
				{ name = "cmp-nvim-lsp-signature-help" }, -- cmp-nvim-lsp-signature-help
				-- Filesystem paths
				{ name = "aync_path" }, -- nvim-cmp source for filesystem paths with async processing
				-- Git
				{ name = "git" }, -- Git source for nvim-cmp
				-- Symbols
				{ name = "latex_symbols" }, -- Add latex symbol support for nvim-cmp
				-- Misc
				{ name = "dap" }, --  nvim-cmp source for nvim-dap REPL and nvim-dap-ui buffers
				{ name = "nvim_lua" }, -- nvim-cmp source for nvim lua
				{ name = "treesitter" }, -- cmp source for treesitter
				-- { name = "sql" }              -- SQL keywords for cmp
			})
			-- Defines if a buffer is "big" or not. Can be adjusted to your liking
			bufIsBig = function(bufnr)
				local max_filesize = 100 * 1024 -- 100 KB
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
				if ok and stats and stats.size > max_filesize then
					return true
				else
					return false
				end
			end
			-- If a file is too large, I don't want to add to it's cmp sources treesitter, see:
			-- https://github.com/hrsh7th/nvim-cmp/issues/1522
			vim.api.nvim_create_autocmd("BufReadPre", {
				callback = function(t)
					local sources = default_sources
					if not bufIsBig(t.buf) then
						sources[#sources + 1] = { name = "treesitter", group_index = 2 }
					end
					cmp.setup.buffer({
						sources = sources,
					})
				end,
			})
			-- Disables nvim-cmp for guihui buffers
			if vim.o.ft == "clap_input" and vim.o.ft == "guihua" and vim.o.ft == "guihua_rust" then
				require("cmp").setup.buffer({ completion = { enable = false } })
			end
			-- VSCode Codicons
			local codicons = {
				Text = " ",
				Method = " ",
				Function = " ",
				Constructor = " ",
				Field = " ",
				Variable = " ",
				Class = " ",
				Interface = " ",
				Module = " ",
				Property = " ",
				Unit = " ",
				Value = " ",
				Enum = " ",
				Keyword = " ",
				Snippet = " ",
				Color = " ",
				File = " ",
				Reference = " ",
				Folder = " ",
				EnumMember = " ",
				Constant = " ",
				Struct = " ",
				Event = " ",
				Operator = " ",
				TypeParameter = " ",
			}
			-- General settings
			cmp.setup({
				enabled = function()
					-- disable completion in comments
					local context = require("cmp.config.context")
					-- keep command mode completion enabled when cursor is in a comment
					if vim.api.nvim_get_mode().mode == "c" then
						return true
					else
						return not context.in_treesitter_capture("comment") and
						not context.in_syntax_group("Comment")
					end
				end,
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
				}),
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				view = {
					entries = { name = "custom", selection_order = "near_cursor" },
				},
				-- UI style
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				-- Adding icons (through lspkind) to the completion
				formatting = {
					format = require("lspkind").cmp_format({
						mode = "text",
						before = function(entry, vim_item)
							-- use Codicons as icons
							vim_item.kind = string.format("%s %s", codicons[vim_item.kind],
								vim_item.kind)
							return vim_item
						end,
					}),
				},
			})
			-- Special settings for search
			cmp.setup.cmdline({ "?", "/" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
				view = {
					entries = { name = "wildmenu", separator = " / " },
				},
			})
			-- Special settings for cmd
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
					{ name = "cmdline" },
				}),
			})
			vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#0B9910", bg = "#7E8294" })
		end,
	},
	{
		"lukas-reineke/cmp-under-comparator",
		opts = {},
	},
}

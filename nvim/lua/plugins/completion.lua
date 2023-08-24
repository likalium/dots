return {
	{
		'hrsh7th/nvim-cmp',
		dependencies = { 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip', 'neovim/nvim-lspconfig', 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline', 'petertriho/cmp-git', 'dmitmel/cmp-cmdline-history', 'tamago324/cmp-zsh', 'hrsh7th/cmp-calc', 'hrsh7th/cmp-emoji', 'ray-x/cmp-treesitter', 'KadoBOT/cmp-plugins', 'hrsh7th/cmp-nvim-lua', 'chrisgrieser/cmp-nerdfont' },
		event = { 'InsertEnter', 'CmdLineEnter' },
		config = function()
			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
			end
			local cmp = require'cmp'
			local luasnip = require'luasnip'
			local lspkind = require'lspkind'
			local lspconfig = require'lspconfig'

			cmp.setup({
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm({ select = true }),
					['<Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { 'i', 's' }),
					['<S-Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, {'i', 's' })
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' },
					{ name = 'calc' },
					-- { name = "zsh" }, -- To reduce load time
					{ name = 'plugins' },
					{ name = 'nvim-lua' },
					{ name = 'treesitter' },
					{ name = 'emoji' },
					{ name = 'nerdfont' },
					{ name = 'buffer' },
				}),
				view = { entries = { name = 'custom', selection_order = 'near_cursor' } },
				formatting = {
					format = lspkind.cmp_format({
						mode = 'symbol_text',
						menu = ({
							buffer = '[BUFFER]',
							nvim_lsp = '[LSP]',
							luasnip = '[LuaSnip]',
							nvim_lua = '[Lua]',
						}),
					}),
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
			})
			cmp.setup.filetype('gitcommit', {
				sources = cmp.config.sources({
					{ name = 'cmp_git' }
				}, {
					{ name = 'buffer' }
				}),
			})
			cmp.setup.cmdline({ '/', '?' }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = { { name = 'cmdline-history' }, { name = 'buffer' } },
				view = { entries = { name = 'wildmenu', separator = ' / ' } },
			})
			cmp.setup.cmdline(':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' }, { name = 'cmdline-history' } })
			})
		end,
	},
}

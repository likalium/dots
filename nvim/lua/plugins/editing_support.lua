return {
	{ 'windwp/nvim-autopairs', event = 'InsertEnter', opts = { check_ts = true } },
	{ 'windwp/nvim-ts-autotag', event = 'InsertEnter', opts = {} },
	{ 'pocco81/high-str.nvim', cmd = { 'HSHighlight', 'HSRmHighlight', 'HSExport', 'HSImport' } },
	{ 'folke/zen-mode.nvim', cmd = 'ZenMode' },
	{
		'nvim-treesitter/nvim-treesitter-context',
		cmd = {
			'TSContextEnable',
			'TSContextDisable',
			'TSContextToggle'
		},
		opts = { plugins = { kitty = true } }
	},
	{ 'nacro90/numb.nvim', event = 'CmdLineEnter', opts = { number_only = true } },
	{
		'filipdutescu/renamer.nvim',
		branch = 'master',
		keys = {
			{ '<F2>', "<cmd>lua require'renamer'.rename()<CR>", noremap = true },
			{ '<leader>rn', '<cmd>lua require("renamer").rename()<cr>', { mode = { 'n', 'v' }, noremap = true, silent = true }}
		},
		dependencies = 'nvim-lua/plenary.nvim',
		opts = {}
	},
	{
		'gbprod/yanky.nvim',
		dependencies = 'kkharji/sqlite.lua',
		keys = {
			{ "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }},
			{ "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }},
			{ "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }},
			{"gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }},
			{ "<c-n>", "<Plug>(YankyCycleForward)" },
			{ "<c-p>", "<Plug>(YankyCycleBackward)" }
		},
		opts = {
			ring = {
				storage = 'sqlite'
			}
		}
	},
	{ 'echasnovski/mini.move', version = false, keys = { "<M-h>", "<M-j>", "<M-k>", "<M-l>" }, opts = {} },
	{
		'bennypowers/nvim-regexplainer',
		config = true,
		keys = {
			{ '<leader>rx', "<cmd>RegexplainerShowPopup<CR>" }
		},
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
			'MunifTanjim/nui.nvim'
		},
		opts = {}
	},
	{ 'anuvyklack/pretty-fold.nvim', event = 'BufEnter', opts = {} },
	{ 'gbprod/stay-in-place.nvim', event = 'BufEnter', opts = {} },
	{ 'echasnovski/mini.ai', version = false, opts = {} },
	{
		'Wansmer/treesj',
		keys = { '<space>m', '<space>j', '<space>s' },
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		opts = {}
	},
	{ 'shortcuts/no-neck-pain.nvim', cmd = { 'NoNeckPain', 'NoNeckPainWidthUp', 'NoNeckPainWidthDown' } },
	{
		'niuiic/part-edit.nvim',
		dependencies = 'niuiic/core.nvim',
		keys = {
			{ '<leader>pe', '<cmd>PartEdit<CR>', { silent = true, mode = 'v' }}
		},
		cmd = 'PartEdit',
		opts = { open_in = 'float', float = { win = { width_ratio = 0.8, height_ratio = 0.6 }}},
	},
	-- Comment
	{
		'numToStr/Comment.nvim',
		keys = { 'gcc', 'gbb' },
		opts = {}
	},
	{
		'folke/todo-comments.nvim',
		event = 'BufRead',
		dependencies = "nvim-lua/plenary.nvim",
		opts = {}
	},
	{
		'LudoPinelli/comment-box.nvim',
		keys = {
			{ '<leader>ccb', "<cmd>CBccbox<CR>", { mode = 'v', desc = 'Create a centered comment box, with centered text'}},
			{ '<leader>', "<cmd>CBcatalog", { mode = 'v', desc = "Open comment boxes catalog"}}
		},
		cmd = {
			'CBllbox',
			'CBlcbox',
			'CBlrbox',
			'CBclbox',
			'CBccbox',
			'CBcrbox',
			'CBrlbox',
			'CBrcbox',
			'CBrrbox',
			'CBalbox',
			'CBacbox',
			'CBarbox',
			'CBline',
			'CBcline',
			'CBrline',
			'CBcatalog',
		}
	}
}

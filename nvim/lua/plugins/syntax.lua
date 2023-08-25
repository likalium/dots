return {
	{
		'nvim-treesitter/nvim-treesitter',
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"cmake",
				"commonlisp",
				"cpp",
				"diff",
				"html",
				"javascript",
				"json",
				"latex",
				"lua",
				"make",
				"meson",
				"python",
				"r",
				"regex",
				"rasi",
				"scss",
				"toml",
				"vim",
				"yuck",
			},
			sync_install = true,
			auto_install = true,
			ignore_install = {""},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = true,
			},
			matchup = { enable = true },
		}
	},
	{ 'nvim-treesitter/nvim-treesitter-textobjects', dependencies = 'nvim-treesitter/nvim-treesitter' },
	{ 'kylechui/nvim-surround', event = 'VeryLazy', config = function() require'nvim-surround'.setup() end },
	{ 'm-demare/hlargs.nvim', lazy = false, config = true },
}


return {
	{ 'lewis6991/gitsigns.nvim', lazy = false, opts = {} },
	{
		'NeogitOrg/neogit',
		cmd = 'Neogit',
		keys = {
			{ '<leader>g', '<cmd>Neogit<CR>' }
		},
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope.nvim',
			'sindrets/diffview.nvim'
		},
		opts = {}
	},
	{
		'akinsho/git-conflict.nvim',
		version = "*",
		cmd = {
			'GitConflictChooseOurs',
			'GitConflictChooseTheir',
			'GitConflictChooseBoth',
			'GitConflictChooseNone',
			'GitConflictNextConfict',
			'GitConflictPrevConfict',
			'GitConflictListQf'
		},
		config = true
	},
	-- Github
	{
		'pwntester/octo.nvim',
		cmd = 'Octo',
		config = function()
			require'octo'.setup()
		end
	}
}

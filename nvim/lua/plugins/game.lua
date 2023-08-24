return {
	{ 'alec-gibson/nvim-tetris', cmd = 'Tetris' },
	{ 'seandewar/nvimesweeper', cmd = 'Nvimesweeper' },
	{ 'rktjmp/shenzhen-solitaire.nvim', cmd = 'ShenzhenSolitaireNewGame' },
	{ 'Eandrju/cellular-automaton.nvim', cmd = 'CellularAutomaton' },
	{ 'alanfortlink/blackjack.nvim', cmd = { 'BlackJackNewGame', 'BlackJackQuit', 'BlackJackResetScores' } },
	{ 'jim-fx/sudoku.nvim', cmd = 'Sudoku', config = true },
	{ 'folke/drop.nvim', opts = { theme = "snow" } },
	-- Competitive programming
	{ 'xeluxee/competitest.nvim', dependencies = 'MunifTanjim/nui.nvim', config = true },
	{
		'Dhanus3133/Leetbuddy.nvim',
		cmd = { 'LBQuestions', 'LBQuestion', 'LBReset', 'LBTest', 'LBSubmit' },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = true
	}
}

return {
	{
		'nvim-neotest/neotest',
		config = function ()
			require'neotest'.setup({
				adapters = {
					require'neotest-python'
				}
			})
		end
	},
	{
		'klen/nvim-test',
		cmd = { 'TestSuite', 'TestFile', 'TestEdit', 'TestNearest', 'TestLast', 'TestVisit', 'TestInfo' },
		config = true
	}
}

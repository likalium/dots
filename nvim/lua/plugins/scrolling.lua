return {
	-- Scrollbar
	{
		'gorbit99/codewindow.nvim',
		keys = {
			{ '<leader>mt', "<cmd>lua require'codewindow'.toggle_minimap()<CR>" } -- mt -> minimap toggle
		},
		config = function()
			local codewindow = require('codewindow')
			codewindow.setup({ window_border = 'rounded' })
			codewindow.apply_default_keybinds()
		end,
	}
}

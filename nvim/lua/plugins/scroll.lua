return {
	{
		'karb94/neoscroll.nvim',
		event = 'BufEnter',
		config = function()
			require'neoscroll'.setup({
				mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
				hide_cursor = false,
				stop_eof = true,
				respect_scrolloff = true,
				cursor_scroll_alone = true,
				easing_function = nil,
				pre_hook = nil,
				post_hook = nil,
				performance_mode = false,
			})
		end,
	},
}

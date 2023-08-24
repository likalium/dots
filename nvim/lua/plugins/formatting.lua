return {
	{ 'echasnovski/mini.align', keys = { 'ga', 'gA' }, version = false, opts = {} },
	-- Indent
	{
		'lukas-reineke/indent-blankline.nvim',
		event = 'BufRead',
		opts = {
			show_current_context = true,
		}
	}
}

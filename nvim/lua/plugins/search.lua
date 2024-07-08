-- recurring opts for nvim-hlslens keymaps
local kopts = { noremap = true, silent = true }
return {
	{
		-- Hlsearch Lens for Neovim
		"kevinhwang91/nvim-hlslens",
		dependencies = { "kevinhwang91/nvim-ufo" },
		opts = {},
		keys = {
			{ "n",         "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>",	kopts },
			{ "N",         "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>",	kopts },
			{ "*",         "*<Cmd>lua require('hlslens').start()<CR>",						kopts },
			{ "#",         "#<Cmd>lua require('hlslens').start()<CR>",						kopts },
			{ "g*",        "g*<Cmd>lua require('hlslens').start()<CR>",						kopts },
			{ "g#",        "g#<Cmd>lua require('hlslens').start()<CR>",						kopts },
			{ "<leader>l", "<Cmd>noh<CR>",										kopts },
		},
	},
}

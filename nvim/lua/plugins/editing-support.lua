return {
	{
		'windwp/nvim-autopairs',
		lazy = false,
		config = function()
			require('nvim-autopairs').setup({
				-- Disabling autopairs for guihua
				disable_filetype = { "TelescopePrompt" , "guihua", "guihua_rust", "clap_input" }
			})
		end
	},
	{
		'windwp/nvim-ts-autotag',
		lazy = false,
		config = true
	}
}

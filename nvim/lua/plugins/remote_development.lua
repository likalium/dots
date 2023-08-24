return {
	{
		'chipsenkbeil/distant.nvim',
		branch = 'v0.3',
		cmd = { 'DistantInstall', 'DistantConnect' },
		config = function()
			require'distant':setup()
		end
	}
}

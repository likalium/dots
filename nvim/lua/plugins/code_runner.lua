return {
	{
		'michaelb/sniprun',
		build = 'sh install.sh',
		cmd = { 'SnipRun', 'SnipInfo', 'SnipClose', 'SnipReset', 'SnipReplMemoryClean' },
		config = true,
	},
	{ 'stevearc/overseer.nvim', cmd = { 'OverseerRun', 'OverseerToggle' }, opts = {} }
}

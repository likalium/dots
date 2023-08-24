local lazypath = vim.fn.stdpath("data") .. "lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
	vim.fn.system({ "git", "-C", lazypath, "checkout", "tags/stable" })
end
vim.opt.rtp:prepend(lazypath)

return function(opts)
	opts = vim.tbl_deep_extend("force", {
		spec = {
			{ import = "plugins" },
		},
		defaults = { lazy=true, module = false },
		install = {
			missing=true,
			colorscheme = { "nord", "catppuccin", "tokyonight", "decay.nvim" },
		},
		checker = { enabled = true },
		performance = {
			{ cache = {enabled=true } },
			disabled_plugins = {
				"tutor",
			},
		},
		debug = false,
		ui = {
			size = {  width = 1, height = 1 },
			border = "rounded",
		},
	}, opts or {})
	require("lazy").setup(opts)
end


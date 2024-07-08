-- by likalium :)

-- Loading options
require("config.options")

-- Bootstrapping lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Lazy.nvim options, see "https://github.com/folke/lazy.nvim?tab=readme-ov-file#%EF%B8%8F-configuration"
local lazyOpts = {
	defaults = {
		lazy = true,
	},
	install = {
		colorscheme = { "tokyonight" },
	},
	ui = {
		size = {
			width = 1,
			height = 0.9,
		},
		border = "rounded",
	},
	checker = {
		enabled = true,
	},
}

-- Loading all plugins with lazy.nvim, with options defined in lazyOpts
require("lazy").setup("plugins", lazyOpts)

-- Loading colorscheme
vim.cmd([[colorscheme tokyonight]])

-- Applying custom highlight groups
require("config.highlights")

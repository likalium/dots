-- by likalium :)

HOME = os.getenv("HOME")

require'config.options'
vim.cmd([[filetype plugin indent on]])
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
require('config.lazy')({
	debug = false,
	defaults = {lazy = true, event = VeryLazy},
	performance = {
		cache = {
			enabled = true,
		},
	},
})
require'config.cmd'
vim.cmd([[colorscheme tokyonight]])

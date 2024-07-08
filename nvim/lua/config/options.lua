-- Setting up <leader>
vim.g.mapleader = ","

-- Disable netrw as we will use plugins that will do even better
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Custom LSP icons
vim.diagnostic.config({
	update_in_insert = true,
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.INFO] = "󰌵 ",
			[vim.diagnostic.severity.HINT] = " ",
		},
	},
})

-- Setting tab to 4
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

-- We don't want cmdheight for the sake of fanciness
-- vim.opt.cmdheight = 0
-- Instead, show shortcuts in statusline (needed for `showCmd` in heirline to work. See nvim/lua/plugins/bars_and_lines.lua)
vim.opt.showcmdloc = "statusline"

-- I love relative line numbers :)
vim.opt.relativenumber = true

-- See https://github.com/rebelot/heirline.nvim/issues/203
vim.cmd([[au VimLeavePre * set stl=]])

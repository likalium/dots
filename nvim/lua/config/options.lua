local g = vim.g
local opt = vim.opt
local cmd = vim.cmd
local o = vim.o

vim.patchmode = ".orig"
-- Personnal
g.mapleader = ','
opt.number = true
opt.ruler = true
opt.cursorline = true
opt.backup = false
opt.modeline = true
opt.showmatch = false
opt.ignorecase = true
opt.smartcase = true
opt.infercase = true
opt.wrap = false
opt.autoindent = true
opt.linebreak = true
opt.wrapscan = true
opt.tabstop = 4
opt.shiftwidth = 4
cmd([[au! ColorScheme * hi CursorLineNr guifg='white' guibg=#292e42]])

-- Edgy
opt.laststatus = 3
opt.splitkeep = "screen"

-- Lsp Signs
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl })
end

-- Treesitter Context
cmd([[au! ColorScheme * hi TreesitterContext guibg='bg_dark']])

-- Nvim-UFO
o.foldcolumn = '1'
o.foldlevel = 99
vim.o.foldenable = true

return {
	-- Web Development
	{ 'ray-x/web-tools.nvim' },
	-- Markdown and LaTeX
	{
		'iamcco/markdown-preview.nvim',
		build = "cd app && npm install",
		cmd = { 'MarkdownPreview', 'MarkdownPreviewStop' },
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	-- Yuck
	{ 'elkowar/yuck.vim', ft = 'yuck' },
	-- ipynb files
	{ 'meatballs/notebook.nvim', ft = 'ipynb' }
}

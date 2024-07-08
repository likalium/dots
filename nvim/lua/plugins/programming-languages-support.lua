return {
	{
		-- Neovim plugin for web developers
		"ray-x/web-tools.nvim",
		opts = {},
		cmd = {
			"BrowserSync",
			"BrowserOpen",
			"BrowserPreview",
			"BrowserRestart",
			"BrowserStop",
			"TagRename",
			"HurlRun",
			"Npm",
			"Yarn",
			"Pnpm",
			"Npx",
			"Node",
			"JobStop",
		},
		keys = {
			{ "<leader>bs", "<cmd>BrowserSync<CR>",    desc = "Run browser-sync server (web-tools)" },
			{ "<leader>bo", "<cmd>BrowserOpen<CR>",    desc = "Open browser-sync (web-tools)" },
			{ "<leader>br", "<cmd>BrowserRestart<CR>", desc = "Restart browser-sync (web-tools)" },
			{ "<leader>bS", "<cmd>BrowserStop<CR>",    desc = "Stop browser-sync (web-tools)" },
		},
	},
	{
		-- UNOFFICIAL Tailwind CSS integration and tooling for Neovim
		"luckasRanarison/tailwind-tools.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {},
	},
	{
		-- markdown preview plugin for (neo)vim
		"iamcco/markdown-preview.nvim",
		build = "cd app && npx --yes yarn install",
		ft = { "markdown" },
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		keys = {
			{ "<leader>mt", "<cmd>MarkdownPreviewToggle<CR>", desc = "Toggle MarkdownPreview" },
		},
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
	},
}

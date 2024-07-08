return {
	{
		-- Nvim Treesitter configurations and abstraction layer
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
	--	cond = function ()
	--		-- If the buffer is too big, we don't load treesitter. Can be adjusted to your liking.
	--		bufIsBig = function(bufnr)
	--			local max_filesize = 100 * 1024 -- 100 KB
	--			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
	--			if ok and stats and stats.size > max_filesize then
	--				return true
	--			else
	--				return false
	--			end
	--		end
	--	end,
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"bash",
					"c",
					"comment",
					"cpp",
					"css",
					"diff",
					"gitignore",
					"html",
					"hyprlang",
					"javascript",
					"json",
					"latex",
					"lua",
					"markdown",
					"markdown_inline",
					"norg",
					"printf",
					"python",
					"scss",
					"toml",
					"vim",
					"vimdoc",
					"zathurarc",
				},
				highlight = {
					enable = true,
				},
				incremental_selection = {
					enable = true,
				},
				indent = {
					enable = true,
				},
			})
		end,
	},
}

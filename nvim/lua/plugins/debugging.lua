return {
	{
		'mfussenegger/nvim-dap',
		dependencies = { 'mfussenegger/nvim-dap-python', 'jbyuki/one-small-step-for-vimkind', 'tomblind/local-lua-debugger-vscode' },
		keys = {
			{ '<F8>', "<cmd>lua require'dap'.toggle_breakpoint()<CR>", noremap = true },
			{ '<F9>', "<cmd>lua require'dap'.continue()<CR>", noremap = true },
			{'<F10>', "<cmd>lua require'dap'.step_over()<CR>", noremap = true },
			{'<S-F10>', "<cmd>lua require'dap'.step_into()<CR>", noremap = true },
			{ '<F12>', "<cmd>lua require'dap.ui.widgets'.hover()<CR>", noremap = true },
			{ '<F5>', "<cmd>lua require'osv'.launch({port = 8086})<CR>", noremap = true }
		},
		config = function()
			local dap = require"dap"
			-- Lua
			dap.adapters["local-lua"] = {
				type = "executable",
				command = "node",
				args = {
					"/absolute/path/to/local-lua-debugger-vscode/extension/debugAdapter.js"
				},
				enrich_config = function(config, on_config)
					if not config["extensionPath"] then
						local c = vim.deepcopy(config)
						c.extensionPath = "/absolute/path/to/local-lua-debugger-vscode/"
						on_config(c)
					else
						on_config(config)
					end
				end,
			}

			require'dap-python'.setup('~/.config/nvim/virtualenvs/debugpy/bin/python')

			dap.configurations.lua = {
				{
					type = 'nlua',
					request = 'attach',
					name = "Attach to running Neovim instance",
				}
			}
			dap.adapters.nlua = function(callback, config)
				callback({ type = 'server', host = config.host or "127.0.0.1", port = config.port or 8086 })
			end

			dap.adapters.bashdb = {
				type = 'executable';
				command = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/bash-debug-adapter';
				name = 'bashdb';
			}
			dap.configurations.sh = {
				{
					type = 'bashdb';
					request = 'launch';
					name = "Launch file";
					showDebugOutput = true;
					pathBashdb = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb';
					pathBashdbLib = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir';
					trace = true;
					file = "${file}";
					program = "${file}";
					cwd = '${workspaceFolder}';
					pathCat = "cat";
					pathBash = "/bin/bash";
					pathMkfifo = "mkfifo";
					pathPkill = "pkill";
					args = {};
					env = {};
					terminalKind = "integrated";
				}
			}
		end
	},
	{ 'rcarriga/nvim-dap-ui', config = true },
	{
		'andrewferrier/debugprint.nvim',
		keys = { 'g?p', 'g?P', 'g?v', 'g?V', 'g?o', 'g?O' },
		cmd = 'DeleteDebugPrints',
		config = true
	},
	-- quickfix
	{ 'kevinhwang91/nvim-bqf' }
}

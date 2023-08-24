local api = vim.api
local create_cmd = api.nvim_create_user_command

-- Nvim-Dap-Ui
create_cmd('DapUiOpen', 'lua require("dapui").open()', { desc = "Open nvim-dap-ui" })
create_cmd('DapUiClose', "lua require'dapui'.close()", { desc = "Close nvim-dap-ui" })

-- Typo
create_cmd("Typo", function() require'typo'.check() end, {} )

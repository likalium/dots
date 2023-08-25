return {
	{ 'SmiteshP/nvim-navic', dependencies = 'neovim/nvim-lspconfig', opts = { lsp = { auto_attach = true } } },
	{
		'rebelot/heirline.nvim',
		event = 'BufEnter',
		config = function()
			local utils = require'heirline.utils'
			local gethi = utils.get_highlight
			local conditions = require("heirline.conditions")
			local util = require'tokyonight.util'
			local colors = require'tokyonight.colors'.setup()
			local lightbg = util.lighten(colors.bg, 0.95)

			local space = { provider = " " }
			local seps = {
					{ provider = '  ', hl = { fg = 'dark3'} },
					{ provider = '  ', hl = { fg = 'dark3'} },
			}
			local align = { provider = "%=" }

			local ruler = {
				{
					provider = " %4(%l/%L%):%c ", hl = { fg = gethi('statement').fg, bg = 'terminal_black' }
				},
				{
					provider = "",
					hl = { fg = lightbg}
				}
			}
			ruler = utils.surround({'', ''}, 'terminal_black', { ruler })
			local percent = { provider = " %P", hl = { fg = gethi('statement').fg, bg = lightbg}}
			-- Statusline
			local viMode = {
				init = function(self)
					self.mode = vim.fn.mode(1)
				end,
				static = {
					mode_names = {
						n = "N",
						no = "N?",
						nov = "N?",
						noV = "N?",
						["no\22"] = "N?",
						niI = "Ni",
						niR = "Nr",
						niV = "Nv",
						nt = "Nt",
						v = "V",
						vs = "Vs",
						V = "V_",
						Vs = "Vs",
						["\22"] = "^V",
						["\22s"] = "^V",
						s = "S",
						S = "S_",
						["\19"] = "^S",
						i = "I",
						ic = "Ic",
						ix = "Ix",
						R = "R",
						Rc = "Rc",
						Rx = "Rx",
						Rv = "Rv",
						Rvc = "Rv",
						Rvx = "Rv",
						c = "C",
						cv = "Ex",
						r = "...",
						rm = "M",
						["r?"] = "?",
						["!"] = "!",
						t = "T",
					},
					mode_colors = {
						n = "red" ,
						i = "green",
						v = "cyan",
						V =  "cyan",
						["\22"] =  "cyan",
						c =  "orange",
						s =  "purple",
						S =  "purple",
						["\19"] =  "purple",
						R =  "orange",
						r =  "orange",
						["!"] =  "red",
						t =  "red",
					}
				},
				provider = function(self)
					return " 󰣇 %2("..self.mode_names[self.mode].."%) "
				end,
				hl = function(self)
					local mode = self.mode:sub(1, 1)
					return { fg = self.mode_colors[mode], bg = lightbg, bold = false, }
				end,
				update = {
					"ModeChanged",
					pattern = "*:*",
					callback = vim.schedule_wrap(function()
						vim.cmd("redrawstatus")
					end),
				}
			}
			local fileNameBlockBase = {
				init = function(self)
					self.filename = vim.api.nvim_buf_get_name(0)
				end,
			}
			local fileIcon = {
				init = function(self)
					local filename = vim.api.nvim_buf_get_name(0)
					local extension = vim.fn.fnamemodify(filename, ":e")
					self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
				end,
				provider = function(self)
					return self.icon and (self.icon .. " ")
				end,
				hl = function(self)
					return { fg = self.icon_color }
				end
			}
			local fileName = {
				init = function(self)
					self.lfilename = vim.fn.fnamemodify(self.filename, ":.")
					if self.lfilename == "" then self.lfilename = "[No Name]" end
				end,
				hl = { fg = gethi("Directory").fg, bold = true },

				flexible = 2,

				{
					provider = function(self)
						return self.lfilename
					end,
				},
				{
					provider = function(self)
						return vim.fn.pathshorten(self.lfilename)
					end,
				},
			}
			local fileFlags = {
				{
					condition = function()
						return vim.bo.modified
					end,
					provider = " ",
					hl = { fg = "green" }
				},
				{
					condition = function()
						return not vim.bo.modifiable or vim.bo.readonly
					end,
					provider = ' 󰌾',
					hl = { fg = 'green'}
				}
			}
			local fileNameBlock = utils.insert(
			fileNameBlockBase,
			fileIcon,
			utils.insert(fileName),
			fileFlags,
			{ provider = "%<" })
			local fileSize = {
				{
					provider = function()
						local suffix = { 'b', 'k', 'M', 'G', 'T', 'P', 'E' }
						local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
						fsize = (fsize < 0 and 0) or fsize
						if fsize < 1024 then
							return fsize..suffix[1]
						end
						local i = math.floor((math.log(fsize) / math.log(1024)))
						return string.format("%.2g%s", fsize / math.pow(1024, i), suffix[i + 1])
					end,
					hl = { fg = 'blue2' }
				}
			}
			local scrollBar = {
				static = {
					sbar = { '🭶', '🭷', '🭸', '🭹', '🭺', '🭻' }
				},
				provider = function(self)
					local curr_line = vim.api.nvim_win_get_cursor(0)[1]
					local lines = vim.api.nvim_buf_line_count(0)
					local i = math.floor((curr_line - 1) / lines * #self.sbar ) + 1
					return string.rep(self.sbar[i], 2)
				end,
				hl = { fg = "blue", bg = lightbg }
			}
			percent = {
				utils.insert(
				percent,
				space,
				scrollBar),
			}
			local navic = {
				condition = function() return require'nvim-navic'.is_available() end,
				{
					{
						provider = function()
							return require'nvim-navic'.get_location({
								highlight = true,
								click = true,
								lsp = { auto_attach = true },
							})
						end,
					},
				},
				{ provider = "" },
				flexible = 3
			}
			local diagnostics = {

				condition = conditions.has_diagnostics,

				static = {
					error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
					warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
					info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
					hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
				},

				init = function(self)
					self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
					self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
					self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
					self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
				end,

				update = { "DiagnosticChanged", "BufEnter" },

				{
					provider = function(self)
						return self.errors > 0 and (self.error_icon .. self.errors .. " ")
					end,
					hl = { fg = gethi("DiagnosticError").fg },
				},
				{
					provider = function(self)
						return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
					end,
					hl = { fg = gethi("DiagnosticWarn").fg },
				},
				{
					provider = function(self)
						return self.info > 0 and (self.info_icon .. self.info .. " ")
					end,
					hl = { fg = gethi("DiagnosticInfo").fg },
				},
				{
					provider = function(self)
						return self.hints > 0 and (self.hint_icon .. self.hints .. " ")
					end,
					hl = { fg = gethi('DiagnosticHint').fg },
				},
				{ provider = ' ', hl = { fg = 'dark3'} },
				on_click = {
					callback = function()
						require("trouble").toggle({ mode = "document_diagnostics" })
					end,
					name = 'heirline_diagnostics'
				}
			}
			local git = {
				condition = conditions.is_git_repo,

				init = function(self)
					self.status_dict = vim.b.gitsigns_status_dict
					self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
				end,

				hl = { fg = 'yellow', bg = "terminal_black" },

				{
					provider = "",
					hl = { fg = lightbg}
				},
				{
					provider = function(self)
						return "  " .. self.status_dict.head
					end,
					hl = { bold = true }
				},
				{
					condition = function(self)
						return self.has_changes
					end,
					provider = "("
				},
				{
					provider = function(self)
						local count = self.status_dict.added or 0
						return count > 0 and ("+" .. count)
					end,
					hl = { fg = gethi('GitSignsAdd').fg },
				},
				{
					provider = function(self)
						local count = self.status_dict.removed or 0
						return count > 0 and ("-" .. count)
					end,
					hl = { fg = gethi('GitSignsDelete').fg },
				},
				{
					provider = function(self)
						local count = self.status_dict.changed or 0
						return count > 0 and ("~" .. count)
					end,
					hl = { fg = gethi('GitSignsChange').fg },
				},
				{
					condition = function(self)
						return self.has_changes
					end,
					provider = ")",
				},
			}
			git = utils.surround(
			{'', ""},
			function()
				if not conditions.is_git_repo then
					return lightbg
				else
					return 'terminal_black'
				end
			end,
			{git})
			--[[
			local DAPMessages = {
				condition = function()
					local session = require("dap").session()
					return session ~= nil
				end,
					provider = function()
						return " " .. require("dap").status()
					end,
					hl = { fg = gethi("Debug").fg }
			}
			]]--
			local helpFileName = {
				condition = function()
					return vim.bo.filetype == "help"
				end,
				provider = function()
					local filename = vim.api.nvim_buf_get_name(0)
					return vim.fn.fnamemodify(filename, ":t")
				end,
				hl = { fg = colors.blue },
			}
			local terminalName = {
				{
					provider = function()
						local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
						return "  " .. tname .. " "
					end,
					hl = { fg = "blue", bg = lightbg, bold = true }
				}
			}
			local terminalStatus = utils.insert(
			{ provider = "", hl = { fg = lightbg }},
			terminalName
			)
			terminalStatus = utils.surround({'', ''}, util.lighten(colors.black, 0.8), { { condition = conditions.is_active, viMode }, terminalStatus })
			local fileType = {
				provider = function()
					return string.upper(vim.bo.filetype)
				end,
				hl = { fg = util.lighten(colors.green2, 0.7), bold = true },
			}
			local defaultStatusline = {
				viMode,
				git,
				space,
				fileNameBlock,
				seps[1],
				align,
				navic,
				align,
				seps[2],
				diagnostics,
				fileSize,
				space,
				ruler,
				percent,
			}
			local inactiveStatusline = {
				condition = conditions.is_not_active,
				fileType, space, fileNameBlock, align
			}
			local specialStatusline = {
				condition = function()
					return conditions.buffer_matches({
						buftype = { "nofile", "prompt", "help", "quickfix" },
						filetype = { "^git.*" } ,
					})
				end,

				fileType, space, helpFileName, align
			}
			local terminalStatusline = {

				condition = function()
					return conditions.buffer_matches({ buftype = { "terminal" } })
				end,

				terminalStatus, align
			}
			local statusLines = {
				hl = function()
					if conditions.is_active() then
						return "StatusLine"
					else
						return "StatusLineNC"
					end
				end,

				fallthrough = false,

				specialStatusline, terminalStatusline, inactiveStatusline, defaultStatusline,
			}

			-- Winbar
			local fileDir = {
				init = function(self)
					local filedir = vim.api.nvim_buf_get_name(0)
					self.filedir = vim.fn.fnamemodify(filedir, ":~:h")
					self.trail = self.filedir:sub(-1) == ' ' or ' '
					return self.filedir ..  self.trail .. " "
				end,
				flexible = 1,
				hl = { fg = 'dark3'},
				{
					provider = function(self)
 						self.filedir = vim.fn.fnamemodify(self.filedir, ":gs?/?  ?")
						return self.filedir .. self.trail .. " "
					end
				}
			}
			local fileNameBlockW = utils.insert(
			fileNameBlockBase,
			fileIcon,
			utils.insert(fileName),
			space,
			align)
			local winBars = {
				hl = { bg = lightbg },
				fallthrough = false,
				{
					condition = function()
						return conditions.buffer_matches({ buftype = { "terminal" } })
					end,
					terminalName, align
				},
				{
					space,
					fileDir,
					fileNameBlockW
				},
			}

			-- Bufferline
			local tablineBufnr = {
				provider = function(self)
					return tostring(self.bufnr) .. ". "
				end,
				hl = { italic = true },
			}

			local tablineFileName = {
				provider = function(self)
					local filename = self.filename
					filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
					return filename .. ""
				end,
				hl = function(self)
					if self.is_active then
						return { fg = 'purple', bold = true, italic = true }
					else
						return { fg = 'terminal_black', italic = true, bold = false }
					end
				end
			}

			local tablineFileFlags = {
				{
					condition = function(self)
						return vim.api.nvim_buf_get_option(self.bufnr, "modified")
					end,
					provider = "  ",
					hl = { fg = "green" },
				},
				{
					provider = function(self)
						if vim.api.nvim_buf_get_option(self.bufnr, "buftype") == "terminal" then
							return "  "
						end
					end,
					hl = { fg = "orange" },
				}
			}

			local tablineFileNameBlock = {
				init = function(self)
					self.filename = vim.api.nvim_buf_get_name(self.bufnr)
				end,
				on_click = {
					callback = function(_, minwid, _, button)
						if (button == "m") then
							vim.schedule(function()
								vim.api.nvim_buf_delete(minwid, { force = false })
							end)
						else
							vim.api.nvim_win_set_buf(0, minwid)
						end
					end,
					minwid = function(self)
						return self.bufnr
					end,
					name = "heirline_tabline_buffer_callback",
				},
				hl = function(self)
					if self.is_active then
						return { bg = lightbg }
					else
						return { bg = 'bg' }
					end
				end,
				tablineBufnr,
				fileIcon,
				tablineFileName,
				tablineFileFlags,
			}

			-- a nice "x" button to close the buffer
			local tablineCloseButton = {
				condition = function(self)
					return not vim.api.nvim_buf_get_option(self.bufnr, "modified")
				end,
				{ provider = " " },
				{
					provider = "",
					hl = { fg = 'terminal_black' },
					on_click = {
						callback = function(_, minwid)
							vim.schedule(function()
								vim.api.nvim_buf_delete(minwid, { force = false })
								vim.cmd.redrawtabline()
							end)
						end,
						minwid = function(self)
							return self.bufnr
						end,
						name = "heirline_tabline_close_buffer_callback",
					},
				},
			}

			local tablineBufferBlock = utils.surround(
			{ "", "" },
			function(self)
				if self.is_active then
					return lightbg
				else
					return 'bg'
				end
			end,
			{ tablineFileNameBlock, tablineCloseButton }
			)

			local get_bufs = function()
				return vim.tbl_filter(function(bufnr)
					return vim.api.nvim_buf_get_option(bufnr, "buflisted")
				end, vim.api.nvim_list_bufs())
			end

			local buflist_cache = {}

			-- setup an autocmd that updates the buflist_cache every time that buffers are added/removed
			vim.api.nvim_create_autocmd({ "VimEnter", "UIEnter", "BufAdd", "BufDelete" }, {
				callback = function()
					vim.schedule(function()
						local buffers = get_bufs()
						for i, v in ipairs(buffers) do
							buflist_cache[i] = v
						end
						for i = #buffers + 1, #buflist_cache do
							buflist_cache[i] = nil
						end

						-- check how many buffers we have and set showtabline accordingly
						if #buflist_cache > 1 then
							vim.o.showtabline = 2 -- always
						else
							vim.o.showtabline = 1 -- only when #tabpages > 1
						end
					end)
				end,
			})

			local bufferLine = utils.make_buflist(
			tablineBufferBlock,
			{ provider = " ", hl = { fg = "dark3" } },
			{ provider = " ", hl = { fg = "dark3" } },
			-- out buf_func simply returns the buflist_cache
			function()
				return buflist_cache
			end,
			-- no cache, as we're handling everything ourselves
			false
			)
			local tabpage = {
				provider = function(self)
					return "%" .. self.tabnr .. "T " .. self.tabpage .. " %T"
				end,
				hl = function(self)
					if not self.is_active then
						return { bg = lightbg, fg = 'terminal_black' }
					else
						return { bg = lightbg, fg = 'green' }
					end
				end,
			}

			local tabpageClose = {
				provider = "%999X  %X",
				hl = { fg = "dark3" },
			}
			local tabLineOffset = {
				condition = function(self)
					local win = vim.api.nvim_tabpage_list_wins(0)[1]
					local bufnr = vim.api.nvim_win_get_buf(win)
					self.winid = win

					if vim.bo[bufnr].filetype == "neo-tree" then
						self.title = "NeoTree"
						return true
					end
				end,

				provider = function(self)
					local title = self.title
					local width = vim.api.nvim_win_get_width(self.winid)
					local pad = math.ceil((width - #title) / 2)
					return string.rep(" ", pad) .. title .. string.rep(" ", pad)
				end,

				hl = function(self)
					if vim.api.nvim_get_current_win() == self.winid then
						return { bg = lightbg, fg = 'green' }
					else
						return { bg = lightbg, fg = 'terminal_black' }
					end
				end,
			}

			local tabPages = {
				-- only show this component if there's 2 or more tabpages
				condition = function()
					return #vim.api.nvim_list_tabpages() >= 2
				end,
				{ provider = "%=" },
				utils.make_tablist(tabpage),
				tabpageClose,
			}
			local tabLine = {
				tabLineOffset,
				bufferLine,
				{
					condition = function()
					return #vim.api.nvim_list_tabpages() < 2
					end,
					align
				},
				tabPages
			}
			-- Setup
			require'heirline'.setup({
				statusline = statusLines,
				winbar = winBars,
				tabline = tabLine,
				opts = {
					colors = colors,
					disable_winbar_cb = function(args)
						return conditions.buffer_matches({
							buftype = { "nofile", "prompt", "help", "quickfix" },
							filetype = { "^git.*", "fugitive", "Trouble", "dashboard", 'noice', 'notify', 'OverseerForm' },
						}, args.buf)
					end
				}
			})
			vim.o.showtabline = 2
			vim.cmd([[au fileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])
		end
	}
}

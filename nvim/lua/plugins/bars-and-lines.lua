-- We use exclusively Heirline as statusline, bufferline, and winbar, because it's a fast and powerful tool that can manage all of them.
-- Everything is stolen (then sometimes slightly modified) from heirline.nvim/cookbook.md. Thanks rebelot for these snippets in addition to this aweomse plugin!!!

return {
	{
		-- A no-nonsense Neovim Statusline plugin designed around recursive inheritance to be exceptionally fast and versatile.
		"rebelot/heirline.nvim",
		event = "UiEnter",
		dependencies = { "nvim-tree/nvim-web-devicons", "lewis6991/gitsigns.nvim" },
		config = function()
			-- Defining aliases for modules we will use a lot
			local conditions = require("heirline.conditions")
			local utils = require("heirline.utils")
			local colorUtils = require("tokyonight.util")
			-- Setting up color aliases for tokyonight colorscheme
			local colors = require("tokyonight.colors").setup()
			require("heirline").load_colors(colors)
			-- Aliases for providers we'll use a lot
			local space = { provider = " " }
			local currentBufBigger = {
				condition = function(self)
					return self.is_active
				end,
				provider = "  ",
			}
			local align = { provider = "%=" } -- Relies on vim statusline syntax. See :h 'statusline'
			local rightArrow = { provider = " " }
			local leftArrow = { provider = " " }
			local separator = { provider = " | ", hl = { fg = "dark3" } }

			-- ====== Statusline ======
			-- Shows the current mode, with dynamic colors
			local viMode = {
				-- get vim current mode, this information will be required by the provider
				-- and the highlight functions, so we compute it only once per component
				-- evaluation and store it as a component attribute
				init = function(self)
					self.mode = vim.fn.mode(1) -- :h mode()
					self.mode = self.mode:sub(1, 1) -- get only the first mode character
					self.color = self.mode_colors[self.mode]
				end,

				-- Re-evaluate the component only on ModeChanged event!
				-- Also allows the statusline to be re-evaluated when entering operator-pending mode
				update = {
					"ModeChanged",
					pattern = "*:*",
					callback = vim.schedule_wrap(function()
						vim.cmd("redrawstatus")
					end),
				},

				-- Now we define some dictionaries to map the output of mode() to the
				-- corresponding string and color. We can put these into `static` to compute
				-- them at initialisation time.
				static = {
					mode_names = { -- change the strings if you like it vvvvverbose!
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
						-- Made for Tokyonight storm
						n = "red1",
						i = "purple",
						v = "blue2",
						V = "blue2",
						["\22"] = "blue2",
						c = "yellow",
						s = "green",
						S = "green",
						["\19"] = "green",
						R = "yellow",
						r = "yellow",
						["!"] = "red1",
						t = "green",
					},
				},
				-- We can now access the value of mode() that, by now, would have been
				-- computed by `init()` and use it to index our strings dictionary.
				-- note how `static` fields become just regular attributes once the
				-- component is instantiated.
				-- To be extra meticulous, we can also add some vim statusline syntax to
				-- control the padding and make sure our string is always at least 2
				-- characters long. Plus a nice Icon.
				{
					provider = function(self)
						return "  %2(" .. self.mode_names[self.mode] .. "%) "
					end,
					-- Same goes for the highlight. Now the foreground and the background will change according to the current mode.
					hl = function(self)
						return {
							fg = self.color,
							bg = colorUtils.darken(colors[self.color], 0.15),
							bold = true,
						}
					end,
				},
				{
					-- Works as separator between this and next component
					rightArrow,
					hl = function(self)
						return {
							fg = colorUtils.darken(colors[self.color], 0.15),
							bg = "bg_highlight",
						}
					end,
				},
			}

			-- Computes file size, in human readable format
			local fileSize = {
				{
					provider = function()
						-- stackoverflow, compute human readable file size
						local suffix = { "b", "k", "M", "G", "T", "P", "E" }
						local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
						fsize = (fsize < 0 and 0) or fsize
						if fsize < 1024 then
							return fsize .. suffix[1] .. " "
						end
						local i = math.floor((math.log(fsize) / math.log(1024)))
						return string.format("%.2g%s ", fsize / math.pow(1024, i), suffix[i + 1])
					end,
					hl = { bg = "bg_highlight", fg = colorUtils.lighten(colors.yellow, 0.8) },
				},
				{
					rightArrow,
					hl = { fg = "bg_highlight", bg = "bg_dark" },
				},
			}
			-- Making fileSize flexible
			-- local flexibleFileSize = { flexible = 5, { fileSize }, { provider = "" } }

			-- Slightly different fileSize component for the inactive buffer bar
			local inactiveFileSize = utils.insert({
				{
					space,
					hl = { bg = "bg_highlight" },
				},
				fileSize,
			})

			-- Shows the filename with an icon
			local fileNameBlock = {
				-- let's first set up some attributes needed by this component and its children
				init = function(self)
					self.filename = vim.api.nvim_buf_get_name(0)
				end,
			}
			-- We can now define some children separately and add them later

			local fileIcon = {
				init = function(self)
					local filename = vim.api.nvim_buf_get_name(0)
					local extension = vim.fn.fnamemodify(filename, ":e")
					self.icon, self.icon_color =
						require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
				end,
				provider = function(self)
					return self.icon and (self.icon .. " ")
				end,
				hl = function(self)
					return { fg = self.icon_color }
				end,
			}
			local fileName = {
				init = function(self)
					self.vanillaPath = vim.api.nvim_buf_get_name(0)
				end,
				provider = function(self)
					-- first, trim the pattern relative to the current directory. For other
					-- options, see :h filename-modifers
					local filename = vim.fn.fnamemodify(self.vanillaPath, ":t")
					if filename == "" then
						return "[No Name] "
					end
					-- now, if the filename would occupy more than 1/4th of the available
					-- space, we trim the file path to its initials
					-- See Flexible Components section below for dynamic truncation
					return filename .. " "
				end,
				hl = { fg = "blue" },
			}
			local fileFlags = {
				{
					condition = function()
						return vim.bo.modified
					end,
					provider = "󰐗 ",
					hl = { fg = "green" },
				},
				{
					condition = function()
						return not vim.bo.modifiable or vim.bo.readonly
					end,
					provider = " ",
					hl = { fg = "orange" },
				},
			}
			-- let's add the children to our fileNameBlock component
			fileNameBlock = utils.insert(
				fileNameBlock,
				fileIcon,
				fileName,
				fileFlags,
				-- Separator with the next component
				{
					condition = conditions.is_git_repo,
					rightArrow,
					hl = { fg = "bg_dark", bg = "bg_highlight" },
				},
				-- Alternative separator if not in a Git repo
				{
					condition = function()
						return not conditions.is_git_repo()
					end,
					provider = " ",
					hl = { fg = "dark3" },
				},
				{ provider = "%<" } -- this means that the statusline is cut here when there's not enough space
			)

			-- Git integration
			local git = {
				condition = conditions.is_git_repo,

				init = function(self)
					self.status_dict = vim.b.gitsigns_status_dict
					self.has_changes = self.status_dict.added ~= 0
						or self.status_dict.removed ~= 0
						or self.status_dict.changed ~= 0
				end,

				hl = { fg = "yellow", bg = "bg_highlight" },

				update = {
					"User",
					pattern = "GitSignsUpdate",
					callback = vim.schedule_wrap(function()
						vim.cmd("redrawstatus")
					end),
				},

				{ -- git branch name
					provider = function(self)
						return " " .. self.status_dict.head
					end,
				},
				-- You could handle delimiters, icons and counts similar to Diagnostics
				{ provider = "(" },
				{
					provider = function(self)
						local count = self.status_dict.added or 0
						return count > 0 and ("+" .. count)
					end,
					hl = { fg = colors.git.add },
				},
				{
					provider = function(self)
						local count = self.status_dict.removed or 0
						return count > 0 and ("-" .. count)
					end,
					hl = { fg = colors.git.delete },
				},
				{
					provider = function(self)
						local count = self.status_dict.changed or 0
						return count > 0 and ("~" .. count)
					end,
					hl = { fg = colors.git.change },
				},
				{ provider = ") " },
				{
					rightArrow,
					hl = { fg = "bg_highlight", bg = "bg_dark" },
				},
			}
			--git = { flexible = 4, git, { provider = "" } }

			-- Shows LSP servers in use
			local LSPActive = {
				condition = conditions.lsp_attached,
				update = { "LspAttach", "LspDetach" },
				on_click = {
					callback = function()
						vim.defer_fn(function()
							vim.cmd("LspInfo")
						end, 100)
					end,
					name = "heirline_LSP",
				},
				{
					provider = function()
						local names = {}
						for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
							table.insert(names, server.name)
						end
						return "   " .. table.concat(names, " ")
					end,
					hl = { fg = "green1" },
				},
				separator,
			}
			--LSPActive = { flexible = 2, LSPActive, {provider = ""} }

			-- Prints DAP Messages
			local DAPMessages = {
				condition = function()
					local session = require("dap").session()
					return session ~= nil
				end,
				provider = function()
					return " " .. require("dap").status()
				end,
				hl = "Debug",
			}
			--DAPMessages = { flexible = 1, DAPMessages, { provider = ""} }

			-- Shows filetype
			local fileType = {
				provider = function()
					if vim.bo.filetype == "" then
						return "[None]"
					else
						return string.upper(vim.bo.filetype)
					end
				end,
				hl = { fg = utils.get_highlight("Type").fg },
			}
			--fileType = { flexible = 3, fileType, { provider = ""} }
			-- Filetype with an icon, and a separator on the left or the right, depending if window is active or not
			local iconFileType = {
				{
					condition = conditions.is_active,
					separator,
				},
				{
					provider = " ",
					hl = { fg = "magenta" },
				},
				fileType,
				{
					condition = conditions.is_not_active,
					separator,
				},
			}
			--fileIcon = { flexible = 3, fileIcon, { provider = ""} }

			-- Shows LSP Diagnostics
			local diagnostics = {

				condition = conditions.has_diagnostics,

				static = {
					error_icon = " ",
					warn_icon = " ",
					hint_icon = "󰌵 ",
					info_icon = " ",
				},

				init = function(self)
					self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
					self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
					self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
					self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
				end,

				update = {
					"DiagnosticChanged",
					callback = vim.schedule_wrap(function()
						vim.cmd("redrawstatus")
						vim.cmd("redrawtabline")
					end),
				},

				on_click = {
					callback = function()
						require("trouble").toggle({ mode = "document_diagnostics" })
					end,
					name = "heirline_diagnostics",
				},
				separator,
				{
					provider = function(self)
						-- 0 is just another output, we can decide to print it or not!
						return self.errors > 0 and (self.error_icon .. self.errors .. " ")
					end,
					hl = "DiagnosticError",
				},
				{
					provider = function(self)
						return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
					end,
					hl = "DiagnosticWarn",
				},
				{
					provider = function(self)
						return self.info > 0 and (self.info_icon .. self.info .. " ")
					end,
					hl = "DiagnosticInfo",
				},
				{
					provider = function(self)
						return self.hints > 0 and (self.hint_icon .. self.hints)
					end,
					hl = "DiagnosticHint",
				},
			}

			-- If recording a macro, displays it with the letter of the macro
			local macroRec = {
				hl = { fg = "purple", bg = colorUtils.darken(colors.purple, 0.15) },
				{
					leftArrow,
					hl = { fg = colorUtils.darken(colors.purple, 0.15), bg = "bg_dark" },
				},
				{
					provider = "  ",
				},
				{
					provider = function()
						return vim.fn.reg_recording()
					end,
				},
				update = {
					"RecordingEnter",
					"RecordingLeave",
				},
			}

			-- Show what you're currently typing (useful since we have no cmdheight)
			local showCmd = {
				{
					leftArrow,
					hl = { fg = "bg_dark", bg = colorUtils.darken(colors.purple, 0.15) },
				},
				{
					provider = " :%3.5(%S%) ",
					hl = { fg = "purple" },
				},
				{
					leftArrow,
					hl = { fg = colorUtils.darken(colors.green, 0.15) },
				},
			}

			-- Ruler
			local ruler = {
				-- %l = current line number
				-- %L = number of lines in the buffer
				-- %c = column number
				-- %P = percentage through file of displayed window
				{
					provider = " %l/%L%):%2c ",
					hl = { fg = "green", bg = colorUtils.darken(colors.green, 0.15) },
				},
			}

			-- Scrollbar
			local scrollBar = {
				{
					provider = "%4P ",
					hl = { fg = "green" },
				},
				{
					static = {
						sbar = { "🭶", "🭷", "🭸", "🭹", "🭺", "🭻" },
					},
					provider = function(self)
						local curr_line = vim.api.nvim_win_get_cursor(0)[1]
						local lines = vim.api.nvim_buf_line_count(0)
						local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
						return string.rep(self.sbar[i], 2)
					end,
					hl = { fg = "green", bg = colorUtils.lighten(colors.bg, 0.95) },
				},
			}

			-- Adding a delimiter with the ruler for usage in the active buffer bar. In the inactive buffer bar there is no ruler, so no need for a separator
			local activeScrollBar = utils.insert({
				{
					leftArrow,
					hl = { fg = "bg_dark", bg = colorUtils.darken(colors.green, 0.15) },
				},
				scrollBar,
			})

			-- Displays the name of the opened terminal buffer
			local terminalName = {
				{
					provider = function()
						local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
						return " " .. tname
					end,
					hl = { fg = "purple", bold = true },
				},
			}

			-- Default statusline for active buffer
			local activeStatusline = {
				{
					viMode,
					fileSize,
					fileNameBlock,
					git,
					LSPActive,
					align,
					DAPMessages,
					align,
					iconFileType,
					diagnostics,
					macroRec,
					showCmd,
					ruler,
					activeScrollBar,
				},
			}

			-- Statusline for inactive buffers
			local inactiveStatusline = {
				-- Use this statusline only if the buffer is not active
				condition = conditions.is_not_active,
				{
					inactiveFileSize,
					fileNameBlock,
					align,
					iconFileType,
					scrollBar,
				},
			}

			-- Statusline for special buffers
			local specialStatusline = {
				condition = function()
					return conditions.buffer_matches({
						-- Buffer types where this statusline will be applied
						buftype = { "nofile", "prompt", "help", "quickfix" },
						-- Fileypes where this statusline will be applied
						filetype = { "^git.*" },
					})
				end,
				{
					space,
					fileType,
					space,
					fileName,
					align,
					scrollBar,
				},
			}

			-- Statusline for terminal buffers
			local terminalStatusline = {
				condition = function()
					return conditions.buffer_matches({ buftype = { "terminal" } })
				end,
				hl = { bg = "bg_highlight" },
				{ condition = conditions.is_active, viMode },
				terminalName,
				align,
			}

			-- This element will allow us to easily display the right statusline for each buffer
			local statusLines = {
				hl = function()
					if conditions.is_active() then
						return "StatusLine"
					else
						return "StatusLineNC"
					end
				end,

				-- the first statusline with no condition, or which condition returns true is used.
				-- think of it as a switch case with breaks to stop fallthrough.
				fallthrough = false,

				specialStatusline,
				terminalStatusline,
				inactiveStatusline,
				activeStatusline,
			}

			-- ====== Bufferline ======
			-- akinsho/bufferline.nvim-like bufferline, because I just love the design

			-- Will appear at the beginning of each buffer
			local bufferPrefix = {
				provider = "▌",
				hl = function(self)
					if self.is_active then
						return { fg = "blue1", bg = "black" }
					else
						return { fg = "dark3" }
					end
				end,
			}

			-- Alternative design:
			--local bufferPrefix = {
			--	provider = "▌",
			--	condition = function(self) return self.is_active end,
			--	hl = { fg = "blue1", bg = "black" }
			--}
			--local bufferSuffix = {
			--	provider = "▐",
			--	condition = function(self) return self.is_active end,
			--	hl = { fg = "dark3" }
			--}

			-- Fetch the buffer number, add ". " at the end of it
			local tablineBufnr = {
				provider = function(self)
					return tostring(self.bufnr) .. ". "
				end,
				hl = "Comment",
			}

			-- Shows the filename of the file associated to the buffer
			local tablineFileName = {
				provider = function(self)
					-- self.filename will be defined later, just keep looking at the example!
					local filename = self.filename
					filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
					return filename
				end,
				update = { "DiagnosticChanged", "BufEnter" },
				hl = function(self)
					local highlight = { fg = "dark3", italic = true } -- Default color is the inactive buffer color
					-- We set colors according to diagnostics
					if self.is_active or self.is_visible then
						highlight.fg = colorUtils.lighten(colors.blue1, 0.7)
					end
					if conditions.has_diagnostics() and self.bufnr == vim.fn.bufnr() then
						if #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR }) > 0 then
							highlight.fg = "red1"
						elseif #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN }) > 0 then
							highlight.fg = "yellow"
						end
					end
					return highlight
				end,
			}

			-- this looks exactly like the FileFlags component that we saw in
			-- #crash-course-part-ii-filename-and-friends, but we are indexing the bufnr explicitly
			-- also, we are adding a nice icon for terminal buffers.
			local tablineFileFlags = {
				{
					condition = function(self)
						return vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
					end,
					provider = "",
					hl = { fg = "green" },
				},
				{
					condition = function(self)
						return not vim.api.nvim_get_option_value("modifiable", { buf = self.bufnr })
							or vim.api.nvim_get_option_value("readonly", { buf = self.bufnr })
					end,
					provider = function(self)
						if vim.api.nvim_get_option_value("buftype", { buf = self.bufnr }) == "terminal" then
							return "  "
						else
							return ""
						end
					end,
					hl = { fg = "orange" },
				},
			}

			-- Here the filename block finally comes together
			local tablineFileNameBlock = {
				init = function(self)
					self.filename = vim.api.nvim_buf_get_name(self.bufnr)
				end,
				hl = function(self)
					if self.is_active then
						return { bg = "black" }
						-- why not?
						-- elseif not vim.api.nvim_buf_is_loaded(self.bufnr) then
						--     return { fg = "gray" }
					end
				end,
				on_click = {
					callback = function(_, minwid, _, button)
						if button == "m" then -- close on mouse middle click
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
				bufferPrefix,
				-- Make the tab corresponding to the active buffer bigger
				currentBufBigger,
				space,
				tablineBufnr,
				fileIcon, -- turns out the version defined in #crash-course-part-ii-filename-and-friends can be reutilized as is here!
				tablineFileName,
				space,
				tablineFileFlags,
				-- We print a space after the filename to make it look better, but only if there is no file flags
				-- If there is already file flags, no need for a space, it's already looking good, and so adding a space would make it look worse
				{
					condition = function(self)
						return (tablineFileFlags == "" or not self.is_active)
					end,
					space,
				},
				-- Make the tab corresponding to the active buffer bigger
				currentBufBigger,
				-- bufferSuffix -- Uncomment this if you use the alternative design that makes uses of bufferSuffix
			}

			-- and here we go
			local BufferLine = utils.make_buflist(
				{ tablineFileNameBlock, hl = { bg = "bg" } },
				{ provider = "", hl = { fg = "gray" } }, -- left truncation, optional (defaults to "<")
				{ provider = "", hl = { fg = "gray" } } -- right truncation, also optional (defaults to ...... yep, ">")
			-- by the way, open a lot of buffers and try clicking them ;)
			)
			-- Yep, with heirline we're driving manual!
			vim.o.showtabline = 2
			vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])

			-- ====== Winbar ======
			-- Generates the clickable filePath that we us in the winbar
			local function filePath()
				-- Separator between directories (looks better than a "/"!)
				local dirSep = { provider = "  ", hl = { fg = "dark3" } }

				local vanillaPath = vim.api.nvim_buf_get_name(0) -- fetching complete file path
				-- Reduce file path to home dir if possible; and remove the last elements (in other words, the actual filename)
				-- -> We remove the filename because it must not be a clickable element
				local shortPath = vim.fn.fnamemodify(vanillaPath, ":~:h")

				-- Creating a list of each element of the path (removing the "/")
				local pathElements = {}
				for part in string.gmatch(shortPath, "[^/]+") do
					table.insert(pathElements, part)
				end

				-- Modifying pathElements so it nows contains an association between each element and it's real path on the disk
				-- Will allow us that, on click on the element, to open the folder we clicked on, instead of being just a dumb string.
				-- New format: Now each element is a table in this format: { "shortString", "fullPath" }
				pathElements[1] = { pathElements[1], pathElements[1] } -- Root doesn't need to be modified
				if #pathElements > 1 then
					for i = 2, #pathElements do
						-- Our current element path is the previous element path + our element name
						local elementCurrentPath = pathElements[i - 1][2] .. "/" .. pathElements[i]
						pathElements[i] = { pathElements[i], elementCurrentPath }
					end
				end

				-- Our output will be a table containing, for each element, it's shortString as provider and, as "on_click" function, it will
				-- open the directory in the wanted nvim file manager (I personally like oil.nvim so that's why I use it here)
				local finalTable = {}
				for i, j in ipairs(pathElements) do
					table.insert(finalTable, {
						hl = { fg = "green1" },
						provider = j[1],
						on_click = {
							callback = function()
								require("oil").open(j[2])
								print("Opening dir: " .. j[2])
							end,
							name = "heirline_oil" .. i, -- We use the index of each dorectory to have different names for each
							update = true,
						},
					})
					table.insert(finalTable, dirSep)
				end
				return finalTable
			end

			-- Statusline for normal buffers (in other terms, regular files)
			local defaultWinbar = {
				space,
				filePath(),
				fileIcon,
				fileName,
				align,
			}
			local winbar = {
				update = "BufEnter",
				hl = { bg = "black" },
				fallthrough = false,
				defaultWinbar,
			}

			require("heirline").setup({
				statusline = statusLines,
				tabline = BufferLine,
				winbar = winbar,
				opts = {
					disable_winbar_cb = function(args)
						return conditions.buffer_matches({
							buftype = { "nofile", "prompt", "help", "quickfix", "terminal" },
							filetype = { "^git.*", "fugitive", "Trouble", "dashboard", "oil" },
						}, args.buf)
					end,
				},
			})
		end,
	},
}

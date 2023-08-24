-- Written from scratch by likalium :)

local present,alpha=pcall(require,"alpha")
if not present then
	return
end
local if_nil=vim.F.if_nil

local header={
	type="text",
	val={
		[[                              ▓▓            ░░    ▒▒░░░░  ]], 
		[[                            ░░▓▓            ░░░░  ░░      ]],        
		[[                            ░░▓▓      ░░░░░░  ░░░░▒▒░░▒▒  ]],        
		[[                            ░░▓▓          ░░  ▒▒  ░░▒▒▒▒  ]],        
		[[          ▓▓▓▓            ░░░░▓▓  ░░  ░░░░░░░░░░▒▒░░      ]],        
		[[            ▓▓██▓▓        ░░░░░░    ░░    ░░  ▒▒░░▒▒      ]],        
		[[              ▓▓██▓▓      ░░░░░░░░░░░░░░░░▒▒▒▒░░▒▒        ]],        
		[[              ▓▓██▓▓▓▓  ░░░░░░  ░░  ░░    ▒▒░░▒▒▒▒        ]],        
		[[                ██▓▓▓▓  ░░▒▒  ░░░░▒▒░░▒▒▒▒░░▒▒▒▒          ]],        
		[[                ▓▓██▓▓▓▓░░  ░░░░▒▒░░▒▒    ▒▒░░▒▒          ]],        
		[[                ▓▓██▓▓▓▓  ░░░░  ░░▒▒▒▒▒▒▒▒░░▒▒            ]],        
		[[                  ▓▓▓▓▓▓▒▒  ▒▒▒▒▒▒  ▒▒▒▒▒▒▒▒▒▒            ]],        
		[[                  ▓▓▓▓▓▓░░  ▒▒░░▒▒  ▒▒▒▒▒▒▒▒▒▒            ]],        
		[[                  ▓▓▓▓▓▓  ▒▒▒▒  ▒▒░░▒▒░░░░▒▒              ]],        
		[[                ▓▓██▓▓░░▒▒░░▒▒▒▒▒▒▒▒░░▒▒▒▒██████▓▓        ]],        
		[[                ▓▓██▓▓░░▒▒▒▒░░▒▒░░▒▒▒▒▒▒▒▒██▓▓▓▓▓▓▓▓▓▓▓▓  ]],        
		[[                ▓▓██▓▓░░▒▒▒▒▒▒▒▒▒▒░░▒▒████▓▓████▓▓▓▓▓▓▓▓▓▓]],        
		[[                ▓▓██▓▓████▒▒▒▒░░▒▒▒▒████████▓▓▓▓        ▓▓]],        
		[[                ▓▓██▓▓████▒▒▒▒▒▒▒▒████▓▓▓▓                ]],        
		[[                  ▓▓██▓▓██▒▒▒▒▒▒████                      ]],        
		[[                  ▓▓██▓▓██▒▒████                          ]],        
		[[                    ▓▓██▓▓██				     ]],
		[[                     OMG IT'S KORN!!!		     ]],
	},
	opts={
		position="center",
		hl="AlphaAscii"
	},
}

local function button(sc,desc,keybind)
	local sc_=sc:gsub("%s",""):gsub("SPC", "<leader")
	local opts={
		position="center",
		shortcut=sc,
		align_shortcut="right",
		width=50,
		text=desc,
		hl_shortcut="Number",
		hl="Function"
	}
	if keybind then
		opts.keymap={"n",sc_,keybind,keybind_opts,{noremap=true,silent=true,nowait=true}}
	end
	return {
		type="button",
		val=desc,
		on_press=function()
			local key=vim.api.nvim_replace_termcodes(sc_,true,false,true)
			vim.api.nvim_feedkeys(key,'t',false)
		end,
		opts=opts,
	}
end
local buttons={
	type="group",
	val={
		button('n','󰻭 Create new file','<cmd>ene<CR>'),
		button('s','󰱽 Search of existing file','<cmd>Telescope find_files<CR>'),
		button('r',' Recently opened files','<cmd>Telescope oldfiles<CR>'),
		button('s',' Reopen last session','<cmd>SessionManager load_last_session<CR>'),
		button('c',' Edit config','<cmd>e ~/.config/nvim<CR>'),
		button('u','󰗼 Exit,','<cmd>qa!<CR>'),
	},
	opts={spacing=1},
}
local section={
	 header=header,
	 buttons=buttons,
	 footer="Made with  by likalium"
 }
 local opts={
	 layout={
		 section.header,
		 section.buttons,
		 section.footer
	 },
 }
 alpha.setup(opts)

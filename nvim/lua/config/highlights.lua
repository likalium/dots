-- Custom highlights

-- Customization of lspkind items in nvim-cmp popup
vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#282C34", fg = "#1ABC9C" })
vim.api.nvim_set_hl(0, "Pmenu", { fg = "#C5CDD9", bg = "#22252A" })

vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#FF007C", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#FF007C", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#C792EA", bg = "NONE", italic = true })

vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#73DACA", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#73DACA", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = "#73DACA", bg = "NONE" })

vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#F7768E", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#F7768E", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#F7768E", bg = "NONE" })

vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#E0AF68", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = "#E0AF68", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = "#E0AF68", bg = "NONE" })

vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#BB9AF7", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = "#BB9AF7", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#BB9AF7", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#BB9AF7", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#BB9AF7", bg = "NONE" })

vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#1ABC9C", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "#1ABC9C", bg = "NONE" })

vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#9D7CD8", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#9D7CD8", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = "#9D7CD8", bg = "NONE" })

vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#7DCFFF", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = "#7DCFFF", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = "#7DCFFF", bg = "NONE" })

vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#3D59A1", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = "#3D59A1", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#3D5EA1", bg = "NONE" })


-- Changing the background color of the tabline to the bg color
vim.api.nvim_set_hl(0, "TabLineFill", { bg = "bg" })

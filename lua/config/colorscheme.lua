local present, tokyonight = pcall(require, "tokyonight")
if not present then
	return
end

local colors = require("tokyonight.colors").setup({ style = "day" }) -- pass in any of the colors.fg explained above

-- ╭──────────────────────────────────────────────────────────╮
-- │ Setup Colorscheme                                        │
-- ╰──────────────────────────────────────────────────────────╯
tokyonight.setup({
	style = "night", -- The theme comes in three styles, `storm`, a darker variant `night` and
	styles = {
		-- Style to be applied to different syntax groups
		-- Value is any valid attr-list value for `:help nvim_set_hl`
		comments = { italic = true },
		keywords = { italic = true },
		conditionals = { italic = true },
		functions = {},
		variables = {},
		-- Background styles. Can be "dark", "transparent" or "normal"
		sidebars = "dark", -- style for sidebars, see below
		floats = "dark", -- style for floating windows
	},
	on_highlights = function(H, C)
		-- Native
		H["@keyword.import"] = { fg = C.purple, italic = true }
		H["@tag.tsx"] = { fg = C.blue2 }
		H["@tag.builtin.tsx"] = { fg = C.red }

		-- Tokyonight
		H.CursorLine = { bg = "NONE" }
		H.LspInlayHint = { bg = "NONE", fg = C.comment }
		H.TelescopeResultsComment = { fg = C.comment }
		H.GitSignsCurrentLineBlame = { fg = C.comment }
		H.DiagnosticVirtualTextError = { bg = "NONE", fg = C.red }
		H.DiagnosticVirtualTextHint = { bg = "NONE", fg = C.teal }
		H.DiagnosticVirtualTextInfo = { bg = "NONE", fg = C.green }
		H.DiagnosticVirtualTextWarn = { bg = "NONE", fg = C.yellow }
		H.WinSeparator = { fg = C.fg, bg = "NONE" }
		H.TroubleNormal = { bg = "NONE", fg = C.fg }
	end,
})

-- Set Colorscheme
vim.cmd("colorscheme " .. HackVim.colorscheme)

-- Hackvim Colors
vim.api.nvim_set_hl(0, "HackvimPrimary", { fg = colors.purple })
vim.api.nvim_set_hl(0, "HackvimSecondary", { fg = colors.yellow })

vim.api.nvim_set_hl(0, "HackvimPrimaryBold", { bold = true, fg = colors.purple })
vim.api.nvim_set_hl(0, "HackvimSecondaryBold", { bold = true, fg = colors.yellow })

vim.api.nvim_set_hl(0, "HackvimHeader", { bold = true, fg = colors.blue })
vim.api.nvim_set_hl(0, "HackvimHeaderInfo", { bold = true, fg = colors.blue })
vim.api.nvim_set_hl(0, "HackvimFooter", { bold = true, fg = colors.fg_gutter })
vim.api.nvim_set_hl(0, "HackvimHeader", { bold = true, fg = colors.fg })
vim.api.nvim_set_hl(0, "HackvimNvimTreeTitle", { bold = true, fg = colors.fg, bg = colors.bg })

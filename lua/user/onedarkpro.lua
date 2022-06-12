vim.o.background = "dark"
local onedarkpro = require("onedarkpro")
onedarkpro.setup({
	theme = "onedark_vivid",
	hlgroups = {
		CursorLineNr = { fg = "${fg}" },
		DiagnosticUnderlineError = { fg = "NONE" },
		DiagnosticUnderlineHint = { fg = "NONE" },
		DiagnosticUnderlineInfo = { fg = "NONE" },
		DiagnosticUnderlineWarn = { fg = "NONE" },
		IndentBlanklineContextChar = { fg = "${fg}" },
		LineNr = { bg = "NONE" },
		ModeMsg = { bg = "${bg_dark}" },
		NeoTreeDirectoryIcon = { fg = "${fg}" },
		NeoTreeNormalNC = { bg = "${bg_dark}" },
		NormalNC = { bg = "${bg_dark}" },
		SignColumn = { bg = "NONE" },
		TabLine = { bg = "${bg_dark}", fg = "gray" },
		TabLineFill = { bg = "${bg_dark}" },
		TabLineSel = { bg = "${bg}", fg = "${fg}" },
		TermCursor = { bg = "${fg}", fg = "${bg}" },
		TermCursorNC = { bg = "NONE" },
		WhichKeyFloat = { bg = "${bg_dark}" },
		WinBarNC = { bg = "${bg_dark}" },
		WinSeparator = { bg = "${bg_dark}" },
		UltestSummaryInfo = { fg = "${purple}", style = "bold" },
	},
	styles = {
		comments = "italic",
		functions = "NONE",
		keywords = "bold,italic",
		strings = "NONE",
		variables = "NONE",
		virtual_text = "NONE",
	},
	options = {
		bold = true, -- Use the themes opinionated bold styles?
		italic = true, -- Use the themes opinionated italic styles?
		underline = false, -- Use the themes opinionated underline styles?
		undercurl = false, -- Use the themes opinionated undercurl styles?
		cursorline = true, -- Use cursorline highlighting?
		transparency = true, -- Use a transparent background?
		terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
		window_unfocussed_color = true, -- When the window is out of focus, change the normal background?
	},
})
onedarkpro.load()

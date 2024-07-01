local present, catppuccin = pcall(require, "catppuccin")
if not present then
	return
end

local mocha = require("catppuccin.palettes").get_palette("mocha")

-- ╭──────────────────────────────────────────────────────────╮
-- │ Setup Colorscheme                                        │
-- ╰──────────────────────────────────────────────────────────╯
catppuccin.setup({
	--   -- Replace this with your scheme-specific settings or remove to use the defaults
	-- transparent = true,
	flavour = "mocha", -- "latte, frappe, macchiato, mocha"
	no_bold = true, --No Bold
	styles = { -- Haes the styles of general hi groups (see `:h highlight-args`):
		comments = { "italic" }, -- Change the style of comments
		conditionals = { "italic" },
		loops = {},
		functions = {},
		keywords = { "italic" },
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
		-- miscs = {}, -- Uncomment to turn off hard-coded styles
	},
	-- Integrations
	integrations = {
		aerial = true,
		alpha = true,
		cmp = true,
		dashboard = true,
		flash = true,
		gitsigns = true,
		headlines = true,
		illuminate = true,
		indent_blankline = { enabled = true },
		leap = true,
		lsp_trouble = true,
		mason = true,
		markdown = true,
		mini = true,
		native_lsp = {
			inlay_hints = {
				background = false,
			},
		},
		navic = { enabled = true, custom_bg = "lualine" },
		neotest = true,
		neotree = true,
		noice = true,
		notify = true,
		semantic_tokens = true,
		telescope = true,
		treesitter = true,
		treesitter_context = true,
		which_key = true,
	},

	custom_highlights = function(colors)
		return {
			TelescopeResultsComment = { fg = colors.overlay0 },
			GitSignsCurrentLineBlame = { fg = colors.overlay0 },
			DiagnosticVirtualTextError = { bg = colors.none },
			DiagnosticVirtualTextHint = { bg = colors.none },
			DiagnosticVirtualTextInfo = { bg = colors.none },
			DiagnosticVirtualTextWarn = { bg = colors.none },
			TelescopePromptBorder = { fg = colors.text, bg = colors.none },
			TelescopeResultsBorder = { fg = colors.text, bg = colors.none },
			TelescopePreviewBorder = { fg = colors.text, bg = colors.none },
			NormalFloat = { bg = colors.none },
			FloatBorder = { fg = colors.text, bg = colors.none },
			Pmenu = { bg = colors.none },
			WinSeparator = { fg = colors.text, bg = colors.none },
			TroubleNormal = { bg = colors.none, fg = colors.text },
			NoiceCmdlinePopupBorder = { bg = colors.none, fg = colors.text },
			NoiceCmdlinePopupBorderCmdline = { bg = colors.none, fg = colors.text },
			NoiceCmdlinePopupBorderCalculator = { bg = colors.none, fg = colors.text },
			NoiceCmdlinePopupBorderFilter = { bg = colors.none, fg = colors.text },
      NoiceCmdlinePopupBorderHelp = { bg = colors.none, fg = colors.text },
      NoiceCmdlinePopupBorderIncRename = { bg = colors.none, fg = colors.text },
      NoiceCmdlinePopupBorderInput = { bg = colors.none, fg = colors.text },
      NoiceCmdlinePopupBorderLua = { bg = colors.none, fg = colors.text },
      NoiceCmdlinePopupBorderSearch = { bg = colors.none, fg = colors.text },
      NoiceCmdlineIconSearch = { bg = colors.none, fg = colors.mauve },
		}
	end,
	highlight_overrides = {
		all = function(colors)
			return {
				Tag = { fg = colors.red },
			}
		end,
	},
})

-- Set Colorscheme
vim.cmd("colorscheme " .. HackVim.colorscheme)

-- Hackvim Colors
vim.api.nvim_set_hl(0, "HackvimPrimary", { fg = mocha.mauve })
vim.api.nvim_set_hl(0, "HackvimSecondary", { fg = mocha.lavender })

vim.api.nvim_set_hl(0, "HackvimPrimaryBold", { bold = true, fg = mocha.lavender })
vim.api.nvim_set_hl(0, "HackvimSecondaryBold", { bold = true, fg = mocha.mauve })

vim.api.nvim_set_hl(0, "HackvimHeader", { bold = true, fg = mocha.blue })
vim.api.nvim_set_hl(0, "HackvimHeaderInfo", { bold = true, fg = mocha.blue })
vim.api.nvim_set_hl(0, "HackvimFooter", { bold = true, fg = mocha.subtext1 })
vim.api.nvim_set_hl(0, "HackvimHeader", { bold = true, fg = mocha.blue })
vim.api.nvim_set_hl(0, "HackvimNvimTreeTitle", { bold = true, fg = mocha.text, bg = mocha.base })

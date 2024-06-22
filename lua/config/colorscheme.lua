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
	transparent_background = true,
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
			inlay_hints = {},
			virtual_text = {},
			virtual_lines = {},
			underlines = {},
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
vim.api.nvim_set_hl(0, "HackvimHeaderInfo", { bold = true, fg = mocha.green })
vim.api.nvim_set_hl(0, "HackvimFooter", { bold = true, fg = mocha.yellow })
vim.api.nvim_set_hl(0, "HackvimHeader", { bold = true, fg = mocha.blue })
vim.api.nvim_set_hl(0, "HackvimNvimTreeTitle", { bold = true, fg = mocha.text, bg = mocha.base })

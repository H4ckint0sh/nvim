local present, catppuccin = pcall(require, "catppuccin")
if not present then
  return
end

-- ╭──────────────────────────────────────────────────────────╮
-- │ Setup Colorscheme                                        │
-- ╰──────────────────────────────────────────────────────────╯
catppuccin.setup({
  --   -- Replace this with your scheme-specific settings or remove to use the defaults
  -- transparent = true,
  flavour = "mocha",         -- "latte, frappe, macchiato, mocha"
  no_bold = true,            --No Bold
  styles = {                 -- Haes the styles of general hi groups (see `:h highlight-args`):
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

-- Ecovim Colors
vim.api.nvim_set_hl(0, "EcovimPrimary", { fg = "#488dff" })
vim.api.nvim_set_hl(0, "EcovimSecondary", { fg = "#FFA630" })

vim.api.nvim_set_hl(0, "EcovimPrimaryBold", { bold = true, fg = "#488DFF" })
vim.api.nvim_set_hl(0, "EcovimSecondaryBold", { bold = true, fg = "#FFA630" })

vim.api.nvim_set_hl(0, "EcovimHeader", { bold = true, fg = "#488DFF" })
vim.api.nvim_set_hl(0, "EcovimHeaderInfo", { bold = true, fg = "#FFA630" })
vim.api.nvim_set_hl(0, "EcovimFooter", { bold = true, fg = "#FFA630" })

vim.api.nvim_set_hl(0, "EcovimNvimTreeTitle", { bold = true, fg = "#FFA630", bg = "#16161e" })

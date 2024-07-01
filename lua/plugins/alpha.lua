local present, alpha = pcall(require, "alpha")
if not present then
	return
end

local mocha = require("catppuccin.palettes").get_palette("mocha")
local icons = require("utils.icons")
local if_nil = vim.F.if_nil
local fn = vim.fn
local config_dir = fn.stdpath("config")

-- ╭──────────────────────────────────────────────────────────╮
-- │ Header                                                   │
-- ╰──────────────────────────────────────────────────────────╯

local header = require("alpha.themes.dashboard")
-- Define and set highlight groups for each logo line
vim.api.nvim_set_hl(0, "NeovimDashboardLogo1", { fg = mocha.text }) -- Indigo
vim.api.nvim_set_hl(0, "NeovimDashboardLogo2", { fg = mocha.subtext1 }) -- Deep Purple
vim.api.nvim_set_hl(0, "NeovimDashboardLogo3", { fg = mocha.subtext0 }) -- Deep Purple
vim.api.nvim_set_hl(0, "NeovimDashboardLogo4", { fg = mocha.overlay2 }) -- Medium Purple
vim.api.nvim_set_hl(0, "NeovimDashboardLogo5", { fg = mocha.overlay1 }) -- Light Purple
vim.api.nvim_set_hl(0, "NeovimDashboardLogo6", { fg = mocha.overlay0 }) -- Very Light Purple
vim.api.nvim_set_hl(0, "NeovimDashboardUsername", { fg = mocha.lavender }) -- light purple
header.section.header.type = "group"
header.section.header.val = {
	{
		type = "text",
		val = "██╗  ██╗ █████╗  ██████╗██╗  ██╗██╗   ██╗██╗███╗   ███╗",
		opts = { hl = "NeovimDashboardLogo1", shrink_margin = false, position = "center" },
	},
	{
		type = "text",
		val = "██║  ██║██╔══██╗██╔════╝██║ ██╔╝██║   ██║██║████╗ ████║",
		opts = { hl = "NeovimDashboardLogo2", shrink_margin = false, position = "center" },
	},
	{
		type = "text",
		val = "███████║███████║██║     █████╔╝ ██║   ██║██║██╔████╔██║",
		opts = { hl = "NeovimDashboardLogo3", shrink_margin = false, position = "center" },
	},
	{
		type = "text",
		val = "██╔══██║██╔══██║██║     ██╔═██╗ ██║   ██║██║██║╚██╔╝██║",
		opts = { hl = "NeovimDashboardLogo4", shrink_margin = false, position = "center" },
	},
	{
		type = "text",
		val = "██║  ██║██║  ██║╚██████╗██║  ██╗╚██████╔╝██║██║ ╚═╝ ██║",
		opts = { hl = "NeovimDashboardLogo5", shrink_margin = false, position = "center" },
	},
	{
		type = "text",
		val = "╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝ ╚═════╝ ╚═╝╚═╝     ╚═╝",
		opts = { hl = "NeovimDashboardLogo6", shrink_margin = false, position = "center" },
	},
	{
		type = "padding",
		val = 1,
	},
	{
		type = "text",
		val = "𝙾𝚑 𝚝𝚑𝚎 𝚓𝚘𝚢 𝚘𝚏 𝚑𝚊𝚟𝚒𝚗𝚐 𝚢𝚘𝚞𝚛 𝚘𝚠𝚗 𝚌𝚞𝚜𝚝𝚘𝚖 𝚝𝚎𝚡𝚝 𝚎𝚍𝚒𝚝𝚘𝚛 :)",
		opts = { hl = "NeovimDashboardUsername", shrink_margin = false, position = "center" },
	},
	{
		type = "padding",
		val = 1,
	},
}

-- ╭──────────────────────────────────────────────────────────╮
-- │ Heading Info                                             │
-- ╰──────────────────────────────────────────────────────────╯

local thingy = io.popen('echo "$(LANG=en_us_88591; date +%a) $(date +%d) $(LANG=en_us_88591; date +%b)" | tr -d "\n"')
if thingy == nil then
	return
end
local date = thingy:read("*a")
thingy:close()

local datetime = os.date(" %H:%M")

local hi_top_section = {
	type = "text",
	val = "┌────────────   Today is "
		.. date
		.. " ────────────┐",
	opts = {
		position = "center",
		hl = "HackvimHeaderInfo",
	},
}

local hi_middle_section = {
	type = "text",
	val = "│                                                │",
	opts = {
		position = "center",
		hl = "HackvimHeaderInfo",
	},
}

local hi_bottom_section = {
	type = "text",
	val = "└───══───══───══───  "
		.. datetime
		.. "  ───══───══───══────┘",
	opts = {
		position = "center",
		hl = "HackvimHeaderInfo",
	},
}

-- ╭──────────────────────────────────────────────────────────╮
-- │ Buttons                                                  │
-- ╰──────────────────────────────────────────────────────────╯
-- Copied from Alpha.nvim source code

local leader = "SPC"

--- @param sc string
--- @param txt string
--- @param keybind string optional
--- @param keybind_opts table optional
local function button(sc, txt, keybind, keybind_opts)
	local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")

	local opts = {
		position = "center",
		shortcut = sc,
		cursor = 5,
		width = 50,
		align_shortcut = "right",
		hl_shortcut = "HackvimPrimary",
	}
	if keybind then
		keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
		opts.keymap = { "n", sc_, keybind, keybind_opts }
	end

	local function on_press()
		-- local key = vim.api.nvim_replace_termcodes(keybind .. "<Ignore>", true, false, true)
		local key = vim.api.nvim_replace_termcodes(sc_ .. "<Ignore>", true, false, true)
		vim.api.nvim_feedkeys(key, "t", false)
	end

	return {
		type = "button",
		val = txt,
		on_press = on_press,
		opts = opts,
	}
end

header.section.buttons.val = {
	button("f", icons.fileNoBg .. " " .. "Find File", "<cmd>Telescope find_files<CR>", {}),
	button(
		"w",
		icons.word .. " " .. "Find Word",
		"<cmd>lua require('plugins.telescope.pickers.multi-rg')({ layout_strategy = 'vertical' })<CR>",
		{}
	),
	button("h", icons.fileRecent .. " " .. "Recents", "<cmd>Telescope oldfiles hidden=true<CR>", {}),
	button(
		"l",
		icons.timer .. " " .. "Load Current Dir Session",
		"<cmd>SessionManager load_current_dir_session<CR>",
		{}
	),
	button("u", icons.packageDown .. " " .. "Update Plugins", "<cmd>Lazy update<CR>", {}),
	button("m", icons.package .. " " .. "Manage Plugins", "<cmd>Lazy<CR>", {}),
	button("s", icons.cog .. " " .. "Settings", "<cmd>e $MYVIMRC<CR>", {}),
	button("<ESC>", icons.exit .. " " .. "Exit", "<cmd>exit<CR>", {}),
}

-- ╭──────────────────────────────────────────────────────────╮
-- │ Footer                                                   │
-- ╰──────────────────────────────────────────────────────────╯

local function file_exists(file)
	local f = io.open(file, "rb")
	if f then
		f:close()
	end
	return f ~= nil
end

local function line_from(file)
	if not file_exists(file) then
		return {}
	end
	local lines = {}
	for line in io.lines(file) do
		lines[#lines + 1] = line
	end
	return lines
end

local function footer()
	local plugins = require("lazy").stats().count
	local v = vim.version()
	local hackvim_version = line_from(config_dir .. "/.hackvim.version")
	return string.format(" v%d.%d.%d  󰂖 %d  󰴹 %s ", v.major, v.minor, v.patch, plugins, hackvim_version[1])
end

header.section.footer.val = {
	footer(),
}
header.section.footer.opts = {
	position = "center",
	hl = "HackvimFooter",
}

local section = {
	header = header.section.header,
	hi_top_section = hi_top_section,
	hi_middle_section = hi_middle_section,
	hi_bottom_section = hi_bottom_section,
	buttons = header.section.buttons,
	footer = header.section.footer,
}

-- ╭──────────────────────────────────────────────────────────╮
-- │ Setup                                                    │
-- ╰──────────────────────────────────────────────────────────╯

local opts = {
	layout = {
		{ type = "padding", val = 3 },
		section.header,
		{ type = "padding", val = 1 },
		section.hi_top_section,
		section.hi_middle_section,
		section.hi_bottom_section,
		{ type = "padding", val = 2 },
		section.buttons,
		{ type = "padding", val = 2 },
		section.footer,
	},
	opts = {
		margin = 5,
	},
}

alpha.setup(opts)

-- ╭──────────────────────────────────────────────────────────╮
-- │ Hide tabline and statusline on startup screen            │
-- ╰──────────────────────────────────────────────────────────╯
vim.api.nvim_create_augroup("alpha_tabline", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = "alpha_tabline",
	pattern = "alpha",
	command = "set showtabline=0 laststatus=0 noruler",
})

vim.api.nvim_create_autocmd("FileType", {
	group = "alpha_tabline",
	pattern = "alpha",
	callback = function()
		vim.api.nvim_create_autocmd("BufUnload", {
			group = "alpha_tabline",
			buffer = 0,
			command = "set showtabline=2 ruler laststatus=3",
		})
	end,
})

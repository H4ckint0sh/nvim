local mocha = require("catppuccin.palettes").get_palette("mocha")
local check_recording = require("internal.statusline.macro").check_recording

local green = mocha.green
local mauve = mocha.mauve
local crust = mocha.crust
local text = mocha.text
local base = mocha.base
local lavender = mocha.lavender

vim.api.nvim_set_hl(0, "StatusLineNormal", { bg = green, fg = crust })
vim.api.nvim_set_hl(0, "StatusLineInsert", { bg = mauve, fg = crust })
vim.api.nvim_set_hl(0, "StatusLineVisual", { bg = lavender, fg = crust })
vim.api.nvim_set_hl(0, "StatusLineLsp", { bg = base, fg = text })
vim.api.nvim_set_hl(0, "StatusLine", { bg = base, fg = text })

local modes_map = {
	["n"] = { "NORMAL", mocha.lavender },
	["no"] = { "N-PENDING", mocha.lavender },
	["i"] = { "INSERT", mocha.green },
	["ic"] = { "INSERT", mocha.green },
	["t"] = { "TERMINAL", mocha.green },
	["v"] = { "VISUAL", mocha.flamingo },
	["V"] = { "V-LINE", mocha.flamingo },
	[""] = { "V-BLOCK", mocha.flamingo },
	["R"] = { "REPLACE", mocha.maroon },
	["Rv"] = { "V-REPLACE", mocha.maroon },
	["s"] = { "SELECT", mocha.maroon },
	["S"] = { "S-LINE", mocha.maroon },
	[""] = { "S-BLOCK", mocha.maroon },
	["c"] = { "COMMAND", mocha.peach },
	["cv"] = { "COMMAND", mocha.peach },
	["ce"] = { "COMMAND", mocha.peach },
	["r"] = { "PROMPT", mocha.teal },
	["rm"] = { "MORE", mocha.teal },
	["r?"] = { "CONFIRM", mocha.mauve },
	["!"] = { "SHELL", mocha.green },
}

-- Function to capitalize the first character of a string
local function capitalizeFirstChar(str)
	if str == nil or str == "" then
		return str
	end
	local firstChar = string.sub(str, 1, 1)
	local restOfString = string.sub(str, 2)
	firstChar = string.upper(firstChar)
	restOfString = string.lower(restOfString)
	return firstChar .. restOfString
end

-- Iterate over the modes_map and set highlights
for _, info in pairs(modes_map) do
	local highlight_group = "StatusLine" .. capitalizeFirstChar(info[1])
	local color = info[2]
	vim.api.nvim_set_hl(0, highlight_group, { bg = color, fg = mocha.crust,  bold = true })
end

local function get_mode_color()
	local current_mode = vim.api.nvim_get_mode().mode

  local mode_color = "%#" .. "StatusLine" .. capitalizeFirstChar(modes_map[current_mode][1]) .. "#"
	return mode_color
end

local function get_mode()
	local current_mode = vim.api.nvim_get_mode().mode
	return table.concat({
		get_mode_color(),
		" ",
		modes_map[current_mode][1] or "",
		" ",
		"%#StatusLine#",
	})
end

local function get_lsp_clients()
	local clients = vim.lsp.get_active_clients()
	for _, client in ipairs(clients) do
		local filetypes = client.config.filetypes
		if filetypes and vim.fn.index(filetypes, vim.bo.filetype) ~= -1 then
			return "[" .. client.name .. "]"
		end
	end
	return ""
end

local M = {}

M.global = function()
	local has_lsp_status, lsp_status = pcall(require, "lsp-status")
	local recording_msg = check_recording()
	return table.concat({
		get_mode(),
		" ",
		vim.fn.fnamemodify(vim.api.nvim_eval("getcwd()"), ":~"),
		"%#StatusLine#%{'Line: '}%l/%L, %{'Col: '}%c",
		"%=",
		" ",
		recording_msg,
		"%=",
		has_lsp_status and lsp_status.status() or "",
		" ",
		"%#StatusLineLsp#",
		get_lsp_clients(),
		" ",
	})
end

return M

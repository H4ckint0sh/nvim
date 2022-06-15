local status_ok, impatient = pcall(require, "copilot")
if not status_ok then
	return
end
vim.g.copilot_assume_mapped = true
vim.g.copilot_no_tab_map = true
vim.g.copilot_filetypes = {
	["*"] = false,
	["javascript"] = true,
	["javascriptreact"] = true,
	["typescript"] = true,
	["typescriptreact"] = true,
	["html"] = true,
	["css"] = true,
	["less"] = true,
	["scss"] = true,
	["lua"] = true,
	["rust"] = true,
	["c"] = true,
	["c#"] = true,
	["c++"] = true,
	["go"] = true,
	["python"] = true,
	["markdown"] = true,
}

local bufferline = require("bufferline")

bufferline.setup({
	options = {
		mode = "buffers",
		numbers = "ordinal",
		max_name_length = 10,
		max_prefix_length = 8, -- prefix used when a buffer is de-duplicated
		truncate_names = true, -- whether or not tab names should be truncated
		tab_size = 10,
		separator_style = {},
		always_show_bufferline = true,
		offsets = { { filetype = "NvimTree", text = "File Manager", separator = false } },
		style_preset = {
			bufferline.style_preset.no_italic,
			bufferline.style_preset.no_bold,
			bufferline.style_preset.minimal,
		},
		diagnostics = false,
		show_buffer_icons = false,
		show_buffer_close_icons = false,
		show_close_icon = false,
		show_tab_indicators = false,
		indicator_icon = nil,
		indicator = { style = "none", icon = "" },
		buffer_close_icon = "",
		modified_icon = "●",
		close_icon = "",
	},
})

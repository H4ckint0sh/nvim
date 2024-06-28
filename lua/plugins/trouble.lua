require("trouble").setup({
	auto_close = true, -- auto close when there are no items
	focus = true, -- Focus the window when open
	keys = {
		zo = "fold_open",
	},
	modes = {
		mode = "diagnostics",
		preview = {
			type = "split",
			relative = "win",
			position = "right",
			size = 0.3,
		},
	},
})

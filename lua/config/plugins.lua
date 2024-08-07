return {
	-- ╭─────────────────────────────────────────────────────────╮
	-- │ Themes                                                  │
	-- ╰─────────────────────────────────────────────────────────╯
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme tokyonight]])
			require("config.colorscheme")
		end,
	},
	{ "nvim-lua/plenary.nvim" },
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({ default = true })
		end,
	},
	{
		"goolord/alpha-nvim",
		lazy = false,
		config = function()
			require("plugins.alpha")
		end,
	},

	-- ╭─────────────────────────────────────────────────────────╮
	-- │ Treesitter                                              │
	-- ╰─────────────────────────────────────────────────────────╯
	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufReadPre",
		dependencies = {
			"hiphish/rainbow-delimiters.nvim",
			"JoosepAlviste/nvim-ts-context-commentstring",
			"nvim-treesitter/nvim-treesitter-textobjects",
			"RRethy/nvim-treesitter-textsubjects",
		},
		config = function()
			require("plugins.treesitter")
			vim.g.rainbow_delimiters = {
				query = {
					javascript = "rainbow-parens",
					tsx = "rainbow-parens",
				},
			}
		end,
	},

	-- ╭─────────────────────────────────────────────────────────╮
	-- │ Navigating (Telescope/Tree/Refactor)                    │
	-- ╰─────────────────────────────────────────────────────────╯
	{
		"nvim-pack/nvim-spectre",
		lazy = true,
		keys = {
			{
				"<Leader>pr",
				"<cmd>lua require('spectre').open_visual({select_word=true})<CR>",
				desc = "refactor",
			},
			{
				"<Leader>pr",
				"<cmd>lua require('spectre').open_visual()<CR>",
				mode = "v",
				desc = "refactor",
			},
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		lazy = false,
		config = function()
			require("plugins.telescope")
		end,
		dependencies = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "cljoly/telescope-repo.nvim" },
		},
	},
	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
		lazy = true,
		init = function()
			require("plugins.bqf-init")
		end,
		opts = {
			preview = {
				winblend = 0,
			},
		},
	},
	{
		"nvim-tree/nvim-tree.lua",
		cmd = {
			"NvimTreeOpen",
			"NvimTreeClose",
			"NvimTreeToggle",
			"NvimTreeFindFile",
			"NvimTreeFindFileToggle",
		},
		keys = {
			{ "<C-e>", "<cmd>lua require('nvim-tree.api').tree.toggle()<CR>", desc = "NvimTree" },
		},
		config = function()
			require("plugins.tree")
		end,
	},
	{
		"gbprod/stay-in-place.nvim",
		lazy = false,
		config = true, -- run require("stay-in-place").setup()
	},
	{
		"chentoast/marks.nvim",
		event = "BufEnter",
		config = true,
	},

	-- ╭─────────────────────────────────────────────────────────╮
	-- │ LSP Base                                                │
	-- ╰─────────────────────────────────────────────────────────╯
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = {
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		servers = nil,
	},
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = {
			{ "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" },
		},
	},

	-- ╭─────────────────────────────────────────────────────────╮
	-- │ LSP Cmp                                                 │
	-- ╰─────────────────────────────────────────────────────────╯
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = function()
			require("plugins.cmp")
		end,
		dependencies = {
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-calc",
			"saadparwaiz1/cmp_luasnip",
			{
				"L3MON4D3/LuaSnip",
				dependencies = "rafamadriz/friendly-snippets",
				build = "make install_jsregexp",
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load({
						paths = { vim.fn.stdpath("config") .. "/snippets" },
					})
				end,
			},
			{
				cond = HackVim.plugins.ai.tabnine.enabled,
				"tzachar/cmp-tabnine",
				build = "./install.sh",
			},
			{
				"David-Kunz/cmp-npm",
				config = function()
					require("plugins.cmp-npm")
				end,
			},
			{
				"zbirenbaum/copilot-cmp",
				cond = HackVim.plugins.ai.copilot.enabled,
				config = function()
					require("copilot_cmp").setup()
				end,
			},
			"petertriho/cmp-git",
		},
	},

	-- ╭─────────────────────────────────────────────────────────╮
	-- │ LSP Addons                                              │
	-- ╰─────────────────────────────────────────────────────────╯
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		name = "lsp_lines",
		dependencies = { "neovim/nvim-lspconfig" },
		event = "LspAttach",
		keys = {
			{
				"<Leader>l",
				function()
					require("lsp_lines").toggle()
				end,
				mode = { "n", "v" },
				desc = "Toggle lsp_lines",
			},
		},
		config = function(_, opts)
			require("lsp_lines").setup(opts)
			-- vim.diagnostic.config({ virtual_text = false })
		end,
	},
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		dependencies = "MunifTanjim/nui.nvim",
		config = function()
			require("plugins.dressing")
		end,
	},
	{ "onsails/lspkind-nvim" },
	{
		"folke/trouble.nvim",
		cmd = { "Trouble" },
		config = function()
			require("plugins.trouble")
		end,
		keys = {
			{
				"<leader>cD",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Workspace Diagnostics",
			},
			{
				"<leader>cd",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cx",
				"<cmd>Trouble lsp toggle win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>gr",
				"<cmd>Trouble lsp_references<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>gd",
				"<cmd>Trouble lsp_definitions<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>gi",
				"<cmd>Trouble lsp_implementations<cr>",
				desc = "LSP Definitions / refere)",
			},
			{
				"<leader>gy",
				"<cmd>Trouble lsp_type_definitions<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>cL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>cq",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
	{ "nvim-lua/popup.nvim" },
	{
		"SmiteshP/nvim-navic",
		config = function()
			require("plugins.navic")
		end,
		dependencies = "neovim/nvim-lspconfig",
	},
	{
		"pmizio/typescript-tools.nvim",
		event = { "BufReadPre", "BufNewFile" },
		ft = { "typescript", "typescriptreact" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("plugins.typescript-tools")
		end,
	},
	{
		"axelvc/template-string.nvim",
		event = "InsertEnter",
		ft = {
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
		},
		config = true, -- run require("template-string").setup()
	},
	{
		"dmmulroy/tsc.nvim",
		cmd = { "TSC" },
		config = true,
	},
	{
		"antosha417/nvim-lsp-file-operations",
		event = "LspAttach",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-tree/nvim-tree.lua" },
		},
		config = function()
			require("lsp-file-operations").setup()
		end,
	},
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		cmd = "Refactor",
		keys = {
			{ "<leader>re", ":Refactor extract ", mode = "x", desc = "Extract function" },
			{ "<leader>rf", ":Refactor extract_to_file ", mode = "x", desc = "Extract function to file" },
			{ "<leader>rv", ":Refactor extract_var ", mode = "x", desc = "Extract variable" },
			{ "<leader>ri", ":Refactor inline_var", mode = { "x", "n" }, desc = "Inline variable" },
			{ "<leader>rI", ":Refactor inline_func", mode = "n", desc = "Inline function" },
			{ "<leader>rb", ":Refactor extract_block", mode = "n", desc = "Extract block" },
			{ "<leader>rf", ":Refactor extract_block_to_file", mode = "n", desc = "Extract block to file" },
		},
		config = true,
	},

	-- ╭─────────────────────────────────────────────────────────╮
	-- │ General                                                 │
	-- ╰─────────────────────────────────────────────────────────╯
	{
		"mistricky/codesnap.nvim",
		build = "make",
		cmd = "CodeSnapPreviewOn",
		opts = {
			watermark = nil,
		},
	},
	{ "AndrewRadev/switch.vim", lazy = false },
	{
		"Wansmer/treesj",
		lazy = true,
		cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
		keys = {
			{ "gJ", "<cmd>TSJToggle<CR>", desc = "Toggle Split/Join" },
		},
		config = function()
			require("treesj").setup({
				use_default_keymaps = false,
			})
		end,
	},
	{
		"numToStr/Comment.nvim",
		lazy = false,
		dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
		config = function()
			require("plugins.comment")
		end,
	},
	{
		"LudoPinelli/comment-box.nvim",
		lazy = false,
		keys = {
			{ "<leader>ac", "<cmd>lua require('comment-box').llbox()<CR>", desc = "comment box" },
			{ "<leader>ac", "<cmd>lua require('comment-box').llbox()<CR>", mode = "v", desc = "comment box" },
		},
	},
	{ "tpope/vim-repeat", lazy = false },
	{ "tpope/vim-speeddating", lazy = false },
	{ "dhruvasagar/vim-table-mode", ft = { "markdown" } },
	{
		"smoka7/multicursors.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"smoka7/hydra.nvim",
		},
		opts = {
			hint_config = {
				border = HackVim.ui.float.border or "rounded",
				position = "bottom",
				show_name = false,
			},
		},
		keys = {
			{
				"<LEADER>m",
				"<CMD>MCstart<CR>",
				desc = "multicursor",
			},
			{
				"<LEADER>m",
				"<CMD>MCvisual<CR>",
				mode = "v",
				desc = "multicursor",
			},
			{
				"<C-Down>",
				"<CMD>MCunderCursor<CR>",
				desc = "multicursor down",
			},
		},
	},
	{
		"nacro90/numb.nvim",
		lazy = false,
		config = function()
			require("plugins.numb")
		end,
	},
	{
		"folke/todo-comments.nvim",
		lazy = false,
		event = "BufEnter",
		config = function()
			require("plugins.todo-comments")
		end,
	},
	{
		"folke/zen-mode.nvim",
		cmd = { "ZenMode" },
		config = function()
			require("plugins.zen")
		end,
		cond = HackVim.plugins.zen.enabled,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			char = {
				keys = { "f", "F", "t", "T" },
			},
		},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,   desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o",               function() require("flash").remote() end, desc = "Remote Flash" },
    },
	},
	{
		"folke/twilight.nvim",
		config = true,
		cond = HackVim.plugins.zen.enabled,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		lazy = true,
		config = function()
			require("plugins.which-key")
		end,
	},
	{
		"echasnovski/mini.bufremove",
		version = "*",
		config = function()
			require("mini.bufremove").setup({
				silent = true,
			})
		end,
	},
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"echasnovski/mini.bufremove",
		},
		version = "*",
		config = function()
			require("plugins.bufferline")
		end,
		keys = {
			{ "<Space>1", "<cmd>BufferLineGoToBuffer 1<CR>" },
			{ "<Space>2", "<cmd>BufferLineGoToBuffer 2<CR>" },
			{ "<Space>3", "<cmd>BufferLineGoToBuffer 3<CR>" },
			{ "<Space>4", "<cmd>BufferLineGoToBuffer 4<CR>" },
			{ "<Space>5", "<cmd>BufferLineGoToBuffer 5<CR>" },
			{ "<Space>6", "<cmd>BufferLineGoToBuffer 6<CR>" },
			{ "<Space>7", "<cmd>BufferLineGoToBuffer 7<CR>" },
			{ "<Space>8", "<cmd>BufferLineGoToBuffer 8<CR>" },
			{ "<Space>9", "<cmd>BufferLineGoToBuffer 9<CR>" },
			{ "<A-1>", "<cmd>BufferLineGoToBuffer 1<CR>" },
			{ "<A-2>", "<cmd>BufferLineGoToBuffer 2<CR>" },
			{ "<A-3>", "<cmd>BufferLineGoToBuffer 3<CR>" },
			{ "<A-4>", "<cmd>BufferLineGoToBuffer 4<CR>" },
			{ "<A-5>", "<cmd>BufferLineGoToBuffer 5<CR>" },
			{ "<A-6>", "<cmd>BufferLineGoToBuffer 6<CR>" },
			{ "<A-7>", "<cmd>BufferLineGoToBuffer 7<CR>" },
			{ "<A-8>", "<cmd>BufferLineGoToBuffer 8<CR>" },
			{ "<A-9>", "<cmd>BufferLineGoToBuffer 9<CR>" },
			{ "<Leader>bb", "<cmd>BufferLineMovePrev<CR>", desc = "Move back" },
			{ "<Leader>bl", "<cmd>BufferLineCloseLeft<CR>", desc = "Close Left" },
			{ "<Leader>br", "<cmd>BufferLineCloseRight<CR>", desc = "Close Right" },
			{ "<Leader>bn", "<cmd>BufferLineMoveNext<CR>", desc = "Move next" },
			{ "<Leader>bp", "<cmd>BufferLinePick<CR>", desc = "Pick Buffer" },
			{ "<Leader>bP", "<cmd>BufferLineTogglePin<CR>", desc = "Pin/Unpin Buffer" },
			{ "<Leader>bsd", "<cmd>BufferLineSortByDirectory<CR>", desc = "Sort by directory" },
			{ "<Leader>bse", "<cmd>BufferLineSortByExtension<CR>", desc = "Sort by extension" },
			{ "<Leader>bsr", "<cmd>BufferLineSortByRelativeDirectory<CR>", desc = "Sort by relative dir" },
		},
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				background_colour = "#000000",
			})
		end,
		init = function()
			local banned_messages = {
				"No information available",
				"LSP[tsserver] Inlay Hints request failed. Requires TypeScript 4.4+.",
				"LSP[tsserver] Inlay Hints request failed. File not opened in the editor.",
			}
			vim.notify = function(msg, ...)
				for _, banned in ipairs(banned_messages) do
					if msg == banned then
						return
					end
				end
				return require("notify")(msg, ...)
			end
		end,
	},
	{
		"vuki656/package-info.nvim",
		event = "BufEnter package.json",
		config = function()
			require("plugins.package-info")
		end,
	},
	-- {
	--   "iamcco/markdown-preview.nvim",
	--   build = "cd app && npm install",
	--   setup = function()
	--     vim.g.mkdp_filetypes = { "markdown" }
	--   end,
	--   ft = { "markdown" },
	-- },
	{
		"airblade/vim-rooter",
		event = "VeryLazy",
		config = function()
			vim.g.rooter_patterns = HackVim.plugins.rooter.patterns
			vim.g.rooter_silent_chdir = 1
			vim.g.rooter_resolve_links = 1
		end,
	},
	{
		"Shatur/neovim-session-manager",
		lazy = false,
		config = function()
			require("plugins.session-manager")
		end,
		keys = {
			{ "<Leader>ps", "<cmd>SessionManager available_commands<CR>", desc = "session manager" },
			{ "<Leader>pS", "<cmd>SessionManager save_current_session<CR>", desc = "save session" },
		},
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = true,
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
			{
				"luukvbaal/statuscol.nvim",
				config = function()
					local builtin = require("statuscol.builtin")
					require("statuscol").setup({
						relculright = true,
						segments = {
							{ text = { "%s" }, click = "v:lua.ScSa" },
							{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
							{ text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
						},
					})
				end,
			},
		},
		init = function()
			vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
			vim.o.foldcolumn = "1" -- '0' is not bad
			vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true

			-- Tell the server the capability of foldingRange,
			-- Neovim hasn't added foldingRange to default capabilities, users must add it manually
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}
			local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
			for _, ls in ipairs(language_servers) do
				require("lspconfig")[ls].setup({
					capabilities = capabilities,
					-- you can add other fields for setting up lsp server in this table
				})
			end
		end,
	},
	{
		"echasnovski/mini.align",
		lazy = false,
		version = "*",
		config = function()
			require("mini.align").setup()
		end,
	},
	{
		"rareitems/printer.nvim",
		event = "BufEnter",
		ft = {
			"lua",
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
		},
		config = function()
			require("plugins.printer")
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPre",
		main = "ibl",
		config = function()
			require("plugins.indent")
		end,
	},
	{
		"folke/noice.nvim",
		cond = HackVim.plugins.experimental_noice.enabled,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		lazy = false,
		config = function()
			require("plugins.noice")
		end,
	},
	-- ╭─────────────────────────────────────────────────────────╮
	-- │ Snippets & Language & Syntax                            │
	-- ╰─────────────────────────────────────────────────────────╯
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("plugins.autopairs")
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		ft = {
			"html",
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
			"svelte",
			"vue",
			"tsx",
			"jsx",
			"rescript",
			"xml",
			"php",
			"markdown",
			"astro",
			"glimmer",
			"handlebars",
			"hbs",
		},
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true, -- Auto close tags
					enable_rename = true, -- Auto rename pairs of tags
					enable_close_on_slash = true, -- Auto close on trailing </
				},
			})
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("plugins.colorizer")
		end,
	},
	{
		"js-everts/cmp-tailwind-colors",
		config = true,
	},
	{
		"razak17/tailwind-fold.nvim",
		opts = {
			min_chars = 50,
		},
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		ft = { "html", "svelte", "astro", "vue", "typescriptreact" },
	},
	{
		"MaximilianLloyd/tw-values.nvim",
		keys = {
			{ "<Leader>cv", "<CMD>TWValues<CR>", desc = "Tailwind CSS values" },
		},
		opts = {
			border = HackVim.ui.float.border or "rounded", -- Valid window border style,
			show_unknown_classes = true, -- Shows the unknown classes popup
		},
	},
	{
		"laytan/tailwind-sorter.nvim",
		cmd = {
			"TailwindSort",
			"TailwindSortOnSaveToggle",
		},
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
		build = "cd formatter && npm i && npm run build",
		config = true,
	},
	{
		"johmsalas/text-case.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		-- Author's Note: If default keymappings fail to register (possible config issue in my local setup),
		-- verify lazy loading functionality. On failure, disable lazy load and report issue
		-- lazy = false,
		config = function()
			require("textcase").setup({
				-- Set `default_keymappings_enabled` to false if you don't want automatic keymappings to be registered.
				default_keymappings_enabled = true,
				-- `prefix` is only considered if `default_keymappings_enabled` is true. It configures the prefix
				-- of the keymappings, e.g. `gau ` executes the `current_word` method with `to_upper_case`
				-- and `gaou` executes the `operator` method with `to_upper_case`.
				prefix = "gu",
				-- If `substitude_command_name` is not nil, an additional command with the passed in name
				-- will be created that does the same thing as "Subs" does.
				substitude_command_name = nil,
				-- By default, all methods are enabled. If you set this option with some methods omitted,
				-- these methods will not be registered in the default keymappings. The methods will still
				-- be accessible when calling the exact lua function e.g.:
				-- "<CMD>lua require('textcase').current_word('to_snake_case')<CR>"
				enabled_methods = {
					"to_upper_case",
					"to_lower_case",
					"to_snake_case",
					"to_dash_case",
					"to_title_dash_case",
					"to_constant_case",
					"to_dot_case",
					"to_phrase_case",
					"to_camel_case",
					"to_pascal_case",
					"to_title_case",
					"to_path_case",
					"to_upper_phrase_case",
					"to_lower_phrase_case",
				},
			})
			require("telescope").load_extension("textcase")
		end,
		cmd = { "TextCaseOpenTelescope", "Subs" },
		keys = { "gu" },
	},

	-- ╭─────────────────────────────────────────────────────────╮
	-- │ AI                                                      │
	-- ╰─────────────────────────────────────────────────────────╯
	{
		"jcdickinson/codeium.nvim",
		cond = HackVim.plugins.ai.codeium.enabled,
		event = "InsertEnter",
		cmd = "Codeium",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = true,
	},
	{
		"zbirenbaum/copilot.lua",
		cond = HackVim.plugins.ai.copilot.enabled,
		lazy = false,
		config = function()
			require("plugins.copilot")
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		event = "VeryLazy",
		opts = {
			show_help = "no",
			prompts = {
				Explain = "Explain how it works.",
				Review = "Review the following code and provide concise suggestions.",
				Tests = "Briefly explain how the selected code works, then generate unit tests.",
				Refactor = "Refactor the code to improve clarity and readability.",
			},
		},
		build = function()
			vim.defer_fn(function()
				vim.cmd("UpdateRemotePlugins")
				vim.notify("CopilotChat - Updated remote plugins. Please restart Neovim.")
			end, 3000)
		end,
		keys = {
			{ "<leader>ccb", ":CopilotChatBuffer<cr>", desc = "CopilotChat - Buffer" },
			{ "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
			{ "<leader>cct", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
			{
				"<leader>ccT",
				"<cmd>CopilotChatVsplitToggle<cr>",
				desc = "CopilotChat - Toggle Vsplit", -- Toggle vertical split
			},
			{
				"<leader>ccv",
				":CopilotChatVisual",
				mode = "x",
				desc = "CopilotChat - Open in vertical split",
			},
			{
				"<leader>ccc",
				":CopilotChatInPlace<cr>",
				mode = { "n", "x" },
				desc = "CopilotChat - Run in-place code",
			},
			{
				"<leader>ccf",
				"<cmd>CopilotChatFixDiagnostic<cr>", -- Get a fix for the diagnostic message under the cursor.
				desc = "CopilotChat - Fix diagnostic",
			},
		},
	},

	-- ╭─────────────────────────────────────────────────────────╮
	-- │ Git                                                     │
	-- ╰─────────────────────────────────────────────────────────╯
	{
		"lewis6991/gitsigns.nvim",
		event = "BufRead",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("plugins.git.signs")
		end,
		keys = {
			{ "<Leader>ghd", desc = "diff hunk" },
			{ "<Leader>ghp", desc = "preview" },
			{ "<Leader>ghR", desc = "reset buffer" },
			{ "<Leader>ghr", desc = "reset hunk" },
			{ "<Leader>ghs", desc = "stage hunk" },
			{ "<Leader>ghS", desc = "stage buffer" },
			{ "<Leader>ght", desc = "toggle deleted" },
			{ "<Leader>ghu", desc = "undo stage" },
		},
	},
	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitCurrentFile",
			"LazyGitFilterCurrentFile",
			"LazyGitFilter",
		},
		keys = {
			{ "<Leader>gg", "<cmd>LazyGit<CR>", desc = "lazygit" },
		},
		config = function()
			vim.g.lazygit_floating_window_scaling_factor = 0.9
		end,
	},

	-- ╭─────────────────────────────────────────────────────────╮
	-- │ Testing                                                 │
	-- ╰─────────────────────────────────────────────────────────╯
	{
		"rcarriga/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"haydenmeade/neotest-jest",
		},
		config = function()
			require("plugins.neotest")
		end,
	},
	{
		"andythigpen/nvim-coverage",
		dependencies = "nvim-lua/plenary.nvim",
		cmd = {
			"Coverage",
			"CoverageSummary",
			"CoverageLoad",
			"CoverageShow",
			"CoverageHide",
			"CoverageToggle",
			"CoverageClear",
		},
		config = function()
			require("coverage").setup()
		end,
	},

	-- ╭─────────────────────────────────────────────────────────╮
	-- │ DAP                                                     │
	-- ╰─────────────────────────────────────────────────────────╯
	{
		{
			"mfussenegger/nvim-dap",
			config = function()
				local dap = require("dap")
				local js_based_languages = {
					"typescript",
					"javascript",
					"typescriptreact",
					"javascriptreact",
					"vue",
				}

				for _, language in ipairs(js_based_languages) do
					dap.configurations[language] = {
						-- Debug single nodejs files
						{
							type = "pwa-node",
							request = "launch",
							name = "Launch file",
							program = "${file}",
							cwd = vim.fn.getcwd(),
							sourceMaps = true,
						},
						-- Debug nodejs processes (make sure to add --inspect when you run the process)
						{
							type = "pwa-node",
							request = "attach",
							name = "Attach",
							processId = require("dap.utils").pick_process,
							cwd = vim.fn.getcwd(),
							sourceMaps = true,
						},
						-- Debug web applications (client side)
						{
							type = "pwa-chrome",
							request = "launch",
							name = "Launch & Debug Chrome",
							url = function()
								local co = coroutine.running()
								return coroutine.create(function()
									vim.ui.input({
										prompt = "Enter URL: ",
										default = "http://localhost:3000",
									}, function(url)
										if url == nil or url == "" then
											return
										else
											coroutine.resume(co, url)
										end
									end)
								end)
							end,
							webRoot = vim.fn.getcwd(),
							protocol = "inspector",
							sourceMaps = true,
							userDataDir = false,
						},
						-- Divider for the launch.json derived configs
						{
							name = "----- ↓ launch.json configs ↓ -----",
							type = "",
							request = "launch",
						},
					}
				end
			end,
			keys = {
				{
					"<leader>dB",
					function()
						require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
					end,
					desc = "Breakpoint Condition",
				},
				{
					"<leader>db",
					function()
						require("dap").toggle_breakpoint()
					end,
					desc = "Toggle Breakpoint",
				},
				{
					"<leader>dc",
					function()
						require("dap").continue()
					end,
					desc = "Continue",
				},
				{
					"<leader>da",
					function()
						require("dap").continue({ before = get_args })
					end,
					desc = "Run with Args",
				},
				{
					"<leader>dC",
					function()
						require("dap").run_to_cursor()
					end,
					desc = "Run to Cursor",
				},
				{
					"<leader>dg",
					function()
						require("dap").goto_()
					end,
					desc = "Go to line (no execute)",
				},
				{
					"<leader>di",
					function()
						require("dap").step_into()
					end,
					desc = "Step Into",
				},
				{
					"<leader>dj",
					function()
						require("dap").down()
					end,
					desc = "Down",
				},
				{
					"<leader>dk",
					function()
						require("dap").up()
					end,
					desc = "Up",
				},
				{
					"<leader>dl",
					function()
						require("dap").run_last()
					end,
					desc = "Run Last",
				},
				{
					"<leader>do",
					function()
						require("dap").step_out()
					end,
					desc = "Step Out",
				},
				{
					"<leader>dO",
					function()
						require("dap").step_over()
					end,
					desc = "Step Over",
				},
				{
					"<leader>dp",
					function()
						require("dap").pause()
					end,
					desc = "Pause",
				},
				{
					"<leader>dr",
					function()
						require("dap").repl.toggle()
					end,
					desc = "Toggle REPL",
				},
				{
					"<leader>ds",
					function()
						require("dap").session()
					end,
					desc = "Session",
				},
				{
					"<leader>dt",
					function()
						require("dap").terminate()
					end,
					desc = "Terminate",
				},
				{
					"<leader>dw",
					function()
						require("dap.ui.widgets").hover()
					end,
					desc = "Widgets",
				},
				{
					"<leader>dO",
					function()
						require("dap").step_out()
					end,
					desc = "Step Out",
				},
				{
					"<leader>do",
					function()
						require("dap").step_over()
					end,
					desc = "Step Over",
				},
				{
					"<leader>da",
					function()
						if vim.fn.filereadable(".vscode/launch.json") then
							local dap_vscode = require("dap.ext.vscode")
							dap_vscode.load_launchjs(nil, {
								["pwa-node"] = {
									"typescript",
									"javascript",
									"typescriptreact",
									"javascriptreact",
									"vue",
								},
								["chrome"] = {
									"typescript",
									"javascript",
									"typescriptreact",
									"javascriptreact",
									"vue",
								},
								["pwa-chrome"] = {
									"typescript",
									"javascript",
									"typescriptreact",
									"javascriptreact",
									"vue",
								},
							})
						end
						require("dap").continue()
					end,
					desc = "Run with Args",
				},
			},
			dependencies = {
				-- Install the vscode-js-debug adapter
				{
					"microsoft/vscode-js-debug",
					-- After install, build it and rename the dist directory to out
					build = "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
					version = "1.*",
				},
				{
					"mxsdev/nvim-dap-vscode-js",
					config = function()
						---@diagnostic disable-next-line: missing-fields
						require("dap-vscode-js").setup({
							-- Path of node executable. Defaults to $NODE_PATH, and then "node"
							-- node_path = "node",

							-- Path to vscode-js-debug installation.
							debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),

							-- Command to use to launch the debug server. Takes precedence over "node_path" and "debugger_path"
							-- debugger_cmd = { "js-debug-adapter" },

							-- which adapters to register in nvim-dap
							adapters = {
								"chrome",
								"pwa-node",
								"pwa-chrome",
								"pwa-msedge",
								"pwa-extensionHost",
								"node-terminal",
							},

							-- Path for file logging
							-- log_file_path = "(stdpath cache)/dap_vscode_js.log",

							-- Logging level for output to file. Set to false to disable logging.
							-- log_file_level = false,

							-- Logging level for output to console. Set to false to disable console output.
							-- log_console_level = vim.log.levels.ERROR,
						})
					end,
				},
				{
					"thehamsta/nvim-dap-virtual-text",
					opts = {},
				},
				{
					"rcarriga/nvim-dap-ui",
					dependencies = { -- stylua: ignore
						"nvim-neotest/nvim-nio",
					},
					keys = {
						{
							"<leader>du",
							function()
								require("dapui").toggle({})
							end,
							desc = "Dap UI",
						},
						{
							"<leader>de",
							function()
								require("dapui").eval()
							end,
							desc = "Eval",
							mode = { "n", "v" },
						},
					},
					opts = {},
					config = function(_, opts)
						-- setup dap config by VsCode launch.json file
						require("dap.ext.vscode").load_launchjs()
						local dap = require("dap")
						local dapui = require("dapui")
						dapui.setup(opts)
						dap.listeners.after.event_initialized["dapui_config"] = function()
							dapui.open({})
						end
						dap.listeners.before.event_terminated["dapui_config"] = function()
							dapui.close({})
						end
						dap.listeners.before.event_exited["dapui_config"] = function()
							dapui.close({})
						end
					end,
				},
				{
					"Joakker/lua-json5",
					build = "./install.sh",
				},
			},
		},
	},

	-- ╭─────────────────────────────────────────────────────────╮
	-- │ Format & Lint                                           │
	-- ╰─────────────────────────────────────────────────────────╯
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("plugins.formatting")
		end,
	},
	{
		"mfussenegger/nvim-lint",
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		config = function()
			require("plugins.linting")
		end,
	},
}

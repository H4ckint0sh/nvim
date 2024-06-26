-- Setup installer & lsp configs
local mason_ok, mason = pcall(require, "mason")
local mason_lsp_ok, mason_lsp = pcall(require, "mason-lspconfig")
local ufo_config_handler = require("plugins.nvim-ufo").handler

if not mason_ok or not mason_lsp_ok then
  return
end

mason.setup({
  ui = {
    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    border = HackVim.ui.float.border or "rounded",
  },
})

mason_lsp.setup({
  -- A list of servers to automatically install if they're not already installed
  ensure_installed = {
    "bashls",
    "cssls",
    "eslint",
    "graphql",
    "html",
    "jsonls",
    "lua_ls",
    "prismals",
    "tailwindcss",
    "tsserver",
    "astro"
  },
  -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
  -- This setting has no relation with the `ensure_installed` setting.
  -- Can either be:
  --   - false: Servers are not automatically installed.
  --   - true: All servers set up via lspconfig are automatically installed.
  --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
  --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
  automatic_installation = true,
})

local lspconfig = require("lspconfig")

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    silent = true,
    border = HackVim.ui.float.border,
  }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = HackVim.ui.float.border }),
  --["textDocument/publishDiagnostics"] = vim.lsp.with(
  --  vim.lsp.diagnostic.on_publish_diagnostics,
  --  { virtual_text = HackVim.lsp.virtual_text }
  --),
}

local function on_attach(client, bufnr)
  -- set up buffer keymaps, etc.
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

require("mason-lspconfig").setup_handlers {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name)
    require("lspconfig")[server_name].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      handlers = handlers,
    }
  end,

  ["tsserver"] = function()
    -- Skip since we use typescript-tools.nvim
  end,

  ["tailwindcss"] = function()
    lspconfig.tailwindcss.setup({
      capabilities = require("config.lsp.servers.tailwindcss").capabilities,
      filetypes = require("config.lsp.servers.tailwindcss").filetypes,
      handlers = handlers,
      init_options = require("config.lsp.servers.tailwindcss").init_options,
      on_attach = require("config.lsp.servers.tailwindcss").on_attach,
      settings = require("config.lsp.servers.tailwindcss").settings,
    })
  end,

  ["cssls"] = function()
    lspconfig.cssls.setup({
      capabilities = capabilities,
      handlers = handlers,
      on_attach = require("config.lsp.servers.cssls").on_attach,
      settings = require("config.lsp.servers.cssls").settings,
    })
  end,

  ["eslint"] = function()
    lspconfig.eslint.setup({
      capabilities = capabilities,
      handlers = handlers,
      on_attach = require("config.lsp.servers.eslint").on_attach,
      settings = require("config.lsp.servers.eslint").settings,
    })
  end,

  ["jsonls"] = function()
    lspconfig.jsonls.setup({
      capabilities = capabilities,
      handlers = handlers,
      on_attach = on_attach,
      settings = require("config.lsp.servers.jsonls").settings,
    })
  end,

  ["lua_ls"] = function()
    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      handlers = handlers,
      on_attach = on_attach,
      settings = require("config.lsp.servers.lua_ls").settings,
    })
  end,

  ["vuels"] = function()
    lspconfig.vuels.setup({
      filetypes = require("config.lsp.servers.vuels").filetypes,
      handlers = handlers,
      init_options = require("config.lsp.servers.vuels").init_options,
      on_attach = require("config.lsp.servers.vuels").on_attach,
      settings = require("config.lsp.servers.vuels").settings,
    })
  end,
  ["astro"] = function()
    lspconfig.astro.setup({
    })
  end
}

require("ufo").setup({
  fold_virt_text_handler = ufo_config_handler,
	provider_selector = function(bufnr, filetype, _)
		local fmap = { lua = { "lsp", "treesitter" } }

		return fmap[filetype]
			or function()
				local function handle_fallback_exception(err, providerName)
					if type(err) == "string" and err:match("UfoFallbackException") then
						return require("ufo").getFolds(bufnr, providerName)
					else
						return require("promise").reject(err)
					end
				end

				return require("ufo")
					.getFolds(bufnr, "lsp")
					:catch(function(err)
						return handle_fallback_exception(err, "treesitter")
					end)
					:catch(function(err)
						return handle_fallback_exception(err, "indent")
					end)
			end
	end,

	open_fold_hl_timeout = 400,
	close_fold_kinds_for_ft = { default = { "imports", "comment" } },
	preview = {
		win_config = {
			border = { "", "─", "", "", "", "─", "", "" },
			-- winhighlight = "Normal:Folded",
			winblend = 0,
		},
		mappings = {
			scrollU = "<C-u>",
			scrollD = "<C-d>",
			jumpTop = "[",
			jumpBot = "]",
		},
	},
})

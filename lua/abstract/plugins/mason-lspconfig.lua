--[[━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
────────────────────────────────────────────────
Plugin:    mason-lspconfig.nvim
Github:    https://github.com/williamboman/mason-lspconfig.nvim

Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim.

Resources:
https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
────────────────────────────────────────────────
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━]]

local spec = {
	"williamboman/mason-lspconfig.nvim",
	lazy = true,
	dependencies = {
		"b0o/SchemaStore.nvim", -- A Neovim Lua plugin providing access to the SchemaStore catalog.
	},
}

local function mason_lspconfig(hook)
	local lspconfig = require("lspconfig")

	local function set_lspconfig(server, options)
		local lsp_options = vim.tbl_deep_extend("force", hook, options)
		lspconfig[server].setup(lsp_options)
	end

	local server_config = {
		function(server_name)
			set_lspconfig(server_name, {})
		end,
		["rust_analyzer"] = function()
			-- Rust LSP is maintained by https://github.com/mrcjkb/rustaceanvim
			vim.g.rustaceanvim = { server = hook }
		end,
		["tsserver"] = function()
			-- Typescript LSP is maintained by https://github.com/pmizio/typescript-tools.nvim
			vim.list_extend(hook, require("abstract.plugins.typescript-tools").settings)
			require("typescript-tools").setup(hook)
		end,
		["html"] = function()
			set_lspconfig("html", { filetypes = { "html", "htmldjango" } })
		end,
		["jsonls"] = function()
			set_lspconfig("jsonls", {
				settings = { json = { schemas = require("schemastore").json.schemas(), validate = { enable = true } } },
			})
		end,
		["yamlls"] = function()
			set_lspconfig("yamlls", {
				settings = {
					yaml = {
						schemaStore = {
							-- You must disable built-in schemaStore support if you want to use
							-- this plugin and its advanced options like `ignore`.
							enable = false,
							-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
							url = "",
						},
						schemas = require("schemastore").yaml.schemas(),
					},
				},
			})
		end,
		["cssls"] = function()
			set_lspconfig("cssls", {
				capabilities = { textDocument = { completion = { completionItem = { snippetSupport = true } } } },
			})
		end,
	}

	-- override with user defined config ("~/.config/nvim/lua/override/lsp.lua")
	local user_config = require("override.lsp").setup(lspconfig)
	server_config = vim.tbl_extend("force", server_config, user_config)

	return server_config
end

spec.config = function()
	local hook = require("abstract.plugins.lspconfig").config()
	require("mason-lspconfig").setup({
		-- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "lua_ls" }
		-- This setting has no relation with the `automatic_installation` setting.
		---@type string[]
		ensure_installed = {},

		-- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
		-- This setting has no relation with the `ensure_installed` setting.
		-- Can either be:
		--   - false: Servers are not automatically installed.
		--   - true: All servers set up via lspconfig are automatically installed.
		--   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
		--       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
		---@type boolean
		automatic_installation = false,

		-- See `:h mason-lspconfig.setup_handlers()`
		---@type table<string, fun(server_name: string)>?
		handlers = mason_lspconfig(hook),
	})
end

return spec

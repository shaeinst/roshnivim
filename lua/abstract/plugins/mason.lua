--[[
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
─────────────────────────────────────────────────
Plugin:    mason.nvim
Github:    https://github.com/williamboman/mason.nvim

Companion plugin for nvim-lspconfig that allows you to seamlessly install LSP servers
locally (inside :echo stdpath("data")).

!!! WARNINGS !!!:
0. mason.nvim is optimized to load as little as possible during setup. Lazy-loading the plugin, or somehow deferring the setup, is not recommended.
1. make sure `lspconfig` is not loaded after `mason-lspconfig`.
2. Also, make sure not to set up any servers via `lspconfig` _before_ calling `mason-lspconfig`'s setup function.
3. It's important that you set up the plugins in the following order:
    mason.nvim
    mason-lspconfig.nvim
    Setup servers via lspconfig
4. Pay extra attention to this if you lazy-load plugins, or somehow "chain" the loading of plugins via your plugin manager.
	require("mason").setup()
	require("mason-lspconfig").setup()

	After setting up mason-lspconfig you may set up servers via lspconfig
	require("lspconfig").lua_ls.setup {}
	require("lspconfig").rust_analyzer.setup {}
─────────────────────────────────────────────────
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--]]

local spec = {
	"williamboman/mason.nvim",
	event = { "BufRead", "BufNewFile", "InsertEnter" },
	keys = { ":", "M" },
}

local mason_config = {
	-- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
	-- debugging issues with package installations.
	log_level = vim.log.levels.INFO,
	-- Limit for the maximum amount of packages to be installed at the same time. Once this limit is reached, any further
	-- packages that are requested to be installed will be put in a queue.
	max_concurrent_installers = 4,

	ui = {
		-- Whether to automatically check for new versions when opening the :Mason window.
		check_outdated_packages_on_open = true,
		-- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
		border = "rounded",
		-- Width of the window. Accepts:
		-- - Integer greater than 1 for fixed width.
		-- - Float in the range of 0-1 for a percentage of screen width.
		width = 0.8,
		-- Height of the window. Accepts:
		-- - Integer greater than 1 for fixed height.
		-- - Float in the range of 0-1 for a percentage of screen height.
		height = 0.9,

		icons = {
			-- The list icon to use for installed packages.
			package_installed = "✓",
			-- The list icon to use for packages that are installing, or queued for installation.
			package_pending = "➜",
			-- The list icon to use for packages that are not installed.
			package_uninstalled = "✗",
		},
	},
}

spec.config = function(_, opts)
	require("mason").setup(vim.tbl_deep_extend("keep", opts, mason_config))
	require("abstract.plugins.mason-lspconfig").setup()
	require("abstract.plugins.none-ls").setup()
end

return spec

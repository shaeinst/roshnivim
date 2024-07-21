--[[━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
────────────────────────────────────────────────
Plugin:    flutter-tools.nvim
Github:    https://github.com/akinsho/flutter-tools.nvim

Tools to help create flutter apps in neovim using the native lsp
────────────────────────────────────────────────
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━]]

local spec = {
	"akinsho/flutter-tools.nvim",
	ft = { "dart" },
}

spec.config = function()
	require("flutter-tools").setup(vim.tbl_extend("force", {
		--
		-- flutter-tools setup settings goes here
		--
	}, { lsp = require("abstract.plugins.lspconfig").config() }))
end

return spec

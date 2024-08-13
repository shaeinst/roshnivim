--[[
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
────────────────────────────────────────────────
Plugin: toggleterm.nvim
Github: https://github.com/akinsho/toggleterm.nvim

A neovim lua plugin to help easily manage multiple terminal windows
────────────────────────────────────────────────
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--]]

local spec = {
	"akinsho/toggleterm.nvim",
	version = "*",
	lazy = true,
	cmd = {
		"ToggleTerm",
		"ToggleTermSetName",
		"ToggleTermToggleAll",
		"ToggleTermSendCurrentLine",
		"ToggleTermSendVisualLines",
		"ToggleTermSendVisualSelection",
	},
	keys = require("abstract.configs.mapping").plugin["akinsho/toggleterm.nvim"],
}

spec.config = function()
	require("toggleterm").setup({})
end

return spec

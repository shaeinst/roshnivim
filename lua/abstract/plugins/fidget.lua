--[[
--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
────────────────────────────────────────────────
Plugin:    fidget.nvim
Github:    https://github.com/j-hui/fidget.nvim

💫 Extensible UI for Neovim notifications and LSP progress messages.
────────────────────────────────────────────────
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--]]

local spec = {
	"j-hui/fidget.nvim",
	lazy = true,
	event = { "LspAttach" },
	opts = {}
}


return spec

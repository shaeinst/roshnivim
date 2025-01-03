--[[
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
─────────────────────────────────────────────────
Plugin: ecolog.nvim
Source: https://github.com/philosofonusus/ecolog.nvim

A Neovim plugin for seamless environment variable integration and management.
Provides intelligent autocompletion, type checking, and value peeking for
environment variables in your projects. All in one place.
─────────────────────────────────────────────────
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--]]

local spec = {
	"philosofonusus/ecolog.nvim",
	lazy = false, -- Lazy loading is done internally
}

spec.opts = {
	integrations = {
		lsp = true, -- To enable LSP integration
		blink_cmp = true, -- To enable blink.cmp integration
	},
}

return spec

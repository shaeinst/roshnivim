--[[
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
─────────────────────────────────────────────────
Plugin: abstract-winbar
Github: https://github.com/Abstract-IDE/abstract-winbar

Neovim Winbar: Elevating Awesome. Simple, Dynamic, Navic-Powered.
─────────────────────────────────────────────────
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--]]

ABSTRACT.PLUGINS["SmiteshP/nvim-navic"].enabled = true

local spec = {
	"Abstract-IDE/abstract-winbar",
	lazy = true,
	event = { "BufRead" },
	dependencies = {
		"SmiteshP/nvim-navic", -- Simple winbar/statusline plugin that shows your current code context
	},
}

spec.setup = function(opts)
	require("abstract-winbar").setup(opts or {
		-- exclude_filetypes = {},
	})
end

return spec

--[[
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
─────────────────────────────────────────────────
Plugin: rest.nvim
Github: https://github.com/rest-nvim/rest.nvim

A fast Neovim http client written in Lua
─────────────────────────────────────────────────
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--]]

local spec = {
	"rest-nvim/rest.nvim",
	lazy = true,
	ft = "http",
}

spec.config = function()
	require("abstract.utils.map").set_map("rest-nvim/rest.nvim")
	require("rest-nvim").setup({
		result = {
			split = {
				horizontal = false,
			},
		},
	})
end

return spec

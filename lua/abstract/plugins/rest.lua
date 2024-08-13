--[[
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
─────────────────────────────────────────────────
Plugin: kulala.nvim
Github: https://github.com/mistweaverco/kulala.nvim

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

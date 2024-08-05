--[[
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
────────────────────────────────────────────────
Plugin: vim-dadbod-ui
Github: https://github.com/kristijanhusak/vim-dadbod-ui

Simple UI for vim-dadbod.
It allows simple navigation through databases and allows saving queries for later use.
────────────────────────────────────────────────
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--]]

local spec = {
	"kristijanhusak/vim-dadbod-ui",
	lazy= true,
	cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
	},
}

spec.init = function()
	-- Your DBUI configuration
	vim.g.db_ui_use_nerd_fonts = 1
end

return spec

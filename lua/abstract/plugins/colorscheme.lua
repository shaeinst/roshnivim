--[[
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
─────────────────────────────────────────────────
Plugin: Abstract-cs
Github: https://github.com/Abstract-IDE/Abstract-cs

colorscheme for (neo)vim written in lua specially made for Abstract
─────────────────────────────────────────────────
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--]]

local spec = {
	"Abstract-IDE/Abstract-cs",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
}

spec.config = function()
	require("abstract_cs").setup({})
end

return spec

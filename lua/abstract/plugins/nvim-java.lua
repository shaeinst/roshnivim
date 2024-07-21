--[[
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
────────────────────────────────────────────────
Plugin: nvim-java
Github: https://github.com/nvim-java/nvim-java

Painless Java in Neovim
────────────────────────────────────────────────
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--]]

local spec = {
	"nvim-java/nvim-java",
	lazy = true,
}

spec.setup = function()
	require('java').setup()
end

return spec

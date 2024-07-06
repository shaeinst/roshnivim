--[[━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
────────────────────────────────────────────────
Plugin: nvim-java
Github: https://github.com/nvim-java/nvim-java

Painless Java in Neovim
────────────────────────────────────────────────
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━]]

local spec = {
	"nvim-java/nvim-java",
}

spec.setup = function()
	require('java').setup()
end

return spec

--[[
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
────────────────────────────────────────────────
Plugin:    abstract-cursor
Github:    https://github.com/Abstract-IDE/abstract-cursor

dynamic cursor
────────────────────────────────────────────────
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--]]

local spec = {
	-- "/home/sh4h1d/codeDNA/dev/Projects/neovim/Abstract-DB",
	"/home/sh7a/codeDNA/dev/Projects/neovim/Abstract-DB",
	dev = true,
}

spec.config = function()
	vim.opt.runtimepath:prepend("/home/sh7a/codeDNA/dev/Projects/neovim/Abstract-DB")
	require("abstract_db").setup()
end

return spec

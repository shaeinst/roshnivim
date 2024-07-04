--[[
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
─────────────────────────────────────────────────
Plugin: bufdelete.nvim
Github: https://github.com/famiu/bufdelete.nvim

Neovim's default :bdelete command can be quite annoying, since
it also messes up your entire window layout by deleting windows.
bufdelete.nvim aims to fix that by providing useful commands that
allow you to delete a buffer without messing up your window layout.
─────────────────────────────────────────────────
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--]]

local spec = {
	"famiu/bufdelete.nvim",
}

spec.config = function()
	require("abstract.utils.map").set_plugin("famiu/bufdelete.nvim")
end


return spec

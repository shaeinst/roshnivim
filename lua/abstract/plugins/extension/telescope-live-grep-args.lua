--[[
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
─────────────────────────────────────────────────
Plugin:    telescope.telescope-live-grep-args.nvim
Github:    https://github.com/nvim-telescope/telescope-live-grep-args.nvim

Live grep with args
─────────────────────────────────────────────────
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--]]

local M = {}

local lga_actions = require("telescope-live-grep-args.actions")

M.config = {
	-- auto_quoting = true, -- enable/disable auto-quoting
	-- -- define mappings, e.g.
	-- mappings = { -- extend mappings
	-- 	i = {
	-- 		["<C-k>"] = lga_actions.quote_prompt(),
	-- 		["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
	-- 		-- freeze the current list and start a fuzzy search in the frozen list
	-- 		["<C-space>"] = lga_actions.to_fuzzy_refine,
	-- 	},
	-- },
	-- -- ... also accepts theme settings, for example:
	-- theme = "dropdown", -- use dropdown theme
	-- theme = { }, -- use own theme spec
	-- layout_config = { mirror=true }, -- mirror preview pane
}

return M

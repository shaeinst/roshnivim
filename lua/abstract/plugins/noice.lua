--[[
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
─────────────────────────────────────────────────
Plugin: noice.nvim
Github: https://github.com/folke/noice.nvim

💥 Highly experimental plugin that completely replaces
the UI for messages, cmdline and the popupmenu.
─────────────────────────────────────────────────
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--]]

local spec = {
	"folke/noice.nvim",
	event = "VeryLazy",
}

spec.opts = {
	lsp = {
		signature = { enabled = false },
		hover = { enabled = false },
	},
	presets = {
		bottom_search = false, -- use a classic bottom cmdline for search
		command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false, -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = true, -- add a border to hover docs and signature help
	},
	health = {
		checker = false, -- Disable if you don't want health checks to run
	},
	cmdline = {
		enabled = true, -- enables the Noice cmdline UI
		view = "cmdline", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
	},
}

return spec

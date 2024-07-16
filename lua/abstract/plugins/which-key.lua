--[[━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
────────────────────────────────────────────────
Plugin:    which-key
Github:    https://github.com/folke/which-key.nvim

WhichKey is a lua plugin for Neovim 0.5 that displays a popup
with possible key bindings of the command you started typing.
────────────────────────────────────────────────
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━]]

local spec = {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
}

---@class wk.Opts
spec.opts = {
	---@type false | "classic" | "modern" | "helix"
	preset = "modern",
	-- Delay before showing the popup. Can be a number or a function that returns a number.
	---@type number | fun(ctx: { keys: string, mode: string, plugin?: string }):number
	delay = function(ctx)
		return ctx.plugin and 0 or 200
	end,
	--- You can add any mappings here, or use `require('which-key').add()` later
	---@type wk.Spec
	spec = {},
	-- show a warning when issues were detected with your mappings
	notify = true,
	-- Enable/disable WhichKey for certain mapping modes
	modes = {
		n = true, -- Normal mode
		i = true, -- Insert mode
		x = true, -- Visual mode
		s = true, -- Select mode
		o = true, -- Operator pending mode
		t = true, -- Terminal mode
		c = true, -- Command mode
	},
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		presets = {
			operators = true, -- adds help for operators like d, y, ...
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true,   -- bindings for folds, spelling and others prefixed with z
			g = true,   -- bindings for prefixed with g
		},
	},
	---@type wk.Win
	win = {
		-- width = 1,
		-- height = { min = 4, max = 25 },
		-- col = 0,
		row = -1,
		-- border = "none",
		padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
		title = true,
		title_pos = "center",
		zindex = 1000,
		-- Additional vim.wo and vim.bo options
		bo = {},
		wo = {
			-- winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
		},
	},
	layout = {
		width = { min = 20 }, -- min and max width of the columns
		spacing = 3,    -- spacing between columns
		align = "left", -- align columns left, center or right
	},
	keys = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	---@type (string|wk.Sorter)[]
	--- Add "manual" as the first element to use the order the mappings were registered
	--- Other sorters: "desc"
	sort = { "local", "order", "group", "alphanum", "mod", "lower", "icase" },
	expand = 1, -- expand groups when <= n mappings
	---@type table<string, ({[1]:string, [2]:string}|fun(str:string):string)[]>
	replace = {
		key = {
			function(key)
				return require("which-key.view").format(key)
			end,
			-- { "<Space>", "SPC" },
		},
		desc = {
			{ "<Plug>%((.*)%)", "%1" },
			{ "^%+",            "" },
			{ "<[cC]md>",       "" },
			{ "<[cC][rR]>",     "" },
			{ "<[sS]ilent>",    "" },
			{ "^lua%s+",        "" },
			{ "^call%s+",       "" },
			{ "^:%s*",          "" },
		},
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
		ellipsis = "…",
		--- See `lua/which-key/icons.lua` for more details
		--- Set to `false` to disable keymap icons
		---@type wk.IconRule[]|false
		rules = false,
		-- use the highlights from mini.icons
		-- When `false`, it will use `WhichKeyIcon` instead
		colors = true,
		-- used by key format
		keys = {
			Up = " ",
			Down = " ",
			Left = " ",
			Right = " ",
			C = "󰘴 ",
			M = "󰘵 ",
			S = "󰘶 ",
			CR = "󰌑 ",
			Esc = "󱊷 ",
			ScrollWheelDown = "󱕐 ",
			ScrollWheelUp = "󱕑 ",
			NL = "󰌑 ",
			BS = "⌫",
			Space = "󱁐 ",
			Tab = "󰌒 ",
		},
	},
	show_help = true, -- show a help message in the command line for using WhichKey
	show_keys = true, -- show the currently pressed key and its label as a message in the command line
	-- Which-key automatically sets up triggers for your mappings.
	-- But you can disable this and setup the triggers yourself.
	-- Be aware, that triggers are not needed for visual and operator pending mode.
	triggers = true, -- automatically setup triggers
	disable = {
		-- disable WhichKey for certain buf types and file types.
		ft = {},
		bt = {},
		-- disable a trigger for a certain context by returning true
		---@type fun(ctx: { keys: string, mode: string, plugin?: string }):boolean?
		trigger = function(ctx)
			return false
		end,
	},
}


return spec

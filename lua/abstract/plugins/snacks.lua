--[[
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
─────────────────────────────────────────────────
Plugin: snacks.nvim
Github: github.com/folke/snacks.nvim

A collection of small QoL plugins for Neovim.
─────────────────────────────────────────────────
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--]]

local spec = {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	keys = require("abstract.configs.mapping").plugin["folke/snacks.nvim"],
}

---@type snacks.Config
local opts = {

	-- Delete buffers without disrupting window layout.
	---@class snacks.bufdelete.Opts
	bufdelete = {
		enabled = true,
	},

	-- Better vim.ui.input
	input = {
		enabled = true,
	},

	-- Deal with big files
	---@class snacks.bigfile.Config
	bigfile = {
		notify = true, -- show notification when big file detected
		size = 5 * 1024 * 1024, -- 5MB
		-- Enable or disable features when big file detected
		---@param ctx {buf: number, ft:string}
		setup = function(ctx)
			vim.cmd([[NoMatchParen]])
			Snacks.util.wo(0, { foldmethod = "manual", statuscolumn = "", conceallevel = 0 })
			vim.b.minianimate_disable = true
			vim.schedule(function()
				vim.bo[ctx.buf].syntax = ctx.ft
			end)
		end,
	},
}

---@class snacks.lazygit.Config: snacks.terminal.Opts
---@field args? string[]
---@field theme? snacks.lazygit.Theme
opts.lazygit = {
	-- automatically configure lazygit to use the current colorscheme
	-- and integrate edit with the current neovim instance
	configure = true,
	-- extra configuration for lazygit that will be merged with the default
	-- snacks does NOT have a full yaml parser, so if you need `"test"` to appear with the quotes
	-- you need to double quote it: `"\"test\""`
	config = {
		os = { editPreset = "nvim-remote" },
		gui = {
			-- set to an empty string "" to disable icons
			nerdFontsVersion = "3",
		},
	},
	theme_path = vim.fs.normalize(vim.fn.stdpath("cache") .. "/lazygit-theme.yml"),
	-- Theme for lazygit
	theme = {
		[241] = { fg = "Special" },
		-- activeBorderColor = { fg = "MatchParen", bold = true },
		-- cherryPickedCommitBgColor = { fg = "Identifier" },
		-- cherryPickedCommitFgColor = { fg = "Function" },
		-- defaultFgColor = { fg = "Normal" },
		-- inactiveBorderColor = { fg = "FloatBorder" },
		-- optionsTextColor = { fg = "Function" },
		-- searchingActiveBorderColor = { fg = "MatchParen", bold = true },
		-- selectedLineBgColor = { bg = "Visual" }, -- set to `default` to have no background colour
		-- unstagedChangesColor = { fg = "DiagnosticError" },
	},
	win = {
		style = "lazygit",
	},
}

-- Indent guides and scopes
opts.indent = {
	indent = {
		enabled = true, -- enable indent guides
		priority = 1,
		char = "│",
		only_scope = false, -- only show indent guides of the scope
		only_current = false, -- only show indent guides in the current window
		hl = "SnacksIndent", ---@type string|string[] hl groups for indent guides
	},
	---@class snacks.indent.Scope.Config: snacks.scope.Config
	scope = {
		enabled = true, -- enable highlighting the current scope
		priority = 200,
		char = "│", -- │ | ¦ ┆ ┊ ║ ▎
		underline = true, -- underline the start of the scope
		only_current = false, -- only show scope in the current window
		hl = "SnacksIndentScope", ---@type string|string[] hl group for scopes
	},
	chunk = {
		-- when enabled, scopes will be rendered as chunks, except for the
		-- top-level scope which will be rendered as a scope.
		enabled = false,
		-- only show chunk scopes in the current window
		only_current = false,
		priority = 100,
		hl = "SnacksIndentChunk", ---@type string|string[] hl group for chunk scopes
		char = {
			corner_top = "╭", --    ╭   ┌
			corner_bottom = "╰", -- ╰   └
			horizontal = "─",
			vertical = "│",
			arrow = ">",
		},
	},

	---@class snacks.indent.animate: snacks.animate.Config
	---@field style? "out"|"up_down"|"down"|"up"
	animate = {
		enabled = true, -- vim.fn.has("nvim-0.10") == 1,
		--- * out: animate outwards from the cursor
		--- * up: animate upwards from the cursor
		--- * down: animate downwards from the cursor
		--- * up_down: animate up or down based on the cursor position
		style = "out",
		easing = "linear",
		duration = {
			step = 20, -- ms per step
			total = 300, -- maximum duration
		},
	},
}

-- Pretty vim.notify
---@class snacks.notifier.Config
---@field keep? fun(notif: snacks.notifier.Notif): boolean # global keep function
opts.notifier = {
	enabled = true,
	timeout = 3000, -- default timeout in ms
	width = { min = 40, max = 0.4 },
	height = { min = 1, max = 0.6 },
	-- editor margin to keep free. tabline and statusline are taken into account automatically
	margin = { top = 0, right = 1, bottom = 0 },
	padding = true, -- add 1 cell of left/right padding to the notification window
	sort = { "level", "added" }, -- sort by level and time
	-- minimum log level to display. TRACE is the lowest
	-- all notifications are stored in history
	level = vim.log.levels.TRACE,
	icons = {
		error = " ",
		warn = " ",
		info = " ",
		debug = " ",
		trace = " ",
	},
	keep = function(notif)
		return vim.fn.getcmdpos() > 0
	end,
	---@type snacks.notifier.style
	style = "compact",
	top_down = true, -- place notifications from top to bottom
	date_format = "%R", -- time format for notifications
	-- format for footer when more lines are available
	-- `%d` is replaced with the number of lines.
	-- only works for styles with a border
	---@type string|boolean
	more_format = " ↓ %d lines ",
	refresh = 50, -- refresh at most every 50ms
}

-- Beautiful declarative dashboards
---@class snacks.dashboard.Config
---@field enabled? boolean
---@field sections snacks.dashboard.Section
---@field formats table<string, snacks.dashboard.Text|fun(item:snacks.dashboard.Item, ctx:snacks.dashboard.Format.ctx):snacks.dashboard.Text>
opts.dashboard = {
	enabled = true,
	width = 40,
	sections = function()
		local header = function()
			local _header = ""
			_header = _header .. "┃█████       " .. "\n"
			_header = _header .. "┃██ ██      " .. "\n"
			_header = _header .. "┃██  ██     " .. "\n"
			_header = _header .. "┃██ ████████  " .. "\n"
			_header = _header .. "┃██    ██   " .. "\n"
			_header = _header .. "┃██     ██  " .. "\n"
			return _header
		end

		local info = function()
			local _datetime, datetime = pcall(os.date, " %I:%M:%p (%d-%m-%Y)")
			local version = vim.version()
			local nvim_verion = string.format("v%d.%d.%d", version.major, version.minor, version.patch)
			if _datetime then
				return nvim_verion .. " | " .. datetime
			end
			return nvim_verion
		end

		-- stylua: ignore
		return {
			{ align = "center", text = { header() } },
			{
				gap = 0,
				indent = 0,
				padding = 2,
				{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
				{ icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
				{ icon = " ", key = "s", desc = "Sessions", action = ":lua require('telescope'):SessionManager load_session" },
				{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
				{ icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
				{ icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
				{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
			},
			{
				align = "center",
				gap = 0,
				{ section = "startup" },
				{ text = { info() } },
			}
		}
	end,
}

spec.opts = opts

return spec

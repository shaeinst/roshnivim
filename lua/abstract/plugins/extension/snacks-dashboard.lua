--[[
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
─────────────────────────────────────────────────
Plugin: Dashboard - snacks.nvim
Source: https://github.com/folke/snacks.nvim/blob/main/docs/dashboard.md

Beautiful declarative dashboards
─────────────────────────────────────────────────
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--]]

---@class snacks.dashboard.Config
---@field enabled? boolean
---@field sections snacks.dashboard.Section
---@field formats table<string, snacks.dashboard.Text|fun(item:snacks.dashboard.Item, ctx:snacks.dashboard.Format.ctx):snacks.dashboard.Text>
local config = {
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

		local session = function()
			require("telescope")
			vim.cmd([[SessionManager load_session]])
		end

		-- stylua: ignore
		return {
			{ align = "center", text = { header() } },
			{
				gap = 0,
				indent = 0,
				padding = 4,
				{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
				{ icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
				{ icon = " ", key = "s", desc = "Sessions", action = session },
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

return config

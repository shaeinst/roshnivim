local M = {}
vim.g.MAPPINGS = {}

local function lazy()
	-- bootstrap lazy.nvim
	local opts = require("abstract.plugins.lazy").opts
	local install_path = opts.root .. "/lazy.nvim"
	if not vim.loop.fs_stat(install_path) then
		-- stylua: ignore
		vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
			install_path })
	end
	vim.opt.rtp:prepend(install_path)

	local plugins = require("abstract.configs.plugin")
	for i, plugin in ipairs(plugins) do
		plugins[i] = { import = "abstract.plugins." .. plugin }
	end
	-- user's plugins (~/.config/nvim/lua/plugins/)
	table.insert(plugins, { import = "plugins" })
	opts.spec = plugins
	require("lazy").setup(opts)
end

local function loadMap()
	vim.g.MAPPINGS = vim.tbl_extend(
		"force",
		require("abstract.configs.mapping").builtin,
		require("override.mapping") -- "~/.config/nvim/lua/override/mapping.lua"
	)
	local set_map = require("abstract.utils.map").set_map
	set_map(vim.g.MAPPINGS)
	vim.api.nvim_create_augroup("AbstractAutoGroup", { clear = true })
	vim.api.nvim_create_autocmd({ "User" }, {
		desc = "Set mappings",
		pattern = "*",
		group = "AbstractAutoGroup",
		callback = function(type)
			if type.match == "AbstractLoadMapping" then
				set_map(vim.g.MAPPINGS)
			end
		end,
	})
end

function M.setup()
	-- call abstract autocmds
	require("abstract.configs.autocmd")
	-- set Abstract's default config
	require("abstract.configs.vimopt")
	-- Override Abstract's default with user config
	dofile(vim.fn.stdpath("config") .. "/init.lua")
	-- Even though we are using a plugin for mapping, and loadMap() should be loaded after initializing lazy,
	-- we are not doing so. I think lazy resets the global variable or something (honestly, I don't know),
	-- and we are calling loadMap before lazy
	loadMap()
	lazy()
end

return M

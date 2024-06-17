local M = {}

function M.set_plugin(name)
	local register = require("which-key").register
	local plugin_map = require("abstract.configs.mapping").plugin[name]

	register(plugin_map.maps, plugin_map.opts)

	-- only set the users maps once
	if vim.g.ABSTRACT_SET_MAPS == nil then
		for _, get in ipairs(require("abstract.configs.mapping").builtin) do
			register(get.maps, get.opts)
		end
		local user_maps = require("override.mapping") -- "~/.config/nvim/lua/override/mapping.lua"
		for _, get in ipairs(user_maps) do
			register(get.maps, get.opts)
		end
		vim.g.ABSTRACT_MAPS = user_maps
		vim.g.ABSTRACT_SET_MAPS = true
	end

	-- some plugins like lspconfig and copilot takes time to load so for this we are using
	-- custom option is_lazy to explicitly know that we need to again set the users maps.
	if plugin_map.opts.is_lazy then
		for _, get in ipairs(vim.g.ABSTRACT_MAPS) do
			register(get.maps, get.opts)
		end
	end
end

return M

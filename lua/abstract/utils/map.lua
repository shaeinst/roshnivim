local M = {}

M.set_plugin = function(name, lazy)
	local add = require("which-key").add
	local plugin_map = require("abstract.configs.mapping").plugin[name]
	add(plugin_map)

	--[[
		Override Abstract's default with user config
		Since some plugins are lazy-loaded and hence some mapping are done lazily,
		we need to make sure that the user's mapping is loaded after the plugin's mapping.
		This is used to override the plugin's mapping with user's mapping.

		WARN: i tried to keep mappings in global variable (vim.g.ABSTRACT_MAPPING) but i thinks it's been scoped out
		by lazy.nvim, so i have to use require("override.mapping") to get the user's mapping. this is inefficient and
		can be improved.
	]]
	if lazy then
		for _, map in ipairs(require("override.mapping")) do
			add(map)
		end
	end
end

return M

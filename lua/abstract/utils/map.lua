local M = {}

function M.set_plugin(name)
	local mapping = require("abstract.configs.mapping").plugin[name]
	vim.g.MAPPINGS = vim.tbl_extend("keep", vim.g.MAPPINGS, mapping)
	vim.api.nvim_command("doautocmd User AbstractLoadMapping")
end

function M.set_map(map)
	local import, wk = pcall(require, "which-key")
	if import then
		wk.register(map)
	end
end

return M

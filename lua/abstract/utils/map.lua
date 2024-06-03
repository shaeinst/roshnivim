local M = {}

function M.set_plugin(name)
	local mapping = require("abstract.configs.mapping").plugin[name]
	vim.g.MAPPINGS = vim.tbl_extend("keep", vim.g.MAPPINGS, mapping)
	vim.api.nvim_command("doautocmd User AbstractLoadMapping")
end

function M.set_map(maps)
	local import, wk = pcall(require, "which-key")
	if import then
		local opts = {
			mode = "n", -- NORMAL mode
			-- prefix: use "<leader>f" for example for mapping everything related to finding files
			-- the prefix is prepended to every mapping part of `mappings`
			prefix = "",
			buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
			silent = true, -- use `silent` when creating keymaps
			noremap = true, -- use `noremap` when creating keymaps
			nowait = false, -- use `nowait` when creating keymaps
			expr = false, -- use `expr` when creating keymaps
		}
		wk.register(maps, opts)
	end
end

return M

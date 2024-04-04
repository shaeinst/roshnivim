local M = {}

function M.setup(path)
	vim.g.ABSTRACT_LOADED = false
	vim.g.ABSTRACT_INSTALL_PATH = path
	require("abstract.bridge").setup()
	vim.g.ABSTRACT_LOADED = true
end

return M

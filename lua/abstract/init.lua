local M = {}

function M.setup(path)
	-- initialize globals
	require("abstract.utils.globals")
	ABSTRACT["INSTALL_PATH"] = path
	require("abstract.bridge").setup()
end

return M

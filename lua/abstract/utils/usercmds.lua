local M = {}

M.lsp_loaded = function()
	vim.api.nvim_exec([[ autocmd User AbstractLSPLoaded lua return ]], false)
end

return M

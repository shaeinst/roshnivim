local M = {}
local plugin = {}

M.builtin = {
	-- navigate to previous/next buffer
	{ "\\", ":bnext<CR>",       desc = "Goto next buffer" },
	{ "|",  ":bprevious<CR>",   desc = "Goto previous buffer" },
	{ "??", ":let @/ = ''<CR>", desc = "Clear the last used search pattern" },
}

plugin["nvim-telescope/telescope.nvim"] = {
	-- Find files from current file's project
	{ "<C-p>", "<cmd>Telescope find_files<cr>",                                                            desc = "Find File (project dir)" },
	-- Show all files from current working directory
	{ "<C-f>", "<cmd>lua require('telescope.builtin').find_files( { cwd = vim.fn.expand('%:p:h') }) <CR>", desc = "Find File (current dir)" },
	{ "<C-b>", "<cmd>lua require('telescope.builtin').buffers() <CR>",                                     desc = "Opened buffers" },
	{ "tt",    "<cmd>lua require('telescope.builtin').builtin() <CR>",                                     desc = "Telescope builtin" },
	{ "tc",    "<cmd>lua require('telescope.builtin').commands() <CR>",                                    desc = "Commands" },
	{ "th",    "<cmd>lua require('telescope.builtin').help_tags() <CR>",                                   desc = "Help tags" },
	{ "tm",    "<cmd>lua require('telescope.builtin').keymaps() <CR>",                                     desc = "Mappings" },
	{ "tw",    "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find() <CR>",                   desc = "Find Word (current file)", },
	{ "tg",    "<cmd>lua require('telescope.builtin').live_grep() <CR>",                                   desc = "Find Word (project wise)" },
	{ "tp",    ":lua require'telescope'.extensions.project.project{}<CR>",                                 desc = "Projects picker" },
}

plugin["neovim/nvim-lspconfig"] = {
	{ "<Leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>",               desc = "Show diagnostics" },
	-- { "<Leader>n",  "<cmd>lua vim.diagnostic.goto_next()<CR>",                desc = "Move to next diagnostic" },
	-- { "<Leader>b",  "<cmd>lua vim.diagnostic.goto_prev()<CR>",                desc = "Move to previous diagnostic" },
	-- { "<Leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>",                  desc = "Code action" },
	-- { "<Leader>a",  "<cmd>lua vim.lsp.buf.range_code_action()<CR>",           desc = "Range code action" },
	-- { "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>",                      desc = "Rename symbol" },
	-- {";wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "" },
	-- {";wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "" },
	-- {";wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "" },
	{ "<Leader>d", "<Cmd>lua vim.lsp.buf.definition()<CR>",                  desc = "Jumps to definition" },
	{ "<Leader>D", "<Cmd>lua vim.lsp.buf.declaration()<CR>",                 desc = "Jumps to declaration" },
	{ "<Leader>T", "<cmd>lua vim.lsp.buf.type_definition()<CR>",             desc = "Jumps to type definition" },
	{ "<Leader>i", "<cmd>lua vim.lsp.buf.implementation()<CR>",              desc = "Lists all symbol implementations" },
	{ "<Leader>s", "<cmd>lua vim.lsp.buf.signature_help()<CR>",              desc = "Show symbol signature information" },
	{ "<Leader>f", "<cmd>lua vim.lsp.buf.format({ timeout_ms = 3000 })<CR>", desc = "Format document" },
	{ "K",         "<Cmd>lua vim.lsp.buf.hover()<CR>",                       desc = "Show symbol hover information" },
	{ "<Leader>r", "<cmd>Telescope lsp_references<CR>",                      desc = "Lsp references" },
	-- using 'filipdutescu/renamer.nvim' for rename
	{ "<Leader>R", "<cmd>lua require('renamer').rename()<cr>",               desc = "Rename symbol" },
	-- using 'rachartier/tiny-code-action.nvim' for code action
	{ "<Leader>a", "<cmd>lua require('tiny-code-action').code_action()<CR>", desc = "Code action" },
}

plugin["zbirenbaum/copilot.lua"] = {
	mode = { "i" },
	{ "<M-l>", "<cmd>lua require('copilot.suggestion').accept()<CR>",  desc = "Accept suggestion (Copilot)" },
	{ "<M-h>", "<cmd>lua require('copilot.suggestion').dismiss()<CR>", desc = "Dismiss suggestion (Copilot)" },
	{ "<M-j>", "<cmd>lua require('copilot.suggestion').next()<CR>",    desc = "Next suggestion (Copilot)" },
	{ "<M-k>", "<cmd>lua require('copilot.suggestion').prev()<CR>",    desc = "Previous suggestion (Copilot)" },
}

plugin["nvimtools/none-ls.nvim"] = {
	{ "<Leader>f", "<cmd>lua vim.lsp.buf.format({ timeout_ms = 3000 })<CR>", desc = "Format document" },
}

plugin["ThePrimeagen/harpoon"] = {
	{
		{ "<Leader>g", group = "Harpoon" },
		{ "<Leader>h", "<cmd>lua HarpoonTelescope()<cr>",    desc = "Open harpoon window" },
		{ "<Leader>a", "<cmd>lua Harpoon_List:append()<cr>", desc = "Add current buffer to harpoon" },
		{ "<Leader>r", "<cmd>lua Harpoon_List:remove()<cr>", desc = "Remove current buffer from harpoon" },
		{ "<Leader>p", "<cmd>lua Harpoon_List:prev()<cr>",   desc = "Goto previous in harpoon list" },
		{ "<Leader>n", "<cmd>lua Harpoon_List:next()<cr>",   desc = "Goto next in harpoon list" },
	},
	{ "<C-h>",     "<cmd>lua HarpoonTelescope()<cr>",     desc = "Open harpoon window" },
	{ "<Leader>1", "<cmd>lua Harpoon_List:select(1)<cr>", desc = "Goto 1st file in harpoon" },
	{ "<Leader>2", "<cmd>lua Harpoon_List:select(2)<cr>", desc = "Goto 2nd file in harpoon" },
	{ "<Leader>3", "<cmd>lua Harpoon_List:select(3)<cr>", desc = "Goto 3rd file in harpoon" },
	{ "<Leader>4", "<cmd>lua Harpoon_List:select(4)<cr>", desc = "Goto 4th file in harpoon" },
}

plugin["cbochs/grapple.nvim"] = {
	{
		{ "<Leader>g",  group = "Grapple" },
		{ "<Leader>gt", "<cmd>Grapple open_tags<cr>",      desc = "Show tags" },
		{ "<Leader>gl", "<cmd>Grapple open_loaded<cr>",    desc = "Show loaded" },
		{ "<Leader>gs", "<cmd>Grapple open_scopes<cr>",    desc = "Show scopes" },
		{ "<Leader>ga", "<cmd>Grapple toggle<cr>",         desc = "Tag (toggle)" },
		{ "<Leader>gk", "<cmd>Grapple toggle_tags<cr>",    desc = "Tags (toggle)" },
		{ "<Leader>gK", "<cmd>Grapple toggle_scopes<cr>",  desc = "Scopes (toggle)" },
		{ "<Leader>gn", "<cmd>Grapple cycle forward<cr>",  desc = "Goto next tag" },
		{ "<Leader>gp", "<cmd>Grapple cycle backward<cr>", desc = "Goto previous tag" },
	},
	{ "<M-1>", "<cmd>Grapple select index=1<cr>", desc = "Grapple select 1" },
	{ "<M-2>", "<cmd>Grapple select index=2<cr>", desc = "Grapple select 2" },
	{ "<M-3>", "<cmd>Grapple select index=3<cr>", desc = "Grapple select 3" },
	{ "<M-4>", "<cmd>Grapple select index=4<cr>", desc = "Grapple select 4" },
	{ "<M-5>", "<cmd>Grapple select index=5<cr>", desc = "Grapple select 5" },
}

plugin["folke/trouble.nvim"] = {
	{ "<Leader>t", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
}

plugin["nvim-neo-tree/neo-tree.nvim"] = {
	{ ";f", ":Neotree toggle<CR>", desc = "File Explorer(toggle)" },
}

plugin["nanozuki/tabby.nvim"] = {
	-- Mappings (:h tab)
	{ ";q",       ":tabclose<CR>", desc = "Close current tab" },
	{ ";Q",       ":tabonly<CR>",  desc = "Close all other tab" },
	-- navigate to previous/next tab
	{ "<C-\\>",   ":tabn<CR>",     desc = "Go to next tab" },
	{ "<C-S-\\>", ":tabp<CR>",     desc = "Go to previous tab" },
	-- move current tab to previous/next position
	{ ";,",       ":-tabmove<CR>", desc = "Move tab to next position" },
	{ ";.",       ":+tabmove<CR>", desc = "Move tab to previous position" },
}

plugin["smoka7/hop.nvim"] = {
	{ "f", "<cmd>lua require'hop'.hint_words()<cr>", desc = "Jump anywhere" },
}

plugin["Shatur/neovim-session-manager"] = {
	{ ";s",  group = "Session" },
	{ ";sl", ":SessionManager load_session<CR>",   desc = "Load sessions" },
	{ ";sd", ":SessionManager delete_session<CR>", desc = "Delete sessions" },
}

plugin["rmagatti/goto-preview"] = {
	{ "gp",  group = "Goto Preview" },
	{ "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",      desc = "Preview definition" },
	{ "gpt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", desc = "Preview type definition" },
	{ "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",  desc = "Preview definition" },
	{ "gpD", "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>",     desc = "Preview declaration" },
	{ "gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>",      desc = "Preview definition" },
	{ "gpQ", "<cmd>lua require('goto-preview').close_all_win()<CR>",                desc = "Close all window" },
}

plugin["anuvyklack/windows.nvim"] = {
	{ ";m", ":WindowsMaximize<CR>", desc = "Window maximizer (toggle)" },
}

plugin["famiu/bufdelete.nvim"] = {
	{ "<M-q>q", "<cmd>lua require('bufdelete').bufwipeout(0)<CR>", desc = "close current buffer without killing windows" },
}

plugin["stevearc/oil.nvim"] = {
	{ "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
}

M.plugin = plugin

return M

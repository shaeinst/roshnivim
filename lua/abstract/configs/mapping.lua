local M = {}
local plugin = {}

M.builtin = {
	{ "??",       ":let @/ = ''<CR>", desc = "Clear last used search pattern" },

	{ "<M-b>",    ":bnext<CR>",       desc = "Goto next buffer" },
	{ "<M-S-b>",  ":bprevious<CR>",   desc = "Goto previous buffer" },
	{ "<M-q>w",   ":close <CR>",      desc = "Close current window" },

	-- TAB (:h tab)
	{ "<M-q>t",   ":tabclose<CR>", desc = "Close current tab" },
	{ "<M-q>T",   ":tabonly<CR>",  desc = "Close all other tab" },
	{ "<M-.>",    ":tabn<CR>",     desc = "Go to next tab" },
	{ "<M-,>",    ":tabp<CR>",     desc = "Go to previous tab" },
	{ "<M-S-,>",  ":-tabmove<CR>", desc = "Move tab to next position" },
	{ "<M-S-.>",  ":+tabmove<CR>", desc = "Move tab to previous position" },

	{ "<M-h>",  "<C-w>h", desc = "Move cursor to left window" },
	{ "<M-l>",  "<C-w>l", desc = "Move cursor to right window" },
	{ "<M-k>",  "<C-w>k", desc = "Move cursor to above window" },
	{ "<M-j>",  "<C-w>j", desc = "Move cursor to below window" },
}

plugin["famiu/bufdelete.nvim"] = {
	{ "<M-q><M-q>", "<CMD>lua require('bufdelete').bufwipeout(0)<CR>", desc = "Close current buffer without killing windows" },
}

plugin["nvim-telescope/telescope.nvim"] = {
	{ "tt",    "<CMD>lua require('telescope.builtin').builtin() <CR>",     desc = "Telescope builtin" },
	{ "tc",    "<CMD>lua require('telescope.builtin').commands() <CR>",    desc = "Commands" },
	{ "th",    "<CMD>lua require('telescope.builtin').help_tags() <CR>",   desc = "Help tags" },
	{ "tm",    "<CMD>lua require('telescope.builtin').keymaps() <CR>",     desc = "Mappings" },
	{ "tg",    "<CMD>lua require('telescope.builtin').live_grep() <CR>",   desc = "Find Word (project wise)" },
	{ "tw",    "<CMD>lua require('telescope.builtin').current_buffer_fuzzy_find() <CR>", desc = "Find Word (current file)", },
	{ "tp",    "<CMD>lua require('telescope').extensions.project.project{}<CR>", desc = "Projects picker" },
	-- Find files from current file's project
	{ "<C-p>", "<CMD>Telescope find_files<CR>",                            desc = "Find File (project dir)" },
	-- Show all files from current working directory
	{ "<C-b>", "<CMD>lua require('telescope.builtin').buffers() <CR>",     desc = "Opened buffers" },
	{ "<C-f>", "<CMD>lua require('telescope.builtin').find_files( { cwd = vim.fn.expand('%:p:h') }) <CR>", desc = "Find File (current dir)" },
}

plugin["neovim/nvim-lspconfig"] = {
	{ "<Leader>e", "<CMD>lua vim.diagnostic.open_float()<CR>",               desc = "Show diagnostics" },
	-- { "<Leader>n",  "<CMD>lua vim.diagnostic.goto_next()<CR>",                desc = "Move to next diagnostic" },
	-- { "<Leader>b",  "<CMD>lua vim.diagnostic.goto_prev()<CR>",                desc = "Move to previous diagnostic" },
	-- { "<Leader>a", "<CMD>lua vim.lsp.buf.code_action()<CR>",                  desc = "Code action" },
	-- { "<Leader>a",  "<CMD>lua vim.lsp.buf.range_code_action()<CR>",           desc = "Range code action" },
	-- { "<Leader>rn", "<CMD>lua vim.lsp.buf.rename()<CR>",                      desc = "Rename symbol" },
	-- {";wa", "<CMD>lua vim.lsp.buf.add_workspace_folder()<CR>", "" },
	-- {";wr", "<CMD>lua vim.lsp.buf.remove_workspace_folder()<CR>", "" },
	-- {";wl", "<CMD>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "" },
	{ "<Leader>d", "<CMD>lua vim.lsp.buf.definition()<CR>",                  desc = "Jumps to definition" },
	{ "<Leader>D", "<CMD>lua vim.lsp.buf.declaration()<CR>",                 desc = "Jumps to declaration" },
	{ "<Leader>T", "<CMD>lua vim.lsp.buf.type_definition()<CR>",             desc = "Jumps to type definition" },
	{ "<Leader>i", "<CMD>lua vim.lsp.buf.implementation()<CR>",              desc = "Lists all symbol implementations" },
	{ "<Leader>s", "<CMD>lua vim.lsp.buf.signature_help()<CR>",              desc = "Show symbol signature information" },
	{ "<Leader>f", "<CMD>lua vim.lsp.buf.format({ timeout_ms = 3000 })<CR>", desc = "Format document" },
	{ "K",         "<CMD>lua vim.lsp.buf.hover()<CR>",                       desc = "Show symbol hover information" },
	{ "<Leader>r", "<CMD>Telescope lsp_references<CR>",                      desc = "Lsp references" },
	-- using 'filipdutescu/renamer.nvim' for rename
	{ "<Leader>R", "<CMD>lua require('renamer').rename()<CR>",               desc = "Rename symbol" },
	-- using 'rachartier/tiny-code-action.nvim' for code action
	{ "<Leader>a", "<CMD>lua require('tiny-code-action').code_action()<CR>", desc = "Code action" },
}

plugin["zbirenbaum/copilot.lua"] = {
	mode = { "i" },
	{ "<M-l>", "<CMD>lua require('copilot.suggestion').accept()<CR>",  desc = "Accept suggestion (Copilot)" },
	{ "<M-h>", "<CMD>lua require('copilot.suggestion').dismiss()<CR>", desc = "Dismiss suggestion (Copilot)" },
	{ "<M-j>", "<CMD>lua require('copilot.suggestion').next()<CR>",    desc = "Next suggestion (Copilot)" },
	{ "<M-k>", "<CMD>lua require('copilot.suggestion').prev()<CR>",    desc = "Previous suggestion (Copilot)" },
}

plugin["nvimtools/none-ls.nvim"] = {
	{ "<Leader>f", "<CMD>lua vim.lsp.buf.format({ timeout_ms = 3000 })<CR>", desc = "Format document" },
}

plugin["ThePrimeagen/harpoon"] = {
	{
		{ "<Leader>g", group = "Harpoon" },
		{ "<Leader>h", "<CMD>lua HarpoonTelescope()<CR>",    desc = "Open harpoon window" },
		{ "<Leader>a", "<CMD>lua Harpoon_List:append()<CR>", desc = "Add current buffer to harpoon" },
		{ "<Leader>r", "<CMD>lua Harpoon_List:remove()<CR>", desc = "Remove current buffer from harpoon" },
		{ "<Leader>p", "<CMD>lua Harpoon_List:prev()<CR>",   desc = "Goto previous in harpoon list" },
		{ "<Leader>n", "<CMD>lua Harpoon_List:next()<CR>",   desc = "Goto next in harpoon list" },
	},
	{ "<C-h>",     "<CMD>lua HarpoonTelescope()<CR>",     desc = "Open harpoon window" },
	{ "<Leader>1", "<CMD>lua Harpoon_List:select(1)<CR>", desc = "Goto 1st file in harpoon" },
	{ "<Leader>2", "<CMD>lua Harpoon_List:select(2)<CR>", desc = "Goto 2nd file in harpoon" },
	{ "<Leader>3", "<CMD>lua Harpoon_List:select(3)<CR>", desc = "Goto 3rd file in harpoon" },
	{ "<Leader>4", "<CMD>lua Harpoon_List:select(4)<CR>", desc = "Goto 4th file in harpoon" },
}

plugin["cbochs/grapple.nvim"] = {
	{
		{ "<Leader>g",  group = "Grapple" },
		{ "<Leader>gt", "<CMD>Grapple open_tags<CR>",      desc = "Show tags" },
		{ "<Leader>gl", "<CMD>Grapple open_loaded<CR>",    desc = "Show loaded" },
		{ "<Leader>gs", "<CMD>Grapple open_scopes<CR>",    desc = "Show scopes" },
		{ "<Leader>ga", "<CMD>Grapple toggle<CR>",         desc = "Tag (toggle)" },
		{ "<Leader>gk", "<CMD>Grapple toggle_tags<CR>",    desc = "Tags (toggle)" },
		{ "<Leader>gK", "<CMD>Grapple toggle_scopes<CR>",  desc = "Scopes (toggle)" },
		{ "<Leader>gn", "<CMD>Grapple cycle forward<CR>",  desc = "Goto next tag" },
		{ "<Leader>gp", "<CMD>Grapple cycle backward<CR>", desc = "Goto previous tag" },
	},
	{ "<M-1>", "<CMD>Grapple select index=1<CR>", desc = "Grapple select 1" },
	{ "<M-2>", "<CMD>Grapple select index=2<CR>", desc = "Grapple select 2" },
	{ "<M-3>", "<CMD>Grapple select index=3<CR>", desc = "Grapple select 3" },
	{ "<M-4>", "<CMD>Grapple select index=4<CR>", desc = "Grapple select 4" },
	{ "<M-5>", "<CMD>Grapple select index=5<CR>", desc = "Grapple select 5" },
}

plugin["folke/trouble.nvim"] = {
	{ "<Leader>t", "<CMD>Trouble diagnostics toggle<CR>", desc = "Diagnostics (Trouble)" },
}

plugin["nvim-neo-tree/neo-tree.nvim"] = {
	{ ";f", ":Neotree toggle<CR>", desc = "File Explorer(toggle)" },
}

plugin["smoka7/hop.nvim"] = {
	{ "f", "<CMD>lua require'hop'.hint_words()<CR>", desc = "Jump anywhere" },
}

plugin["Shatur/neovim-session-manager"] = {
	{ ";s",  group = "Session" },
	{ ";sl", ":SessionManager load_session<CR>",   desc = "Load sessions" },
	{ ";sd", ":SessionManager delete_session<CR>", desc = "Delete sessions" },
}

plugin["rmagatti/goto-preview"] = {
	{ "gp",  group = "Goto Preview" },
	{ "gpd", "<CMD>lua require('goto-preview').goto_preview_definition()<CR>",      desc = "Preview definition" },
	{ "gpt", "<CMD>lua require('goto-preview').goto_preview_type_definition()<CR>", desc = "Preview type definition" },
	{ "gpi", "<CMD>lua require('goto-preview').goto_preview_implementation()<CR>",  desc = "Preview definition" },
	{ "gpD", "<CMD>lua require('goto-preview').goto_preview_declaration()<CR>",     desc = "Preview declaration" },
	{ "gpr", "<CMD>lua require('goto-preview').goto_preview_references()<CR>",      desc = "Preview definition" },
	{ "gpQ", "<CMD>lua require('goto-preview').close_all_win()<CR>",                desc = "Close all window" },
}

plugin["anuvyklack/windows.nvim"] = {
	{ ";m", ":WindowsMaximize<CR>", desc = "Window maximizer (toggle)" },
}

plugin["stevearc/oil.nvim"] = {
	{ "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
}

plugin["lsig/messenger.nvim"] = {
	{ ";gs", "<CMD>lua require('messenger').show()<CR>", desc = "Show commit message" },
}

M.plugin = plugin

return M

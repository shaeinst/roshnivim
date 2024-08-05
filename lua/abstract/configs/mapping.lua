local M = {}

-- Mappings that don't depend on any plugin
M.builtin = {
	-- { "??",         ":let @/ = ''<CR>", desc = "Clear last used search pattern" },

	{ "\\",         ":bnext<CR>",     desc = "Goto next buffer" },
	{ "|",          ":bprevious<CR>", desc = "Goto previous buffer" },
	{ "<M-q><M-w>", ":close <CR>",    desc = "Close current window" },

	-- TAB (:h tab)
	{ "<M-q>t",     ":tabclose<CR>",  desc = "Close current tab" },
	{ "<M-q>T",     ":tabonly<CR>",   desc = "Close all other tab" },
	{ "<M-.>",      ":tabn<CR>",      desc = "Goto next tab" },
	{ "<M-,>",      ":tabp<CR>",      desc = "Goto previous tab" },
	{ "<M-S-,>",    ":-tabmove<CR>",  desc = "Move tab to next position" },
	{ "<M-S-.>",    ":+tabmove<CR>",  desc = "Move tab to previous position" },

	{ "<M-h>",      "<C-w>h",         desc = "Move cursor to left window" },
	{ "<M-l>",      "<C-w>l",         desc = "Move cursor to right window" },
	{ "<M-k>",      "<C-w>k",         desc = "Move cursor to above window" },
	{ "<M-j>",      "<C-w>j",         desc = "Move cursor to below window" },
}

-- Mappings that depends on plugin but reqires to override builtin mappings
M.override = {
	{ "<Leader>f", "<CMD>lua vim.lsp.buf.format({ timeout_ms = 3000 })<CR>", desc = "Format document" },
}

-- Mappings that depends on plugin
M.plugin = {

	["nvim-telescope/telescope.nvim"] = {
		{ "tt",    "<CMD>lua require('telescope.builtin').builtin()<CR>",                                     desc = "Telescope builtin" },
		{ "tc",    "<CMD>lua require('telescope.builtin').commands()<CR>",                                    desc = "Commands" },
		{ "th",    "<CMD>lua require('telescope.builtin').help_tags()<CR>",                                   desc = "Help tags" },
		{ "tm",    "<CMD>lua require('telescope.builtin').keymaps()<CR>",                                     desc = "Mappings" },
		{ "tw",    "<CMD>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>",                   desc = "Find word (current file)" },
		-- Grep word. (using telescope-live-grep-args.nvim)
		-- { "tg",    "<CMD>lua require('telescope.builtin').live_grep() <CR>",                  desc = "Find Word (project wise)" },
		{ "tg",    "<CMD>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",            desc = "Find word (project wise)" },
		{ "tG",    "<CMD>lua require('telescope-live-grep-args.shortcuts').grep_word_under_cursor()<CR>",     desc = "Find word under cursor (project wise)" },
		-- Find files from current file's project
		{ "tp",    "<CMD>lua require('telescope').extensions.project.project{}<CR>",                          desc = "Projects picker" },
		{ "<C-p>", "<CMD>Telescope find_files<CR>",                                                           desc = "Find File (project dir)", },
		-- Show all files from current working directory
		{ "<C-b>", "<CMD>lua require('telescope.builtin').buffers()<CR>",                                     desc = "Opened buffers", },
		{ "<C-f>", "<CMD>lua require('telescope.builtin').find_files( { cwd = vim.fn.expand('%:p:h') })<CR>", desc = "Find File (current dir)", },
	},

	["neovim/nvim-lspconfig"] = {
		-- { "<Leader>f",  "<CMD>lua vim.lsp.buf.format({ timeout_ms = 3000 })<CR>", desc = "Format document" },
		-- using 'patrickpichler/hovercraft.nvim' for hover
		-- { "K",          "<CMD>lua vim.lsp.buf.hover()<CR>",             desc = "Show symbol hover information", },
		-- { "<Leader>rn", "<CMD>lua vim.lsp.buf.rename()<CR>",            desc = "Rename symbol" },
		{ "<Leader>e", "<CMD>lua vim.diagnostic.open_float()<CR>",               desc = "Show diagnostics" },
		{ "<Leader>d", "<CMD>lua vim.lsp.buf.definition()<CR>",                  desc = "Jumps to definition" },
		-- using 'filipdutescu/renamer.nvim' for rename
		{ "<Leader>R", "<CMD>lua require('renamer').rename()<CR>",               desc = "Rename symbol" },
		-- using 'rachartier/tiny-code-action.nvim' for code action
		{ "<Leader>a", "<CMD>lua require('tiny-code-action').code_action()<CR>", desc = "Code action" },
		{
			{ "<Leader>l",   group = "LSP" },
			{ "<Leader>lf",  "<CMD>lua vim.lsp.buf.format({ timeout_ms = 3000 })<CR>",                      desc = "Format document" },
			{ "<Leader>lA",  "<CMD>lua vim.lsp.buf.range_code_action()<CR>",                                desc = "Range code action" },
			{ "<Leader>ld",  "<CMD>lua vim.lsp.buf.declaration()<CR>",                                      desc = "Jumps to declaration" },
			{ "<Leader>li",  "<CMD>lua vim.lsp.buf.implementation()<CR>",                                   desc = "Lists all symbol implementations", },
			{ "<Leader>ls",  "<CMD>lua vim.lsp.buf.signature_help()<CR>",                                   desc = "Show symbol signature information", },
			{ "<Leader>lt",  "<CMD>lua vim.lsp.buf.type_definition()<CR>",                                  desc = "Jumps to type definition" },
			{ "<Leader>lh",  function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, desc = "Inlay hints (toggle)" },
			{ "<Leader>lb",  "<CMD>lua vim.diagnostic.goto_prev()<CR>",                                     desc = "Move to previous diagnostic" },
			{ "<Leader>ln",  "<CMD>lua vim.diagnostic.goto_next()<CR>",                                     desc = "Move to next diagnostic" },
			{ "<Leader>lr",  "<CMD>Telescope lsp_references<CR>",                                           desc = "Lsp references" },
			{
				{ "<Leader>lw",   group = "Workspace" },
				{ "<Leader>lwa", "<CMD>lua vim.lsp.buf.add_workspace_folder()<CR>",                         desc = "Add workspace folder" },
				{ "<Leader>lwr", "<CMD>lua vim.lsp.buf.remove_workspace_folder()<CR>",                      desc = "Remove workspace folders" },
				{ "<Leader>lwl", "<CMD>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",   desc = "List workspace folders" },
			}
		}
	},

	["zbirenbaum/copilot.lua"] = {
		mode = { "i" },
		{ "<M-l>", "<CMD>lua require('copilot.suggestion').accept()<CR>",  desc = "Accept suggestion (Copilot)" },
		{ "<M-h>", "<CMD>lua require('copilot.suggestion').dismiss()<CR>", desc = "Dismiss suggestion (Copilot)" },
		{ "<M-j>", "<CMD>lua require('copilot.suggestion').next()<CR>",    desc = "Next suggestion (Copilot)" },
		{ "<M-k>", "<CMD>lua require('copilot.suggestion').prev()<CR>",    desc = "Previous suggestion (Copilot)" },
	},

	["patrickpichler/hovercraft.nvim"] = {
		{
			"K",
			function()
				local hovercraft = require("hovercraft")
				if hovercraft.is_visible() then
					hovercraft.enter_popup()
				else
					hovercraft.hover()
				end
			end,
			desc = "Hover"
		},
	},

	["ThePrimeagen/harpoon"] = {
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
	},

	["cbochs/grapple.nvim"] = {
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
	},

	["folke/trouble.nvim"] = {
		{ "<Leader>t", "<CMD>Trouble diagnostics toggle<CR>", desc = "Diagnostics (Trouble)" },
	},

	["nvim-neo-tree/neo-tree.nvim"] = {
		{ ";f", ":Neotree toggle<CR>", desc = "File Explorer(toggle)" },
	},

	["smoka7/hop.nvim"] = {
		{ "f", "<CMD>lua require'hop'.hint_words()<CR>", desc = "Jump anywhere" },
	},

	["Shatur/neovim-session-manager"] = {
		{ ";s",  group = "Session Manager" },
		{ ";sl", ":SessionManager load_session<CR>",   desc = "Load sessions" },
		{ ";sd", ":SessionManager delete_session<CR>", desc = "Delete sessions" },
	},

	["rmagatti/goto-preview"] = {
		{ "gp",  group = "Goto Preview" },
		{ "gpd", "<CMD>lua require('goto-preview').goto_preview_definition()<CR>",      desc = "Preview definition" },
		{ "gpt", "<CMD>lua require('goto-preview').goto_preview_type_definition()<CR>", desc = "Preview type definition", },
		{ "gpi", "<CMD>lua require('goto-preview').goto_preview_implementation()<CR>",  desc = "Preview definition" },
		{ "gpD", "<CMD>lua require('goto-preview').goto_preview_declaration()<CR>",     desc = "Preview declaration" },
		{ "gpr", "<CMD>lua require('goto-preview').goto_preview_references()<CR>",      desc = "Preview definition" },
		{ "gpQ", "<CMD>lua require('goto-preview').close_all_win()<CR>",                desc = "Close all window" },
	},

	["anuvyklack/windows.nvim"] = {
		{ ";m", ":WindowsMaximize<CR>", desc = "Window maximizer (toggle)" },
	},

	["stevearc/oil.nvim"] = {
		{ "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
	},

	["lsig/messenger.nvim"] = {
		{ "<Leader>v",  group = "Version Control (Git)" },
		{ "<Leader>vs", "<CMD>lua require('messenger').show()<CR>", desc = "Show commit message" },
		{ "<Leader>vp", "<CMD>lua require('messenger').show()<CR>", desc = "Show commit message" },
	},

	["isakbm/gitgraph.nvim"] = {
		{ "<Leader>v", group = "Version Control (Git)" },
		{
			"<Leader>vg",
			function()
				require("gitgraph").draw({}, { all = true, max_count = 5000 })
			end,
			desc = "New git graph",
		},
	},

	["famiu/bufdelete.nvim"] = {
		{ "<M-q><M-q>", "<CMD>lua require('bufdelete').bufwipeout(0)<CR>", desc = "Close current buffer without killing windows", },
	},

	["chrisgrieser/nvim-rip-substitute"] = {
		{ "<Leader>:", "<CMD>lua require('rip-substitute').sub()<CR>", desc = "rip substitute", },
	},
}

return M

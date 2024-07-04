--[[
    is_lazy is a custom option that I added to the plugin table in mapping.lua.
    This is used to explicitly know that we need to again set the users maps.
    This is useful for plugins like lspconfig and copilot that takes time to load.
]]

local M = {}
local plugin = {}

M.builtin = {
	{
		opts = {
			mode = "n",
		},
		maps = {
			-- navigate to previous/next buffer
			["\\"] = { ":bnext<CR>", "Goto next buffer" },
			["|"] = { ":bprevious<CR>", "Goto previous buffer" },
			["??"] = { ":let @/ = ''<CR>", "Clear the last used search pattern" },
		},
	},
}

plugin["nvim-telescope/telescope.nvim"] = {
	opts = {
		mode = "n",
	},
	maps = {
		-- Find files from current file's project
		["<C-p>"] = { "<cmd>Telescope find_files<cr>", "Find File (project dir)" },
		-- stylua: ignore
		-- Show all files from current working directory
		["<C-f>"] = { "<cmd>lua require('telescope.builtin').find_files( { cwd = vim.fn.expand('%:p:h') }) <CR>", "Find File (current dir)" },
		["<C-b>"] = { "<cmd>lua require('telescope.builtin').buffers() <CR>", "Opened buffers" },
		["tt"] = { "<cmd>lua require('telescope.builtin').builtin() <CR>", "Telescope builtin" },
		["tc"] = { "<cmd>lua require('telescope.builtin').commands() <CR>", "Commands" },
		["th"] = { "<cmd>lua require('telescope.builtin').help_tags() <CR>", "Help tags" },
		["tm"] = { "<cmd>lua require('telescope.builtin').keymaps() <CR>", "Mappings" },
		["tw"] = {
			"<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find() <CR>",
			"Find Word (current file)",
		},
		["tg"] = { "<cmd>lua require('telescope.builtin').live_grep() <CR>", "Find Word (project wise)" },
		["tp"] = { ":lua require'telescope'.extensions.project.project{}<CR>", "Projects picker" },
	},
}

plugin["neovim/nvim-lspconfig"] = {
	opts = {
		mode = "n",
		is_lazy = true,
	},
	maps = {
		["<Leader>e"] = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Show diagnostics" },
		-- ["<Leader>n"] = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Move to next diagnostic" },
		-- ["<Leader>b"] = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Move to previous diagnostic" },
		["<Leader>d"] = { "<Cmd>lua vim.lsp.buf.definition()<CR>", "Jumps to definition" },
		["<Leader>D"] = { "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Jumps to declaration" },
		["<Leader>T"] = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Jumps to type definition" },
		["<Leader>i"] = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Lists all symbol implementations" },
		["<Leader>s"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Show symbol signature information" },
		-- ["<Leader>h"] = { "<Cmd>lua vim.lsp.buf.hover()<CR>", "Show symbol hover information" },
		["K"] = { "<Cmd>lua vim.lsp.buf.hover()<CR>", "Show symbol hover information" },
		-- using 'filipdutescu/renamer.nvim' for rename instead
		-- ["<Leader>rn"] = { "<cmd>lua vim.lsp.buf.rename()<CR>", "" },
		["<Leader>f"] = { "<cmd>lua vim.lsp.buf.format({ timeout_ms = 3000 })<CR>", "Format document" },
		["<Leader>a"] = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code action" },
		-- ["<Leader>a"]   = { "<cmd>lua vim.lsp.buf.range_code_action()<CR>", "Range code action" },
		["<Leader>r"] = { "<cmd>Telescope lsp_references<CR>", "Lsp references" },

		-- [";wa"] = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "" },
		-- [";wr"] = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "" },
		-- [";wl"] = { "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "" },
	},
}

plugin["zbirenbaum/copilot.lua"] = {
	opts = {
		mode = "i",
		is_lazy = true,
	},
	maps = {
		["<M-l>"] = { "<cmd>lua require('copilot.suggestion').accept()<CR>", "Accept suggestion (Copilot)" },
		["<M-h>"] = { "<cmd>lua require('copilot.suggestion').dismiss()<CR>", "Dismiss suggestion (Copilot)" },
		["<M-j>"] = { "<cmd>lua require('copilot.suggestion').next()<CR>", "Next suggestion (Copilot)" },
		["<M-k>"] = { "<cmd>lua require('copilot.suggestion').prev()<CR>", "Previous suggestion (Copilot)" },
	},
}

plugin["nvimtools/none-ls.nvim"] = {
	opts = {
		mode = "n",
	},
	maps = {
		["<Leader>f"] = { "<cmd>lua vim.lsp.buf.format({ timeout_ms = 3000 })<CR>", "Format document" },
	},
}

plugin["ThePrimeagen/harpoon"] = {
	opts = {
		mode = "n",
	},
	maps = {
		["<Leader>h"] = {
			{
				["h"] = { "<cmd>lua HarpoonTelescope()<cr>", "Open harpoon window" },
				["a"] = { "<cmd>lua Harpoon_List:append()<cr>", "Add current buffer to harpoon" },
				["r"] = { "<cmd>lua Harpoon_List:remove()<cr>", "Remove current buffer from harpoon" },
				["p"] = { "<cmd>lua Harpoon_List:prev()<cr>", "Goto previous in harpoon list" },
				["n"] = { "<cmd>lua Harpoon_List:next()<cr>", "Goto next in harpoon list" },
			},
			"Harpoon",
		},
		["<C-h>"] = { "<cmd>lua HarpoonTelescope()<cr>", "Open harpoon window" },
		["<Leader>1"] = { "<cmd>lua Harpoon_List:select(1)<cr>", "Goto 1st file in harpoon" },
		["<Leader>2"] = { "<cmd>lua Harpoon_List:select(2)<cr>", "Goto 2nd file in harpoon" },
		["<Leader>3"] = { "<cmd>lua Harpoon_List:select(3)<cr>", "Goto 3rd file in harpoon" },
		["<Leader>4"] = { "<cmd>lua Harpoon_List:select(4)<cr>", "Goto 4th file in harpoon" },
	},
}

plugin["cbochs/grapple.nvim"] = {
	opts = {
		mode = "n",
	},
	maps = {
		["<Leader>g"] = {
			{
				["t"] = { "<cmd>Grapple open_tags<cr>", "Show tags" },
				["l"] = { "<cmd>Grapple open_loaded<cr>", "Show loaded" },
				["s"] = { "<cmd>Grapple open_scopes<cr>", "Show scopes" },
				["a"] = { "<cmd>Grapple toggle<cr>", "Tag (toggle)" },
				["k"] = { "<cmd>Grapple toggle_tags<cr>", "Tags (toggle)" },
				["K"] = { "<cmd>Grapple toggle_scopes<cr>", "Scopes (toggle)" },
				["n"] = { "<cmd>Grapple cycle forward<cr>", "Goto next tag" },
				["p"] = { "<cmd>Grapple cycle backward<cr>", "Goto previous tag" },
			},
			"+Grapple",
		},
		["<M-1>"] = { "<cmd>Grapple select index=1<cr>", "Grapple select 1" },
		["<M-2>"] = { "<cmd>Grapple select index=2<cr>", "Grapple select 2" },
		["<M-3>"] = { "<cmd>Grapple select index=3<cr>", "Grapple select 3" },
		["<M-4>"] = { "<cmd>Grapple select index=4<cr>", "Grapple select 4" },
		["<M-5>"] = { "<cmd>Grapple select index=5<cr>", "Grapple select 5" },
	},
}

plugin["folke/trouble.nvim"] = {
	opts = {
		mode = "n",
	},
	maps = {
		["<Leader>t"] = { "<cmd>Trouble diagnostics toggle<cr>", "Diagnostics (Trouble)" },
	},
}

plugin["nvim-neo-tree/neo-tree.nvim"] = {
	opts = {
		mode = "n",
	},
	maps = {
		[";f"] = { ":Neotree toggle<CR>", "File Explorer(toggle)" },
	},
}

plugin["nanozuki/tabby.nvim"] = {
	opts = {
		mode = "n",
	},
	maps = {
		-- Mappings (:h tab)
		[";q"] = { ":tabclose<CR>", "Close current tab" },
		[";Q"] = { ":tabonly<CR>", "Close all other tab" },
		-- navigate to previous/next tab
		["<C-\\>"] = { ":tabn<CR>", "Go to next tab" },
		["<C-S-\\>"] = { ":tabp<CR>", "Go to previous tab" },
		-- move current tab to previous/next position
		[";,"] = { ":-tabmove<CR>", "Move tab to next position" },
		[";."] = { ":+tabmove<CR>", "Move tab to previous position" },
	},
}

plugin["filipdutescu/renamer.nvim"] = {
	opts = {
		mode = "n",
	},
	maps = {
		["<Leader>R"] = { "<cmd>lua require('renamer').rename()<cr>", "Rename symbol" },
	},
}

plugin["smoka7/hop.nvim"] = {
	opts = {
		mode = "n",
	},
	maps = {
		f = { "<cmd>lua require'hop'.hint_words()<cr>", "Jump anywhere" },
		-- local directions = require("hop.hint").HintDirection
		-- vim.keymap.set("", "f", function()
		-- 	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
		-- end, { remap = true })
		-- vim.keymap.set("", "F", function()
		-- 	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
		-- end, { remap = true })
		-- vim.keymap.set("", "t", function()
		-- 	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
		-- end, { remap = true })
		-- vim.keymap.set("", "T", function()
		-- 	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
		-- end, { remap = true })
	},
}

plugin["Shatur/neovim-session-manager"] = {
	opts = {
		mode = "n",
	},
	maps = {
		[";s"] = {
			{
				["s"] = { ":SessionManager load_session<CR>", "Load sessions" },
				["d"] = { ":SessionManager delete_session<CR>", "Delete sessions" },
			},
			"+Session",
		},
	},
}

plugin["rmagatti/goto-preview"] = {
	opts = {
		mode = "n",
	},
	maps = {
		["gp"] = {
			{
				["d"] = { "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", "Preview definition" },
				["i"] = { "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", "Preview definition" },
				["r"] = { "<cmd>lua require('goto-preview').goto_preview_references()<CR>", "Preview definition" },
				["P"] = { "<cmd>lua require('goto-preview').close_all_win()<CR>", "Close all window" },
			},
			"+Goto Preview",
		},
	},
}

plugin["anuvyklack/windows.nvim"] = {
	opts = {
		mode = "n",
	},
	maps = {
		[";m"] = { ":WindowsMaximize<CR>", "Window maximizer (toggle)" },
	},
}

plugin["famiu/bufdelete.nvim"] = {
	opts = {
		mode = "n",
	},
	maps = {
		["<M-q>q"] = { "<cmd>lua require('bufdelete').bufwipeout(0)<CR>", "close current buffer without killing windows" },
	},
}

M.plugin = plugin

return M

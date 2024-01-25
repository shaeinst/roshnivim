--[[
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
─────────────────────────────────────────────────
Plugin: nvim-cmp
Github: https://github.com/hrsh7th/nvim-cmp/

A completion engine plugin for neovim written in Lua.
Completion sources are installed from external repositories and "sourced".
─────────────────────────────────────────────────
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--]]




-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

local _cmp, cmp = pcall(require, "cmp")
local _luasnip, luasnip = pcall(require, "luasnip")
local _neotab, neotab = pcall(require, "neotab")
if not _cmp or not _luasnip then
	return
end

cmp.setup({

	-- -- Disabling completion in certain contexts, such as comments
	-- enabled = function()
	-- 	-- disable completion in comments
	-- 	local context = require 'cmp.config.context'
	-- 	-- keep command mode completion enabled when cursor is in a comment
	-- 	if vim.api.nvim_get_mode().mode == 'c' then
	-- 		return true
	-- 	else
	-- 		return not context.in_treesitter_capture("comment")
	-- 			and not context.in_syntax_group("Comment")
	-- 	end
	-- end,

	completion = {
		-- completeopt = 'menu,menuone,noinsert',
	},

	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},

	formatting = {

		fields = { "kind", "abbr", "menu" },

		format = function(entry, vim_item)
			local kind_icons = {
				Text = "", -- 
				Method = "", --  
				Function = "⅀", --  
				Constructor = "", -- 
				Field = "", -- 
				Variable = "", -- 
				Class = "", -- ﴯ
				Interface = "", -- 
				Module = "", --  
				Property = "", -- ﰠ
				Unit = "", -- 
				Value = "", -- 
				Enum = "", -- 
				Keyword = "", -- 
				Snippet = "", -- 
				Color = "", -- 
				File = "", -- 
				Reference = "", -- 
				Folder = "", --   
				EnumMember = "", -- 
				Constant = "π", --  
				Struct = "", -- 
				Event = "", -- 
				Operator = "", -- 
				TypeParameter = " ",
			}

			vim_item.kind = (kind_icons[vim_item.kind] or "") .. " "
			-- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- show icons with the name of the item kind

			-- limit completion width
			local MAX_LABEL_WIDTH = 35
			local label = vim_item.abbr
			local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
			if truncated_label ~= label then
				vim_item.abbr = truncated_label .. "…"
			end

			-- set a name for each source
			vim_item.menu = ({
				nvim_lsp = "[LSP]",
				path = "[PTH]",
				buffer = "[BUF]",
				luasnip = "[SNP]",
				nvim_lua = "[LUA]",
				treesitter = "[🌲T]",
				latex_symbols = "[LTX]",
			})[entry.source.name]

			return vim_item
		end,
	},

	sources = {
		{ name = "nvim_lsp" },
		-- {name = 'nvim_lsp_signature_help' }, -- using ray-x/lsp_signature.nvim instead
		{ name = "nvim_lua" },
		{ name = "path" },
		{ name = "luasnip" },
		{ name = "buffer",    keyword_length = 1 },
		{ name = "treesitter" },
		-- {name = 'calc'},
	},

	window = {
		documentation = {
			border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
		},
		completion = {
			border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
		},
	},

	experimental = {
		-- ghost_text = true,
	},

	mapping = {
		["<C-Space>"] = cmp.mapping.complete({}),
		["<C-e>"] = cmp.mapping.close(),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		}),

		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
				-- this will auto complete if our cursor in next to a word and we press tab
				-- elseif has_words_before() then
				--     cmp.complete()
			else
				if _neotab then
					neotab.tabout()
				end
				-- fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
})

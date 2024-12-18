--[[
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
─────────────────────────────────────────────────
Plugin: blink.cmp
Github: https://github.com/Saghen/blink.cmp

Performant, batteries-included completion plugin for Neovim
─────────────────────────────────────────────────
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--]]

local spec = {
	"saghen/blink.cmp",
	lazy = false, -- lazy loading handled internally
	dependencies = {
		{ "kawre/neotab.nvim", lazy = true, opts = {} }, -- Simple yet convenient Neovim plugin for tabbing in and out of brackets, parentheses, quotes, and more.
	},
	-- use a release tag to download pre-built binaries
	-- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	-- build = 'cargo build --release',
	version = "v0.*",
	-- allows extending the providers array elsewhere in your config without having to redefine it
	opts_extend = { "sources.default" },
}

spec.config = function()
	local luasnip = require("abstract.plugins.LuaSnip").setup()
	local neotab = require("neotab")
	local blink = require("blink.cmp")

	blink.setup({

		snippets = {
			expand = function(snippet)
				luasnip.lsp_expand(snippet)
			end,
			active = function(filter)
				if filter and filter.direction then
					return luasnip.jumpable(filter.direction)
				end
				return luasnip.in_snippet()
			end,
			jump = function(direction)
				luasnip.jump(direction)
			end,
		},
		sources = {
			enabled_providers = { "lsp", "path", "snippets", "buffer" },
		},

		-- When specifying 'preset' in the keymap table, the custom key mappings are merged with the preset,
		-- and any conflicting keys will overwrite the preset mappings.
		-- The "fallback" command will run the next non blink keymap.
		--
		-- Example:
		--
		keymap = {
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide", "fallback" },
			["<CR>"] = { "accept", "fallback" },

			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },

			["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
			["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },

			["<C-u>"] = { "scroll_documentation_up", "fallback" },
			["<C-d>"] = { "scroll_documentation_down", "fallback" },
		},
		enabled = function()
			return vim.bo.buftype ~= "prompt" and vim.b.completion ~= false
		end,

		completion = {
			trigger = {
				-- When false, will not show the completion window automatically when in a snippet
				show_in_snippet = false,
			},

			list = {
				-- Maximum number of items to display
				max_items = 200,
				-- Controls if completion items will be selected automatically, and whether selection automatically inserts
				-- 'preselect' will automatically select the first item in the completion list
				-- 'manual' will not select any item by default
				-- 'auto_insert' will not select any item by default, and insert the completion items automatically
				-- when selecting the
				selection = "auto_insert",
			},
			accept = {
				-- Create an undo point when accepting a completion item
				create_undo_point = true,
			},
			menu = {
				enabled = true,
				min_width = 15,
				max_height = 12,
				border = "rounded",
				-- keep the cursor X lines away from the top/bottom of the window
				scrolloff = 0,

				draw = {
					treesitter = true,
					align_to_component = "kind",
					columns = { { "kind_icon", "label", "label_description", "kind" } },
					components = {
						kind_icon = {
							text = function(ctx)
								return ctx.kind_icon .. " "
							end,
						},
						label = {
							width = { max = 35, fill = false },
						},
						label_description = {
							width = { max = 12, fill = true },
							text = function(ctx)
								return " " .. ctx.label_description
							end,
						},
						kind = {
							ellipsis = false,
							width = { fill = false },
						},
					},
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 500, -- Delay before showing the documentation window
				update_delay_ms = 150, -- Delay before updating the documentation window when selecting a new item, while an existing item is still visible
				-- Whether to use treesitter highlighting, disable if you run into performance issues
				treesitter_highlighting = true,
				window = {
					max_width = 60,
					max_height = 20,
					border = "rounded",
				},
			},
			-- Displays a preview of the selected item on the current line
			ghost_text = {
				enabled = false,
			},
			signature = {
				enabled = true,
			},
			appearance = {
				highlight_ns = vim.api.nvim_create_namespace("blink_cmp"),
				-- Sets the fallback highlight groups to nvim-cmp's highlight groups
				-- Useful for when your theme doesn't support blink.cmp
				-- Will be removed in a future release
				use_nvim_cmp_as_default = false,
				-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",

				kind_icons = {
					Text = "",
					Method = "",
					Function = "󰊕",
					Constructor = "󰒓",

					Field = "󰜢",
					Variable = "󰆦",
					Property = "󰖷",

					Class = "",
					Interface = "",
					Struct = "",
					Module = "󰅩",

					Unit = "",
					Value = "󰦨",
					Enum = "",
					EnumMember = "",

					Keyword = "󰻾",
					Constant = "󰏿",

					Snippet = "",
					Color = "",
					File = "",
					Reference = "",
					Folder = "󰉋",
					Event = "",
					Operator = "",
					TypeParameter = " ",
				},
			},
		},
	})
end

return spec


-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
-- ───────────────────────────────────────────────── --
--    Plugin:    packer.nvim
--    Github:    github.com/wbthomason/packer.nvim
-- ───────────────────────────────────────────────── --
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --





-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
-- ━━━━━━━━━━━━━━━━━━━❰ configs ❱━━━━━━━━━━━━━━━━━━━ --
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --

--              NOTE:1
-- If you want to automatically ensure that packer.nvim is installed on any machine you clone your configuration to,
-- add the following snippet (which is due to @Iron-E) somewhere in your config before your first usage of packer:
local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({
		'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path
	})
	execute 'packadd packer.nvim'
end

-- safely import packer
local ok, packer = pcall(require, "packer")
if not ok then return end


local commits = require("plugins.commits")

-- automatically run :PackerCompile whenever plugins.lua is updated
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])


return packer.startup {

	config = {
		-- Move to lua dir so impatient.nvim can cache it
		compile_path = vim.fn.stdpath('config') .. '/plugin/packer_compiled.lua',

		display = {
			open_fn = function()
				return require('packer.util').float({border = 'single'})
			end
		}
	},

	function()

		use { -- Packer can manage itself
			'wbthomason/packer.nvim',
			commit = commits.packer,
		}

		-- Improve Start-UP time
		use { -- Speed up loading Lua modules in Neovim to improve startup time.
			'lewis6991/impatient.nvim',
			commit = commits.impatient,
		}

		use { -- Easily speed up your neovim startup time!. A faster version of filetype.vim
			'nathom/filetype.nvim',
			commit = commits.filetype,
		}

		use { -- colorscheme for (neo)vim written in lua specially made for Abstract
			'Abstract-IDE/Abstract-cs',
			commit = commits.Abstract_cs,
			branch = 'v2',
		}

		use { -- Companion plugin for nvim-lspconfig that allows you to seamlessly install LSP servers locally (inside :echo stdpath("data")).
			'williamboman/nvim-lsp-installer',
			commit = commits.lsp_installer,
			config = [[ require('plugins/nvim-lsp-installer') ]]
		}

		use { -- A collection of common configurations for Neovim's built-in language server client
			'neovim/nvim-lspconfig',
			commit = commits.lspconfig,
			-- [loading with after causing errors. for now, disable it]
			-- after = "nvim-lsp-installer", -- make sure setup for nvim-lsp-installer executes before the setup for lspconfig
			config = [[ require('plugins/nvim-lspconfig') ]]
		}

		use { -- vscode-like pictograms for neovim lsp completion items Topics
			'onsails/lspkind-nvim',
			commit = commits.lspkind,
			config = [[ require('plugins/lspkind-nvim') ]]
		}

		use { -- Nvim Treesitter configurations and abstraction layer
			'nvim-treesitter/nvim-treesitter',
			commit = commits.treesitter,
			run = ':TSUpdate',
			requires = {'nvim-treesitter/playground', commit=commits.playground, opt = true},  -- Treesitter playground integrated into Neovim
			config = [[ require('plugins/nvim-treesitter') ]]
		}

		use { -- A completion plugin for neovim coded in Lua.
			'hrsh7th/nvim-cmp',
			commit = commits.cmp,
			requires = {
				{"hrsh7th/cmp-nvim-lsp", commit=commits.cmp_lsp},     -- nvim-cmp source for neovim builtin LSP client
				{"hrsh7th/cmp-buffer", commit=commits.cmp_buffer},    -- nvim-cmp source for buffer words.
				{"hrsh7th/cmp-path", commit=commits.cmp_path},        -- nvim-cmp source for filesystem paths.
				{"saadparwaiz1/cmp_luasnip", commit=commits.cmp_luasnip},-- luasnip completion source for nvim-cmp
				{"hrsh7th/cmp-nvim-lsp-signature-help", commit=commits.cmp_lsp_signature_help}, -- nvim-cmp source for displaying function signatures with the current parameter emphasized:
				{"hrsh7th/cmp-nvim-lua", ft = 'lua', commit=commits.cmp_lua}, -- nvim-cmp source for nvim lua
			},
			config = [[ require('plugins/nvim-cmp') ]]
		}

		use { -- Snippet Engine for Neovim written in Lua.
			'L3MON4D3/LuaSnip',
			commit = commits.luasnip,
			requires = {"rafamadriz/friendly-snippets", commit=commits.friendly_snippets},  -- Snippets collection for a set of different programming languages for faster development.
			config = [[ require('plugins/LuaSnip') ]]
		}

		use { -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
			'jose-elias-alvarez/null-ls.nvim',
			commit = commits.null_ls,
			config = [[ require('plugins/null-ls_nvim') ]]
		}

		use { -- A super powerful autopairs for Neovim. It support multiple character.
			'windwp/nvim-autopairs',
			commit = commits.autopairs,
			config = [[ require('plugins/nvim-autopairs') ]]
		}

		use { -- Find, Filter, Preview, Pick. All lua, all the time.
			'nvim-telescope/telescope.nvim',
			commit = commits.telescope,
			requires = {
				{'nvim-lua/popup.nvim', commit=commits.popup},
				{'nvim-lua/plenary.nvim', commit=commits.plenary},
				{'nvim-telescope/telescope-fzf-native.nvim', commit=commits.telescope_fzf_native, run = 'make'}, -- FZF sorter for telescope written in c
				{'nvim-telescope/telescope-file-browser.nvim', commit=commits.telescope_file_browser}, -- File Browser extension for telescope.nvim
				{'nvim-telescope/telescope-media-files.nvim', commit=commits.telescope_media_files}, -- Telescope extension to preview media files using Ueberzug.
				{'nvim-telescope/telescope-ui-select.nvim', commit=commits.telescope_ui_select}, -- It sets vim.ui.select to telescope.
			},
			config = [[ require('plugins/telescope_nvim') ]]
		}

		use { -- Use (neo)vim terminal in the floating/popup window.
			'voldikss/vim-floaterm',
			commit = commits.floaterm,
			config = [[ require('plugins/vim-floaterm') ]]
		}

		use { -- lua `fork` of vim-web-devicons for neovim
			'kyazdani42/nvim-web-devicons',
			commit = commits.web_devicons,
			config = [[ require('plugins/nvim-web-devicons') ]]
		}

		use { -- Maximizes and restores the current window in Vim
			'szw/vim-maximizer',
			commit = commits.maximizer,
			config = [[ require('plugins/vim-maximizer') ]]
		}

		use { -- Smart and powerful comment plugin for neovim. Supports commentstring, dot repeat, left-right/up-down motions, hooks, and more
			'numToStr/Comment.nvim',
			commit = commits.Comment,
			config = [[ require('plugins/Comment_nvim') ]]
		}

		use {
			'JoosepAlviste/nvim-ts-context-commentstring', --  Neovim treesitter plugin for setting the commentstring based on the cursor location in a file.
			commit = commits.ts_context_commentstring,
			config = [[ require('plugins/nvim-ts-context-commentstring') ]]
		}

		use { -- The fastest Neovim colorizer.
			'norcalli/nvim-colorizer.lua',
			commit = commits.colorizer,
			config = [[ require('plugins/nvim-colorizer_lua') ]]
		}

		use { --  Indent guides for Neovim
			'lukas-reineke/indent-blankline.nvim',
			commit = commits.indent_blankline,
			config = [[ require('plugins/indent-blankline_nvim') ]]
		}

		use { -- Git signs written in pure lua
			'lewis6991/gitsigns.nvim',
			commit = commits.gitsigns,
			requires = {'nvim-lua/plenary.nvim', commit=commits.plenary},
			config = [[ require('plugins/gitsigns_nvim') ]]
		}

		use { -- A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing.
			'folke/trouble.nvim',
			commit = commits.trouble,
			config = [[ require('plugins/trouble_nvim') ]]
		}

		use { -- A snazzy bufferline for Neovim
			'akinsho/nvim-bufferline.lua',
			commit = commits.bufferline_lua,
			requires = {'kyazdani42/nvim-web-devicons', commit=commits.web_devicons},
			config = [[ require('plugins/nvim-bufferline_lua') ]]
		}

		use { -- A File Explorer For Neovim Written In Lua
			'kyazdani42/nvim-tree.lua',
			commit = commits.tree_lua,
			config = [[ require('plugins/nvim-tree_lua') ]]
		}

		use { -- A minimal, stylish and customizable statusline for Neovim written in Lua
			'feline-nvim/feline.nvim',
			commit = commits.feline,
			-- requires = {
			--   'nvim-lua/lsp-status.nvim',
			-- },
			config = [[ require('plugins/feline_nvim') ]]
		}

		use { -- fast and highly customizable greeter for neovim.
			"goolord/alpha-nvim",
			commit = commits.alpha,
			requires = {'kyazdani42/nvim-web-devicons', commit=commits.web_devicons},
			config = [[ require('plugins/alpha-nvim') ]]
		}

		use { --  smart indent and project detector with project based config loader
			'shaeinst/penvim',
			commit = commits.penvim,
			config = [[ require('plugins/penvim') ]]
		}

		use { -- preview native LSP's goto definition calls in floating windows.
			'rmagatti/goto-preview',
			commit = commits.goto_preview,
			config = [[ require('plugins/goto-preview') ]]
		}

		use { --  A simple wrapper around :mksession
			'Shatur/neovim-session-manager',
			commit = commits.session_manager,
			config = [[ require('plugins/neovim-session-manager') ]]
		}

		use { -- VS Code-like renaming UI for Neovim, writen in Lua.
			'filipdutescu/renamer.nvim',
			commit = commits.renamer,
			branch = 'master',
			requires = {'nvim-lua/plenary.nvim', commit=commits.plenary},
			config = [[ require('plugins/renamer_nvim') ]]
		}

		use { -- EditorConfig plugin for Neovim
			'gpanders/editorconfig.nvim',
			commit = commits.editorconfig,
		}

		use { --  Neovim motions on speed!
			'phaazon/hop.nvim',
			commit = commits.hop,
			config = [[ require('plugins/hop_nvim') ]]
		}

		-- ━━━━━━━━━━━━━━━━━❰ DEVELOPMENT ❱━━━━━━━━━━━━━━━━━ --

		----           for flutter/dart
		use { -- Tools to help create flutter apps in neovim using the native lsp
			'akinsho/flutter-tools.nvim',
			commit = commits.flutter_tools,
			ft = {'dart'},
			requires = {
				{'nvim-lua/plenary.nvim', commit=commits.plenary},
				{'Neevash/awesome-flutter-snippets', commit=commits.awesome_flutter_snipppets}, -- collection snippets and shortcuts for commonly used Flutter functions and classes
				{
					'dart-lang/dart-vim-plugin', -- Syntax highlighting for Dart in Vim
					commit = commits.dart_vim_plugin,
					config = [[ require('plugins/dart-vim-plugin') ]]
				}
			},
			config = [[ require('plugins/flutter-tools_nvim') ]]
		}

		--            for Web-Development
		use { --  Use treesitter to auto close and auto rename html tag, work with html,tsx,vue,svelte,php.
			"windwp/nvim-ts-autotag",
			commit = commits.ts_autotag,
			ft = {'html', 'tsx', 'vue', 'svelte', 'php'},
			requires = {'nvim-treesitter/nvim-treesitter', commit=commits.treesitter},

			config = [[ require('plugins/nvim-ts-autotag') ]]
		}
		-- ━━━━━━━━━━━━━━❰ end of DEVELOPMENT ❱━━━━━━━━━━━━━ --
	end
}

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
-- ━━━━━━━━━━━━━━━━━❰ end configs ❱━━━━━━━━━━━━━━━━━ --
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --


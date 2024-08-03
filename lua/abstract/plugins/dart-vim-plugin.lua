--[[
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
────────────────────────────────────────────────
Plugin:    dart-vim-plugin
Github:    https://github.com/dart-lang/dart-vim-plugin

dart-vim-plugin provides filetype detection, syntax highlighting,
and indentation for Dart code in Vim.
────────────────────────────────────────────────
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--]]

local spec = {
	"dart-lang/dart-vim-plugin",
	lazy = true,
	ft = { "dart" },
}

spec.config = function()
	-- Enable HTML syntax highlighting inside Dart strings  (default: false)
	vim.g.dart_html_in_string = "v.true"
	-- Enable Dart style guide syntax (like 2-space indentation)
	vim.g.dart_style_guide = 2
	-- Enable DartFmt execution on buffer save with
	vim.g.dart_format_on_save = 0
end

return spec

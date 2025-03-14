return {
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
		require("rose-pine").setup({
			variant = "moon", -- auto, main, moon, or dawn
			dark_variant = "moon", -- main, moon, or dawn
			dim_inactive_windows = false,
			extend_background_behind_borders = true,

			enable = {
				terminal = true,
				legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
				migrations = true, -- Handle deprecated options automatically
			},

			styles = {
				bold = true,
				italic = false, -- Keep this false globally
				transparency = true,
			},

			groups = {
				border = "muted",
				link = "iris",
				panel = "surface",

				error = "love",
				hint = "iris",
				info = "foam",
				note = "pine",
				todo = "rose",
				warn = "gold",

				git_add = "foam",
				git_change = "rose",
				git_delete = "love",
				git_dirty = "rose",
				git_ignore = "muted",
				git_merge = "iris",
				git_rename = "pine",
				git_stage = "iris",
				git_text = "rose",
				git_untracked = "subtle",

				h1 = "iris",
				h2 = "foam",
				h3 = "rose",
				h4 = "gold",
				h5 = "pine",
				h6 = "foam",
			},

			palette = {
				-- Override the builtin palette per variant
				-- moon = {
				--     base = '#18191a',
				--     overlay = '#363738',
				-- },
			},

			highlight_groups = {
				-- Syntax Highlighting (mimicking Tokyo Night)
				["@keyword.return"] = { fg = "rose", italic = true }, -- Return statements
				["@parameter"] = { fg = "foam", italic = true }, -- Function arguments
				["@function.call"] = { fg = "gold" }, -- Function calls
				["@function"] = { fg = "gold", bold = true }, -- Function definitions
				["@method.call"] = { fg = "gold" }, -- Method calls
				["@variable"] = { fg = "text" }, -- Variables
				["@field"] = { fg = "foam" }, -- Object fields
				["@property"] = { fg = "foam" }, -- Properties
				["@constant"] = { fg = "pine" }, -- Constants
				["@constant.builtin"] = { fg = "pine", bold = true }, -- Built-in constants
				["@string"] = { fg = "foam" }, -- Strings
				["@number"] = { fg = "gold" }, -- Numbers
				["@boolean"] = { fg = "rose" }, -- Booleans
				["@type"] = { fg = "pine" }, -- Types
				["@type.builtin"] = { fg = "pine", italic = true }, -- Built-in types
				["@namespace"] = { fg = "iris" }, -- Namespaces
				["@operator"] = { fg = "subtle" }, -- Operators
				["@punctuation.delimiter"] = { fg = "subtle" }, -- Delimiters (e.g., commas)
				["@punctuation.bracket"] = { fg = "subtle" }, -- Brackets
				["@comment"] = { fg = "muted", italic = true }, -- Comments

				-- Git Highlighting
				GitSignsAdd = { fg = "foam" },
				GitSignsChange = { fg = "rose" },
				GitSignsDelete = { fg = "love" },

				-- Diagnostics
				DiagnosticError = { fg = "love" },
				DiagnosticWarn = { fg = "gold" },
				DiagnosticInfo = { fg = "foam" },
				DiagnosticHint = { fg = "iris" },

				-- LSP Highlighting
				LspReferenceText = { bg = "overlay" },
				LspReferenceRead = { bg = "overlay" },
				LspReferenceWrite = { bg = "overlay" },

				-- Cursor Line
				CursorLine = { bg = "overlay" },
				CursorLineNr = { fg = "gold", bold = true },

				-- Other
				NormalFloat = { bg = "surface" },
				FloatBorder = { fg = "muted", bg = "surface" },
			},

			before_highlight = function(group, highlight, palette)
				-- Disable all undercurls
				-- if highlight.undercurl then
				--     highlight.undercurl = false
				-- end
				--
				-- Change palette colour
				-- if highlight.fg == palette.pine then
				--     highlight.fg = palette.foam
				-- end
			end,
		})
	end,
}

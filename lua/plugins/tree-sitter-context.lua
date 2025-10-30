return {
	"nvim-treesitter/nvim-treesitter-context",
	opts = {
		enable = false,
		max_lines = 0,
		line_numbers = true,
		multiline_threshold = 20,
		trim_scope = "outer",
		mode = "cursor",
		separator = nil,
		zindex = 20,

		patterns = {
			default = {
				"class",
				"function",
				"method",
				-- Add these for more granular context
				"for_statement",
				"while_statement",
				"if_statement",
				"switch_statement",
				"case_statement",
				"try_statement", -- For Python try/except
				"catch_clause", -- For other languages
			},
		},
	},
}

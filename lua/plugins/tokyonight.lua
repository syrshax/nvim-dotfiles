return {
	"folke/tokyonight.nvim",
	priority = 1000,
	config = function()
		require("tokyonight").setup({
			style = "storm", -- Or "storm"
			transparent = true, -- For float/sidebar transparency
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
			on_colors = function(colors) end,
			on_highlights = function(highlights) end,
			light_style = false,
			terminal_colors = true,
			day_brightness = 0.3,
			dim_inactive = false,
			lualine_bold = false,
			cache = true,
			plugins = {},
		})

		vim.cmd("highlight Comment gui=bold,italic")
		vim.cmd("highlight Keyword gui=bold") -- Example: bold keywords
		vim.cmd("highlight Function gui=bold") -- Example: bold functions
		vim.cmd("highlight Identifier gui=bold") -- Example: bold identifiers
	end,
}

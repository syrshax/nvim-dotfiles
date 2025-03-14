return {
	"ray-x/starry.nvim",
	config = function()
		require("starry").setup({
			style = {
				name = "moonlight", -- Replace with your preferred theme name
				-- Other style options can be added here
			},
			-- Additional configuration options can be added here
		})

		vim.g.starry_transparent = true
	end,
}

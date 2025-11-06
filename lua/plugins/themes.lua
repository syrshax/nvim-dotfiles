return {
	{ "catppuccin/nvim", name = "catppuccin-late", priority = 1000 },
	"EdenEast/nightfox.nvim",
	"sainnhe/everforest",
	"ntk148v/komau.vim",
	"lunarvim/horizon.nvim",
	{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = ... },
	{ "ray-x/starry.nvim" },
	-- Tokyo Night
	{
		"folke/tokyonight.nvim",
	},
	-- Gruvbox
	-- Gruvbox (Corrected Initialization)
	{
		"ellisonleao/gruvbox.nvim",
		opts = {
			transparent_mode = true,
			terminal_colors = true,
		},
	},
	-- Kanagawa
	{
		"rebelot/kanagawa.nvim",
	},
	-- Catppuccin
	{
		"catppuccin/nvim",
		name = "catppuccin",
	},
	-- Dracula
	{
		"Mofiqul/dracula.nvim",
	},
	-- One Dark
	{
		"navarasu/onedark.nvim",
	},
	-- Nightfox
	{
		"EdenEast/nightfox.nvim",
	},
	-- Rose Pine
	{
		"rose-pine/neovim",
		name = "rose-pine",
	},
	-- Everforest
	{
		"sainnhe/everforest",
		lazy = true,
	},
	-- Nord
	{
		"shaunsingh/nord.nvim",
		lazy = true,
	},
	-- Nightfox
	{
		"EdenEast/nightfox.nvim",
		lazy = false, -- Set to false to load it immediately
		priority = 1000, -- Load early to avoid flashes
		config = function()
			require("nightfox").setup({
				options = {
					-- General options
					compile_path = vim.fn.stdpath("cache") .. "/nightfox",
					compile_file_suffix = "_compiled",
					transparent = true, -- <--- THIS IS THE KEY FOR TRANSPARENT BACKGROUND
					terminal_colors = true,
					dim_inactive = false,
					module_default = true,

					-- Colorblind support (optional)
					colorblind = {
						enable = false,
						simulate_only = false,
						severity = {
							protan = 0,
							deutan = 0,
							tritan = 0,
						},
					},

					-- Styling options (adjust as desired)
					styles = {
						comments = "NONE",
						conditionals = "NONE",
						constants = "NONE",
						functions = "NONE",
						keywords = "NONE",
						numbers = "NONE",
						operators = "NONE",
						strings = "NONE",
						types = "NONE",
						variables = "NONE",
					},

					-- Inverse highlight options (optional)
					inverse = {
						match_paren = false,
						visual = false,
						search = false,
					},

					-- Modules for plugin integration (add more as needed)
					modules = {
						-- Example: If you use nvim-tree
						-- nvimtree = true,
						-- WhichKey = true,
						-- LspSaga = true,
						-- ...
					},
				},
				-- You can define custom palettes, specs, and groups here if you want
				-- to deeply customize nightfox. For most users, the default options
				-- are sufficient or they'd adjust 'styles' and 'modules'.
				palettes = {},
				specs = {},
				groups = {},
			})

			-- After setting up nightfox, you need to load the colorscheme.
			-- 'nightfox' is the default name, but you can specify variants like 'dayfox', 'dawnfox', etc.
			-- OR use a specific variant, e.g.:
			-- vim.cmd("colorscheme nordfox")
		end,
		-- 'init' is not strictly necessary here since 'config' is where setup happens,
		-- but it's good practice for general theme loading if you don't have a setup function.
		-- init = function()
		--     -- Ensure termguicolors is enabled for true color support
		--     vim.o.termguicolors = true
		-- end,
	},

	{
		"projekt0n/github-nvim-theme",
		name = "github-theme",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("github-theme").setup({
				-- ...
			})
		end,
	},
	{
		"/idr4n/github-monochrome.nvim",
		name = "github-monochrome",
		priority = 1001,
	},
	{
		"ring0-rootkit/ring0-dark.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		init = function() end,
	},

	{ "blazkowolf/gruber-darker.nvim" },
}

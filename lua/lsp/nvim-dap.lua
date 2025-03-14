return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"mfussenegger/nvim-dap-python", -- Python
		"ray-x/go.nvim", -- Go support
		"ray-x/guihua.lua", -- Recommended by ray-x/go.nvim
		"leoluz/nvim-dap-go",
	},
	config = function()
		-- Load base configurations
		require("lsp.dap.config").setup()
		require("lsp.dap.keymaps").setup()

		-- Load language-specific configurations
		require("lsp.dap.python").setup()
		require("lsp.dap.go").setup()
	end,
}

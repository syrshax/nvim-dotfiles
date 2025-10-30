local dap = require("dap")

local M = {}

M.setup = function()
	-- 1. DEFINE THE ADAPTER
	-- This configuration tells nvim-dap how to start the CodeLLDB Debug Adapter.
	dap.adapters.codelldb = {
		type = "server",
		port = "${port}",
		executable = {
			-- Adjust this path if 'codelldb' is not in your system PATH
			command = "codelldb",
			args = { "--port", "${port}" },
		},
	}

	-- 2. DEFINE THE LAUNCH CONFIGURATION
	-- This configuration is what you select when you start debugging (e.g., with :DapContinue)
	dap.configurations.cpp = {
		{
			name = "Launch Handmade Hero",
			type = "codelldb", -- Must match the adapter name above
			request = "launch",

			-- This function dynamically gets the path to your compiled executable
			program = function()
				-- Replace 'handmadehero' with the actual name of your executable
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/handmadehero", "file")
			end,

			-- Set the working directory to the project folder
			cwd = "${workspaceFolder}",

			-- Set to true if you want to stop at the first instruction (main)
			stopOnEntry = false,

			-- The args from your build script are not necessary here, but
			-- you should still ensure your build script uses -g for debug symbols.
		},
	}

	-- Optional: If you want C files to use the same configuration
	dap.configurations.c = dap.configurations.cpp
end

return M

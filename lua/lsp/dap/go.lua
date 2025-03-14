local M = {}

function M.setup()
	local dap = require("dap")
	local dapui = require("dapui")

	-- Load go debugger
	require("dap-go").setup({
		-- delve configurations
		delve = {
			initialize_timeout_sec = 20,
			port = "${port}",
		},
		-- Log level for dap-go
		log_level = "info", -- Adjust if needed: "trace", "debug", "info", "warn", "error"
		-- Debugger path (if `dlv` is not in PATH)
		-- dap_configurations = {}, -- Uncomment to add custom configurations
	})

	-- Add test debug configuration for Go
	table.insert(dap.configurations.go, {
		type = "go",
		name = "Debug Test",
		request = "launch",
		mode = "test",
		program = "${file}",
	})

	-- Register listeners for test results
	dap.listeners.after.event_terminated["dap-go"] = function()
		dapui.close()
	end

	-- Additional keymaps specific to Go debugging if needed
	vim.keymap.set("n", "<leader>dt", function()
		require("dap-go").debug_test()
	end, { desc = "Debug Go Test" })

	vim.keymap.set("n", "<leader>dgt", function()
		require("dap-go").debug_last_test()
	end, { desc = "Debug Last Go Test" })
end

return M

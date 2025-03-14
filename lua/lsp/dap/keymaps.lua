local M = {}

function M.setup()
	local dap = require("dap")
	local dap_python = require("dap-python")

	-- Basic debugging keymaps
	vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
	vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Continue" })
	vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
	vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
	vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
	vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Debug: Open REPL" })

	-- Watch expressions
	vim.keymap.set("n", "<leader>dw", function()
		require("dapui").elements.watches.add()
	end, { desc = "Add Watch Expression" })

	vim.keymap.set("n", "<leader>dW", function()
		local widgets = require("dap.ui.widgets")
		widgets.hover()
	end, { desc = "Hover Value" })

	-- Evaluation keymaps
	vim.keymap.set("n", "<leader>de", function()
		require("dapui").eval()
	end, { desc = "Evaluate Under Cursor" })

	vim.keymap.set("v", "<leader>de", function()
		require("dapui").eval()
	end, { desc = "Evaluate Selection" })

	-- Test debugging keymaps
	vim.keymap.set("n", "<leader>dtm", dap_python.test_method, { desc = "Debug: Test Method" })
	vim.keymap.set("n", "<leader>dtc", dap_python.test_class, { desc = "Debug: Test Class" })
	vim.keymap.set("n", "<leader>dts", function()
		dap_python.debug_selection()
	end, { desc = "Debug: Test Selection" })

	-- Neotest integration
	local neotest = require("neotest")
	vim.keymap.set("n", "<leader>td", function()
		neotest.run.run({ strategy = "dap" })
	end, { desc = "Debug: Current Test" })

	-- Debug info command
	vim.keymap.set("n", "<leader>di", function()
		local python_config = require("lsp.dap.python")
		local env = python_config.get_env()
		local info = {
			"DAP Python Configuration:",
			"Debugger Path: " .. python_config.get_debugger_path(),
			"Project Path: " .. python_config.get_python_path(),
			"VIRTUAL_ENV: " .. (os.getenv("VIRTUAL_ENV") or "not set"),
			"Current Directory: " .. vim.fn.getcwd(),
			"Environment Variables:",
			"PYTHONPATH: " .. (env.PYTHONPATH or "not set"),
			"VIRTUAL_ENV: " .. (env.VIRTUAL_ENV or "not set"),
			"PATH: " .. (env.PATH or "not set"),
		}
		vim.notify(table.concat(info, "\n"), vim.log.levels.INFO)
	end, { desc = "Show Debug Environment Info" })
end

return M

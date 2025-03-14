local M = {}

function M.setup()
	local dap = require("dap")
	local dapui = require("dapui")
	local widgets = require("dap.ui.widgets")

	-- Add highlighting
	vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#FF0000", bold = true })
	vim.api.nvim_set_hl(0, "DapBreakpointLine", { bg = "#331111" })
	vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#61afef", bold = true })
	vim.api.nvim_set_hl(0, "DapLogPointLine", { bg = "#112233" })
	vim.api.nvim_set_hl(0, "DapStopped", { fg = "#98c379", bold = true })
	vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#112211" })

	-- Setup Breakpoint Signs
	vim.fn.sign_define("DapBreakpoint", {
		text = "●",
		texthl = "DapBreakpoint",
		linehl = "DapBreakpointLine",
		numhl = "DapBreakpoint",
	})
	vim.fn.sign_define("DapBreakpointCondition", {
		text = "◆",
		texthl = "DapBreakpoint",
		linehl = "DapBreakpointLine",
		numhl = "DapBreakpoint",
	})
	vim.fn.sign_define("DapLogPoint", {
		text = "◆",
		texthl = "DapLogPoint",
		linehl = "DapLogPointLine",
		numhl = "DapLogPoint",
	})
	vim.fn.sign_define("DapStopped", {
		text = "▶",
		texthl = "DapStopped",
		linehl = "DapStoppedLine",
		numhl = "DapStopped",
	})
	vim.fn.sign_define("DapBreakpointRejected", {
		text = "●",
		texthl = "DapBreakpointRejected",
		linehl = "DapBreakpointLine",
		numhl = "DapBreakpointRejected",
	})

	-- Test status signs
	vim.fn.sign_define("DapTestPassed", {
		text = "✓",
		texthl = "DapStoppedLine",
		linehl = "",
		numhl = "",
	})
	vim.fn.sign_define("DapTestFailed", {
		text = "✘",
		texthl = "DapBreakpoint",
		linehl = "",
		numhl = "",
	})

	-- Ensure sign column is always visible
	vim.opt.signcolumn = "yes"

	-- Setup DAP UI with all required fields
	dapui.setup({
		icons = {
			expanded = "▾",
			collapsed = "▸",
			current_frame = "▸",
		},
		mappings = {
			-- Use a table with all three values
			expand = { "<CR>", "<2-LeftMouse>" },
			open = "o",
			remove = "d",
			edit = "e",
			repl = "r",
			toggle = "t",
		},
		-- Use an empty table if you don't want to override any element mappings
		element_mappings = {},
		-- Enable/disable expand lines
		expand_lines = true,
		-- Enable forcing buffers
		force_buffers = true,
		layouts = {
			{
				elements = {
					{
						id = "scopes",
						size = 0.25,
						options = {
							multi_line = true,
							max_value_lines = 15,
							show_expanded = true,
						},
					},
					{
						id = "watches",
						size = 0.25,
						options = {
							multi_line = true,
							max_value_lines = 15,
						},
					},
					{ id = "breakpoints", size = 0.25 },
					{ id = "stacks", size = 0.25 },
				},
				position = "right",
				size = 50,
			},
			{
				elements = {
					{
						id = "repl",
						size = 0.5,
						options = {
							multi_line = true,
							max_value_lines = 15,
						},
					},
					{
						id = "console",
						size = 0.5,
						options = {
							max_lines = 500,
							multi_line = true,
							max_value_lines = 15,
						},
					},
				},
				position = "bottom",
				size = 15,
			},
		},
		floating = {
			max_height = 0.9,
			max_width = 0.8,
			border = "rounded",
			mappings = {
				close = { "q", "<Esc>" },
			},
		},
		controls = {
			enabled = true,
			element = "repl",
			icons = {
				pause = "⏸",
				play = "▶",
				step_into = "⏎",
				step_over = "⏭",
				step_out = "⏮",
				step_back = "↶",
				run_last = "↺",
				terminate = "⏹",
			},
		},
		render = {
			indent = 2,
			max_value_lines = 15,
		},
	})

	-- Helper function for variable formatting
	local function format_variable(variable)
		if not variable then
			return ""
		end
		return vim.inspect(variable, {
			indent = "  ",
			newline = "\n",
			depth = 20,
		})
	end

	-- Variable event listener with proper event name
	dap.listeners.before["event_stopped"]["dapui_config"] = function()
		dapui.open()
	end

	-- Better hover implementation
	local orig_hover = widgets.hover
	widgets.hover = function()
		local current_line = vim.fn.line(".")
		local var_name = vim.fn.expand("<cexpr>")

		-- Show enhanced hover window
		widgets.centered_float(orig_hover, {
			border = "rounded",
			max_height = 20,
			max_width = 80,
			wrap = true,
		})
	end

	-- Auto-open/close DAP UI
	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close()
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close()
	end

	-- Add better variable inspection keymaps
	vim.keymap.set("n", "<Leader>dh", widgets.hover, { desc = "DAP Hover" })
	vim.keymap.set("n", "<Leader>dp", widgets.preview, { desc = "DAP Preview" })
	vim.keymap.set("n", "<Leader>df", function()
		widgets.centered_float(widgets.frames)
	end, { desc = "DAP Frames" })
	vim.keymap.set("n", "<Leader>ds", function()
		widgets.centered_float(widgets.scopes)
	end, { desc = "DAP Scopes" })
end

return M

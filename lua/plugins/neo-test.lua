return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-python",
		"nvim-neotest/neotest-go",
		"stevearc/overseer.nvim",
	},
	config = function()
		local neotest = require("neotest")

		-- Set up custom highlights
		vim.api.nvim_set_hl(0, "NeotestPassed", { fg = "#98c379", bold = true })
		vim.api.nvim_set_hl(0, "NeotestFailed", { fg = "#ff0000", bold = true })
		vim.api.nvim_set_hl(0, "NeotestRunning", { fg = "#61afef", bold = true })
		vim.api.nvim_set_hl(0, "NeotestSkipped", { fg = "#565c64", bold = true })

		-- Define custom signs
		local signs = {
			passed = {
				text = "✓",
				texthl = "NeotestPassed",
				numhl = "NeotestPassed",
				linehl = "NeotestPassedLine",
			},
			failed = {
				text = "✘",
				texthl = "NeotestFailed",
				numhl = "NeotestFailed",
				linehl = "NeotestFailedLine",
			},
			running = {
				text = "⟳",
				texthl = "NeotestRunning",
				numhl = "NeotestRunning",
			},
			skipped = {
				text = "○",
				texthl = "NeotestSkipped",
				numhl = "NeotestSkipped",
			},
		}

		-- Register the signs
		for name, sign in pairs(signs) do
			vim.fn.sign_define("neotest_" .. name, sign)
		end

		neotest.setup({
			adapters = {
				require("neotest-python")({
					runner = "pytest",
					args = { "--verbose" },
					python = function()
						if vim.fn.executable("poetry") == 1 then
							return vim.fn.trim(vim.fn.system("poetry env info -p")) .. "/bin/python"
						elseif vim.fn.executable("poe") == 1 then
							return vim.fn.expand("$VIRTUAL_ENV/bin/python")
						else
							return vim.fn.exepath("python3") or vim.fn.exepath("python")
						end
					end,
				}),
				require("neotest-go")({
					experimental = {
						test_table = true,
					},
					args = { "-count=1", "-timeout=60s" },
					recursive_run = true,
				}),
			},
			-- Your existing configuration
			output = {
				enabled = true,
				open_on_run = false,
			},
			output_panel = {
				enabled = true,
				open_on_run = true,
			},
			status = {
				enabled = true,
				signs = true,
				virtual_text = true,
			},
			summary = {
				enabled = true,
				expand_errors = true,
				follow = true,
				mappings = {
					expand = { "<CR>", "<2-LeftMouse>" },
					expand_all = "e",
					output = "o",
					short = "O",
					run = "r",
					run_marked = "R",
					clear_marked = "c",
					jumpto = "i",
					stop = "u",
					mark = "m",
					debug = "d",
				},
			},
			floating = {
				border = "rounded",
				max_height = 0.8,
				max_width = 0.5,
				options = {},
			},
			highlights = {
				passed = "NeotestPassed",
				failed = "NeotestFailed",
				running = "NeotestRunning",
				skipped = "NeotestSkipped",
			},
			consumers = {
				overseer = require("neotest.consumers.overseer"),
			},
			quickfix = {
				enabled = true,
				open = false, -- Don't open quickfix automatically
			},
			diagnostic = {
				enabled = true,
				severity = vim.diagnostic.severity.ERROR,
			},
		})

		-- Modified function to use floating window instead of output panel
		local function show_test_output()
			vim.schedule(function()
				neotest.output.open({ enter = true, auto_close = true })
			end)
		end

		-- Your existing keymaps
		vim.keymap.set("n", "<leader>tt", function()
			neotest.run.run(vim.fn.expand("%"))
			show_test_output()
		end, { desc = "Run File" })
		vim.keymap.set("n", "<leader>tT", function()
			neotest.run.run(vim.loop.cwd())
			show_test_output()
		end, { desc = "Run All Test Files" })
		vim.keymap.set("n", "<leader>tr", function()
			neotest.run.run()
			show_test_output()
		end, { desc = "Run Nearest" })
		vim.keymap.set("n", "<leader>ts", function()
			neotest.summary.toggle()
		end, { desc = "Toggle Summary" })
		vim.keymap.set("n", "<leader>to", function()
			vim.schedule(function()
				neotest.output.open({ enter = true })
			end)
		end, { desc = "Show Output" })
		vim.keymap.set("n", "<leader>tO", function()
			neotest.output_panel.toggle()
		end, { desc = "Toggle Output Panel" })
		vim.keymap.set("n", "<leader>tS", function()
			neotest.run.stop()
		end, { desc = "Stop" })
		vim.keymap.set("n", "[t", function()
			neotest.jump.prev({ status = "failed" })
		end, { desc = "Previous Failed Test" })
		vim.keymap.set("n", "]t", function()
			neotest.jump.next({ status = "failed" })
		end, { desc = "Next Failed Test" })

		-- Additional useful keymaps for debugging
		vim.keymap.set("n", "<leader>td", function()
			neotest.run.run({ strategy = "dap" })
		end, { desc = "Debug Nearest Test" })
		vim.keymap.set("n", "<leader>tq", function()
			neotest.run.run({ suite = true })
			vim.cmd("copen")
		end, { desc = "Run Suite and Open Quickfix" })
	end,
}

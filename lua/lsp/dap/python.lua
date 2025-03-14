local M = {}

-- Helper functions for Python paths
local function get_debugger_path()
	local original_venv = os.getenv("VIRTUAL_ENV")
	vim.env.VIRTUAL_ENV = nil
	local debugger_path = os.getenv("HOME") .. "/.local/nvim-python-debugger/env/bin/python"
	if original_venv then
		vim.env.VIRTUAL_ENV = original_venv
	end
	return debugger_path
end

local function get_python_path()
	local venv_path = os.getenv("VIRTUAL_ENV")
	local poetry_path = vim.fn.trim(vim.fn.system("poetry env info -p"))

	if venv_path then
		return venv_path .. "/bin/python"
	elseif poetry_path ~= "" then
		return poetry_path .. "/bin/python"
	else
		return vim.fn.exepath("python3") or vim.fn.exepath("python")
	end
end

local function get_env()
	local project_root = vim.fn.getcwd()
	local env = {}
	for k, v in pairs(vim.fn.environ()) do
		env[k] = v
	end

	if env.PYTHONPATH then
		env.PYTHONPATH = project_root .. ":" .. env.PYTHONPATH
	else
		env.PYTHONPATH = project_root
	end

	if vim.fn.isdirectory(project_root .. "/src") == 1 then
		env.PYTHONPATH = project_root .. "/src:" .. env.PYTHONPATH
	end

	return env
end

function M.setup()
	local dap = require("dap")
	local dap_python = require("dap-python")
	local project_root = vim.fn.getcwd()

	-- Setup Python adapter
	dap.adapters.python = {
		type = "executable",
		command = get_debugger_path(),
		args = { "-m", "debugpy.adapter" },
		options = {
			env = {
				VIRTUAL_ENV = os.getenv("HOME") .. "/.local/nvim-python-debugger/env",
				PATH = os.getenv("PATH"),
				PYTHONPATH = project_root,
			},
		},
	}

	-- Basic Python configurations
	dap.configurations.python = {
		{
			type = "python",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			pythonPath = get_python_path,
			env = get_env,
		},
		{
			type = "python",
			request = "attach",
			name = "FastAPI: Attach by PID",
			connect = {
				host = "localhost",
				port = 8000,
			},
			processId = "${command:pickProcess}",
			pathMappings = {
				{
					localRoot = "${workspaceFolder}",
					remoteRoot = ".",
				},
			},
			justMyCode = false,
		},
	}

	-- Configure Python test debugging
	dap_python.setup(get_python_path())
	dap_python.test_runner = "pytest"

	-- Setup test result signs
	dap.listeners.after["event_testFinished"]["dap-python"] = function(session, body)
		if body.passed then
			vim.fn.sign_place(0, "DapTest", "DapTestPassed", session.config.program, { lnum = body.line })
		else
			vim.fn.sign_place(0, "DapTest", "DapTestFailed", session.config.program, { lnum = body.line })
		end
	end

	-- Clear test signs when debugging starts
	dap.listeners.before["initialize"]["dap-python"] = function()
		vim.fn.sign_unplace("DapTest")
	end

	-- Process picker functionality
	local function get_process_list()
		local handle = io.popen("ps -ax -o pid,command")
		local result = handle:read("*a")
		handle:close()

		local processes = {}
		for line in result:gmatch("[^\r\n]+") do
			local pid, cmd = line:match("^%s*(%d+)%s+(.+)$")
			if pid and cmd:find("python") then
				table.insert(processes, {
					label = string.format("%s: %s", pid, cmd),
					pid = tonumber(pid),
				})
			end
		end
		return processes
	end

	-- Register process picker
	dap.listeners.after["event_initialized"]["my-extension"] = function()
		if not dap.session().config.processId then
			return
		end
		if dap.session().config.processId == "${command:pickProcess}" then
			vim.ui.select(get_process_list(), {
				prompt = "Select process to attach to:",
				format_item = function(item)
					return item.label
				end,
			}, function(choice)
				if choice then
					dap.session().config.processId = choice.pid
				end
			end)
		end
	end

	-- Export helper functions for use in keymaps
	M.get_debugger_path = get_debugger_path
	M.get_python_path = get_python_path
	M.get_env = get_env
end

return M

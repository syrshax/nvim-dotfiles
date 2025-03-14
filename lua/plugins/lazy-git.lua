return {
	"kdheepak/lazygit.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		-- Configuration for lazygit.nvim
		vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
		vim.g.lazygit_floating_window_scaling_factor = 0.9 -- scaling factor for floating window
		vim.g.lazygit_floating_window_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } -- customize lazygit popup window border characters
		vim.g.lazygit_use_neovim_remote = 1 -- fallback to 0 if neovim-remote is not installed

		-- Key mappings for LazyGit
		vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>", { silent = true, desc = "Open LazyGit" })
		-- Open LazyGit in current file's directory
		vim.keymap.set("n", "<leader>gf", ":LazyGitCurrentFile<CR>", { silent = true, desc = "LazyGit Current File" })
		-- Show Git file history
		vim.keymap.set("n", "<leader>gh", ":LazyGitFilter<CR>", { silent = true, desc = "LazyGit File History" })
		-- Show Git commits of current file
		vim.keymap.set(
			"n",
			"<leader>gc",
			":LazyGitFilterCurrentFile<CR>",
			{ silent = true, desc = "LazyGit Current File History" }
		)
	end,
}

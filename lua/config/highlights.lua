local augroup = vim.api.nvim_create_augroup("MyHighlightOverrides", { clear = true })

-- Listen for the ColorScheme event
vim.api.nvim_create_autocmd("ColorScheme", {
	group = augroup,
	pattern = "*",
	callback = function()
		local context_bg = "#49515F"
		vim.api.nvim_set_hl(0, "TreesitterContext", { bg = context_bg })

		vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { bg = context_bg, fg = "#6B7280" })
	end,
})

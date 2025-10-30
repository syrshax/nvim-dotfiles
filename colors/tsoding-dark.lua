-- Tsoding Dark Theme for Neovim
-- Based on Tsoding Daily's VSCode theme

-- Reset highlighting
vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
	vim.cmd("syntax reset")
end

vim.o.termguicolors = true
vim.g.colors_name = "tsoding-dark"

-- Color palette
local colors = {
	bg = "#181818",
	bg_alt = "#212121",
	bg_highlight = "#282828",
	bg_widget = "#2d2d2d",
	bg_selection = "#3d2828",
	bg_visual = "#2d2424",
	bg_search = "#2d2d2d",

	fg = "#e8e8e8",
	fg_alt = "#e2e2e2",
	fg_dim = "#bfc5bf",
	fg_comment = "#555555",

	cursor = "#afadad",

	red = "#c22121",
	orange = "#ff9b21",
	yellow = "#ffdd33",
	yellow_bright = "#eae2b9",
	green = "#79bf46",
	green_alt = "#69b037",
	cyan = "#95c9b6",
	blue = "#6796E6",
	purple = "#B267E6",

	operator = "#FFB459",
	punctuation = "#bfc5bf",

	warning = "#c2aa21",
	error = "#F44747",
	info = "#6796E6",
}

-- Editor UI
local highlight_groups = {
	-- Base
	Normal = { fg = colors.fg, bg = colors.bg },
	NormalFloat = { fg = colors.fg, bg = colors.bg_widget },

	-- Cursor
	Cursor = { fg = colors.bg, bg = colors.cursor },
	CursorLine = { bg = colors.bg_highlight },
	CursorColumn = { bg = colors.bg_highlight },

	-- Line numbers
	LineNr = { fg = colors.fg_dim, bg = colors.bg },
	CursorLineNr = { fg = colors.fg, bg = colors.bg },

	-- Selection and search
	Visual = { bg = colors.bg_visual },
	VisualNOS = { bg = colors.bg_visual },
	Search = { bg = colors.bg_search },
	IncSearch = { bg = colors.bg_selection },

	-- Splits and windows
	VertSplit = { fg = colors.bg_alt, bg = colors.bg },
	WinSeparator = { fg = colors.bg_alt, bg = colors.bg },
	StatusLine = { fg = colors.yellow, bg = colors.bg_highlight },
	StatusLineNC = { fg = colors.fg_dim, bg = colors.bg_highlight },

	-- Popup menu
	Pmenu = { fg = colors.fg, bg = colors.bg_widget },
	PmenuSel = { fg = colors.bg, bg = colors.yellow_bright },
	PmenuSbar = { bg = colors.bg_highlight },
	PmenuThumb = { bg = colors.fg_dim },

	-- Messages
	ErrorMsg = { fg = colors.error },
	WarningMsg = { fg = colors.warning },

	-- Tabs
	TabLine = { fg = colors.fg_dim, bg = colors.bg_highlight },
	TabLineFill = { bg = colors.bg_highlight },
	TabLineSel = { fg = colors.fg, bg = colors.bg },

	-- Folds
	Folded = { fg = colors.fg_dim, bg = colors.bg_highlight },
	FoldColumn = { fg = colors.fg_dim, bg = colors.bg },

	-- Diff
	DiffAdd = { fg = colors.green },
	DiffChange = { fg = colors.yellow },
	DiffDelete = { fg = colors.red },
	DiffText = { fg = colors.yellow, bg = colors.bg_highlight },

	-- Syntax highlighting
	Comment = { fg = colors.fg_comment, italic = true },

	Constant = { fg = colors.punctuation },
	String = { fg = colors.green },
	Character = { fg = colors.green_alt },
	Number = { fg = colors.punctuation },
	Boolean = { fg = colors.punctuation },
	Float = { fg = colors.punctuation },

	Identifier = { fg = colors.punctuation },
	Function = { fg = colors.yellow },

	Statement = { fg = colors.yellow },
	Conditional = { fg = colors.yellow },
	Repeat = { fg = colors.yellow },
	Label = { fg = colors.yellow },
	Operator = { fg = colors.punctuation },
	Keyword = { fg = colors.yellow },
	Exception = { fg = colors.yellow },

	PreProc = { fg = colors.yellow_bright },
	Include = { fg = colors.yellow },
	Define = { fg = colors.yellow_bright },
	Macro = { fg = colors.fg_dim },
	PreCondit = { fg = colors.yellow },

	Type = { fg = colors.punctuation },
	StorageClass = { fg = colors.yellow },
	Structure = { fg = colors.yellow },
	Typedef = { fg = colors.yellow_bright },

	Special = { fg = colors.operator },
	SpecialChar = { fg = colors.green_alt },
	Tag = { fg = colors.fg },
	Delimiter = { fg = colors.punctuation },
	SpecialComment = { fg = colors.orange },
	Debug = { fg = colors.purple },

	Underlined = { underline = true },
	Ignore = { fg = colors.fg_comment },
	Error = { fg = colors.error },
	Todo = { fg = colors.orange, bold = true },

	-- TreeSitter highlights
	["@variable"] = { fg = colors.fg },
	["@variable.builtin"] = { fg = colors.punctuation },
	["@variable.parameter"] = { fg = colors.fg_alt },
	["@variable.member"] = { fg = colors.fg },

	["@constant"] = { fg = colors.punctuation },
	["@constant.builtin"] = { fg = colors.punctuation },
	["@constant.macro"] = { fg = colors.fg_dim },

	["@string"] = { fg = colors.green },
	["@string.escape"] = { fg = colors.green_alt },
	["@string.special"] = { fg = colors.green_alt },

	["@character"] = { fg = colors.green_alt },
	["@number"] = { fg = colors.punctuation },
	["@boolean"] = { fg = colors.punctuation },
	["@float"] = { fg = colors.punctuation },

	["@function"] = { fg = colors.fg },
	["@function.builtin"] = { fg = colors.fg },
	["@function.macro"] = { fg = colors.fg_dim },
	["@function.method"] = { fg = colors.fg },

	["@constructor"] = { fg = colors.yellow_bright },
	["@operator"] = { fg = colors.punctuation },
	["@keyword"] = { fg = colors.yellow_bright },
	["@keyword.function"] = { fg = colors.yellow },
	["@keyword.operator"] = { fg = colors.yellow_bright },
	["@keyword.return"] = { fg = colors.yellow },

	["@conditional"] = { fg = colors.yellow },
	["@repeat"] = { fg = colors.yellow },
	["@exception"] = { fg = colors.yellow },

	["@type"] = { fg = colors.fg_dim },
	["@type.builtin"] = { fg = colors.yellow_bright },
	["@type.qualifier"] = { fg = colors.yellow },

	["@namespace"] = { fg = "#919191" },

	["@punctuation.bracket"] = { fg = colors.punctuation },
	["@punctuation.delimiter"] = { fg = colors.punctuation },
	["@punctuation.special"] = { fg = colors.operator },

	["@comment"] = { fg = colors.fg_comment, italic = true },

	["@tag"] = { fg = colors.fg },
	["@tag.attribute"] = { fg = colors.fg },
	["@tag.delimiter"] = { fg = colors.punctuation },

	-- LSP semantic tokens
	["@lsp.type.namespace"] = { fg = "#919191" },
	["@lsp.type.type"] = { fg = colors.fg_dim },
	["@lsp.type.parameter"] = { fg = colors.fg_alt },
	["@lsp.type.macro"] = { fg = colors.fg_dim },

	-- Diagnostics
	DiagnosticError = { fg = colors.error },
	DiagnosticWarn = { fg = colors.warning },
	DiagnosticInfo = { fg = colors.info },
	DiagnosticHint = { fg = colors.cyan },

	DiagnosticUnderlineError = { undercurl = true, sp = colors.error },
	DiagnosticUnderlineWarn = { undercurl = true, sp = colors.warning },
	DiagnosticUnderlineInfo = { undercurl = true, sp = colors.info },
	DiagnosticUnderlineHint = { undercurl = true, sp = colors.cyan },
}

-- Apply highlights
for group, opts in pairs(highlight_groups) do
	vim.api.nvim_set_hl(0, group, opts)
end

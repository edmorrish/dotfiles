vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt
local api = vim.api

opt.compatible = false

-- Line numbering
opt.relativenumber = true
opt.number = true

-- Tabs & Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- Line wrapping
opt.wrap = false

-- Search
opt.ignorecase = true -- Ignore by default
opt.smartcase = true -- Mixed case is case sensitive

-- Cursor Line
opt.cursorline = true

-- Colours
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "number"

-- Backspace
opt.backspace = "indent,eol,start"

-- Clipboard
opt.clipboard:append("unnamedplus") -- Default register is system clipboard (controversial)

-- Split options
opt.splitright = true
opt.splitbelow = true

-- UndoFile
opt.undofile = true

-- Folds
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevelstart = 99

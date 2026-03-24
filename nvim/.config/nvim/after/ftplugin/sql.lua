-- overrides to default values from options.lua

local opt = vim.opt -- for conciseness

-- tabs & indentation
opt.tabstop = 4 -- 4 spaces for tabs (sqlfluff rule)
opt.shiftwidth = 4 -- 4 spaces for indent width

-- registering macros that are useful
-- transform from ColumnName to column_name, make if an alias
vim.fn.setreg("a", [[yiwopcr_ysiwkJi ASj]])

-- transform from column_name to ColumnName, make if an alias
vim.fn.setreg("s", [[yiwopcrpysiw"kJi ASj]])

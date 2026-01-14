-- overrides to default values from options.lua

local opt = vim.opt -- for conciseness

-- tabs & indentation
opt.tabstop = 4 -- 4 spaces for tabs (sqlfluff rule)
opt.shiftwidth = 4 -- 4 spaces for indent width

-- registering macros that are useful
vim.fn.setreg(
  "a",
  "yiwopV:s/\\([a-z]\\)\\([A-Z]\\)/\\1_\\l\\2/g\VgukA AS jkJ nh"
)

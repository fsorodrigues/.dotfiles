local opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)
opt.signcolumn = "yes"

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one
opt.listchars:append({
  tab = "▸▸",
  space = "·",
  trail = "•",
  eol = "¬", -- cleaner look than eol = "↲" IMHO
  nbsp = "‡", -- more obvoius than nbsp = "␣" IMHO
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("HighlightUnicodeNBSP", {}),
  pattern = "*",
  callback = function()
    local groupNameNBSP = "HighlightUnicodeNBSP"
    vim.fn.matchadd(groupNameNBSP, " ") --  Create group mapping: Match the special symbol U+00a0

    -- Set highlighting for this group
    vim.api.nvim_set_hl(0, groupNameNBSP, {
      bg = "darkorange", -- Background color
      fg = "white", -- Foreground color
      -- You can also add other attributes, such as:
      -- bold = true,
      -- italic = true,
      -- underline = true
    })
  end,
})

-- line wrapping
opt.wrap = false -- disable line wrapping

-- adding a line at 80 chars
opt.colorcolumn = "80"

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- appearance
-- turn on termguicolors
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
--opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"

-- backspace
-- allow backspace on indent, end of line or insert mode start position
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- keep cursor from bottom of the screen
opt.scrolloff = 9999

-- change stcomplete menu behavior
opt.completeopt = { "menu", "menuone", "noselect" } -- mostly just for cmp

-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps --
---------------------

-- get default file explorer
keymap.set("n", "<leader>ex", "<CMD>Ex<CR>", { desc = "netrw file navigator" })
keymap.set("n", "<leader>sx", "<CMD>Ex<CR>", { desc = "netrw file navigator" })

-- reload current file
keymap.set("n", "<leader>so", "<CMD>source<CR>", { desc = "Source current file" })

-- clear search highlights
keymap.set("n", "<leader>nh", "<CMD>nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- keep pasting
keymap.set("x", "<leader>p", [["_dP]])

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- move lines
keymap.set("n", "<M-j>", ":m .+1<CR>==") -- <A-∆> move line up(n)
keymap.set("n", "<M-k>", ":m .-2<CR>==") -- <A-˚> move line down(n)
keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv") -- move line up(v)
keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv") -- move line down(v)

-- remove arrow keys mappings
keymap.set("n", "<Up>", "")
keymap.set("n", "<Down>", "")
keymap.set("n", "<Left>", "")
keymap.set("n", "<Right>", "")

-- toggle display of whitespace characters (aka :set list / :set list!)
keymap.set("n", "<leader>ww", function()
	vim.opt.list = not vim.opt.list:get()
end, { desc = "Toggle display of whitespace characters" })
